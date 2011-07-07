From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:23 +0100
Subject: [RFC PATCH 10/17] ARM: kernel: save/restore v7 infrastructure support
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-11-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides all the functions required to manage
platform initialization, context save/restore and power entry/exit
for A9, A8, A5 ARM processors.

It builds on the infrastructure laid out by the patchset and aims
at keeping all v7 code in one single place.

The code relies on common suspend/resume code in the kernel and calls
into the respective subsystems (SCU and L2 for A9) in order to carry out
actions required to enter idle modes.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/sr_v7.c |  298 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 298 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/sr_v7.c

diff --git a/arch/arm/kernel/sr_v7.c b/arch/arm/kernel/sr_v7.c
new file mode 100644
index 0000000..32d1073
--- /dev/null
+++ b/arch/arm/kernel/sr_v7.c
@@ -0,0 +1,298 @@
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
+#include <asm/smp_scu.h>
+#include <asm/outercache.h>
+
+int sr_platform_a8_init(void)
+{
+	int i;
+	unsigned int suspend_size = (unsigned int)(&cpu_v7_suspend_size);
+
+	struct sr_cpu *aem_cpu = (struct sr_cpu *)
+	    get_memory(sizeof(struct sr_cpu));
+
+	struct sr_cluster *aem_cluster = (struct sr_cluster *)
+	    get_memory(sizeof(struct sr_cluster));
+
+	aem_cluster->cpu_type = read_cpuid_id() & 0xff0ffff0;
+
+	if (aem_cluster->cpu_type != CPU_A8)
+		return -ENODEV;
+
+	aem_cluster->num_cpus = 1;
+	aem_cluster->cpu_table = aem_cpu;
+	aem_cluster->lock = get_memory(sizeof(struct bakery));
+	initialize_spinlock(aem_cluster->lock);
+
+	/* (No cluster context for A8) */
+
+	for (i = 0; i < aem_cluster->num_cpus; ++i) {
+		aem_cpu[i].context =
+		     get_memory(sizeof(struct sr_cpu_context));
+		aem_cpu[i].context->mmu_data = get_memory(suspend_size);
+	}
+
+	main_table.cluster_table = aem_cluster;
+	main_table.num_clusters = SR_NR_CLUSTERS;
+	return 0;
+}
+
+/*
+ * This function is called at the end of runtime initialization.
+ *
+ */
+int sr_platform_a9_init(void)
+{
+	int i;
+	struct sr_cpu *aem_cpu;
+	unsigned int suspend_size = (unsigned int)(&cpu_v7_suspend_size);
+
+	struct sr_cluster *aem_cluster = (struct sr_cluster *)
+			get_memory(sizeof(struct sr_cluster));
+
+	aem_cluster->cpu_type = read_cpuid_id() & 0xff0ffff0;
+	aem_cluster->cluster_down = 0;
+
+	if ((aem_cluster->cpu_type != CPU_A9) &&
+			(aem_cluster->cpu_type != CPU_A5))
+		return -ENODEV;
+#ifdef CONFIG_SMP
+	aem_cluster->scu_address = sr_platform_cbar();
+#endif
+	aem_cluster->num_cpus = num_online_cpus();
+
+	aem_cluster->cpu_table = (struct sr_cpu *)
+		get_memory(sizeof(struct sr_cpu) * CONFIG_NR_CPUS);
+	aem_cluster->lock = get_memory(sizeof(struct bakery));
+
+	initialize_spinlock(aem_cluster->lock);
+
+	aem_cluster->context = get_memory(sizeof(struct sr_cluster_context));
+
+	aem_cluster->context->l2_data = get_memory(L2_DATA_SIZE);
+
+
+	for (i = 0, aem_cpu = aem_cluster->cpu_table;
+			i < aem_cluster->num_cpus; ++i) {
+
+		platform_cpu_nc_stacks[i] = (unsigned long)
+			get_memory(STACK_SIZE) +
+					STACK_SIZE - 8;
+
+		aem_cpu[i].context =
+				get_memory(sizeof(struct sr_cpu_context));
+		aem_cpu[i].context->mmu_data = get_memory(suspend_size);
+	}
+	main_table.cluster_table = aem_cluster;
+
+	__cpuc_flush_dcache_area(&main_table, sizeof(struct sr_main_table));
+	outer_clean_range(__pa(&main_table), __pa(&main_table + 1));
+
+	__cpuc_flush_dcache_area(platform_cpu_nc_stacks,
+			sizeof(platform_cpu_nc_stacks)/
+			sizeof(platform_cpu_nc_stacks[0]));
+	outer_clean_range(__pa(platform_cpu_nc_stacks),
+			__pa(platform_cpu_nc_stacks + CONFIG_NR_CPUS));
+
+	return 0;
+}
+
+int notrace sr_platform_a9_save_context(struct sr_cluster *cluster,
+				  struct sr_cpu *cpu,
+				  unsigned flags)
+{
+	u32 cluster_saved_items = 0;
+	struct sr_cpu_context *context;
+	struct sr_cluster_context *cluster_context;
+	unsigned int cpu_index = sr_platform_get_cpu_index();
+
+	context = cpu->context;
+	cluster_context = cluster->context;
+
+	/* add flags as required by hardware (e.g. SR_SAVE_L2 if L2 is on) */
+	flags |= context->flags;
+
+	sr_suspend(context->mmu_data);
+
+	/*
+	 * DISABLE DATA CACHES
+	 *
+	 * - Disable D$ look-up (clear C-bit)
+	 * - Clean+invalidate the D$ cache
+	 * - Exit coherency if SMP
+	 *
+	 */
+
+	disable_clean_inv_dcache_v7_all();
+
+	exit_coherency();
+
+#ifdef CONFIG_SMP
+	if (cpu->power_state >= 2)
+		scu_power_mode(SCU_PM_POWEROFF);
+#endif
+	if (cluster->cluster_down) {
+		if (flags & SR_SAVE_SCU)
+			cluster_saved_items |= SR_SAVE_SCU;
+
+		if (flags & SR_SAVE_L2) {
+			outer_save_context(cluster_context->l2_data,
+					cluster->power_state == 2,
+					platform_cpu_stacks[cpu_index]);
+			cluster_saved_items |= SR_SAVE_L2;
+		}
+		cluster_context->saved_items = cluster_saved_items;
+	}
+
+	return 0;
+}
+
+
+
+/*
+ * This function restores all the context that was lost
+ * when a CPU and cluster entered a low power state. It is called shortly after
+ * reset, with the MMU and data cache off.
+ *
+ * This function is called with cluster->lock held
+ */
+int notrace sr_platform_a9_restore_context(struct sr_cluster *cluster,
+				struct sr_cpu *cpu)
+{
+	struct sr_cpu_context *context;
+	struct sr_cluster_context *cluster_context;
+	u32 cluster_saved_items = 0;
+	int cluster_init = cluster->cluster_down;
+
+	/*
+	 * At this point we may not write to any static data, and we may
+	 * only read the data that we explicitly cleaned from the L2 above.
+	 */
+
+	context = cpu->context;
+	cluster_context = cluster->context;
+#ifdef CONFIG_SMP
+	if (cpu->power_state >= 2)
+		PA(scu_cpu_mode)(cluster->scu_address + 0x8, SCU_PM_NORMAL);
+#endif
+	PA(sr_resume)(context->mmu_data, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+
+	/* First set up the SCU & L2, if necessary */
+	if (cluster_init) {
+		cluster_saved_items = cluster_context->saved_items;
+#ifdef CONFIG_SMP
+		if (cluster_saved_items & SR_SAVE_SCU)
+			scu_reset();
+#endif
+		if (cluster_saved_items & SR_SAVE_L2) {
+			outer_restore_context(cluster_context->l2_data,
+					cluster->power_state == 2);
+
+		}
+	}
+
+	/* Return to OS */
+	return 0;
+}
+
+
+/*
+ * This function saves all a8 the context that will be lost
+ * when a CPU and cluster enter a low power state.
+ *
+ * This function is called with cluster->lock held
+ */
+int notrace sr_platform_a8_save_context(struct sr_cluster *cluster,
+				  struct sr_cpu *cpu, unsigned flags)
+{
+	struct sr_cpu_context *context;
+
+	context = cpu->context;
+
+	sr_suspend(context->mmu_data);
+
+	/*
+	 * Disable, then clean+invalidate the L1 (data) & L2 caches.
+	 *
+	 * Note that if L1 or L2 was to be dormant we would only need to
+	 * clean some key data out,
+	 * and clean+invalidate the stack.
+	 */
+	disable_clean_inv_dcache_v7_all();
+
+	return 0;
+}
+
+/*
+ * This function restores all the a8 context that was lost
+ * when a CPU and cluster entered a low power state. It is called shortly after
+ * reset, with the MMU and data cache off.
+ */
+int notrace sr_platform_a8_restore_context(struct sr_cluster *cluster,
+					struct sr_cpu *cpu)
+{
+	struct sr_cpu_context *context;
+
+	/*
+	 * If the L1 or L2 is dormant, there are special precautions:
+	 * At this point we may not write to any static data, and we may
+	 * only read the data that we explicitly cleaned from the caches above.
+	 */
+	context = cpu->context;
+
+	PA(sr_resume)(context->mmu_data, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+
+	/* Return to OS */
+	return 0;
+}
+
+static struct lp_state lps;
+
+int sr_platform_a8_enter_cstate(unsigned cpu_index, struct sr_cpu *cpu,
+		struct sr_cluster *cluster)
+{
+	lps.cpu = cpu->power_state;
+	lps.cluster = cluster->power_state;
+	platform_pm_enter(&lps);
+	return 0;
+}
+
+int sr_platform_a8_leave_cstate(unsigned cpu_index, struct sr_cpu *cpu,
+		struct sr_cluster *cluster)
+{
+	platform_pm_exit(&lps);
+	return 0;
+}
+
+
+int  sr_platform_a9_enter_cstate(unsigned cpu_index,
+					   struct sr_cpu *cpu,
+					   struct sr_cluster *cluster)
+{
+	lps.cpu = cpu->power_state;
+	lps.cluster = cluster->power_state;
+	platform_pm_enter(&lps);
+
+	return 0;
+}
+
+/*
+ * This function tells the PCU this CPU has finished powering up.
+ * It is entered with cluster->lock held.
+ */
+int  sr_platform_a9_leave_cstate(unsigned cpu_index,
+					struct sr_cpu *cpu,
+					struct sr_cluster *cluster)
+{
+	platform_pm_exit(&lps);
+	return 0;
+}
-- 
1.7.4.4
