From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:49 +0900
Subject: [PATCH v16 10/16] arm64: kexec_file: load initrd and device-tree
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-11-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

load_other_segments() is expected to allocate and place all the necessary
memory segments other than kernel, including initrd and device-tree
blob (and elf core header for crash).
While most of the code was borrowed from kexec-tools' counterpart,
users may not be allowed to specify dtb explicitly, instead, the dtb
presented by the original boot loader is reused.

arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
specific data allocated in load_other_segments().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  17 +++
 arch/arm64/kernel/machine_kexec_file.c | 185 +++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..bbb5f505b0ba 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,23 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *dtb;
+	unsigned long dtb_mem;
+};
+
+struct kimage;
+
+extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c38a8048ed00..b433d947d486 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,197 @@
  * Copyright (C) 2018 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  *
+ * Most code is derived from arm64 port of kexec-tools
  */
 
 #define pr_fmt(fmt) "kexec_file: " fmt
 
+#include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+/* relevant device tree properties */
+#define FDT_PSTR_INITRD_STA	"linux,initrd-start"
+#define FDT_PSTR_INITRD_END	"linux,initrd-end"
+#define FDT_PSTR_BOOTARGS	"bootargs"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.dtb);
+	image->arch.dtb = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
+
+static int setup_dtb(struct kimage *image,
+		     unsigned long initrd_load_addr, unsigned long initrd_len,
+		     char *cmdline, void *dtb)
+{
+	int nodeoffset;
+	int ret;
+
+	nodeoffset = fdt_path_offset(dtb, "/chosen");
+	if (nodeoffset < 0)
+		return -EINVAL;
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(dtb, nodeoffset, FDT_PSTR_BOOTARGS,
+							cmdline);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	} else {
+		ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			return -EINVAL;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_INITRD_STA,
+							initrd_load_addr);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_INITRD_END,
+						initrd_load_addr + initrd_len);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	} else {
+		ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_INITRD_STA);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			return -EINVAL;
+
+		ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * More space needed so that we can add initrd and bootargs.
+ */
+#define DTB_EXTRA_SPACE 0x1000
+
+static int create_dtb(struct kimage *image,
+		      unsigned long initrd_load_addr, unsigned long initrd_len,
+		      char *cmdline, void **dtb)
+{
+	void *buf;
+	size_t buf_size;
+	int ret;
+
+	buf_size = fdt_totalsize(initial_boot_params)
+			+ strlen(cmdline) + DTB_EXTRA_SPACE;
+
+	for (;;) {
+		buf = vmalloc(buf_size);
+		if (!buf)
+			return -ENOMEM;
+
+		/* duplicate a device tree blob */
+		ret = fdt_open_into(initial_boot_params, buf, buf_size);
+		if (ret)
+			return -EINVAL;
+
+		ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, buf);
+		if (ret) {
+			vfree(buf);
+			if (ret == -ENOMEM) {
+				/* unlikely, but just in case */
+				buf_size += DTB_EXTRA_SPACE;
+				continue;
+			} else {
+				return ret;
+			}
+		}
+
+		/* trim it */
+		fdt_pack(buf);
+		*dtb = buf;
+
+		return 0;
+	}
+}
+
+int load_other_segments(struct kimage *image,
+			unsigned long kernel_load_addr,
+			unsigned long kernel_size,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline)
+{
+	struct kexec_buf kbuf;
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0, dtb_len;
+	int ret = 0;
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kernel_load_addr + kernel_size;
+
+	/* load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = 0;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = 0;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
+						+ (unsigned long)SZ_1G * 32;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+		initrd_load_addr = kbuf.mem;
+
+		pr_debug("Loaded initrd@0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				initrd_load_addr, initrd_len, initrd_len);
+	}
+
+	/* load dtb */
+	ret = create_dtb(image, initrd_load_addr, initrd_len, cmdline, &dtb);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	dtb_len = fdt_totalsize(dtb);
+	kbuf.buffer = dtb;
+	kbuf.bufsz = dtb_len;
+	kbuf.mem = 0;
+	kbuf.memsz = dtb_len;
+	/* not across 2MB boundary */
+	kbuf.buf_align = SZ_2M;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = true;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+	image->arch.dtb = dtb;
+	image->arch.dtb_mem = kbuf.mem;
+
+	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			kbuf.mem, dtb_len, dtb_len);
+
+	return 0;
+
+out_err:
+	vfree(dtb);
+	return ret;
+}
-- 
2.19.0
