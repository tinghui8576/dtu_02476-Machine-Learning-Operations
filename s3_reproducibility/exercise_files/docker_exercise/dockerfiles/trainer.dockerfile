# Base image
FROM python:3.10-slim
# For mac m1m2
# FROM --platform=linux/amd64 python:3.10-slim
# install python
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
COPY requirements_dev.txt requirements_dev.txt
COPY pyproject.toml pyproject.toml
COPY src/ src/
COPY data/ data/

WORKDIR /
RUN pip install . --no-cache-dir #(1)
RUN mkdir -p result
CMD ["python", "-u", "src/train_model.py", "train", "--lr", "1e-4"]
