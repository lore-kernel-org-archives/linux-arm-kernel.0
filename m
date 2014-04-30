From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Wed, 30 Apr 2014 15:28:35 +0900
Subject: [PATCH 2/3] cpufreq: Removed exynos_sort_descend_freq_table funtion
Message-ID: <000101cf643d$6a36c270$3ea44750$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying "PM / OPP: Add support for descending order for cpufreq
table"
,to make the table descending we can use OPP_TABLE_ORDER_DESCEND flag.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/cpufreq/exynos5440-cpufreq.c |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
b/drivers/cpufreq/exynos5440-cpufreq.c
index a6b8214..fc19beb 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -279,25 +279,6 @@ static irqreturn_t exynos_cpufreq_irq(int irq, void
*id)
 	return IRQ_HANDLED;
 }
 
-static void exynos_sort_descend_freq_table(void)
-{
-	struct cpufreq_frequency_table *freq_tbl = dvfs_info->freq_table;
-	int i = 0, index;
-	unsigned int tmp_freq;
-	/*
-	 * Exynos5440 clock controller state logic expects the cpufreq table
to
-	 * be in descending order. But the OPP library constructs the table
in
-	 * ascending order. So to make the table descending we just need to
-	 * swap the i element with the N - i element.
-	 */
-	for (i = 0; i < dvfs_info->freq_count / 2; i++) {
-		index = dvfs_info->freq_count - i - 1;
-		tmp_freq = freq_tbl[i].frequency;
-		freq_tbl[i].frequency = freq_tbl[index].frequency;
-		freq_tbl[index].frequency = tmp_freq;
-	}
-}
-
 static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	policy->clk = dvfs_info->cpu_clk;
@@ -367,14 +348,13 @@ static int exynos_cpufreq_probe(struct platform_device
*pdev)
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(dvfs_info->dev,
-					    &dvfs_info->freq_table);
+			&dvfs_info->freq_table, OPP_TABLE_ORDER_DESCEND);
 	if (ret) {
 		dev_err(dvfs_info->dev,
 			"failed to init cpufreq table: %d\n", ret);
 		goto err_put_node;
 	}
 	dvfs_info->freq_count = dev_pm_opp_get_opp_count(dvfs_info->dev);
-	exynos_sort_descend_freq_table();
 
 	if (of_property_read_u32(np, "clock-latency", &dvfs_info->latency))
 		dvfs_info->latency = DEF_TRANS_LATENCY;
-- 
1.7.10.4
