From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:52 -0400
Subject: [PATCH RFC/RFT 5/6] ARM: Exynos: migrate DCSCB to the new MCPM backend
 abstraction
In-Reply-To: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1426701893-25589-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The custom suspend callback is removed for this change. That includes
the dubious call to exynos_cpu_power_up(() that was present at the end
of exynos_suspend().

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-exynos/mcpm-exynos.c | 246 ++++++++-----------------------------
 1 file changed, 51 insertions(+), 195 deletions(-)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index b0d3c2e876..d4bbbfb5fe 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -61,25 +61,7 @@ static void __iomem *ns_sram_base_addr;
 	: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
 	  "r9", "r10", "lr", "memory")
 
-/*
- * We can't use regular spinlocks. In the switcher case, it is possible
- * for an outbound CPU to call power_down() after its inbound counterpart
- * is already live using the same logical CPU number which trips lockdep
- * debugging.
- */
-static arch_spinlock_t exynos_mcpm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-static int
-cpu_use_count[EXYNOS5420_CPUS_PER_CLUSTER][EXYNOS5420_NR_CLUSTERS];
-
-#define exynos_cluster_usecnt(cluster) \
-	(cpu_use_count[0][cluster] +   \
-	 cpu_use_count[1][cluster] +   \
-	 cpu_use_count[2][cluster] +   \
-	 cpu_use_count[3][cluster])
-
-#define exynos_cluster_unused(cluster) !exynos_cluster_usecnt(cluster)
-
-static int exynos_power_up(unsigned int cpu, unsigned int cluster)
+static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
 
@@ -88,127 +70,65 @@ static int exynos_power_up(unsigned int cpu, unsigned int cluster)
 		cluster >= EXYNOS5420_NR_CLUSTERS)
 		return -EINVAL;
 
-	/*
-	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
-	 * variant exists, we need to disable IRQs manually here.
-	 */
-	local_irq_disable();
-	arch_spin_lock(&exynos_mcpm_lock);
-
-	cpu_use_count[cpu][cluster]++;
-	if (cpu_use_count[cpu][cluster] == 1) {
-		bool was_cluster_down =
-			(exynos_cluster_usecnt(cluster) == 1);
-
-		/*
-		 * Turn on the cluster (L2/COMMON) and then power on the
-		 * cores.
-		 */
-		if (was_cluster_down)
-			exynos_cluster_power_up(cluster);
-
-		exynos_cpu_power_up(cpunr);
-	} else if (cpu_use_count[cpu][cluster] != 2) {
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
+	exynos_cpu_power_up(cpunr);
+	return 0;
+}
 
-	arch_spin_unlock(&exynos_mcpm_lock);
-	local_irq_enable();
+static int exynos_cluster_powerup(unsigned int cluster)
+{
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= EXYNOS5420_NR_CLUSTERS)
+		return -EINVAL;
 
+	exynos_cluster_power_up(cluster);
 	return 0;
 }
 
-/*
- * NOTE: This function requires the stack data to be visible through power down
- * and can only be executed on processors like A15 and A7 that hit the cache
- * with the C bit clear in the SCTLR register.
- */
-static void exynos_power_down(void)
+static void exynos_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
 {
-	unsigned int mpidr, cpu, cluster;
-	bool last_man = false, skip_wfi = false;
-	unsigned int cpunr;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	cpunr =  cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
+	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
 			cluster >= EXYNOS5420_NR_CLUSTERS);
+	exynos_cpu_power_down(cpunr);
+}
 
-	__mcpm_cpu_going_down(cpu, cluster);
-
-	arch_spin_lock(&exynos_mcpm_lock);
-	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
-	cpu_use_count[cpu][cluster]--;
-	if (cpu_use_count[cpu][cluster] == 0) {
-		exynos_cpu_power_down(cpunr);
-
-		if (exynos_cluster_unused(cluster)) {
-			exynos_cluster_power_down(cluster);
-			last_man = true;
-		}
-	} else if (cpu_use_count[cpu][cluster] == 1) {
-		/*
-		 * A power_up request went ahead of us.
-		 * Even if we do not want to shut this CPU down,
-		 * the caller expects a certain state as if the WFI
-		 * was aborted.  So let's continue with cache cleaning.
-		 */
-		skip_wfi = true;
-	} else {
-		BUG();
-	}
-
-	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
-		arch_spin_unlock(&exynos_mcpm_lock);
-
-		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
-			/*
-			 * On the Cortex-A15 we need to disable
-			 * L2 prefetching before flushing the cache.
-			 */
-			asm volatile(
-			"mcr	p15, 1, %0, c15, c0, 3\n\t"
-			"isb\n\t"
-			"dsb"
-			: : "r" (0x400));
-		}
+static void exynos_cluster_powerdown_prepare(unsigned int cluster)
+{
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	BUG_ON(cluster >= EXYNOS5420_NR_CLUSTERS);
+	exynos_cluster_power_down(cluster);
+}
 
-		/* Flush all cache levels for this cluster. */
-		exynos_v7_exit_coherency_flush(all);
+static void exynos_cpu_cache_disable(void)
+{
+	/* Disable and flush the local CPU cache. */
+	exynos_v7_exit_coherency_flush(louis);
+}
 
