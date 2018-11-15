From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:54 +0900
Subject: [PATCH v16 15/16] arm64: kexec_file: add kernel signature
 verification support
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-16-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch, kernel verification can be done without IMA security
subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.

You can create a signed kernel image with:
    $ sbsign --key ${KEY} --cert ${CERT} Image

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93dc4d36d6db..11f3e1a00588 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -867,6 +867,30 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config KEXEC_VERIFY_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	help
+	  Select this option to verify a signature with loaded kernel
+	  image. If configured, any attempt of loading a image without
+	  valid signature will fail.
+
+	  In addition to that option, you need to enable signature
+	  verification for the corresponding kernel image type being
+	  loaded in order for this to work.
+
+config KEXEC_IMAGE_VERIFY_SIG
+	bool "Enable Image signature verification support"
+	default y
+	depends on KEXEC_VERIFY_SIG
+	depends on EFI && SIGNED_PE_FILE_VERIFICATION
+	help
+	  Enable Image signature verification support.
+
+comment "Support for PE file signature verification disabled"
+	depends on KEXEC_VERIFY_SIG
+	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9f0d8b5d62d3..d1c6c54c22e3 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -12,7 +12,9 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/pe.h>
 #include <linux/string.h>
+#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 				sizeof(h->magic)))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
+							"no" : "yes");
+
 	return 0;
 }
 
@@ -107,7 +113,18 @@ static void *image_load(struct kimage *image,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+static int image_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	return verify_pefile_signature(kernel, kernel_len, NULL,
+				       VERIFYING_KEXEC_PE_SIGNATURE);
+}
+#endif
+
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
 };
-- 
2.19.0
