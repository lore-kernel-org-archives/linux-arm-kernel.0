From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 16:04:21 +0530
Subject: [PATCH 6/8] cpufreq-dt: free OPP table created during ->init()
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Message-ID: <1ac3e8c67c7bd2a962aed6561693d16ca5cd9db9.1416910766.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OPP layer now supports freeing of OPPs and we should free them once they aren't
useful anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8cba13d..f44419c 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -215,7 +215,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out_put_node;
+		goto out_free_opp;
 	}
 
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
@@ -310,7 +310,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_priv:
 	kfree(priv);
-out_put_node:
+out_free_opp:
+	of_free_opp_table(cpu_dev);
 	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
@@ -326,6 +327,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
+	of_free_opp_table(priv->cpu_dev);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
-- 
2.0.3.693.g996b0fd
