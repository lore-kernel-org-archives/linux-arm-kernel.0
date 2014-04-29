From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Tue, 29 Apr 2014 14:24:05 +0900
Subject: [PATCH 2/2] cpufreq: Remove exynos_sort_descend_freq_table in
 exynos5440-cpufreq.c
Message-ID: <000701cf636b$3d1d13c0$b7573b40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying "PM / OPP: Use list_for_each_entry_reverse instead of
list_for_each_entry",
cpufreq table is sorted int descending order. So
exynos_sort_descend_freq_table
doesn't need anymore.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/cpufreq/exynos5440-cpufreq.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
b/drivers/cpufreq/exynos5440-cpufreq.c
index a6b8214..92db80b 100644
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
@@ -374,7 +355,6 @@ static int exynos_cpufreq_probe(struct platform_device
*pdev)
 		goto err_put_node;
 	}
 	dvfs_info->freq_count = dev_pm_opp_get_opp_count(dvfs_info->dev);
-	exynos_sort_descend_freq_table();
 
 	if (of_property_read_u32(np, "clock-latency", &dvfs_info->latency))
 		dvfs_info->latency = DEF_TRANS_LATENCY;
-- 
1.7.10.4
