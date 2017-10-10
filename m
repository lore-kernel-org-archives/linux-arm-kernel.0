From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 10 Oct 2017 15:36:19 +0900
Subject: [PATCH v5 10/10] arm64: kexec_file: add Image format support
In-Reply-To: <20171010063619.6303-1-takahiro.akashi@linaro.org>
References: <20171010063619.6303-1-takahiro.akashi@linaro.org>
Message-ID: <20171010063619.6303-11-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "Image" binary will be loaded at the offset of TEXT_OFFSET from
the start of system memory. TEXT_OFFSET is determined from the header
of the image.

Regarding kernel signature verification, it will be done through
verify_pefile_signature() as arm64's "Image" binary can be seen as
in PE format. This approach is consistent with x86 implementation.

we can sign an image with sbsign command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                     |   7 +++
 arch/arm64/include/asm/kexec.h         |  66 +++++++++++++++++++++
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/kexec_image.c        | 105 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   3 +
 5 files changed, 182 insertions(+)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e37be8a59a88..a9ef277faa3e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -770,10 +770,17 @@ config KEXEC_FILE
 	  In addition to this option, you need to enable a specific type
 	  of image support.
 
+config KEXEC_FILE_IMAGE_FMT
+	bool "Enable Image support"
+	depends on KEXEC_FILE
+	---help---
+	  Select this option to enable 'Image' kernel loading.
+
 config KEXEC_VERIFY_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
 	select SYSTEM_DATA_VERIFICATION
+	select SIGNED_PE_FILE_VERIFICATION if KEXEC_FILE_IMAGE_FMT
 	---help---
 	  Select this option to verify a signature with loaded kernel
 	  image. If configured, any attempt of loading a image without
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index edb702e64a8a..2a63bf5f32ea 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -104,6 +104,72 @@ struct kimage_arch {
 	unsigned long elf_load_addr;
 };
 
+/**
+ * struct arm64_image_header - arm64 kernel image header
+ *
+ * @pe_sig: Optional PE format 'MZ' signature
+ * @branch_code: Instruction to branch to stext
+ * @text_offset: Image load offset, little endian
+ * @image_size: Effective image size, little endian
+ * @flags:
+ *	Bit 0: Kernel endianness. 0=little endian, 1=big endian
+ * @reserved: Reserved
+ * @magic: Magic number, "ARM\x64"
+ * @pe_header: Optional offset to a PE format header
+ **/
+
+struct arm64_image_header {
+	u8 pe_sig[2];
+	u8 pad[2];
+	u32 branch_code;
+	u64 text_offset;
+	u64 image_size;
+	u64 flags;
+	u64 reserved[3];
+	u8 magic[4];
+	u32 pe_header;
+};
+
+static const u8 arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
+static const u8 arm64_image_pe_sig[2] = {'M', 'Z'};
+
+/**
+ * arm64_header_check_magic - Helper to check the arm64 image header.
+ *
+ * Returns non-zero if header is OK.
+ */
+
+static inline int arm64_header_check_magic(const struct arm64_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	if (!h->text_offset)
+		return 0;
+
+	return (h->magic[0] == arm64_image_magic[0]
+		&& h->magic[1] == arm64_image_magic[1]
+		&& h->magic[2] == arm64_image_magic[2]
+		&& h->magic[3] == arm64_image_magic[3]);
+}
+
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
+extern const struct kexec_file_ops kexec_image_ops;
+
 struct kimage;
 
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 5df003d6157c..a1161bab6810 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -51,6 +51,7 @@ arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
+arm64-obj-$(CONFIG_KEXEC_FILE_IMAGE_FMT)	+= kexec_image.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
new file mode 100644
index 000000000000..b840b6ed6ed9
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,105 @@
+/*
+ * Kexec image loader
+
+ * Copyright (C) 2017 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(Image): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/verification.h>
+#include <asm/byteorder.h>
+#include <asm/memory.h>
+
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm64_image_header *h;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if ((kernel_len < sizeof(*h)) || !arm64_header_check_magic(h))
+		return -EINVAL;
+
+	pr_debug("PE format: %s\n",
+			(arm64_header_check_pe_sig(h) ? "yes" : "no"));
+
+	return 0;
+}
+
+static void *image_load(struct kimage *image, char *kernel,
+			    unsigned long kernel_len, char *initrd,
+			    unsigned long initrd_len, char *cmdline,
+			    unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
+	unsigned long text_offset, kernel_load_addr;
+	int ret;
+
+	/* Create elf core header segment */
+	ret = load_crashdump_segments(image);
+	if (ret)
+		goto out;
+
+	/* Load the kernel */
+	kbuf.image = image;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+	} else {
+		kbuf.buf_min = 0;
+		kbuf.buf_max = ULONG_MAX;
+	}
+	kbuf.top_down = 0;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_align = SZ_2M;
+
+	/* Adjust kernel segment with TEXT_OFFSET */
+	kbuf.memsz += text_offset;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out;
+
+	image->segment[image->nr_segments - 1].mem += text_offset;
+	image->segment[image->nr_segments - 1].memsz -= text_offset;
+	kernel_load_addr = kbuf.mem + text_offset;
+
+	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 kernel_load_addr, kbuf.bufsz, kbuf.memsz);
+
+	/* Load additional data */
+	ret = load_other_segments(image, kernel_load_addr,
+			    initrd, initrd_len, cmdline, cmdline_len);
+
+out:
+	return ERR_PTR(ret);
+}
+
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+static int image_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	return verify_pefile_signature(kernel, kernel_len, NULL,
+				       VERIFYING_KEXEC_PE_SIGNATURE);
+}
+#endif
+
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index cdedd4b05cac..75549bd64e24 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -25,6 +25,9 @@ static int __dt_root_addr_cells;
 static int __dt_root_size_cells;
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+#ifdef CONFIG_KEXEC_FILE_IMAGE_FMT
+	&kexec_image_ops,
+#endif
 	NULL
 };
 
-- 
2.14.1
