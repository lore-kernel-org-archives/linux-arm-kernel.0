From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 24 Mar 2016 12:10:30 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Use generic platdev driver
In-Reply-To: <cover.1458801338.git.viresh.kumar@linaro.org>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
Message-ID: <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-exynos/exynos.c        | 25 -------------------------
 drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
 2 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 1c47aee31e9c..757c6012989c 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -224,29 +224,6 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
-static const struct of_device_id exynos_cpufreq_matches[] = {
-	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
-	{ /* sentinel */ }
-};
-
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
 	/*
@@ -269,8 +246,6 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	exynos_cpufreq_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18b81724ca0b..d7e62528ce06 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -20,6 +20,11 @@ struct cpufreq_dt_compat {
 };
 
 static struct cpufreq_dt_compat compat[] = {
+	{ "samsung,exynos3250",		NULL,		0 },
+	{ "samsung,exynos4210",		NULL,		0 },
+	{ "samsung,exynos4212",		NULL,		0 },
+	{ "samsung,exynos4412",		NULL,		0 },
+	{ "samsung,exynos5250",		NULL,		0 },
 };
 
 static int __init cpufreq_dt_platdev_init(void)
-- 
2.7.1.410.g6faf27b
