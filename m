From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 22 Feb 2018 20:17:21 +0900
Subject: [PATCH v8 02/13] kexec_file: make an use of purgatory optional
In-Reply-To: <20180222111732.23051-1-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
Message-ID: <20180222111732.23051-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, no trampline code between old kernel and new kernel will be
required in kexec_file implementation. This patch introduces a new
configuration, ARCH_HAS_KEXEC_PURGATORY, and allows related code to be
compiled in only if necessary.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig | 3 +++
 arch/x86/Kconfig     | 3 +++
 kernel/kexec_file.c  | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..c32a181a7cbb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -552,6 +552,9 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to a list of segments as is the
 	  case for the older kexec call.
 
+config ARCH_HAS_KEXEC_PURGATORY
+	def_bool KEXEC_FILE
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1236b187824..f031c3efe47e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2019,6 +2019,9 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config ARCH_HAS_KEXEC_PURGATORY
+	def_bool KEXEC_FILE
+
 config KEXEC_VERIFY_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e5bcd94c1efb..990adae52151 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -26,7 +26,11 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 static int kexec_calculate_store_digests(struct kimage *image);
+#else
+static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
+#endif
 
 /* Architectures can provide this probe function */
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
@@ -520,6 +524,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 /* Calculate and store the digest of segments */
 static int kexec_calculate_store_digests(struct kimage *image)
 {
@@ -1022,3 +1027,4 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	return 0;
 }
+#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-- 
2.16.2
