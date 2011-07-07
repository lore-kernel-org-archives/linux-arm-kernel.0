From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:18 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to define a common idle interface for the kernel
to enter low power modes, this patch provides include files
and code that manages OS calls for low power entry and exit.

In ARM world processor HW is categorized as CPU and Cluster.

Corresponding states defined by this common IF are:

C-state [CPU state]:

0 - RUN MODE
1 - STANDBY
2 - DORMANT (not supported by this patch)
3 - SHUTDOWN

R-state [CLUSTER state]

0 - RUN
1 - STANDBY (not supported by this patch)
2 - L2 RAM retention
3 - SHUTDOWN

idle modes are entered through

cpu_enter_idle(cstate, rstate, flags) [sr_entry.S]

which could replace the current processor.idle entry in proc info,
since it just executes wfi for shallow C-states.

Cluster low-power states are reached if and only if all the CPUs in the cluster
are in low-power mode.

Only one cluster is supported at present, and the kernel infrastructure
should be improved to allow multiple clusters to be defined and
enumerated.

Current page table dir and stack pointers are saved using a per-cpu variable;
this scheme breaks as soon as clusters are added to the kernel.

The code keeps a cpumask of alive CPUs and manages the state transitions
accordingly.

Most of the variables needed when the CPU is powered down (MMU off)
are allocated through a platform hook:

platform_context_pointer(unsigned int size)

that returns memory flat-mapped by this patchset as strongly ordered to
avoid toying with L2 cleaning when a single CPU enters lowpower.

Fully tested on dual-core A9 cluster.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/sr_platform_api.h |   28 ++++
 arch/arm/kernel/sr_api.c               |  197 +++++++++++++++++++++++++++++
 arch/arm/kernel/sr_entry.S             |  213 ++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/sr_platform_api.h
 create mode 100644 arch/arm/kernel/sr_api.c
 create mode 100644 arch/arm/kernel/sr_entry.S

