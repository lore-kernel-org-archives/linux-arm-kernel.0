From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 15 Sep 2017 19:59:25 +0900
Subject: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*() from
 x86, powerpc
In-Reply-To: <20170915105932.25338-1-takahiro.akashi@linaro.org>
References: <20170915105932.25338-1-takahiro.akashi@linaro.org>
Message-ID: <20170915105932.25338-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_kexec_kernel_*() and arch_kimage_file_post_load_cleanup can now be
duplicated among some architectures, so let's factor them out.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h            |  4 ++
 arch/powerpc/kernel/machine_kexec_file_64.c | 36 ++----------------
 arch/x86/kernel/machine_kexec_64.c          | 59 +----------------------------
 include/linux/kexec.h                       | 26 ++++++++++---
 kernel/kexec_file.c                         | 52 +++++++++++++++++++------
 5 files changed, 70 insertions(+), 107 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 25668bc8cb2a..50810d24e38f 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -94,6 +94,10 @@ static inline bool kdump_in_progress(void)
 #ifdef CONFIG_KEXEC_FILE
 extern struct kexec_file_ops kexec_elf64_ops;
 
+#define arch_kexec_kernel_image_probe arch_kexec_kernel_image_probe
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len);
+
 #ifdef CONFIG_IMA_KEXEC
 #define ARCH_HAS_KIMAGE_ARCH
 
diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 992c0d258e5d..5b7c4a3fbb50 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -31,8 +31,9 @@
 
 #define SLAVE_CODE_SIZE		256
 
-static struct kexec_file_ops *kexec_file_loaders[] = {
+struct kexec_file_ops *kexec_file_loaders[] = {
 	&kexec_elf64_ops,
+	NULL
 };
 
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
@@ -45,38 +46,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	if (image->type == KEXEC_TYPE_CRASH)
 		return -ENOTSUPP;
 
-	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
-		fops = kexec_file_loaders[i];
-		if (!fops || !fops->probe)
-			continue;
-
-		ret = fops->probe(buf, buf_len);
-		if (!ret) {
-			image->fops = fops;
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
-int arch_kimage_file_post_load_cleanup(struct kimage *image)
-{
-	if (!image->fops || !image->fops->cleanup)
-		return 0;
-
-	return image->fops->cleanup(image->image_loader_data);
+	return kexec_kernel_image_probe(image, buf, buf_len);
 }
 
 /**
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cb0a30473c23..f4df8315d001 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -30,8 +30,9 @@
 #include <asm/set_memory.h>
 
 #ifdef CONFIG_KEXEC_FILE
-static struct kexec_file_ops *kexec_file_loaders[] = {
+struct kexec_file_ops *kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
+		NULL
 };
 #endif
 
@@ -361,62 +362,6 @@ void arch_crash_save_vmcoreinfo(void)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-				  unsigned long buf_len)
-{
-	int i, ret = -ENOEXEC;
-	struct kexec_file_ops *fops;
-
-	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
-		fops = kexec_file_loaders[i];
-		if (!fops || !fops->probe)
-			continue;
-
-		ret = fops->probe(buf, buf_len);
-		if (!ret) {
-			image->fops = fops;
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	vfree(image->arch.elf_headers);
-	image->arch.elf_headers = NULL;
-
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
-int arch_kimage_file_post_load_cleanup(struct kimage *image)
-{
-	if (!image->fops || !image->fops->cleanup)
-		return 0;
-
-	return image->fops->cleanup(image->image_loader_data);
-}
-
-#ifdef CONFIG_KEXEC_VERIFY_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
-				 unsigned long kernel_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(kernel, kernel_len);
-}
-#endif
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index dd056fab9e35..4a2b24d94e04 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -134,6 +134,26 @@ struct kexec_file_ops {
 #endif
 };
 
+int kexec_kernel_image_probe(struct kimage *image, void *buf,
+			     unsigned long buf_len);
+void *kexec_kernel_image_load(struct kimage *image);
+int kexec_kernel_post_load_cleanup(struct kimage *image);
+int kexec_kernel_verify_sig(struct kimage *image, void *buf,
+			    unsigned long buf_len);
+
+#ifndef arch_kexec_kernel_image_probe
+#define arch_kexec_kernel_image_probe kexec_kernel_image_probe
+#endif
+#ifndef arch_kexec_kernel_image_load
+#define arch_kexec_kernel_image_load kexec_kernel_image_load
+#endif
+#ifndef arch_kimage_file_post_load_cleanup
+#define arch_kimage_file_post_load_cleanup kexec_kernel_post_load_cleanup
+#endif
+#ifndef arch_kexec_kernel_verify_sig
+#define arch_kexec_kernel_verify_sig kexec_kernel_verify_sig
+#endif
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
@@ -276,12 +296,6 @@ int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len);
-void * __weak arch_kexec_kernel_image_load(struct kimage *image);
-int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len);
 int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
 					Elf_Shdr *sechdrs, unsigned int relsec);
 int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9f48f4412297..6203b54e04c5 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -26,30 +26,60 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+__weak struct kexec_file_ops *kexec_file_loaders[] = {NULL};
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
-/* Architectures can provide this probe function */
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len)
+int kexec_kernel_image_probe(struct kimage *image, void *buf,
+			     unsigned long buf_len)
 {
-	return -ENOEXEC;
+	int i, ret = -ENOEXEC;
+	struct kexec_file_ops *fops;
+
+	for (i = 0; ; i++) {
+		fops = kexec_file_loaders[i];
+		if (!fops || !fops->probe)
+			break;
+
+		ret = fops->probe(buf, buf_len);
+		if (!ret) {
+			image->fops = fops;
+			return ret;
+		}
+	}
+
+	return ret;
 }
 
-void * __weak arch_kexec_kernel_image_load(struct kimage *image)
+void *kexec_kernel_image_load(struct kimage *image)
 {
-	return ERR_PTR(-ENOEXEC);
+	if (!image->fops || !image->fops->load)
+		return ERR_PTR(-ENOEXEC);
+
+	return image->fops->load(image, image->kernel_buf,
+				 image->kernel_buf_len, image->initrd_buf,
+				 image->initrd_buf_len, image->cmdline_buf,
+				 image->cmdline_buf_len);
 }
 
-int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
+int kexec_kernel_post_load_cleanup(struct kimage *image)
 {
-	return -EINVAL;
+	if (!image->fops || !image->fops->cleanup)
+		return 0;
+
+	return image->fops->cleanup(image->image_loader_data);
 }
 
 #ifdef CONFIG_KEXEC_VERIFY_SIG
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
+int kexec_kernel_verify_sig(struct kimage *image, void *buf,
+			    unsigned long buf_len)
 {
-	return -EKEYREJECTED;
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
 }
 #endif
 
-- 
2.14.1