+static void exynos_cluster_cache_disable(void)
+{
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
 		/*
-		 * Disable cluster-level coherency by masking
-		 * incoming snoops and DVM messages:
+		 * On the Cortex-A15 we need to disable
+		 * L2 prefetching before flushing the cache.
 		 */
-		cci_disable_port_by_cpu(mpidr);
-
-		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
-	} else {
-		arch_spin_unlock(&exynos_mcpm_lock);
-
-		/* Disable and flush the local CPU cache. */
-		exynos_v7_exit_coherency_flush(louis);
+		asm volatile(
+		"mcr	p15, 1, %0, c15, c0, 3\n\t"
+		"isb\n\t"
+		"dsb"
+		: : "r" (0x400));
 	}
 
-	__mcpm_cpu_down(cpu, cluster);
-
-	/* Now we are prepared for power-down, do it: */
-	if (!skip_wfi)
-		wfi();
+	/* Flush all cache levels for this cluster. */
+	exynos_v7_exit_coherency_flush(all);
 
-	/* Not dead at this point?  Let our caller cope. */
+	/*
+	 * Disable cluster-level coherency by masking
+	 * incoming snoops and DVM messages:
+	 */
+	cci_disable_port_by_cpu(read_cpuid_mpidr());
 }
 
 static int exynos_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
@@ -222,10 +142,8 @@ static int exynos_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 
 	/* Wait for the core state to be OFF */
 	while (tries--) {
-		if (ACCESS_ONCE(cpu_use_count[cpu][cluster]) == 0) {
-			if ((exynos_cpu_power_state(cpunr) == 0))
-				return 0; /* success: the CPU is halted */
-		}
+		if ((exynos_cpu_power_state(cpunr) == 0))
+			return 0; /* success: the CPU is halted */
 
 		/* Otherwise, wait and retry: */
 		msleep(1);
@@ -234,63 +152,16 @@ static int exynos_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 	return -ETIMEDOUT; /* timeout */
 }
 
-static void exynos_powered_up(void)
-{
-	unsigned int mpidr, cpu, cluster;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-
-	arch_spin_lock(&exynos_mcpm_lock);
-	if (cpu_use_count[cpu][cluster] == 0)
-		cpu_use_count[cpu][cluster] = 1;
-	arch_spin_unlock(&exynos_mcpm_lock);
-}
-
-static void exynos_suspend(u64 residency)
-{
-	unsigned int mpidr, cpunr;
-
-	exynos_power_down();
-
-	/*
-	 * Execution reaches here only if cpu did not power down.
-	 * Hence roll back the changes done in exynos_power_down function.
-	 *
-	 * CAUTION: "This function requires the stack data to be visible through
-	 * power down and can only be executed on processors like A15 and A7
-	 * that hit the cache with the C bit clear in the SCTLR register."
-	*/
-	mpidr = read_cpuid_mpidr();
-	cpunr = exynos_pmu_cpunr(mpidr);
-
-	exynos_cpu_power_up(cpunr);
-}
-
 static const struct mcpm_platform_ops exynos_power_ops = {
-	.power_up		= exynos_power_up,
-	.power_down		= exynos_power_down,
+	.cpu_powerup		= exynos_cpu_powerup,
+	.cluster_powerup	= exynos_cluster_powerup,
+	.cpu_powerdown_prepare	= exynos_cpu_powerdown_prepare,
+	.cluster_powerdown_prepare = exynos_cluster_powerdown_prepare,
+	.cpu_cache_disable	= exynos_cpu_cache_disable,
+	.cluster_cache_disable	= exynos_cluster_cache_disable,
 	.wait_for_powerdown	= exynos_wait_for_powerdown,
-	.suspend		= exynos_suspend,
-	.powered_up		= exynos_powered_up,
 };
 
-static void __init exynos_mcpm_usage_count_init(void)
-{
-	unsigned int mpidr, cpu, cluster;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER  ||
-			cluster >= EXYNOS5420_NR_CLUSTERS);
-
-	cpu_use_count[cpu][cluster] = 1;
-}
-
 /*
  * Enable cluster-level coherency, in preparation for turning on the MMU.
  */
@@ -302,19 +173,6 @@ static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
 	"b	cci_enable_port_for_self");
 }
 
-static void __init exynos_cache_off(void)
-{
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
-		/* disable L2 prefetching on the Cortex-A15 */
-		asm volatile(
-		"mcr	p15, 1, %0, c15, c0, 3\n\t"
-		"isb\n\t"
-		"dsb"
-		: : "r" (0x400));
-	}
-	exynos_v7_exit_coherency_flush(all);
-}
-
 static const struct of_device_id exynos_dt_mcpm_match[] = {
 	{ .compatible = "samsung,exynos5420" },
 	{ .compatible = "samsung,exynos5800" },
@@ -370,13 +228,11 @@ static int __init exynos_mcpm_init(void)
 	 */
 	pmu_raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
 
-	exynos_mcpm_usage_count_init();
-
 	ret = mcpm_platform_register(&exynos_power_ops);
 	if (!ret)
 		ret = mcpm_sync_init(exynos_pm_power_up_setup);
 	if (!ret)
-		ret = mcpm_loopback(exynos_cache_off); /* turn on the CCI */
+		ret = mcpm_loopback(exynos_cluster_cache_disable); /* turn on the CCI */
 	if (ret) {
 		iounmap(ns_sram_base_addr);
 		return ret;
-- 
2.1.0
