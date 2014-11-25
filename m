From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 16:04:22 +0530
Subject: [PATCH 7/8] exynos5440: free OPP table created during ->init()
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Message-ID: <9b6cc4ddc2010abcac88c3995ce9ee29869cc195.1416910766.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OPP layer now supports freeing of OPPs and we should free them once they aren't
useful anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index f33f25b..27a57ed 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -371,7 +371,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dvfs_info->dev,
 			"failed to init cpufreq table: %d\n", ret);
-		goto err_put_node;
+		goto err_free_opp;
 	}
 	dvfs_info->freq_count = dev_pm_opp_get_opp_count(dvfs_info->dev);
 	exynos_sort_descend_freq_table();
@@ -423,6 +423,8 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
 err_free_table:
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
+err_free_opp:
+	of_free_opp_table(dvfs_info->dev);
 err_put_node:
 	of_node_put(np);
 	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
@@ -433,6 +435,7 @@ static int exynos_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&exynos_driver);
 	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
+	of_free_opp_table(dvfs_info->dev);
 	return 0;
 }
 
-- 
2.0.3.693.g996b0fd
