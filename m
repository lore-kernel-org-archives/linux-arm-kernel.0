From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  4 Dec 2017 11:58:01 +0900
Subject: [PATCH v7 11/11] arm64: kexec_file: enable KEXEC_VERIFY_SIG for Image
In-Reply-To: <20171204025801.12161-1-takahiro.akashi@linaro.org>
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
Message-ID: <20171204025801.12161-12-takahiro.akashi@linaro.org>
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
---
 arch/arm64/Kconfig              | 10 ++++++++++
 arch/arm64/include/asm/kexec.h  | 16 ++++++++++++++++
 arch/arm64/kernel/kexec_image.c | 15 +++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c0b021736c10..289c7bede593 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -814,6 +814,16 @@ config KEXEC_FILE_IMAGE_FMT
 	---help---
 	  Select this option to enable 'Image' kernel loading.
 
+config KEXEC_VERIFY_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	select SYSTEM_DATA_VERIFICATION
+	select SIGNED_PE_FILE_VERIFICATION if KEXEC_FILE_IMAGE_FMT
+	---help---
+	  Select this option to verify a signature with loaded kernel
+	  image. If configured, any attempt of loading a image without
+	  valid signature will fail.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index b6469bc64a89..2a63bf5f32ea 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -131,6 +131,7 @@ struct arm64_image_header {
 };
 
 static const u8 arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
+static const u8 arm64_image_pe_sig[2] = {'M', 'Z'};
 
 /**
  * arm64_header_check_magic - Helper to check the arm64 image header.
@@ -152,6 +153,21 @@ static inline int arm64_header_check_magic(const struct arm64_image_header *h)
 		&& h->magic[3] == arm64_image_magic[3]);
 }
 
+/**
+ * arm64_header_check_pe_sig - Helper to check the arm64 image header.
+ *
+ * Returns non-zero if 'MZ' signature is found.
+ */
+
+static inline int arm64_header_check_pe_sig(const struct arm64_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (h->pe_sig[0] == arm64_image_pe_sig[0]
+		&& h->pe_sig[1] == arm64_image_pe_sig[1]);
+}
+
 extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 1c106237901d..b840b6ed6ed9 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/memory.h>
 
@@ -27,6 +28,9 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 	if ((kernel_len < sizeof(*h)) || !arm64_header_check_magic(h))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			(arm64_header_check_pe_sig(h) ? "yes" : "no"));
+
 	return 0;
 }
 
@@ -84,7 +88,18 @@ static void *image_load(struct kimage *image, char *kernel,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_KEXEC_VERIFY_SIG
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
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
 };
-- 
2.14.1
