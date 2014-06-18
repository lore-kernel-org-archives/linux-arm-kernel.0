From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 18 Jun 2014 20:48:42 +0530
Subject: [PATCH] arm: exynos: Support cluster power off on exynos5420/5800
Message-ID: <1403104722-14848-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turning off a cluster when all 4 cores of the cluster are powered off
saves power significantly. Powering off the A15 L2 alone gives around
100mW in savings. Add support for powering off the A15/A7 clusters on
exynos5420/5800.

The patch enables specific register bits which ensure that:
   - cluster L2 will be turned on before the first man is powered up.
   - last man will be turned off before the cluster L2 is turned off.
   - core is powered down before powering it up.

Remove the exynos_cluster_power_control function completely as we can
rely on the above mentioned bits rather than polling the cluster power
status register.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
The patch is based on Linux-next 20140618. It has been tested on an
exynos5420-based chromebook using the "/dev/bL_switcher" interface as
well as the script provided by Nicolas Pitre and Dave Martin [1].

Patch depends on:
[v2] ARM: EXYNOS: mcpm: Don't rely on firmware's secondary_cpu_start

[1] http://www.spinics.net/lists/linux-samsung-soc/msg31257.html

 arch/arm/mach-exynos/mcpm-exynos.c | 66 ++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index ace0ed6..95b5acf 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -26,6 +26,10 @@
 #define EXYNOS5420_CPUS_PER_CLUSTER	4
 #define EXYNOS5420_NR_CLUSTERS		2
 
+#define EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN	BIT(9)
+#define EXYNOS5420_USE_ARM_CORE_DOWN_STATE	BIT(29)
+#define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
+
 /*
  * The common v7_exit_coherency_flush API could not be used because of the
  * Erratum 799270 workaround. This macro is the same as the common one (in
@@ -73,36 +77,9 @@ cpu_use_count[EXYNOS5420_CPUS_PER_CLUSTER][EXYNOS5420_NR_CLUSTERS];
 
 #define exynos_cluster_unused(cluster) !exynos_cluster_usecnt(cluster)
 
-static int exynos_cluster_power_control(unsigned int cluster, int enable)
-{
-	unsigned int tries = 100;
-	unsigned int val;
-
-	if (enable) {
-		exynos_cluster_power_up(cluster);
-		val = S5P_CORE_LOCAL_PWR_EN;
-	} else {
-		exynos_cluster_power_down(cluster);
-		val = 0;
-	}
-
-	/* Wait until cluster power control is applied */
-	while (tries--) {
-		if (exynos_cluster_power_state(cluster) == val)
-			return 0;
-
-		cpu_relax();
-	}
-	pr_debug("timed out waiting for cluster %u to power %s\n", cluster,
-		enable ? "on" : "off");
-
-	return -ETIMEDOUT;
-}
-
 static int exynos_power_up(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
-	int err = 0;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
@@ -126,12 +103,9 @@ static int exynos_power_up(unsigned int cpu, unsigned int cluster)
 		 * cores.
 		 */
 		if (was_cluster_down)
-			err = exynos_cluster_power_control(cluster, 1);
+			exynos_cluster_power_up(cluster);
 
-		if (!err)
-			exynos_cpu_power_up(cpunr);
-		else
-			exynos_cluster_power_control(cluster, 0);
+		exynos_cpu_power_up(cpunr);
 	} else if (cpu_use_count[cpu][cluster] != 2) {
 		/*
 		 * The only possible values are:
@@ -147,7 +121,7 @@ static int exynos_power_up(unsigned int cpu, unsigned int cluster)
 	arch_spin_unlock(&exynos_mcpm_lock);
 	local_irq_enable();
 
-	return err;
+	return 0;
 }
 
 /*
@@ -178,9 +152,10 @@ static void exynos_power_down(void)
 	if (cpu_use_count[cpu][cluster] == 0) {
 		exynos_cpu_power_down(cpunr);
 
-		if (exynos_cluster_unused(cluster))
-			/* TODO: Turn off the cluster here to save power. */
+		if (exynos_cluster_unused(cluster)) {
+			exynos_cluster_power_down(cluster);
 			last_man = true;
+		}
 	} else if (cpu_use_count[cpu][cluster] == 1) {
 		/*
 		 * A power_up request went ahead of us.
@@ -299,6 +274,7 @@ static int __init exynos_mcpm_init(void)
 {
 	struct device_node *node;
 	void __iomem *ns_sram_base_addr;
+	unsigned int value, i;
 	int ret;
 
 	node = of_find_matching_node(NULL, exynos_dt_mcpm_match);
@@ -342,6 +318,26 @@ static int __init exynos_mcpm_init(void)
 	pr_info("Exynos MCPM support installed\n");
 
 	/*
+	 * On Exynos5420/5800 for the A15 and A7 clusters:
+	 *
+	 * EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN ensures that all the cores
+	 * in a cluster are turned off before turning off the cluster L2.
+	 *
+	 * EXYNOS5420_USE_ARM_CORE_DOWN_STATE ensures that a cores is powered
+	 * off before waking it up.
+	 *
+	 * EXYNOS5420_USE_L2_COMMON_UP_STATE ensures that cluster L2 will be
+	 * turned on before the first man is powered up.
+	 */
+	for (i = 0; i < EXYNOS5420_NR_CLUSTERS; i++) {
+		value = __raw_readl(EXYNOS_COMMON_CONFIGURATION(i) + 0x8);
+		value |= EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN |
+			 EXYNOS5420_USE_ARM_CORE_DOWN_STATE    |
+			 EXYNOS5420_USE_L2_COMMON_UP_STATE;
+		__raw_writel(value, EXYNOS_COMMON_CONFIGURATION(i) + 0x8);
+	}
+
+	/*
 	 * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
 	 * as part of secondary_cpu_start().  Let's redirect it to the
 	 * mcpm_entry_point().
-- 
2.0.0
