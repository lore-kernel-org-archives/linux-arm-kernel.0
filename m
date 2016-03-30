From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 30 Mar 2016 13:45:28 +0530
Subject: [PATCH V3 4/4] cpufreq: exynos: Use generic platdev driver
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Message-ID: <edd0da0dc76bfef1eebee9e033ee4363a35ed449.1459325515.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/exynos.c        | 25 -------------------------
 drivers/cpufreq/cpufreq-dt-platdev.c |  9 +++++++++
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4dfce1069406..4d3b056fd786 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -213,29 +213,6 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
-static const struct of_device_id exynos_cpufreq_matches[] = {
-	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
-#ifndef CONFIG_BL_SWITCHER
-	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5800", .data = "cpufreq-dt" },
-#endif
-	{ /* sentinel */ }
-};
-
-static void __init exynos_cpufreq_init(void)
-{
-	struct device_node *root = of_find_node_by_path("/");
-	const struct of_device_id *match;
-
-	match = of_match_node(exynos_cpufreq_matches, root);
-	if (match)
-		platform_device_register_simple(match->data, -1, NULL, 0);
-}
-
 static void __init exynos_dt_machine_init(void)
 {
 	/*
@@ -258,8 +235,6 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	exynos_cpufreq_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2a3532427ecf..f2ae7ad99a3c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -12,6 +12,15 @@
 #include <linux/platform_device.h>
 
 static const struct of_device_id machines[] = {
+	{ .compatible = "samsung,exynos3250", },
+	{ .compatible = "samsung,exynos4210", },
+	{ .compatible = "samsung,exynos4212", },
+	{ .compatible = "samsung,exynos4412", },
+	{ .compatible = "samsung,exynos5250", },
+#ifndef CONFIG_BL_SWITCHER
+	{ .compatible = "samsung,exynos5420", },
+	{ .compatible = "samsung,exynos5800", },
+#endif
 };
 
 static int __init cpufreq_dt_platdev_init(void)
-- 
2.7.1.410.g6faf27b
