From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:49 -0400
Subject: [PATCH RFC/RFT 2/6] ARM: vexpress: migrate TC2 to the new MCPM backend
 abstraction
In-Reply-To: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1426701893-25589-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/tc2_pm.c | 291 +++++++++++-----------------------------
 1 file changed, 81 insertions(+), 210 deletions(-)

diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index 2fb78b4648..b3328cd46c 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -18,7 +18,6 @@
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/irqchip/arm-gic.h>
 
@@ -44,101 +43,36 @@
 
 static void __iomem *scc;
 
-/*
- * We can't use regular spinlocks. In the switcher case, it is possible
- * for an outbound CPU to call power_down() after its inbound counterpart
- * is already live using the same logical CPU number which trips lockdep
- * debugging.
- */
-static arch_spinlock_t tc2_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-
 #define TC2_CLUSTERS			2
 #define TC2_MAX_CPUS_PER_CLUSTER	3
 
 static unsigned int tc2_nr_cpus[TC2_CLUSTERS];
 
-/* Keep per-cpu usage count to cope with unordered up/down requests */
-static int tc2_pm_use_count[TC2_MAX_CPUS_PER_CLUSTER][TC2_CLUSTERS];
-
-#define tc2_cluster_unused(cluster) \
-	(!tc2_pm_use_count[0][cluster] && \
-	 !tc2_pm_use_count[1][cluster] && \
-	 !tc2_pm_use_count[2][cluster])
-
-static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
+static int tc2_pm_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cluster >= TC2_CLUSTERS || cpu >= tc2_nr_cpus[cluster])
 		return -EINVAL;
-
-	/*
-	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
-	 * variant exists, we need to disable IRQs manually here.
-	 */
-	local_irq_disable();
-	arch_spin_lock(&tc2_pm_lock);
-
-	if (tc2_cluster_unused(cluster))
-		ve_spc_powerdown(cluster, false);
-
-	tc2_pm_use_count[cpu][cluster]++;
-	if (tc2_pm_use_count[cpu][cluster] == 1) {
-		ve_spc_set_resume_addr(cluster, cpu,
-				       virt_to_phys(mcpm_entry_point));
-		ve_spc_cpu_wakeup_irq(cluster, cpu, true);
-	} else if (tc2_pm_use_count[cpu][cluster] != 2) {
-		/*
-		 * The only possible values are:
-		 * 0 = CPU down
-		 * 1 = CPU (still) up
-		 * 2 = CPU requested to be up before it had a chance
-		 *     to actually make itself down.
-		 * Any other value is a bug.
-		 */
-		BUG();
-	}
-
-	arch_spin_unlock(&tc2_pm_lock);
-	local_irq_enable();
-
+	ve_spc_set_resume_addr(cluster, cpu,
+			       virt_to_phys(mcpm_entry_point));
+	ve_spc_cpu_wakeup_irq(cluster, cpu, true);
 	return 0;
 }
 
-static void tc2_pm_down(u64 residency)
+static int tc2_pm_cluster_powerup(unsigned int cluster)
 {
-	unsigned int mpidr, cpu, cluster;
-	bool last_man = false, skip_wfi = false;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= TC2_CLUSTERS)
+		return -EINVAL;
+	ve_spc_powerdown(cluster, false);
+	return 0;
+}
 
+static void tc2_pm_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
+{
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
-
-	__mcpm_cpu_going_down(cpu, cluster);
-
-	arch_spin_lock(&tc2_pm_lock);
-	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
-	tc2_pm_use_count[cpu][cluster]--;
-	if (tc2_pm_use_count[cpu][cluster] == 0) {
-		ve_spc_cpu_wakeup_irq(cluster, cpu, true);
-		if (tc2_cluster_unused(cluster)) {
-			ve_spc_powerdown(cluster, true);
-			ve_spc_global_wakeup_irq(true);
-			last_man = true;
-		}
-	} else if (tc2_pm_use_count[cpu][cluster] == 1) {
-		/*
-		 * A power_up request went ahead of us.
-		 * Even if we do not want to shut this CPU down,
-		 * the caller expects a certain state as if the WFI
-		 * was aborted.  So let's continue with cache cleaning.
-		 */
-		skip_wfi = true;
-	} else
-		BUG();
-
+	ve_spc_cpu_wakeup_irq(cluster, cpu, true);
 	/*
 	 * If the CPU is committed to power down, make sure
 	 * the power controller will be in charge of waking it
@@ -146,55 +80,38 @@ static void tc2_pm_down(u64 residency)
 	 * to the CPU by disabling the GIC CPU IF to prevent wfi
 	 * from completing execution behind power controller back
 	 */
-	if (!skip_wfi)
-		gic_cpu_if_down();
-
-	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
-		arch_spin_unlock(&tc2_pm_lock);
-
-		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
-			/*
-			 * On the Cortex-A15 we need to disable
-			 * L2 prefetching before flushing the cache.
-			 */
-			asm volatile(
-			"mcr	p15, 1, %0, c15, c0, 3 \n\t"
-			"isb	\n\t"
-			"dsb	"
-			: : "r" (0x400) );
-		}
-
-		v7_exit_coherency_flush(all);
-
-		cci_disable_port_by_cpu(mpidr);
-
-		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
-	} else {
-		/*
-		 * If last man then undo any setup done previously.
-		 */
-		if (last_man) {
-			ve_spc_powerdown(cluster, false);
-			ve_spc_global_wakeup_irq(false);
-		}
-
-		arch_spin_unlock(&tc2_pm_lock);
-
-		v7_exit_coherency_flush(louis);
-	}
-
-	__mcpm_cpu_down(cpu, cluster);
+	gic_cpu_if_down();
+}
 
