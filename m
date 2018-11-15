From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:50 +0900
Subject: [PATCH v16 11/16] arm64: kexec_file: allow for loading Image-format
 kernel
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-12-takahiro.akashi@linaro.org>
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
 arch/arm64/include/asm/kexec.h         |   2 +
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/kexec_image.c        | 113 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index bbb5f505b0ba..67e4cb75d1fd 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -101,6 +101,8 @@ struct kimage_arch {
 	unsigned long dtb_mem;
 };
 
+extern const struct kexec_file_ops kexec_image_ops;
+
 struct kimage;
 
 extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 030a39bff117..48868255f09c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -51,7 +51,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
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
index 000000000000..9f0d8b5d62d3
--- /dev/null
+++ b/arch/arm64/kernel/kexec_image.c
@@ -0,0 +1,113 @@
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
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/image.h>
+#include <asm/memory.h>
+
+static int image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm64_image_header *h;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)) ||
+			memcmp(&h->magic, ARM64_IMAGE_MAGIC,
+				sizeof(h->magic)))
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
+	bool be_image, be_kernel;
+	struct kexec_buf kbuf;
+	unsigned long text_offset;
+	struct kexec_segment *kernel_segment;
+	int ret;
+
+	/*
+	 * We require a kernel with an unambiguous Image header. Per
+	 * Documentation/booting.txt, this is the case when image_size
+	 * is non-zero (practically speaking, since v3.17).
+	 */
+	h = (struct arm64_image_header *)kernel;
+	if (!h->image_size)
+		return ERR_PTR(-EINVAL);
+
+	/* Check cpu features */
+	flags = le64_to_cpu(h->flags);
+	be_image = arm64_image_flag_field(flags, ARM64_IMAGE_FLAG_BE);
+	be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	if ((be_image != be_kernel) && !system_supports_mixed_endian())
+		return ERR_PTR(-EINVAL);
+
+	value = arm64_image_flag_field(flags, ARM64_IMAGE_FLAG_PAGE_SIZE);
+	if (((value == ARM64_IMAGE_FLAG_PAGE_SIZE_4K) &&
+			!system_supports_4kb_granule()) ||
+	    ((value == ARM64_IMAGE_FLAG_PAGE_SIZE_64K) &&
+			!system_supports_64kb_granule()) ||
+	    ((value == ARM64_IMAGE_FLAG_PAGE_SIZE_16K) &&
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
+				initrd, initrd_len, cmdline);
+
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_image_ops = {
+	.probe = image_probe,
+	.load = image_load,
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b433d947d486..7e9d5ed3e238 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -26,6 +26,7 @@
 #define FDT_PSTR_BOOTARGS	"bootargs"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_image_ops,
 	NULL
 };
 
-- 
2.19.0
