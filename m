From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Sat,  5 Dec 2015 16:53:03 +0800
Subject: [PATCH 1/2] cpufreq: mt8173: migrate to use operating-points-v2
 bindings
In-Reply-To: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1449305584-414-2-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify mt8173-cpufreq driver to get OPP-sharing information and set up
OPP table provided by operating-points-v2 bindings.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
This patch is based on the series[1] which fixes some issues of
mt8173-cpufreq driver.

[1] http://thread.gmane.org/gmane.linux.power-management.general/68692
---
 drivers/cpufreq/mt8173-cpufreq.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 257bcb9..17e9cad 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -344,6 +344,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	unsigned long rate;
 	int ret;
 
+	/* Mark the first owner of this CPU DVFS domain information */
+	cpumask_set_cpu(cpu, &info->cpus);
+
 	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev) {
 		pr_err("failed to get cpu%d device\n", cpu);
@@ -390,7 +393,15 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	/* Both presence and absence of sram regulator are valid cases. */
 	sram_reg = regulator_get_exclusive(cpu_dev, "sram");
 
-	ret = dev_pm_opp_of_add_table(cpu_dev);
+	/* Get OPP-sharing information from "operating-points-v2" bindings */
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &info->cpus);
+	if (ret) {
+		pr_err("failed to get OPP-sharing information for cpu%d\n",
+		       cpu);
+		goto out_free_resources;
+	}
+
+	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
 	if (ret) {
 		pr_warn("no OPP table for cpu%d\n", cpu);
 		goto out_free_resources;
@@ -421,13 +432,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	 */
 	info->need_voltage_tracking = !IS_ERR(sram_reg);
 
-	/* CPUs in the same cluster share a clock and power domain. */
-	cpumask_copy(&info->cpus, &cpu_topology[cpu].core_sibling);
-
 	return 0;
 
 out_free_opp_table:
-	dev_pm_opp_of_remove_table(cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
 out_free_resources:
 	if (!IS_ERR(proc_reg))
@@ -453,7 +461,7 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	if (!IS_ERR(info->inter_clk))
 		clk_put(info->inter_clk);
 
-	dev_pm_opp_of_remove_table(info->cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
-- 
1.9.1
