From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:41 +0900
Subject: [PATCH v16 02/16] kexec_file: make
 kexec_image_post_load_cleanup_default() global
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change this function from static to global so that arm64 can implement
its own arch_kimage_file_post_load_cleanup() later using
kexec_image_post_load_cleanup_default().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e4e638fb505..49ab758f4d91 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -143,6 +143,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 35cf0ad29718..9ce6672f4fa3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -76,7 +76,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 	return kexec_image_load_default(image);
 }
 
-static int kexec_image_post_load_cleanup_default(struct kimage *image)
+int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
 		return 0;
-- 
2.19.0