diff --git a/arch/arm/include/asm/sr_platform_api.h b/arch/arm/include/asm/sr_platform_api.h
new file mode 100644
index 0000000..32367be
--- /dev/null
+++ b/arch/arm/include/asm/sr_platform_api.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef ASMARM_SR_PLATFORM_API_H
+#define ASMARM_SR_PLATFORM_API_H
+
+#define SR_SAVE_L2	(1 << 31)
+#define SR_SAVE_SCU	(1 << 30)
+#define SR_SAVE_ALL	(SR_SAVE_L2 | SR_SAVE_SCU)
+
+struct lp_state {
+	u16 cpu;
+	u16 cluster;
+};
+
+extern void (*sr_sleep)(void);
+extern void (*arch_reset_handler(void))(void);
+extern int cpu_enter_idle(unsigned cstate, unsigned rstate, unsigned flags);
+extern void *platform_context_pointer(unsigned int);
+#endif
diff --git a/arch/arm/kernel/sr_api.c b/arch/arm/kernel/sr_api.c
new file mode 100644
index 0000000..4e48f60
--- /dev/null
+++ b/arch/arm/kernel/sr_api.c
@@ -0,0 +1,197 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/sched.h>
+#include <linux/cache.h>
+#include <linux/cpu.h>
+
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/system.h>
+#include <asm/cpu_pm.h>
+#include <asm/lb_lock.h>
+#include <asm/sr_platform_api.h>
+
+#include "sr_helpers.h"
+#include "sr.h"
+
+
+struct ____cacheline_aligned sr_main_table main_table = {
+	.num_clusters	= SR_NR_CLUSTERS,
+	.cpu_idle_mask	= { { CPU_BITS_NONE }, },
+};
+
+static int late_init(void);
+
+int sr_runtime_init(void)
+{
+	int ret;
+
+	context_memory_uncached =
+		platform_context_pointer(CONTEXT_SPACE_UNCACHED);
+
+	if (!context_memory_uncached)
+		return -ENOMEM;
+
+	ret = linux_sr_setup_translation_tables();
+
+	if (ret < 0)
+		return ret;
+
+	ret = sr_context_init();
+
+	return ret;
+}
+
+/* return the warm-boot entry point virtual address */
+void (*arch_reset_handler(void))(void)
+{
+	return (void (*)(void)) arch->reset;
+}
+
+static int late_init(void)
+{
+	int rc;
+	struct sr_cluster *cluster;
+	int cluster_index, cpu_index = sr_platform_get_cpu_index();
+
+	cluster_index = sr_platform_get_cluster_index();
+	cluster = main_table.cluster_table + cluster_index;
+	main_table.os_mmu_context[cluster_index][cpu_index] =
+				current->active_mm->pgd;
+	cpu_switch_mm(main_table.fw_mmu_context, current->active_mm);
+	rc = sr_platform_init();
+	cpu_switch_mm(main_table.os_mmu_context[cluster_index][cpu_index],
+				current->active_mm);
+	return rc;
+}
+
+void (*sr_sleep)(void) = default_sleep;
+
+void enter_idle(unsigned cstate, unsigned rstate, unsigned flags)
+{
+	struct sr_cpu *cpu;
+	struct sr_cluster *cluster;
+	cpumask_t *cpuidle_mask;
+	int cpu_index, cluster_index;
+
+	cluster_index = sr_platform_get_cluster_index();
+	cpu_index = sr_platform_get_cpu_index();
+	cpuidle_mask = &main_table.cpu_idle_mask[cluster_index];
+	/*
+	 * WARNING: cluster support will break if multiple clusters are
+	 * instantiated within the kernel. The current version works
+	 * with just one cluster and cpu_index is the hardware processor
+	 * id in cluster index 0.
+	 */
+	main_table.os_mmu_context[cluster_index][cpu_index] =
+				current->active_mm->pgd;
+	cpu_switch_mm(main_table.fw_mmu_context, current->active_mm);
+	local_flush_tlb_all();
+
+	cluster = main_table.cluster_table + cluster_index;
+	cpu = cluster->cpu_table + cpu_index;
+
+	get_spinlock(cpu_index, cluster->lock);
+
+	__cpu_set(cpu_index, cpuidle_mask);
+
+	if (cpumask_weight(cpuidle_mask) == num_online_cpus())
+		cluster->power_state = rstate;
+
+	cluster->cluster_down = (cluster->power_state >= 2);
+
+	cpu->power_state = cstate;
+
+	cpu_pm_enter();
+
+	if (cluster->cluster_down)
+		cpu_complex_pm_enter();
+
+	sr_platform_enter_cstate(cpu_index, cpu, cluster);
+
+	sr_save_context(cluster, cpu, flags);
+
+	release_spinlock(cpu_index, cluster->lock);
+
+	/* Point of no return */
+	(*sr_sleep)();
+
+	/*
+	 * In case we wanted sr_sleep to return
+	 * here is code to turn MMU off and go
+	 * the whole hog on the resume path
+	 */
+
+	cpu_reset((virt_to_phys((void *) arch->reset)));
+}
+
+void exit_idle(struct sr_main_table *mt)
+{
+	struct sr_cpu *cpu;
+	struct sr_cluster *cluster;
+	int cpu_index, cluster_index;
+
+	cpu_index = sr_platform_get_cpu_index();
+
+	cluster_index = sr_platform_get_cluster_index();
+
+	cluster = mt->cluster_table + cluster_index;
+	cpu = cluster->cpu_table + cpu_index;
+
+	PA(get_spinlock)(cpu_index, cluster->lock);
+
+	PA(sr_restore_context)(cluster, cpu);
+
+	sr_platform_leave_cstate(cpu_index, cpu, cluster);
+
+	if (cluster->cluster_down) {
+		cpu_complex_pm_exit();
+		cluster->cluster_down = 0;
+	}
+
+	cpu_pm_exit();
+
+	cpu_clear(cpu_index, main_table.cpu_idle_mask[cluster_index]);
+
+	cpu->power_state = 0;
+	cluster->power_state = 0;
+
+	release_spinlock(cpu_index, cluster->lock);
+	cpu_switch_mm(main_table.os_mmu_context[cluster_index][cpu_index],
+					current->active_mm);
+	local_flush_tlb_all();
+}
+
+
+int sr_init(void)
+{
+	if (lookup_arch()) {
+		printk(KERN_EMERG "SR INIT: Undetected architecture id\n");
+		BUG();
+	}
+
+	if (sr_runtime_init()) {
+		printk(KERN_EMERG "SR INIT: runtime init error\n");
+		BUG();
+	}
+
+	if (late_init()) {
+		printk(KERN_EMERG "SR INIT: late init error\n");
+		BUG();
+	}
+
+	return 0;
+}
+arch_initcall(sr_init);
diff --git a/arch/arm/kernel/sr_entry.S b/arch/arm/kernel/sr_entry.S
new file mode 100644
index 0000000..4fa9bef
--- /dev/null
+++ b/arch/arm/kernel/sr_entry.S
@@ -0,0 +1,213 @@
+/*
+ * Copyright (c) 2008-2011 ARM Ltd
+ *
+ * Author(s):  Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/linkage.h>
+#include <generated/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/memory.h>
+#include <asm/ptrace.h>
+#include <asm/glue-proc.h>
+#include <asm/assembler.h>
+#include <asm-generic/errno-base.h>
+#include <mach/entry-macro.S>
+
+	.text
+
+ENTRY(default_sleep)
+	b out		@ BTAC allocates branch and enters loop mode
+idle:			@ power down is entered with GIC CPU IF still on which
+	dsb		@ might get wfi instruction to complete before the
+	wfi		@ CPU is shut down -- infinite loop
+out:
+    	b idle
+ENDPROC(default_sleep)
+
+
+ENTRY(sr_suspend)
+	b cpu_do_suspend
+ENDPROC(sr_suspend)
+
+ENTRY(sr_resume)
+	add	lr, lr, #(PAGE_OFFSET - PLAT_PHYS_OFFSET)
+	stmfd	sp!, {r4 - r11, lr}
+	ldr	lr, =mmu_on
+	b 	cpu_do_resume
+mmu_on:
+	ldmfd	sp!, {r4 - r11, pc}
+ENDPROC(sr_resume)
+
+/*
+ * This code is in the .data section to retrieve stack pointers stored in
+ * platform_cpu_stacks and platform_cpu_nc_stacks with a pc relative load.
+ * It cannot live in .text since that section can be treated as read-only
+ * and would break the code, which requires stack pointers to be saved on
+ * idle entry.
+ */
+	.data
+	.align
+	.global idle_save_context
+	.global idle_restore_context
+	.global idle_mt
+	.global platform_cpu_stacks
+	.global platform_cpu_nc_stacks
+
+/*
+ * idle entry point
+ * Must be called with IRQ disabled
+ * Idle states are differentiated between CPU and Cluster states
+ *
+ * r0 = cstate defines the CPU power state
+ * r1 = rstate defines the Cluster power state
+ * r2 = flags define what has to be saved
+ *
+ * C-STATE mapping
+ * 0 - run
+ * 1 - wfi (aka standby)
+ * 2 - dormant (not supported)
+ * 3 - shutdown
+ *
+ * R-STATE mapping
+ * 0 - run
+ * 1 - not supported
+ * 2 - L2 retention
+ * 3 - Off mode (every platform defines it, e.g. GIC power domain)
+ *
+ * Cluster low-power states might be hit if and only if all the CPUs making up
+ * the clusters are in some deep C-STATE
+ *
+ */
+
+ENTRY(cpu_enter_idle)
+	cmp	r0, #2		@ this function can replace the idle function
+	wfilt			@ in the processor struct. If targeted power
+	movlt	r0, #0		@ states are shallow ones it just executes wfi
+	movlt	pc, lr		@ and returns
+	cmp	r0, #3
+	cmpls	r1, #3
+	mvnhi	r0, #EINVAL
+	movhi	pc, lr
+	stmfd	sp!, {r4 - r12, lr}
+	stmfd	sp, {r0, r1}
+#ifdef CONFIG_SMP
+	adr	r0, platform_cpu_stacks
+	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
+	ALT_UP(mov r1, #0)
+	and	r1, r1, #15
+	str	sp, [r0, r1, lsl #2]	@ stack phys addr - save it for resume
+#else
+	str	sp, platform_cpu_stacks
+#endif
+	sub	sp, sp, #8
+	ldmfd	sp!,{r0, r1}
+	bl 	enter_idle
+	mov	r0, #0
+	ldmfd   sp!, {r4 - r12, pc}
+ENDPROC(cpu_enter_idle)
+
+/*
+ * This hook, though not strictly necessary, provides an entry point where, if
+ * needed, stack pointers can be switched in case it is needed to improve L2
+ * retention management (uncached stack).
+ */
+ENTRY(sr_save_context)
+	adr	r12, idle_save_context
+	ldr	r12, [r12]
+	bx	r12
+ENDPROC(sr_save_context)
+
+ENTRY(sr_reset_entry_point)
+	@ This is the entry point from the platform warm start code
+	@ It runs with MMU off straight from reset
+	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r0 @ set SVC, irqs off
+#ifdef CONFIG_SMP
+	adr	r0, platform_cpu_nc_stacks
+	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
+	ALT_UP(mov r1, #0)
+	and	r1, r1, #15
+	ldr	r0, [r0, r1, lsl #2]		@ stack phys addr
+#else
+	ldr	r0, platform_cpu_nc_stacks	@ stack phys addr
+#endif
+	mov	sp, r0
+	adr	r0, idle_mt 	@ get phys address of main table and pass it on
+	ldr	r0, [r0]
+	ldr	lr, =return_from_idle
+	adr	r1, resume
+	ldr	r1, [r1]
+	bx	r1
+return_from_idle:
+	@ return to enter_idle caller, with success
+	mov	r0, #0
+	ldmfd	sp!, {r4 - r12, pc}	@ return from idle - registers saved in
+ENDPROC(sr_reset_entry_point)		@ cpu_enter_idle() are still there
+
+
+ENTRY(sr_restore_context)
+	add	lr, lr, #(PAGE_OFFSET - PLAT_PHYS_OFFSET)
+	stmfd	sp!, {r4, lr}
+	adr	r12, idle_restore_context
+	ldr	r12, [r12]
+	ldr	lr, =switch_stack
+	bx	r12
+switch_stack:
+	@ CPU context restored, time to switch to Linux stack and pop out
+#ifdef CONFIG_SMP
+	adr	r0, platform_cpu_stacks
+	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
+	ALT_UP(mov r1, #0)
+	and	r1, r1, #15
+	ldr	r0, [r0, r1, lsl #2]	@ top stack addr
+#else
+	ldr	r0, platform_cpu_stacks	@ top stack addr
+#endif
+	mov	r3, r0
+#ifdef CONFIG_SMP
+	adr	r0, platform_cpu_nc_stacks
+	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
+	ALT_UP(mov r1, #0)
+	and	r1, r1, #15
+	ldr	r0, [r0, r1, lsl #2]		@ non-cacheable stack phys addr
+#else
+	ldr	r0, platform_cpu_nc_stacks	@ non-cacheable stack phys addr
+#endif
+	sub	r2, r0, sp
+	sub	r0, r3, r2
+	mov	r1, sp
+	mov	r4, r0
+	bl	memcpy		@ copy stack used in resume to current stack
+	mov	sp, r4
+	bl 	cpu_init	@ init banked registers
+	ldmfd	sp!, {r4, pc}
+ENDPROC(sr_restore_context)
+
+idle_save_context:
+	.long 0
+idle_restore_context:
+	.long 0
+
+idle_mt:
+	.long main_table - PAGE_OFFSET + PLAT_PHYS_OFFSET
+
+resume:
+	.long exit_idle - PAGE_OFFSET + PLAT_PHYS_OFFSET
+
+platform_cpu_stacks:
+	.rept	CONFIG_NR_CPUS
+	.long	0				@ preserve stack phys ptr here
+	.endr
+
+platform_cpu_nc_stacks:
+	.rept	CONFIG_NR_CPUS
+	.long	0				@ preserve uncached
+						@ stack phys ptr here
+	.endr
+
+	.end
-- 
1.7.4.4
