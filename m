From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 24 Apr 2018 15:09:46 +0530
Subject: [PATCH V3 2/3] cpufreq: armada: Free resources on error paths
In-Reply-To: <cover.1524561482.git.viresh.kumar@linaro.org>
References: <cover.1524561482.git.viresh.kumar@linaro.org>
Message-ID: <fced5258001769db60f75cdce2e2ac4961823be6.1524561482.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The resources weren't freed on failures, free them properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 72a2975499db..1d5db6f6ace9 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -166,6 +166,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 {
 	struct armada_37xx_dvfs *dvfs;
 	struct platform_device *pdev;
+	unsigned long freq;
 	unsigned int cur_frequency;
 	struct regmap *nb_pm_base;
 	struct device *cpu_dev;
@@ -207,33 +208,43 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	}
 
 	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
-	if (!dvfs)
+	if (!dvfs) {
+		clk_put(clk);
 		return -EINVAL;
+	}
 
 	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
 	clk_put(clk);
 
 	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
 	     load_lvl++) {
-		unsigned long freq = cur_frequency / dvfs->divider[load_lvl];
+		freq = cur_frequency / dvfs->divider[load_lvl];
 
 		ret = dev_pm_opp_add(cpu_dev, freq, 0);
-		if (ret) {
-			/* clean-up the already added opp before leaving */
-			while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
-				freq = cur_frequency / dvfs->divider[load_lvl];
-				dev_pm_opp_remove(cpu_dev, freq);
-			}
-			return ret;
-		}
+		if (ret)
+			goto remove_opp;
 	}
 
 	/* Now that everything is setup, enable the DVFS at hardware level */
 	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
 
 	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (ret)
+		goto disable_dvfs;
+
+	return 0;
+
+disable_dvfs:
+	armada37xx_cpufreq_disable_dvfs(nb_pm_base);
+remove_opp:
+	/* clean-up the already added opp before leaving */
+	while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
+		freq = cur_frequency / dvfs->divider[load_lvl];
+		dev_pm_opp_remove(cpu_dev, freq);
+	}
 
-	return PTR_ERR_OR_ZERO(pdev);
+	return ret;
 }
 /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
 late_initcall(armada37xx_cpufreq_driver_init);
-- 
2.15.0.194.g9af6a3dea062
