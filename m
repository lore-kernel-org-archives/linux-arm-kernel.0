From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 11 Feb 2015 16:16:30 +0800
Subject: [PATCH 7/7] cpufreq-dt: Use DT to set policy->cpus/related_cpus
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Message-ID: <7f6fcfa7cbbcc48148487330011b05005c002ab5.1423642246.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates cpufreq-dt driver to read clock sharing information from new OPP
bindings. And then initialize OPPs for CPUs with help of new bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db54b7e..6f307897e17a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -208,8 +208,14 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_put_reg_clk;
 	}
 
+	pd = cpufreq_get_driver_data();
+	if (!pd || !pd->independent_clocks) {
+		if (of_get_cpus_sharing_opps(cpu_dev, policy->cpus))
+			cpumask_setall(policy->cpus);
+	}
+
 	/* OPPs might be populated at runtime, don't check for error here */
-	of_init_opp_table(cpu_dev);
+	of_cpumask_init_opp_table(policy->cpus);
 
 	/*
 	 * But we need OPP table to function so if it is not there let's
@@ -293,10 +299,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	pd = cpufreq_get_driver_data();
-	if (!pd || !pd->independent_clocks)
-		cpumask_setall(policy->cpus);
-
 	of_node_put(np);
 
 	return 0;
@@ -306,7 +308,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	of_free_opp_table(cpu_dev);
+	of_cpumask_free_opp_table(policy->cpus);
 	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
@@ -322,7 +324,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	of_free_opp_table(priv->cpu_dev);
+	of_cpumask_free_opp_table(policy->related_cpus);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
-- 
2.3.0.rc0.44.ga94655d
