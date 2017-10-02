From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  2 Oct 2017 15:14:28 +0900
Subject: [PATCH v4 07/10] arm64: kexec_file: load initrd,
 device-tree and purgatory segments
In-Reply-To: <20171002061431.11117-1-takahiro.akashi@linaro.org>
References: <20171002061431.11117-1-takahiro.akashi@linaro.org>
Message-ID: <20171002061431.11117-8-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

load_other_segments() sets up and adds all the memory segments necessary
other than kernel, including initrd, device-tree blob and purgatory.
Most of the code was borrowed from kexec-tools' counterpart.

arch_kimage_kernel_post_load_cleanup() is meant to free arm64-specific data
allocated for loading kernel.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  22 ++++
 arch/arm64/kernel/Makefile             |   3 +-
 arch/arm64/kernel/machine_kexec_file.c | 213 +++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..2fadd3cbf3af 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,28 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *dtb_buf;
+};
+
+struct kimage;
+
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
+extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
+
+extern int setup_dtb(struct kimage *image,
+		unsigned long initrd_load_addr, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len,
+		char **dtb_buf, size_t *dtb_buf_len);
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f2b4e816b6de..5df003d6157c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -48,8 +48,9 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
+arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..8a09d89f6266
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -0,0 +1,213 @@
+/*
+ * kexec_file for arm64
+ *
+ * Copyright (C) 2017 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * Most code is derived from arm64 port of kexec-tools
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+
+static int __dt_root_addr_cells;
+static int __dt_root_size_cells;
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL
+};
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.dtb_buf);
+	image->arch.dtb_buf = NULL;
+
+	return _kexec_kernel_post_load_cleanup(image);
+}
+
+int arch_kexec_walk_mem(struct kexec_buf *kbuf, int (*func)(u64, u64, void *))
+{
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return walk_iomem_res_desc(crashk_res.desc,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					crashk_res.start, crashk_res.end,
+					kbuf, func);
+	else if (kbuf->top_down)
+		return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
+	else
+		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
+}
+
+int setup_dtb(struct kimage *image,
+		unsigned long initrd_load_addr, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len,
+		char **dtb_buf, size_t *dtb_buf_len)
+{
+	char *buf = NULL;
+	size_t buf_size;
+	int nodeoffset;
+	u64 value;
+	int range_len;
+	int ret;
+
+	/* duplicate dt blob */
+	buf_size = fdt_totalsize(initial_boot_params);
+	range_len = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
+
+	if (initrd_load_addr)
+		buf_size += fdt_prop_len("initrd-start", sizeof(u64))
+				+ fdt_prop_len("initrd-end", sizeof(u64));
+
+	if (cmdline)
+		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);
+
+	buf = vmalloc(buf_size);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = fdt_open_into(initial_boot_params, buf, buf_size);
+	if (ret)
+		goto out_err;
+
+	nodeoffset = fdt_path_offset(buf, "/chosen");
+	if (nodeoffset < 0)
+		goto out_err;
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop(buf, nodeoffset, "bootargs",
+						cmdline, cmdline_len + 1);
+		if (ret)
+			goto out_err;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		value = cpu_to_fdt64(initrd_load_addr);
+		ret = fdt_setprop(buf, nodeoffset, "initrd-start",
+				&value, sizeof(value));
+		if (ret)
+			goto out_err;
+
+		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
+		ret = fdt_setprop(buf, nodeoffset, "initrd-end",
+				&value, sizeof(value));
+		if (ret)
+			goto out_err;
+	}
+
+	/* trim a buffer */
+	fdt_pack(buf);
+	*dtb_buf = buf;
+	*dtb_buf_len = fdt_totalsize(buf);
+
+	return 0;
+
+out_err:
+	vfree(buf);
+	return ret;
+}
+
+int load_other_segments(struct kimage *image, unsigned long kernel_load_addr,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline, unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	unsigned long initrd_load_addr = 0;
+	unsigned long purgatory_load_addr, dtb_load_addr;
+	char *dtb = NULL;
+	unsigned long dtb_len;
+	int ret = 0;
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kernel_load_addr;
+
+	/* Load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = PAGE_SIZE;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
+						+ (unsigned long)SZ_1G * 31;
+		kbuf.top_down = 0;
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
+	/* Load dtb blob */
+	ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, cmdline_len, &dtb, &dtb_len);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	kbuf.buffer = dtb;
+	kbuf.bufsz = dtb_len;
+	kbuf.memsz = dtb_len;
+	/* not across 2MB boundary */
+	kbuf.buf_align = SZ_2M;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = 1;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+	dtb_load_addr = kbuf.mem;
+	image->arch.dtb_buf = dtb;
+
+	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			dtb_load_addr, dtb_len, dtb_len);
+
+	/* Load purgatory  */
+	ret = kexec_load_purgatory(image, kernel_load_addr, ULONG_MAX, 1,
+				   &purgatory_load_addr);
+	if (ret) {
+		pr_err("Loading purgatory failed\n");
+		goto out_err;
+	}
+
+	ret = kexec_purgatory_get_set_symbol(image, "kernel_entry",
+				&kernel_load_addr, sizeof(kernel_load_addr), 0);
+	if (ret) {
+		pr_err("Setting symbol (kernel_entry) failed.\n");
+		goto out_err;
+	}
+
+	ret = kexec_purgatory_get_set_symbol(image, "dtb_addr",
+				&dtb_load_addr, sizeof(dtb_load_addr), 0);
+	if (ret) {
+		pr_err("Setting symbol (dtb_addr) failed.\n");
+		goto out_err;
+	}
+
+	pr_debug("Loaded purgatory at 0x%lx\n", purgatory_load_addr);
+
+	return 0;
+
+out_err:
+	vfree(dtb);
+	image->arch.dtb_buf = NULL;
+	return ret;
+}
-- 
2.14.1
