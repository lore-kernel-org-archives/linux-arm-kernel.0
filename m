From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 21 Dec 2012 10:09:55 +0000
Subject: [PATCH] ARM: tegra: cpufreq: move clk_get/put out of function
 tegra_cpu_init/exit
Message-ID: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_cpu_init/exit will be called every time one cpu core is online or
offline. And all cpu cores share same clocks, redundant clk_get/put
wast time,  so I move them out.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
---
 arch/arm/mach-tegra/cpu-tegra.c |   40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 627bf0f..4faa3c6 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -217,24 +217,6 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 	if (policy->cpu >= NUM_CPUS)
 		return -EINVAL;
 
-	cpu_clk = clk_get_sys(NULL, "cpu");
-	if (IS_ERR(cpu_clk))
-		return PTR_ERR(cpu_clk);
-
-	pll_x_clk = clk_get_sys(NULL, "pll_x");
-	if (IS_ERR(pll_x_clk))
-		return PTR_ERR(pll_x_clk);
-
-	pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(pll_p_clk))
-		return PTR_ERR(pll_p_clk);
-
-	emc_clk = clk_get_sys("cpu", "emc");
-	if (IS_ERR(emc_clk)) {
-		clk_put(cpu_clk);
-		return PTR_ERR(emc_clk);
-	}
-
 	clk_prepare_enable(emc_clk);
 	clk_prepare_enable(cpu_clk);
 
@@ -259,8 +241,6 @@ static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_cpuinfo(policy, freq_table);
 	clk_disable_unprepare(emc_clk);
-	clk_put(emc_clk);
-	clk_put(cpu_clk);
 	return 0;
 }
 
@@ -281,12 +261,32 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
 
 static int __init tegra_cpufreq_init(void)
 {
+	cpu_clk = clk_get_sys(NULL, "cpu");
+	if (IS_ERR(cpu_clk))
+		return PTR_ERR(cpu_clk);
+
+	pll_x_clk = clk_get_sys(NULL, "pll_x");
+	if (IS_ERR(pll_x_clk))
+		return PTR_ERR(pll_x_clk);
+
+	pll_p_clk = clk_get_sys(NULL, "pll_p");
+	if (IS_ERR(pll_p_clk))
+		return PTR_ERR(pll_p_clk);
+
+	emc_clk = clk_get_sys("cpu", "emc");
+	if (IS_ERR(emc_clk)) {
+		clk_put(cpu_clk);
+		return PTR_ERR(emc_clk);
+	}
+
 	return cpufreq_register_driver(&tegra_cpufreq_driver);
 }
 
 static void __exit tegra_cpufreq_exit(void)
 {
         cpufreq_unregister_driver(&tegra_cpufreq_driver);
+	clk_put(emc_clk);
+	clk_put(cpu_clk);
 }
 
 
-- 
1.7.9.5
