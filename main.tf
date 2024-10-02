terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "amazon_clone_bucket" {
  bucket = "amazon-clone-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.amazon_clone_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy-1" {
  bucket = aws_s3_bucket.amazon_clone_bucket.id
  policy = jsonencode(
    {
      Version= "2012-10-17",
      Statement= [
        {
          Sid= "PublicReadGetObject",
          Effect= "Allow",
          Principal= "*",
          Action= "s3:GetObject",
          Resource= [
            "arn:aws:s3:::${aws_s3_bucket.amazon_clone_bucket.id}/*"
          ]
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.amazon_clone_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./style.css"
  key          = "style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "box_1" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_1.jpg"
  key          = "box_1.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "box_2" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_2.jpg"
  key          = "box_2.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "box_3" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_3.jpg"
  key          = "box_3.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "box_4" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_4.jpg"
  key          = "box_4.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "box_5" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_5.jpg"
  key          = "box_5.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "box_6" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_6.avif"
  key          = "box_6.avif"
  content_type = "image/avif"
}

resource "aws_s3_object" "box_7" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_7.jpg"
  key          = "box_7.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "box_8" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./box_8.jpg"
  key          = "box_8.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "amazon_logo" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./amazon_logo.jpg"
  key          = "amazon_logo.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "Amazon-India-Logo-PNG-HD" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./Amazon-India-Logo-PNG-HD.png"
  key          = "Amazon-India-Logo-PNG-HD.png"
  content_type = "image/png"
}

resource "aws_s3_object" "i1" {
  bucket       = aws_s3_bucket.amazon_clone_bucket.bucket
  source       = "./i1.jpg"
  key          = "i1.jpg"
  content_type = "image/jpeg"
}

output "name" {
  value = aws_s3_bucket_website_configuration.website_config.website_endpoint
}
