From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jul 2018 15:57:54 +0900
Subject: [PATCH v12 11/16] arm64: kexec_file: allow for loading Image-format
 kernel
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Message-ID: <20180724065759.19186-12-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides kexec_file_ops for "Image"-format kernel. In this
implementation, a binary is always loaded with a fixed offset identified
in text_offset field of its header.

Regarding signature verification for trusted boot, this patch doesn't
contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
in this series, but file-attribute-based verification is still a viable
option by enabling IMA security subsystem.

You can sign(label) a to-be-kexec'ed kernel image on target file system
with:
    $ evmctl ima_sign --key /path/to/private_key.pem Image

On live system, you must have IMA enforced with, at least, the following
security policy:
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"

See more details about IMA here:
    https://sourceforge.net/p/linux-ima/wiki/Home/

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  28 +++++++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/kexec_image.c        | 108 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 026f7e408f0c..5d102a1054b3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -101,6 +101,34 @@ struct kimage_arch {
 	unsigned long dtb_mem;
 };
 
+/**
+ * struct arm64_image_header - arm64 kernel image header
+ * See Documentation/arm64/booting.txt for details
+ *
+ * @mz_magic: DOS header magic number ('MZ', optional)
+ * @code1: Instruction (branch to stext)
+ * @text_offset: Image load offset
+ * @image_size: Effective image size
+ * @flags: Bit-field flags
+ * @reserved: Reserved
+ * @magic: Magic number
+ * @pe_header: Offset to PE COFF header (optional)
+ **/
+
+struct arm64_image_header {
+	__le16 mz_magic; /* also code0 */
+	__le16 pad;
+	__le32 code1;
+	__le64 text_offset;
+	__le64 image_size;
+	__le64 flags;
+	__le64 reserved[3];
+	__le32 magic;
+	__le32 pe_header;
+};
+
+extern const struct kexec_file_ops kexec_image_ops;
+
 struct kimage;
 
 extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 06281e1ad7ed..a9cc7752f276 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -50,7 +50,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
new file mode 100644
index 000000000000..d64f5e9f9d22
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec image loader
+
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#define pr_fmt(fmt)	"kexec_file(Image): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/memory.h>
+
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm64_image_header *h;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)) ||
+			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void *image_load(struct kimage *image,
+				char *kernel, unsigned long kernel_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct arm64_image_header *h;
+	u64 flags, value;
+	struct kexec_buf kbuf;
+	unsigned long text_offset;
+	struct kexec_segment *kernel_segment;
+	int ret;
+
+	/* Don't support old kernel */
+	h = (struct arm64_image_header *)kernel;
+	if (!h->text_offset)
+		return ERR_PTR(-EINVAL);
+
+	/* Check cpu features */
+	flags = le64_to_cpu(h->flags);
+	value = head_flag_field(flags, HEAD_FLAG_BE);
+	if (((value == HEAD_FLAG_BE) && !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) ||
+	    ((value != HEAD_FLAG_BE) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)))
+		if (!system_supports_mixed_endian())
+			return ERR_PTR(-EINVAL);
+
+	value = head_flag_field(flags, HEAD_FLAG_PAGE_SIZE);
+	if (((value == HEAD_FLAG_PAGE_SIZE_4K) &&
+			!system_supports_4kb_granule()) ||
+	    ((value == HEAD_FLAG_PAGE_SIZE_64K) &&
+			!system_supports_64kb_granule()) ||
+	    ((value == HEAD_FLAG_PAGE_SIZE_16K) &&
+			!system_supports_16kb_granule()))
+		return ERR_PTR(-EINVAL);
+
+	/* Load the kernel */
+	kbuf.image = image;
+	kbuf.buf_min = 0;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	kbuf.buffer = kernel;
+	kbuf.bufsz = kernel_len;
+	kbuf.mem = 0;
+	kbuf.memsz = le64_to_cpu(h->image_size);
+	text_offset = le64_to_cpu(h->text_offset);
+	kbuf.buf_align = MIN_KIMG_ALIGN;
+
+	/* Adjust kernel segment with TEXT_OFFSET */
+	kbuf.memsz += text_offset;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		return ERR_PTR(ret);
+
+	kernel_segment = &image->segment[image->nr_segments - 1];
+	kernel_segment->mem += text_offset;
+	kernel_segment->memsz -= text_offset;
+	image->start = kernel_segment->mem;
+
+	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				kernel_segment->mem, kbuf.bufsz,
+				kernel_segment->memsz);
+
+	/* Load additional data */
+	ret = load_other_segments(image,
+				kernel_segment->mem, kernel_segment->memsz,
+				initrd, initrd_len, cmdline, cmdline_len);
+
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b28fbb0659c9..b8297f10e2ef 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -20,6 +20,7 @@
 #include <asm/byteorder.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_image_ops,
 	NULL
 };
 
-- 
2.18.0