-	/* Now we are prepared for power-down, do it: */
-	if (!skip_wfi)
-		wfi();
+static void tc2_pm_cluster_powerdown_prepare(unsigned int cluster)
+{
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	BUG_ON(cluster >= TC2_CLUSTERS);
+	ve_spc_powerdown(cluster, true);
+	ve_spc_global_wakeup_irq(true);
+}
 
-	/* Not dead at this point?  Let our caller cope. */
+static void tc2_pm_cpu_cache_disable(void)
+{
+	v7_exit_coherency_flush(louis);
 }
 
-static void tc2_pm_power_down(void)
+static void tc2_pm_cluster_cache_disable(void)
 {
-	tc2_pm_down(0);
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
+		/*
+		 * On the Cortex-A15 we need to disable
+		 * L2 prefetching before flushing the cache.
+		 */
+		asm volatile(
+		"mcr	p15, 1, %0, c15, c0, 3 \n\t"
+		"isb	\n\t"
+		"dsb	"
+		: : "r" (0x400) );
+	}
+
+	v7_exit_coherency_flush(all);
+	cci_disable_port_by_cpu(read_cpuid_mpidr());
 }
 
 static int tc2_core_in_reset(unsigned int cpu, unsigned int cluster)
@@ -217,27 +134,21 @@ static int tc2_pm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
 
 	for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; ++tries) {
+		pr_debug("%s(cpu=%u, cluster=%u): RESET_CTRL = 0x%08X\n",
+			 __func__, cpu, cluster,
+			 readl_relaxed(scc + RESET_CTRL));
+
 		/*
-		 * Only examine the hardware state if the target CPU has
-		 * caught up@least as far as tc2_pm_down():
+		 * We need the CPU to reach WFI, but the power
+		 * controller may put the cluster in reset and
+		 * power it off as soon as that happens, before
+		 * we have a chance to see STANDBYWFI.
+		 *
+		 * So we need to check for both conditions:
 		 */
-		if (ACCESS_ONCE(tc2_pm_use_count[cpu][cluster]) == 0) {
-			pr_debug("%s(cpu=%u, cluster=%u): RESET_CTRL = 0x%08X\n",
-				 __func__, cpu, cluster,
-				 readl_relaxed(scc + RESET_CTRL));
-
-			/*
-			 * We need the CPU to reach WFI, but the power
-			 * controller may put the cluster in reset and
-			 * power it off as soon as that happens, before
-			 * we have a chance to see STANDBYWFI.
-			 *
-			 * So we need to check for both conditions:
-			 */
-			if (tc2_core_in_reset(cpu, cluster) ||
-			    ve_spc_cpu_in_wfi(cpu, cluster))
-				return 0; /* success: the CPU is halted */
-		}
+		if (tc2_core_in_reset(cpu, cluster) ||
+		    ve_spc_cpu_in_wfi(cpu, cluster))
+			return 0; /* success: the CPU is halted */
 
 		/* Otherwise, wait and retry: */
 		msleep(POLL_MSEC);
@@ -246,72 +157,40 @@ static int tc2_pm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 	return -ETIMEDOUT; /* timeout */
 }
 
-static void tc2_pm_suspend(u64 residency)
+static void tc2_pm_cpu_suspend_prepare(unsigned int cpu, unsigned int cluster)
 {
-	unsigned int mpidr, cpu, cluster;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
-	tc2_pm_down(residency);
 }
 
