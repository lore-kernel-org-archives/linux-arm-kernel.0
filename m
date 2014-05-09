From: geoff@infradead.org (Geoff Levand)
Date: Fri, 09 May 2014 00:48:17 +0000
Subject: [PATCH 7/8] arm64/kexec: Add core kexec support
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
Message-ID: <64ef27888fa70b3e27ddcf4ca594fa71ab7f7777.1399594544.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S, to the
arm64 architecture that add support for the kexec re-boot mechanism on arm64
(CONFIG_KEXEC).

This implementation supports re-boots of kernels with either PSCI or spin-table
enable methods, but with some limitations on the match of 1st and 2nd stage
kernels.  The known limitations are checked in the kexec_compat_check() routine,
which is called during a kexec_load syscall.  If any limitations are reached an
error is returned by the kexec_load syscall.  Many of the limitations can be
removed with some enhancment to the CPU shutdown management code in
machine_kexec.c.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 MAINTAINERS                         |   9 +
 arch/arm64/Kconfig                  |   8 +
 arch/arm64/include/asm/kexec.h      |  44 +++
 arch/arm64/kernel/Makefile          |   1 +
 arch/arm64/kernel/machine_kexec.c   | 623 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S | 239 ++++++++++++++
 include/uapi/linux/kexec.h          |   1 +
 7 files changed, 925 insertions(+)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 1066264..bb666bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5144,6 +5144,15 @@ F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec.c
 
