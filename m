From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Aug 2017 17:18:10 +0900
Subject: [PATCH 13/14] arm64: kexec_file: add Image format support
In-Reply-To: <20170824081811.19299-1-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
Message-ID: <20170824081811.19299-14-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "Image" binary will be loaded at the offset of TEXT_OFFSET from
the start of system memory. TEXT_OFFSET is basically determined from
the header of the image.

Regarding kernel verification, it will be done through
verify_pefile_signature() as arm64's "Image" binary can be seen as
in PE format. This approach is consistent with x86 implementation.

we can sign it with sbsign command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                     |  11 ++--
 arch/arm64/include/asm/kexec_file.h    |  83 ++++++++++++++++++++++++
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/kexec_image.c        | 112 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 5 files changed, 208 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec_file.h
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cf10bc720d9e..c8f603700bdd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -766,18 +766,21 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
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
 	  This option makes kernel signature verification mandatory for
 	  the kexec_file_load() syscall.
 
-	  In addition to that option, you need to enable signature
-	  verification for the corresponding kernel image type being
-	  loaded in order for this to work.
-
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/include/asm/kexec_file.h b/arch/arm64/include/asm/kexec_file.h
new file mode 100644
index 000000000000..5df899aa0d2e
--- /dev/null
+++ b/arch/arm64/include/asm/kexec_file.h
@@ -0,0 +1,83 @@
+#ifndef _ASM_KEXEC_FILE_H
+#define _ASM_KEXEC_FILE_H
+
+extern struct kexec_file_ops kexec_image_ops;
+
+/**
+ * struct arm64_image_header - arm64 kernel image header.
+ *
+ * @pe_sig: Optional PE format 'MZ' signature.
+ * @branch_code: Reserved for instructions to branch to stext.
+ * @text_offset: The image load offset in LSB byte order.
+ * @image_size: An estimated size of the memory image size in LSB byte order.
+ * @flags: Bit flags:
+ *  Bit 7.0: Image byte order, 1=MSB.
+ * @reserved_1: Reserved.
+ * @magic: Magic number, "ARM\x64".
+ * @pe_header: Optional offset to a PE format header.
+ **/
+
+struct arm64_image_header {
+	u8 pe_sig[2];
+	u16 branch_code[3];
+	u64 text_offset;
+	u64 image_size;
+	u8 flags[8];
+	u64 reserved_1[3];
+	u8 magic[4];
+	u32 pe_header;
+};
+
+static const u8 arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
+static const u8 arm64_image_pe_sig[2] = {'M', 'Z'};
+static const u64 arm64_image_flag_7_be = 0x01U;
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
+/**
+ * arm64_header_check_msb - Helper to check the arm64 image header.
+ *
+ * Returns non-zero if the image was built as big endian.
+ */
+
+static inline int arm64_header_check_msb(const struct arm64_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return !!(h->flags[7] & arm64_image_flag_7_be);
+}
+#endif  /* _ASM_KEXE_FILE_H */
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
index 000000000000..db4aa1379fec
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,112 @@
+/*
+ * Kexec image loader
+
+ * Copyright (C) 2017 Linaro Limited
+ * Authors: AKASHI Takahiro <takahiro.akashi@linaro.org>
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
+#include <asm/kexec_file.h>
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
+	pr_debug("%s: PE format: %s\n", __func__,
+		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
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
+	if (h->image_size) {
+		kbuf.memsz = le64_to_cpu(h->image_size);
+		text_offset = le64_to_cpu(h->text_offset);
+	} else {
+		/* v3.16 or older */
+		kbuf.memsz = kbuf.bufsz; /* NOTE: not including BSS */
+		text_offset = 0x80000;
+	}
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
+struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 012063307001..ab3b19d51727 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -27,7 +27,11 @@
 static int __dt_root_addr_cells;
 static int __dt_root_size_cells;
 
-static struct kexec_file_ops *kexec_file_loaders[0];
+static struct kexec_file_ops *kexec_file_loaders[] = {
+#ifdef CONFIG_KEXEC_FILE_IMAGE_FMT
+	&kexec_image_ops,
+#endif
+};
 
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len)
-- 
2.14.1