-static void tc2_pm_powered_up(void)
+static void tc2_pm_cpu_is_up(unsigned int cpu, unsigned int cluster)
 {
-	unsigned int mpidr, cpu, cluster;
-	unsigned long flags;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
-
-	local_irq_save(flags);
-	arch_spin_lock(&tc2_pm_lock);
-
-	if (tc2_cluster_unused(cluster)) {
-		ve_spc_powerdown(cluster, false);
-		ve_spc_global_wakeup_irq(false);
-	}
-
-	if (!tc2_pm_use_count[cpu][cluster])
-		tc2_pm_use_count[cpu][cluster] = 1;
-
 	ve_spc_cpu_wakeup_irq(cluster, cpu, false);
 	ve_spc_set_resume_addr(cluster, cpu, 0);
+}
 
-	arch_spin_unlock(&tc2_pm_lock);
-	local_irq_restore(flags);
+static void tc2_pm_cluster_is_up(unsigned int cluster)
+{
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	BUG_ON(cluster >= TC2_CLUSTERS);
+	ve_spc_powerdown(cluster, false);
+	ve_spc_global_wakeup_irq(false);
 }
 
 static const struct mcpm_platform_ops tc2_pm_power_ops = {
-	.power_up		= tc2_pm_power_up,
-	.power_down		= tc2_pm_power_down,
+	.cpu_powerup		= tc2_pm_cpu_powerup,
+	.cluster_powerup	= tc2_pm_cluster_powerup,
+	.cpu_suspend_prepare	= tc2_pm_cpu_suspend_prepare,
+	.cpu_powerdown_prepare	= tc2_pm_cpu_powerdown_prepare,
+	.cluster_powerdown_prepare = tc2_pm_cluster_powerdown_prepare,
+	.cpu_cache_disable	= tc2_pm_cpu_cache_disable,
+	.cluster_cache_disable	= tc2_pm_cluster_cache_disable,
 	.wait_for_powerdown	= tc2_pm_wait_for_powerdown,
-	.suspend		= tc2_pm_suspend,
-	.powered_up		= tc2_pm_powered_up,
+	.cpu_is_up		= tc2_pm_cpu_is_up,
+	.cluster_is_up		= tc2_pm_cluster_is_up,
 };
 
-static bool __init tc2_pm_usage_count_init(void)
-{
-	unsigned int mpidr, cpu, cluster;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	if (cluster >= TC2_CLUSTERS || cpu >= tc2_nr_cpus[cluster]) {
-		pr_err("%s: boot CPU is out of bound!\n", __func__);
-		return false;
-	}
-	tc2_pm_use_count[cpu][cluster] = 1;
-	return true;
-}
-
 /*
  * Enable cluster-level coherency, in preparation for turning on the MMU.
  */
@@ -323,23 +202,9 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
 "	b	cci_enable_port_for_self ");
 }
 
-static void __init tc2_cache_off(void)
-{
-	pr_info("TC2: disabling cache during MCPM loopback test\n");
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
-		/* disable L2 prefetching on the Cortex-A15 */
-		asm volatile(
-		"mcr	p15, 1, %0, c15, c0, 3 \n\t"
-		"isb	\n\t"
-		"dsb	"
-		: : "r" (0x400) );
-	}
-	v7_exit_coherency_flush(all);
-	cci_disable_port_by_cpu(read_cpuid_mpidr());
-}
-
 static int __init tc2_pm_init(void)
 {
+	unsigned int mpidr, cpu, cluster;
 	int ret, irq;
 	u32 a15_cluster_id, a7_cluster_id, sys_info;
 	struct device_node *np;
@@ -379,14 +244,20 @@ static int __init tc2_pm_init(void)
 	if (!cci_probed())
 		return -ENODEV;
 
-	if (!tc2_pm_usage_count_init())
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	if (cluster >= TC2_CLUSTERS || cpu >= tc2_nr_cpus[cluster]) {
+		pr_err("%s: boot CPU is out of bound!\n", __func__);
 		return -EINVAL;
+	}
 
 	ret = mcpm_platform_register(&tc2_pm_power_ops);
 	if (!ret) {
 		mcpm_sync_init(tc2_pm_power_up_setup);
 		/* test if we can (re)enable the CCI on our own */
-		BUG_ON(mcpm_loopback(tc2_cache_off) != 0);
+		BUG_ON(mcpm_loopback(tc2_pm_cluster_cache_disable) != 0);
 		pr_info("TC2 power management initialized\n");
 	}
 	return ret;
-- 
2.1.0
