From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:05 +0000
Subject: [PATCH 11/13] arm64/kexec: Add core kexec support
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <3337b516ad1e1227a29b9068519e3ad91d2b305e.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
arm64 architecture that add support for the kexec re-boot mechanism
(CONFIG_KEXEC) on arm64 platforms.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/Kconfig                  |   8 +
 arch/arm64/include/asm/kexec.h      |  52 +++
 arch/arm64/kernel/Makefile          |   2 +
 arch/arm64/kernel/machine_kexec.c   | 612 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S | 185 +++++++++++
 include/uapi/linux/kexec.h          |   1 +
 6 files changed, 860 insertions(+)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f0d3a2d..6f0e1f1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,6 +313,14 @@ config ARCH_HAS_CACHE_LINE_SIZE
 
 source "mm/Kconfig"
 
+config KEXEC
+	bool "kexec system call"
+	---help---
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is independent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
new file mode 100644
index 0000000..9a3932c
--- /dev/null
+++ b/arch/arm64/include/asm/kexec.h
@@ -0,0 +1,52 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#if !defined(_ARM64_KEXEC_H)
+#define _ARM64_KEXEC_H
+
+/* Maximum physical address we can use pages from */
+
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can reach in physical address mode */
+
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can use for the control code buffer */
+
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
+
+#define KEXEC_CONTROL_PAGE_SIZE	4096
+
+#define KEXEC_ARCH KEXEC_ARCH_ARM64
+
+#define ARCH_HAS_KIMAGE_ARCH
+
+#if !defined(__ASSEMBLY__)
+
+struct kimage_arch {
+	void *ctx;
+};
+
+/**
+ * crash_setup_regs() - save registers for the panic kernel
+ *
+ * @newregs: registers are saved here
+ * @oldregs: registers to be saved (may be %NULL)
+ */
+
+static inline void crash_setup_regs(struct pt_regs *newregs,
+				    struct pt_regs *oldregs)
+{
+}
+
+#endif /* !defined(__ASSEMBLY__) */
+
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index df7ef87..8b7c029 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,6 +29,8 @@ arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
+arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o    \
+					   cpu-properties.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
new file mode 100644
index 0000000..043a3bc
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -0,0 +1,612 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/of_fdt.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cpu_ops.h>
+#include <asm/system_misc.h>
+
+#include "cpu-properties.h"
+
+#if defined(DEBUG)
+static const int debug = 1;
+#else
+static const int debug;
+#endif
+
+typedef struct dtb_buffer {char b[0]; } dtb_t;
+
+/* Global variables for the relocate_kernel routine. */
+
+extern const unsigned char relocate_new_kernel[];
+extern const unsigned long relocate_new_kernel_size;
+extern unsigned long kexec_dtb_addr;
+extern unsigned long kexec_kimage_head;
+extern unsigned long kexec_kimage_start;
+
+/**
+ * struct kexec_boot_info - Boot info needed by the local kexec routines.
+ */
+
+struct kexec_boot_info {
+	unsigned int cpu_count;
+	struct cpu_properties *cp;
+};
+
+/**
+ * struct kexec_ctx - Kexec runtime context.
+ *
+ * @first: Info for the first stage kernel.
+ * @second: Info for the second stage kernel.
+ */
+
+struct kexec_ctx {
+	struct kexec_boot_info first;
+	struct kexec_boot_info second;
+};
+
+static struct kexec_ctx *kexec_image_to_ctx(struct kimage *image)
+{
+	return (struct kexec_ctx *)image->arch.ctx;
+}
+
+static struct kexec_ctx *current_ctx;
+
+static int kexec_ctx_alloc(struct kimage *image)
+{
+	BUG_ON(image->arch.ctx);
+
+	image->arch.ctx = kmalloc(sizeof(struct kexec_ctx), GFP_KERNEL);
+
+	if (!image->arch.ctx)
+		return -ENOMEM;
+
+	current_ctx = (struct kexec_ctx *)image->arch.ctx;
+
+	return 0;
+}
+
+static void kexec_ctx_free(struct kexec_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	kfree(ctx->first.cp);
+	ctx->first.cp = NULL;
+
+	kfree(ctx->second.cp);
+	ctx->second.cp = NULL;
+
+	kfree(ctx);
+}
+
+static void kexec_ctx_clean(struct kimage *image)
+{
+	kexec_ctx_free(image->arch.ctx);
+	image->arch.ctx = NULL;
+}
+
+/**
+ * kexec_is_dtb - Helper routine to check the device tree header signature.
+ */
+
+static bool kexec_is_dtb(__be32 magic)
+{
+	return be32_to_cpu(magic) == OF_DT_HEADER;
+}
+
+/**
+ * kexec_is_dtb_user - For debugging output.
+ */
+
+static bool kexec_is_dtb_user(const dtb_t *dtb)
+{
+	__be32 magic;
+
+	return get_user(magic, (__be32 *)dtb) ? false : kexec_is_dtb(magic);
+}
+
+/**
+ * kexec_list_walk - Helper to walk the kimage page list.
+ */
+
+#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
+
+static void kexec_list_walk(void *ctx, unsigned long kimage_head,
+	void (*cb)(void *ctx, unsigned int flag, void *addr, void *dest))
+{
+	void *dest;
+	unsigned long *entry;
+
+	for (entry = &kimage_head, dest = NULL; ; entry++) {
+		unsigned int flag = *entry & IND_FLAGS;
+		void *addr = phys_to_virt(*entry & PAGE_MASK);
+
+		switch (flag) {
+		case IND_INDIRECTION:
+			entry = (unsigned long *)addr - 1;
+			cb(ctx, flag, addr, NULL);
+			break;
+		case IND_DESTINATION:
+			dest = addr;
+			cb(ctx, flag, addr, NULL);
+			break;
+		case IND_SOURCE:
+			cb(ctx, flag, addr, dest);
+			dest += PAGE_SIZE;
+			break;
+		case IND_DONE:
+			cb(ctx, flag , NULL, NULL);
+			return;
+		default:
+			pr_devel("%s:%d unknown flag %xh\n", __func__, __LINE__,
+				flag);
+			cb(ctx, flag, addr, NULL);
+			break;
+		}
+	}
+}
+
+/**
+ * kexec_image_info - For debugging output.
+ */
+
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *image)
+{
+	if (debug) {
+		unsigned long i;
+
+		pr_devel("%s:%d:\n", func, line);
+		pr_devel("  kexec image info:\n");
+		pr_devel("    type:        %d\n", image->type);
+		pr_devel("    start:       %lx\n", image->start);
+		pr_devel("    head:        %lx\n", image->head);
+		pr_devel("    nr_segments: %lu\n", image->nr_segments);
+
+		for (i = 0; i < image->nr_segments; i++) {
+			pr_devel("      segment[%lu]: %016lx - %016lx, "
+				"%lxh bytes, %lu pages\n",
+				i,
+				image->segment[i].mem,
+				image->segment[i].mem + image->segment[i].memsz,
+				image->segment[i].memsz,
+				image->segment[i].memsz /  PAGE_SIZE);
+
+			if (kexec_is_dtb_user(image->segment[i].buf))
+				pr_devel("        dtb segment\n");
+		}
+	}
+}
+
+/**
+ * kexec_find_dtb_seg - Helper routine to find the dtb segment.
+ */
+
+static const struct kexec_segment *kexec_find_dtb_seg(
+	const struct kimage *image)
+{
+	int i;
+
+	for (i = 0; i < image->nr_segments; i++) {
+		if (kexec_is_dtb_user(image->segment[i].buf))
+			return &image->segment[i];
+	}
+
+	return NULL;
+}
+
+/**
+ * kexec_copy_dtb - Helper routine to copy dtb from user space.
+ */
+
+static int kexec_copy_dtb(const struct kexec_segment *seg, dtb_t **dtb)
+{
+	int result;
+
+	BUG_ON(!seg && !seg->bufsz);
+
+	*dtb = kmalloc(seg->bufsz, GFP_KERNEL);
+
+	if (!*dtb) {
+		pr_err("%s: Error: Out of memory.", __func__);
+		return -ENOMEM;
+	}
+
+	result = copy_from_user(*dtb, seg->buf, seg->bufsz);
+
+	if (result) {
+		pr_err("%s: Error: copy_from_user failed.", __func__);
+		kfree(*dtb);
+		*dtb = NULL;
+	}
+
+	return result;
+}
+
+/**
+ * kexec_cpu_info_init - Initialize an array of kexec_cpu_info structures.
+ *
+ * Allocates a cpu info array and fills it with info for all cpus found in
+ * the device tree passed.
+ */
+
+static int kexec_cpu_info_init(const struct device_node *dn,
+	struct kexec_boot_info *info)
+{
+	int result;
+	unsigned int cpu;
+
+	info->cp = kmalloc(
+		info->cpu_count * sizeof(*info->cp), GFP_KERNEL);
+
+	if (!info->cp) {
+		pr_err("%s: Error: Out of memory.", __func__);
+		return -ENOMEM;
+	}
+
+	for (cpu = 0; cpu < info->cpu_count; cpu++) {
+		struct cpu_properties *cp = &info->cp[cpu];
+
+		dn = of_find_node_by_type((struct device_node *)dn, "cpu");
+
+		if (!dn) {
+			pr_devel("%s:%d: bad node\n", __func__, __LINE__);
+			goto on_error;
+		}
+
+		result = read_cpu_properties(cp, dn);
+
+		if (result) {
+			pr_devel("%s:%d: bad node\n", __func__, __LINE__);
+			goto on_error;
+		}
+
+		if (cp->type == cpu_enable_method_psci)
+			pr_devel("%s:%d: cpu-%u: hwid-%llx, '%s'\n",
+				__func__, __LINE__, cpu, cp->hwid,
+				cp->enable_method);
+		else
+			pr_devel("%s:%d: cpu-%u: hwid-%llx, '%s', "
+				"cpu-release-addr %llx\n",
+				__func__, __LINE__, cpu, cp->hwid,
+				cp->enable_method,
+				cp->cpu_release_addr);
+	}
+
+	return 0;
+
+on_error:
+	kfree(info->cp);
+	info->cp = NULL;
+	return -EINVAL;
+}
+
+/**
+ * kexec_boot_info_init - Initialize a kexec_boot_info structure from a dtb.
+ */
+
+static int kexec_boot_info_init(struct kexec_boot_info *info, dtb_t *dtb)
+{
+	struct device_node *dn;
+	struct device_node *i;
+
+	if (!dtb) {
+		/* 1st stage. */
+		dn = NULL;
+	} else {
+		/* 2nd stage. */
+		of_fdt_unflatten_tree((void *)dtb, &dn);
+
+		if (!dn) {
+			pr_err("%s: Error: of_fdt_unflatten_tree failed.\n",
+				__func__);
+			return -EINVAL;
+		}
+	}
+
+	for (info->cpu_count = 0, i = dn; (i = of_find_node_by_type(i, "cpu"));
+		info->cpu_count++)
+		(void)0;
+
+	pr_devel("%s:%d: cpu_count: %u\n", __func__, __LINE__, info->cpu_count);
+
+	if (!info->cpu_count) {
+		pr_err("%s: Error: No cpu nodes found in device tree.\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return kexec_cpu_info_init(dn, info);
+}
+
+/**
+* kexec_cpu_check - Helper to check compatibility of the 2nd stage kernel.
+*
+* Returns true if everything is OK.
+*/
+
+static bool kexec_cpu_check(struct cpu_properties *cp_1,
+	struct cpu_properties *cp_2)
+{
+	if (debug)
+		BUG_ON(cp_1->hwid != cp_2->hwid);
+
+	if (cp_1->type != cpu_enable_method_psci &&
+		cp_1->type != cpu_enable_method_spin_table) {
+		pr_err("%s:%d: hwid-%llx: Error: "
+			"Unknown enable method: %s.\n", __func__, __LINE__,
+			cp_1->hwid, cp_1->enable_method);
+		return false;
+	}
+
+	if (cp_2->type != cpu_enable_method_psci &&
+		cp_2->type != cpu_enable_method_spin_table) {
+		pr_err("%s:%d: hwid-%llx: Error: "
+			"Unknown enable method: %s.\n", __func__, __LINE__,
+			cp_2->hwid, cp_2->enable_method);
+		return false;
+	}
+
+	if (cp_1->type != cp_2->type) {
+		pr_err("%s:%d: hwid-%llx: Error: "
+			"Enable method mismatch: %s != %s.\n", __func__,
+			__LINE__, cp_1->hwid, cp_1->enable_method,
+			cp_2->enable_method);
+		return false;
+	}
+
+	if (cp_1->type == cpu_enable_method_spin_table) {
+		if (cp_1->cpu_release_addr != cp_2->cpu_release_addr) {
+			pr_err("%s:%d: hwid-%llx: Error: "
+				"cpu-release-addr mismatch %llx != %llx.\n",
+				__func__, __LINE__, cp_1->hwid,
+				cp_1->cpu_release_addr,
+				cp_2->cpu_release_addr);
+			return false;
+		}
+	}
+
+	pr_devel("%s:%d: hwid-%llx: OK\n", __func__, __LINE__, cp_1->hwid);
+
+	return true;
+}
+
+/**
+* kexec_compat_check - Iterator for kexec_cpu_check.
+*/
+
+static int kexec_compat_check(const struct kexec_ctx *ctx)
+{
+	unsigned int cpu_1;
+	unsigned int to_process;
+
+	to_process = min(ctx->first.cpu_count, ctx->second.cpu_count);
+
+	if (ctx->first.cpu_count != ctx->second.cpu_count)
+		pr_warn("%s: Warning: CPU count mismatch %u != %u.\n",
+			__func__, ctx->first.cpu_count, ctx->second.cpu_count);
+
+	for (cpu_1 = 0; cpu_1 < ctx->first.cpu_count; cpu_1++) {
+		unsigned int cpu_2;
+		struct cpu_properties *cp_1 = &ctx->first.cp[cpu_1];
+
+		for (cpu_2 = 0; cpu_2 < ctx->second.cpu_count; cpu_2++) {
+			struct cpu_properties *cp_2 = &ctx->second.cp[cpu_2];
+
+			if (cp_1->hwid != cp_2->hwid)
+				continue;
+
+			if (!kexec_cpu_check(cp_1, cp_2))
+				return -EINVAL;
+
+			to_process--;
+		}
+	}
+
+	if (to_process) {
+		pr_warn("%s: Warning: Failed to process %u CPUs.\n", __func__,
+			to_process);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	kexec_ctx_clean(image);
+}
+
+/**
+ * kexec_check_cpu_die -  Check if cpu_die() will work on secondary processors.
+ */
+
+static int kexec_check_cpu_die(void)
+{
+	unsigned int cpu;
+	unsigned int sum = 0;
+
+	/* For simplicity this also checks the primary CPU. */
+
+	for_each_cpu(cpu, cpu_all_mask) {
+		if (cpu && (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_disable ||
+			cpu_ops[cpu]->cpu_disable(cpu))) {
+			sum++;
+			pr_err("%s: Error: "
+				"CPU %u does not support hot un-plug.\n",
+				__func__, cpu);
+		}
+	}
+
+	return sum ? -EOPNOTSUPP : 0;
+}
+
+/**
+ * machine_kexec_prepare - Prepare for a kexec reboot.
+ *
+ * Called from the core kexec code when a kernel image is loaded.
+ */
+
+int machine_kexec_prepare(struct kimage *image)
+{
+	int result;
+	dtb_t *dtb = NULL;
+	struct kexec_ctx *ctx;
+	const struct kexec_segment *dtb_seg;
+
+	kexec_image_info(image);
+
+	result = kexec_check_cpu_die();
+
+	if (result)
+		goto on_error;
+
+	result = kexec_ctx_alloc(image);
+
+	if (result)
+		goto on_error;
+
+	ctx = kexec_image_to_ctx(image);
+
+	result = kexec_boot_info_init(&ctx->first, NULL);
+
+	if (result)
+		goto on_error;
+
+	dtb_seg = kexec_find_dtb_seg(image);
+
+	if (!dtb_seg) {
+		result = -EINVAL;
+		goto on_error;
+	}
+
+	result = kexec_copy_dtb(dtb_seg, &dtb);
+
+	if (result)
+		goto on_error;
+
+	result = kexec_boot_info_init(&ctx->second, dtb);
+
+	if (result)
+		goto on_error;
+
+	result = kexec_compat_check(ctx);
+
+	if (result)
+		goto on_error;
+
+	kexec_dtb_addr = dtb_seg->mem;
+	kexec_kimage_start = image->start;
+
+	goto on_exit;
+
+on_error:
+	kexec_ctx_clean(image);
+on_exit:
+	kfree(dtb);
+	return result;
+}
+
+/**
+ * kexec_list_flush_cb - Callback to flush the kimage list to PoC.
+ */
+
+static void kexec_list_flush_cb(void *ctx , unsigned int flag,
+	void *addr, void *dest)
+{
+	switch (flag) {
+	case IND_INDIRECTION:
+	case IND_SOURCE:
+		__flush_dcache_area(addr, PAGE_SIZE);
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * machine_kexec - Do the kexec reboot.
+ *
+ * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
+ */
+
+void machine_kexec(struct kimage *image)
+{
+	phys_addr_t reboot_code_buffer_phys;
+	void *reboot_code_buffer;
+	struct kexec_ctx *ctx = kexec_image_to_ctx(image);
+
+	BUG_ON(relocate_new_kernel_size > KEXEC_CONTROL_PAGE_SIZE);
+	BUG_ON(num_online_cpus() > 1);
+	BUG_ON(!ctx);
+
+	kexec_image_info(image);
+
+	kexec_kimage_head = image->head;
+
+	reboot_code_buffer_phys = page_to_phys(image->control_code_page);
+	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
+
+	pr_devel("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
+		(void *)image->control_code_page);
+	pr_devel("%s:%d: reboot_code_buffer_phys:  %p\n", __func__, __LINE__,
+		(void *)reboot_code_buffer_phys);
+	pr_devel("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
+		reboot_code_buffer);
+	pr_devel("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
+		relocate_new_kernel);
+	pr_devel("%s:%d: relocate_new_kernel_size: %lxh(%lu) bytes\n", __func__,
+		__LINE__, relocate_new_kernel_size, relocate_new_kernel_size);
+
+	pr_devel("%s:%d: kexec_dtb_addr:           %p\n", __func__, __LINE__,
+		(void *)kexec_dtb_addr);
+	pr_devel("%s:%d: kexec_kimage_head:        %p\n", __func__, __LINE__,
+		(void *)kexec_kimage_head);
+	pr_devel("%s:%d: kexec_kimage_start:       %p\n", __func__, __LINE__,
+		(void *)kexec_kimage_start);
+
+	/*
+	 * Copy relocate_new_kernel to the reboot_code_buffer for use
+	 * after the kernel is shut down.
+	 */
+
+	memcpy(reboot_code_buffer, relocate_new_kernel,
+		relocate_new_kernel_size);
+
+	/* Assure reboot_code_buffer is copied. */
+
+	mb();
+
+	pr_info("Bye!\n");
+
+	local_disable(DAIF_ALL);
+
+	/* Flush the reboot_code_buffer in preparation for its execution. */
+
+	__flush_dcache_area(reboot_code_buffer, relocate_new_kernel_size);
+
+	/* Flush the kimage list. */
+
+	kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
+
+	soft_restart(reboot_code_buffer_phys);
+}
+
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+	/* Empty routine needed to avoid build errors. */
+}
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
new file mode 100644
index 0000000..92aba9d
--- /dev/null
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -0,0 +1,185 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/assembler.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+
+/* The list entry flags. */
+
+#define IND_DESTINATION_BIT 0
+#define IND_INDIRECTION_BIT 1
+#define IND_DONE_BIT        2
+#define IND_SOURCE_BIT      3
+
+/*
+ * relocate_new_kernel - Put the 2nd stage kernel image in place and boot it.
+ *
+ * The memory that the old kernel occupies may be overwritten when coping the
+ * new kernel to its final location.  To assure that the relocate_new_kernel
+ * routine which does that copy is not overwritten all code and data needed
+ * by relocate_new_kernel must be between the symbols relocate_new_kernel and
+ * relocate_new_kernel_end.  The machine_kexec() routine will copy
+ * relocate_new_kernel to the kexec control_code_page, a special page which
+ * has been set up to be preserved during the kernel copy operation.
+ */
+
+.align 3
+
+.globl relocate_new_kernel
+relocate_new_kernel:
+
+	/* Setup the list loop variables. */
+
+	ldr	x10, kexec_kimage_head		/* x10 = list entry */
+
+	mrs	x0, ctr_el0
+	ubfm	x0, x0, #16, #19
+	mov	x11, #4
+	lsl	x11, x11, x0			/* x11 = dcache line size */
+
+	mov	x12, xzr			/* x12 = segment start */
+	mov	x13, xzr			/* x13 = entry ptr */
+	mov	x14, xzr			/* x14 = copy dest */
+
+	/* Check if the new kernel needs relocation. */
+
+	cbz	x10, .Ldone
+	tbnz	x10, IND_DONE_BIT, .Ldone
+
+.Lloop:
+	and	x15, x10, PAGE_MASK		/* x15 = addr */
+
+	/* Test the entry flags. */
+
+.Ltest_source:
+	tbz	x10, IND_SOURCE_BIT, .Ltest_indirection
+
+	/* copy_page(x20 = dest, x21 = src) */
+
+	mov x20, x14
+	mov x21, x15
+
+1:	ldp	x22, x23, [x21]
+	ldp	x24, x25, [x21, #16]
+	ldp	x26, x27, [x21, #32]
+	ldp	x28, x29, [x21, #48]
+	add	x21, x21, #64
+	stnp	x22, x23, [x20]
+	stnp	x24, x25, [x20, #16]
+	stnp	x26, x27, [x20, #32]
+	stnp	x28, x29, [x20, #48]
+	add	x20, x20, #64
+	tst	x21, #(PAGE_SIZE - 1)
+	b.ne	1b
+
+	/* dest += PAGE_SIZE */
+
+	add	x14, x14, PAGE_SIZE
+	b	.Lnext
+
+.Ltest_indirection:
+	tbz	x10, IND_INDIRECTION_BIT, .Ltest_destination
+
+	/* ptr = addr */
+
+	mov	x13, x15
+	b	.Lnext
+
+.Ltest_destination:
+	tbz	x10, IND_DESTINATION_BIT, .Lnext
+
+	/* flush segment */
+
+	bl	.Lflush
+	mov	x12, x15
+
+	/* dest = addr */
+
+	mov	x14, x15
+
+.Lnext:
+	/* entry = *ptr++ */
+
+	ldr	x10, [x13]
+	add	x13, x13, 8
+
+	/* while (!(entry & DONE)) */
+
+	tbz	x10, IND_DONE_BIT, .Lloop
+
+.Ldone:
+	/* flush last segment */
+
+	bl	.Lflush
+
+	dsb	sy
+	isb
+	ic	ialluis
+
+	/* start_new_kernel */
+
+	ldr	x4, kexec_kimage_start
+	ldr	x0, kexec_dtb_addr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	br	x4
+
+/* flush - x11 = line size, x12 = start addr, x14 = end addr. */
+
+.Lflush:
+	cbz	x12, 2f
+	mov	x0, x12
+	sub	x1, x11, #1
+	bic	x0, x0, x1
+1:	dc	civac, x0
+	add	x0, x0, x11
+	cmp	x0, x14
+	b.lo	1b
+2:	ret
+
+.align 3
+
+/* The machine_kexec routines set these variables. */
+
+/*
+ * kexec_dtb_addr - Physical address of the new kernel's device tree.
+ */
+
+.globl kexec_dtb_addr
+kexec_dtb_addr:
+	.quad	0x0
+
+/*
+ * kexec_kimage_head - Copy of image->head, the list of kimage entries.
+ */
+
+.globl kexec_kimage_head
+kexec_kimage_head:
+	.quad	0x0
+
+/*
+ * kexec_kimage_start - Copy of image->start, the entry point of the new kernel.
+ */
+
+.globl kexec_kimage_start
+kexec_kimage_start:
+	.quad	0x0
+
+.Lrelocate_new_kernel_end:
+
+/*
+ * relocate_new_kernel_size - Number of bytes to copy to the control_code_page.
+ */
+
+.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.quad .Lrelocate_new_kernel_end - relocate_new_kernel
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 6925f5b..04626b9 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -39,6 +39,7 @@
 #define KEXEC_ARCH_SH      (42 << 16)
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
+#define KEXEC_ARCH_ARM64   (183 << 16)
 
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
-- 
1.9.1
