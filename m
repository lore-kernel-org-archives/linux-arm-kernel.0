From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 16:04:23 +0530
Subject: [PATCH 8/8] imx6q: free OPP table created during ->init()
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Message-ID: <7c9805644464c2aa84e75478ac2854b06317bd21.1416910766.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OPP layer now supports freeing of OPPs and we should free them once they aren't
useful anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index c2d3076..5da1d13 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -31,6 +31,7 @@ static struct clk *step_clk;
 static struct clk *pll2_pfd2_396m_clk;
 
 static struct device *cpu_dev;
+static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
@@ -207,11 +208,14 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 			goto put_reg;
 		}
 
+		/* Because we have added the OPPs here, we must free them */
+		free_opp = true;
+
 		num = dev_pm_opp_get_opp_count(cpu_dev);
 		if (num < 0) {
 			ret = num;
 			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
-			goto put_reg;
+			goto out_free_opp;
 		}
 	}
 
@@ -306,6 +310,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 
 free_freq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_opp:
+	if (free_opp)
+		of_free_opp_table(cpu_dev);
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
@@ -332,6 +339,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+	if (free_opp)
+		of_free_opp_table(cpu_dev);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
-- 
2.0.3.693.g996b0fd
