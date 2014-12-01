From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  1 Dec 2014 17:11:29 +0530
Subject: [RFC V1 8/8] cpufreq: exynos: reuse dt_device.c to create cpufreq
 platform device
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Message-ID: <f90965f48ac15c6a857421301e659a941f5543ff.1417433163.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have a common interface for create platform device required to probe
cpufreq-dt driver (and others as well). Lets create devices from dt_device.c
instead of platform specific code.

For exynos, we are updating the blacklist instead of DT because the newer kernel
should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 27 ++++++++-------------------
 drivers/cpufreq/dt_device.c   |  6 +++++-
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a1be294..15a4bbd 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -283,30 +283,17 @@ static void __init exynos_init_irq(void)
 }
 
 static const struct of_device_id exynos_cpufreq_matches[] = {
-	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
-	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
+	{ .compatible = "samsung,exynos5420" },
+	{ .compatible = "samsung,exynos5250" },
+	{ .compatible = "samsung,exynos4210" },
+	{ .compatible = "samsung,exynos5440" },
 	{ /* sentinel */ }
 };
 
-static void __init exynos_cpufreq_init(void)
-{
-	struct device_node *root = of_find_node_by_path("/");
-	const struct of_device_id *match;
-
-	match = of_match_node(exynos_cpufreq_matches, root);
-	if (!match) {
-		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-		return;
-	}
-
-	platform_device_register_simple(match->data, -1, NULL, 0);
-}
-
 static void __init exynos_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
+	struct device_node *root = of_find_node_by_path("/");
 	const char *i2c_compat = "samsung,s3c2440-i2c";
 	unsigned int tmp;
 	int id;
@@ -343,7 +330,9 @@ static void __init exynos_dt_machine_init(void)
 			of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	exynos_cpufreq_init();
+	/* Other devices are created by dt_device.c */
+	if (!of_match_node(exynos_cpufreq_matches, root))
+		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index 8b5ac05..bc4bc97 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -24,6 +24,9 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "arm-bL-cpufreq-dt",	.data = "arm-bL-cpufreq-dt" },
 
 	/* BLACKLIST of existing users of cpufreq-dt below */
+	{ .compatible = "samsung,exynos5250",	.data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos4210",	.data = "cpufreq-dt" },
+
 	{ .compatible = "fsl,imx27",		.data = "cpufreq-dt" },
 	{ .compatible = "fsl,imx51",		.data = "cpufreq-dt" },
 
@@ -38,9 +41,10 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "calxeda,ecx-2000",	.data = "cpufreq-dt" },
 
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
+	{ .compatible = "samsung,exynos5420",	.data = "arm-bL-cpufreq-dt" },
 
 	/* BLACKLIST of existing users of other drivers below */
-
+	{ .compatible = "samsung,exynos5440",	.data = "exynos5440-cpufreq" },
 	{},
 };
 
-- 
2.0.3.693.g996b0fd
