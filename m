From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Jul 2016 10:42:00 +0900
Subject: [RFC 2/3] kexec: add dtb info to struct kimage
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
Message-ID: <20160712014201.11456-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch adds dtb buffer information to struct kimage.
When users don't specify dtb explicitly and the one used for the current
kernel can be re-used, this change will be good enough for implementing
kexec_file_load feature.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/kexec.h | 3 +++
 kernel/kexec_file.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b..554c848 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -190,6 +190,9 @@ struct kimage {
 	char *cmdline_buf;
 	unsigned long cmdline_buf_len;
 
+	void *dtb_buf;
+	unsigned long dtb_buf_len;
+
 	/* File operations provided by image loader */
 	struct kexec_file_ops *fops;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9891464..7278329 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -96,6 +96,11 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 		image->initrd_buf = NULL;
 	}
 
+	if (image->dtb_buf) {
+		vfree(image->dtb_buf);
+		image->dtb_buf = NULL;
+	}
+
 	if (image->cmdline_buf) {
 		kfree(image->cmdline_buf);
 		image->cmdline_buf = NULL;
-- 
2.9.0