+KEXEC FOR ARM64
+M:	Geoff Levand <geoff@infradead.org>
+W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+L:	kexec at lists.infradead.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/machine_kexec.c
+F:	arch/arm64/relocate_kernel.S
+
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 L:	keyrings at linux-nfs.org
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e759af5..dcd5ebc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -244,6 +244,14 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 
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
index 0000000..41a6244
--- /dev/null
+++ b/arch/arm64/include/asm/kexec.h
@@ -0,0 +1,44 @@
+#ifndef _ARM64_KEXEC_H
+#define _ARM64_KEXEC_H
+
+#if defined(CONFIG_KEXEC)
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
+#if !defined(__ASSEMBLY__)
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
+/* Function pointer to optional machine-specific reinitialization */
+
+extern void (*kexec_reinit)(void);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_KEXEC */
+
+#endif /* _ARM64_KEXEC_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7d811d9..7272510 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -22,6 +22,7 @@ arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
+arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
new file mode 100644
index 0000000..62779e5
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -0,0 +1,623 @@
+/*
+ * kexec for arm64
+ */
+
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/kexec.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cpu_ops.h>
+#include <asm/system_misc.h>
+
+/* Global variables for the relocate_kernel routine. */
+
+extern const unsigned char relocate_new_kernel[];
+extern const unsigned long relocate_new_kernel_size;
+extern unsigned long kexec_signal_addr;
+extern unsigned long kexec_kimage_head;
+extern unsigned long kexec_dtb_addr;
+extern unsigned long kexec_kimage_start;
+extern unsigned long kexec_spinner_count;
+
+/* Global variables for the kexec_cpu_spin routine. */
+
+extern const unsigned char kexec_cpu_spin[];
+extern const unsigned long kexec_cpu_spin_size;
+
+void (*kexec_reinit)(void);
+
+/**
+ * struct kexec_cpu_info_spin - Info needed for the "spin table" enable method.
+ */
+
+struct kexec_cpu_info_spin {
+	phys_addr_t phy_release_addr; /* cpu order */
+};
+
+/**
+ * struct kexec_cpu_info - Info for a specific cpu in the device tree.
+ */
+
+struct kexec_cpu_info {
+	unsigned int cpu;
+	const struct cpu_operations *cpu_ops;
+	bool spinner;
+	struct kexec_cpu_info_spin spin;
+};
+
+/**
+ * struct kexec_dt_info - Device tree info needed by the local kexec routines.
+ */
+
+struct kexec_dt_info {
+	unsigned int cpu_count;
+	struct kexec_cpu_info *cpu_info;
+	unsigned int spinner_count;
+	phys_addr_t phy_memreserve_addr;
+	unsigned int memreserve_size;
+};
+
+/**
+ * struct kexec_ctx - Kexec runtime context.
+ *
+ * @dt_1st: Device tree info for the 1st stage kernel.
+ * @dt_2nd: Device tree info for the 2nd stage kernel.
+ */
+
+struct kexec_ctx {
+	struct kexec_dt_info dt_1st;
+	struct kexec_dt_info dt_2nd;
+};
+
+static struct kexec_ctx *ctx;
+
+/**
+ * kexec_spin_code_offset - Offset into memreserve area of the spin code.
+ */
+
+static const unsigned int kexec_spin_code_offset = PAGE_SIZE;
+
+/**
+ * kexec_is_dtb - Helper routine to check the device tree header signature.
+ */
+
+static int kexec_is_dtb(__be32 magic)
+{
+	int result = be32_to_cpu(magic) == OF_DT_HEADER;
+
+	return result;
+}
+
+/**
+ * kexec_is_dtb_user - Helper routine to check the device tree header signature.
+ */
+
+static int kexec_is_dtb_user(const void *dtb)
+{
+	__be32 magic;
+
+	get_user(magic, (__be32 *)dtb);
+
+	return kexec_is_dtb(magic);
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
+static void *kexec_copy_dtb(const struct kexec_segment *seg)
+{
+	int result;
+	void *dtb;
+
+	BUG_ON(!seg && !seg->bufsz);
+
+	dtb = kmalloc(seg->bufsz, GFP_KERNEL);
+
+	if (!dtb) {
+		pr_debug("%s: out of memory", __func__);
+		return NULL;
+	}
+
+	result = copy_from_user(dtb, seg->buf, seg->bufsz);
+
+	if (result) {
+		kfree(dtb);
+		return NULL;
+	}
+
+	return dtb;
+}
+
+
+/**
+ * kexec_read_memreserve - Initialize memreserve info from a dtb.
+ */
+
+static int kexec_read_memreserve(const void *dtb, struct kexec_dt_info *info)
+{
+	const struct boot_param_header *h = dtb;
+	struct pair {
+		__be64 phy_addr;
+		__be64 size;
+	} const *pair;
+
+	pair = dtb + be32_to_cpu(h->off_mem_rsvmap);
+
+	if ((pair + 1)->size)
+		pr_warn("kexec: Multiple memreserve regions found.");
+
+	info->phy_memreserve_addr = be64_to_cpu(pair->phy_addr);
+	info->memreserve_size = be64_to_cpu(pair->size);
+
+	pr_debug("%s:%d: memreserve_addr:  %pa (%p)\n", __func__, __LINE__,
+		&info->phy_memreserve_addr,
+		phys_to_virt(info->phy_memreserve_addr));
+	pr_debug("%s:%d: memreserve_size:  %u (%xh)\n", __func__, __LINE__,
+		info->memreserve_size, info->memreserve_size);
+
+	return 0;
+}
+
+/**
+ * kexec_setup_cpu_spin - Initialize cpu spin info from a device tree cpu node.
+ */
+
+static int kexec_setup_cpu_spin(const struct device_node *dn,
+	struct kexec_cpu_info_spin *info)
+{
+	int result;
+	u64 t1;
+
+	memset(info, 0, sizeof(*info));
+
+	result = of_property_read_u64(dn, "cpu-release-addr", &t1);
+
+	if (result) {
+		pr_warn("kexec: Read cpu-release-addr failed.\n");
+		return result;
+	}
+
+	info->phy_release_addr = le64_to_cpu(t1);
+
+	return 0;
+}
+
+/**
+ * kexec_cpu_info_init - Initialize an array of kexec_cpu_info structures.
+ *
+ * Allocates a cpu info array and fills it with info for all cpus found in
+ * the device tree passed.  The cpu info array is zero terminated.
+ */
+
+int kexec_cpu_info_init(const struct device_node *dn,
+	struct kexec_dt_info *info)
+{
+	int result;
+	unsigned int cpu;
+	const struct device_node *i;
+
+	info->cpu_info = kmalloc(
+		(1 + info->cpu_count) * sizeof(struct kexec_cpu_info),
+		GFP_KERNEL);
+
+	if (!info->cpu_info) {
+		pr_debug("%s: out of memory", __func__);
+		return -ENOMEM;
+	}
+
+	info->spinner_count = 0;
+
+	for (cpu = 0, i = dn; cpu < info->cpu_count; cpu++) {
+		struct kexec_cpu_info *cpu_info = &info->cpu_info[cpu];
+
+		i = of_find_node_by_type((struct device_node *)i, "cpu");
+
+		BUG_ON(!i);
+
+		cpu_info->cpu = cpu;
+
+		result = cpu_read_ops((struct device_node *)i, cpu,
+			&cpu_info->cpu_ops);
+
+		if (result)
+			goto on_error;
+
+		cpu_info->spinner = !strcmp(cpu_info->cpu_ops->name,
+			"spin-table");
+
+		if (cpu_info->spinner) {
+			info->spinner_count++;
+
+			result = kexec_setup_cpu_spin(i, &cpu_info->spin);
+
+			if (result)
+				goto on_error;
+		}
+
+		if (cpu_info->spinner)
+			pr_devel("%s:%d: cpu-%u: '%s' release_addr: %pa\n",
+				__func__, __LINE__, cpu,
+				cpu_info->cpu_ops->name,
+				&cpu_info->spin.phy_release_addr);
+		else
+			pr_devel("%s:%d: cpu-%u: '%s'\n", __func__, __LINE__,
+				cpu, cpu_info->cpu_ops->name);
+	}
+
+	return 0;
+
+on_error:
+	kfree(info->cpu_info);
+	info->cpu_info = NULL;
+
+	return result;
+}
+
+/**
+ * kexec_dt_info_init - Initialize a kexec_dt_info structure from a dtb.
+ */
+
+int kexec_dt_info_init(void *dtb, struct kexec_dt_info *info)
+{
+	int result;
+	struct device_node *i;
+	struct device_node *dn;
+
+	if (!dtb) {
+		/* 1st stage. */
+		dn = NULL;
+	} else {
+		/* 2nd stage. */
+
+		of_fdt_unflatten_tree(dtb, &dn);
+
+		result = kexec_read_memreserve(dtb, info);
+
+		if (result)
+			return result;
+	}
+
+	/*
+	 * We may need to work with offline cpus to get them into the correct
+	 * state for a given enable method to work, and so need an info_array
+	 * that has info about all the platform cpus.
+	 */
+
+	for (info->cpu_count = 0, i = dn; (i = of_find_node_by_type(i, "cpu"));
+		info->cpu_count++)
+		(void)0;
+
+	pr_devel("%s:%d: cpu_count: %u\n", __func__, __LINE__, info->cpu_count);
+
+	if (!info->cpu_count) {
+		pr_err("kexec: Error: No cpu nodes found in device tree.\n");
+		return -EINVAL;
+	}
+
+	result = kexec_cpu_info_init(dn, info);
+
+	return result;
+}
+
+/**
+* kexec_spin_2 - The identity map spin loop.
+*/
+
+void kexec_spin_2(unsigned int cpu, phys_addr_t signal_1,
+	phys_addr_t phy_release_addr, phys_addr_t signal_2)
+{
+	typedef void (*fn_t)(phys_addr_t, phys_addr_t);
+
+	fn_t spin_3;
+
+	atomic_dec((atomic_t *)signal_1);
+
+	/* Wait for next signal. */
+
+	while (!atomic_read((atomic_t *)signal_2))
+		(void)0;
+
+	/* Enter the memreserve spin code. */
+
+	spin_3 = (fn_t)(ctx->dt_2nd.phy_memreserve_addr
+		+ kexec_spin_code_offset);
+
+	spin_3(phy_release_addr, signal_2);
+
+	BUG();
+}
+
+static atomic_t spin_1_signal = ATOMIC_INIT(0);
+static atomic_t spin_2_signal = ATOMIC_INIT(0);
+
+/**
+* kexec_spin_1 - The virtual address spin loop.
+*/
+
+static void kexec_spin_1(unsigned int cpu)
+{
+	typedef void (*fn_t)(unsigned int, phys_addr_t, phys_addr_t,
+		phys_addr_t);
+	fn_t fn;
+
+	pr_devel("%s:%d: id: %u\n", __func__, __LINE__, smp_processor_id());
+
+	/* Wait for the signal. */
+
+	while (!atomic_read(&spin_1_signal))
+		(void)0;
+
+	/* Enter the identity mapped spin code. */
+
+	setup_mm_for_reboot();
+
+	fn = (fn_t)virt_to_phys(kexec_spin_2);
+
+	fn(cpu, virt_to_phys(&spin_1_signal),
+		ctx->dt_2nd.cpu_info[cpu].spin.phy_release_addr,
+		virt_to_phys(&spin_2_signal));
+
+	BUG();
+}
+
+/**
+* kexec_restart - Called after the identity mapping is enabled.
+*/
+
+static void kexec_restart(void)
+{
+	unsigned long timeout = 1000;
+
+	atomic_set(&spin_1_signal, ctx->dt_1st.spinner_count - 1);
+
+	__flush_dcache_area(&spin_1_signal, sizeof(spin_1_signal));
+
+	while (timeout-- && atomic64_read(&spin_1_signal))
+		udelay(10);
+}
+
+/**
+* kexec_compat_check - Helper to check compatability of 2nd stage kernel.
+*/
+
+static int kexec_compat_check(const struct kexec_dt_info *dt1,
+	const struct kexec_dt_info *dt2)
+{
+	int result = 0;
+
+	/* No checks needed for psci to psci. */
+
+	if (!dt1->spinner_count && !dt2->spinner_count)
+		goto done;
+
+	/* Check for a cpu count mismatch. */
+
+	if (dt1->cpu_count != dt2->cpu_count) {
+		pr_err("kexec: Error: CPU count mismatch %u -> %u.\n",
+			dt1->cpu_count, dt2->cpu_count);
+		result++;
+	}
+
+	/* Check for an enable method mismatch. */
+
+	if (dt1->spinner_count != dt2->spinner_count) {
+		pr_err("kexec: Error: Enable method mismatch %s -> %s.\n",
+			dt1->cpu_info[0].cpu_ops->name,
+			dt2->cpu_info[0].cpu_ops->name);
+		result++;
+	}
+
+	/* Check for mixed enable methods. */
+
+	if (dt1->spinner_count && (dt1->cpu_count != dt1->spinner_count)) {
+		pr_err("kexec: Error: Mixed enable methods in 1st stage.\n");
+		result++;
+	}
+
+	if (dt2->spinner_count && (dt2->cpu_count != dt2->spinner_count)) {
+		pr_err("kexec: Error: Mixed enable methods in 2nd stage.\n");
+		result++;
+	}
+
+	/* Check for cpus still spinning in secondary_holding_pen. */
+
+	if (NR_CPUS < dt1->spinner_count) {
+		pr_err("kexec: Error: NR_CPUS too small for spin enable %u < %u.\n",
+			NR_CPUS, dt1->spinner_count + 1);
+		result++;
+	}
+
+done:
+	return result ? -EINVAL : 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	if (ctx) {
+		kfree(ctx->dt_1st.cpu_info);
+		ctx->dt_1st.cpu_info = NULL;
+
+		kfree(ctx->dt_2nd.cpu_info);
+		ctx->dt_2nd.cpu_info = NULL;
+	}
+
+	kfree(ctx);
+	ctx = NULL;
+}
+
+void machine_crash_shutdown(struct pt_regs *regs)
+{
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
+	const struct kexec_segment *seg;
+	void *dtb;
+
+	machine_kexec_cleanup(NULL);
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx) {
+		pr_debug("%s: out of memory", __func__);
+		return -ENOMEM;
+	}
+
+	seg = kexec_find_dtb_seg(image);
+	BUG_ON(!seg);
+
+	dtb = kexec_copy_dtb(seg);
+	BUG_ON(!dtb);
+	BUG_ON(!kexec_is_dtb(*(const __be32 *)dtb));
+
+	result = kexec_dt_info_init(NULL, &ctx->dt_1st);
+
+	if (result)
+		goto on_error;
+
+	result = kexec_dt_info_init(dtb, &ctx->dt_2nd);
+
+	if (result)
+		goto on_error;
+
+	if (ctx->dt_2nd.spinner_count) {
+		BUG_ON(!ctx->dt_2nd.phy_memreserve_addr);
+		BUG_ON(kexec_cpu_spin_size >= ctx->dt_2nd.memreserve_size
+			- kexec_spin_code_offset);
+	}
+
+	result = kexec_compat_check(&ctx->dt_1st, &ctx->dt_2nd);
+
+	if (result)
+		goto on_error;
+
+	kexec_dtb_addr = seg->mem;
+	kexec_kimage_start = image->start;
+	kexec_spinner_count = ctx->dt_1st.spinner_count - 1;
+
+	smp_spin_table_set_die(kexec_spin_1);
+
+	goto on_exit;
+
+on_error:
+	machine_kexec_cleanup(NULL);
+on_exit:
+	kfree(dtb);
+
+	return result;
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
+	unsigned int cpu;
+
+	BUG_ON(relocate_new_kernel_size > KEXEC_CONTROL_PAGE_SIZE);
+	BUG_ON(num_online_cpus() > 1);
+
+	pr_devel("%s:%d: id: %u\n", __func__, __LINE__, smp_processor_id());
+
+	kexec_kimage_head = image->head;
+	kexec_signal_addr = virt_to_phys(&spin_2_signal);
+
+	reboot_code_buffer_phys = page_to_phys(image->control_code_page);
+	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
+
+	if (ctx->dt_2nd.spinner_count) {
+		void *va;
+
+		/*
+		* Copy the spin code to the 2nd stage memreserve area as
+		* dictated by the arm64 boot specification.
+		*/
+
+		va = phys_to_virt(ctx->dt_2nd.phy_memreserve_addr
+			+ kexec_spin_code_offset);
+
+		memcpy(va, kexec_cpu_spin, kexec_cpu_spin_size);
+
+		flush_icache_range((unsigned long)va,
+			(unsigned long)va + kexec_cpu_spin_size);
+
+		/*
+		 * Zero the release address for all the 2nd stage cpus.
+		 */
+
+		for (cpu = 0; cpu < ctx->dt_2nd.cpu_count; cpu++) {
+			u64 *release_addr;
+
+			if (!ctx->dt_2nd.cpu_info[cpu].spinner)
+				continue;
+
+			release_addr = phys_to_virt(
+				ctx->dt_2nd.cpu_info[cpu].spin.phy_release_addr);
+
+			*release_addr = 0;
+
+			__flush_dcache_area(release_addr, sizeof(u64));
+		}
+	}
+
+	/*
+	 * Copy relocate_new_kernel to the reboot_code_buffer for use
+	 * after the kernel is shut down.
+	 */
+
+	memcpy(reboot_code_buffer, relocate_new_kernel,
+		relocate_new_kernel_size);
+
+	flush_icache_range((unsigned long)reboot_code_buffer,
+		(unsigned long)reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
+
+	/* TODO: Adjust any mismatch in cpu enable methods. */
+
+	pr_info("Bye!\n");
+
+	if (kexec_reinit)
+		kexec_reinit();
+
+	local_irq_disable();
+	local_fiq_disable();
+
+	setup_restart();
+	kexec_restart();
+	soft_restart(reboot_code_buffer_phys);
+}
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
new file mode 100644
index 0000000..15a49d6
--- /dev/null
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -0,0 +1,239 @@
+/*
+ * kexec for arm64
+ */
+
+#include <asm/memory.h>
+#include <asm/page.h>
+
+/*
+ * kexec_cpu_spin - Spin the CPU as described in the arm64/booting.txt document.
+ *
+ * Prototype: void kexec_cpu_spin(phys_addr_t release_addr, phys_addr_t signal);
+ *
+ * The caller must initialize release_addr to zero or a valid address
+ * prior to calling kexec_cpu_spin.  Note that if the MMU will be turned on
+ * or off while the CPU is spinning here this code must be in an identity
+ * mapped page.  The value written to release_addr must be in little endian
+ * order.
+ */
+
+.align 3
+
+.globl kexec_cpu_spin
+kexec_cpu_spin:
+
+	/* Signal that this cpu has entered. */
+1:
+	ldxr    x2, [x1]
+	sub     x2, x2, 1
+	stxr    w3, x2, [x1]
+	cbnz    w3, 1b
+
+
+	/* Spin while release_addr is zero. */
+1:
+	wfe
+	ldr	x4, [x0]
+	cbz	x4, 1b
+
+	/* Convert LE to CPU. */
+
+#if defined(__AARCH64EB__)
+	rev	x4, x4
+#endif
+
+	/* Jump to new kernel. */
+
+	mov	x0, xzr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+
+	br	x4
+
+.align 3
+
+.kexec_cpu_spin_end:
+
+/*
+ * kexec_cpu_spin_size - Byte count for copy operations.
+ */
+
+.globl kexec_cpu_spin_size
+kexec_cpu_spin_size:
+	.quad .kexec_cpu_spin_end - kexec_cpu_spin
+
+
+/*
+ * relocate_new_kernel - Put the 2nd stage kernel image in place and boot it.
+ *
+ * The memory that the old kernel occupies may be overwritten when coping the
+ * new kernel to its final location.  To assure that the relocate_new_kernel
+ * routine which does that copy is not overwritten, all code and data needed
+ * by relocate_new_kernel must be between the symbols relocate_new_kernel and
+ * relocate_new_kernel_end.  The machine_kexec() routine will copy
+ * relocate_new_kernel to the kexec control_code_page, a special page which
+ * has been set up to be preserved during the kernel copy operation.
+ */
+
+/* These definitions correspond to the kimage_entry flags in linux/kexec.h */
+
+#define IND_DESTINATION_BIT 0
+#define IND_INDIRECTION_BIT 1
+#define IND_DONE_BIT        2
+#define IND_SOURCE_BIT      3
+
+.align 3
+
+.globl relocate_new_kernel
+relocate_new_kernel:
+
+	/* Signal secondary cpus to enter the memreserve spin code. */
+
+	ldr	x1, kexec_signal_addr
+	ldr	x2, kexec_spinner_count
+	str	x2, [x1]
+
+	/* Wait for all secondary cpus to enter. */
+1:
+	ldr	x2, [x1]
+	cbnz	x2, 1b
+
+	/* Copy the new kernel image. */
+
+	ldr	x10, kexec_kimage_head		/* x10 = entry */
+
+	/* Check if the new kernel needs relocation. */
+
+	cbz	x10, .done
+	tbnz	x10, IND_DONE_BIT, .done
+
+	/* Setup loop variables. */
+
+	mov	x12, xzr			/* x12 = ptr */
+	mov	x13, xzr			/* x13 = dest */
+
+.loop:
+	/* addr = entry & PAGE_MASK */
+
+	and	x14, x10, PAGE_MASK		/* x14 = addr */
+
+	/* switch (entry & IND_FLAGS) */
+
+.case_source:
+	tbz	x10, IND_SOURCE_BIT, .case_indirection
+
+	/* copy_page(x20 = dest, x21 = addr) */
+
+	mov x20, x13
+	mov x21, x14
+
+	prfm	pldl1strm, [x21, #64]
+1:	ldp	x22, x23, [x21]
+	ldp	x24, x25, [x21, #16]
+	ldp	x26, x27, [x21, #32]
+	ldp	x28, x29, [x21, #48]
+	add	x21, x21, #64
+	prfm	pldl1strm, [x21, #64]
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
+	add	x13, x13, PAGE_SIZE
+	b	.next_entry
+
+.case_indirection:
+	tbz	x10, IND_INDIRECTION_BIT, .case_destination
+
+	/* ptr = addr */
+
+	mov	x12, x14
+	b	.next_entry
+
+.case_destination:
+	tbz	x10, IND_DESTINATION_BIT, .next_entry
+
+	/* dest = addr */
+
+	mov	x13, x14
+
+.next_entry:
+	/* entry = *ptr++ */
+
+	ldr	x10, [x12]
+	add	x12, x12, 8
+
+	/* while (!(entry & IND_DONE)) */
+
+	tbz	x10, IND_DONE_BIT, .loop
+
+.done:
+	/* Jump to new kernel. */
+
+	ldr	x0, kexec_dtb_addr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+
+	ldr	x4, kexec_kimage_start
+	br	x4
+
+.align 3
+
+/* The machine_kexec routines set these variables. */
+
+/*
+ * kexec_signal_addr - Physical address of the spin signal variable.
+ */
+
+.globl kexec_signal_addr
+kexec_signal_addr:
+	.quad	0x0
+
+/*
+ * kexec_spinner_count - Count of spinning cpus.
+ */
+
+.globl kexec_spinner_count
+kexec_spinner_count:
+	.quad	0x0
+
+/*
+ * kexec_dtb_addr - The address of the new kernel's device tree.
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
+.relocate_new_kernel_end:
+
+/*
+ * relocate_new_kernel_size - Byte count to copy to kimage control_code_page.
+ */
+
+.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.quad .relocate_new_kernel_end - relocate_new_kernel
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index d6629d4..b0bc56d 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -28,6 +28,7 @@
 #define KEXEC_ARCH_SH      (42 << 16)
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
+#define KEXEC_ARCH_ARM64   (183 << 16)
 
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
-- 
1.9.1
