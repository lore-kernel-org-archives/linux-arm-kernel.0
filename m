From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 16:04:20 +0530
Subject: [PATCH 5/8] arm_big_little: free OPP table created during ->init()
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Message-ID: <b5fca3025ec6411bb134306059c119b6b58f5ee2.1416910766.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OPP layer now supports freeing of OPPs and we should free them once they aren't
useful anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c    | 7 ++++++-
 drivers/cpufreq/arm_big_little.h    | 5 ++++-
 drivers/cpufreq/arm_big_little_dt.c | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index a46c223..e1a6ba6 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -289,6 +289,8 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev)
 
 	clk_put(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+	if (arm_bL_ops->free_opp_table)
+		arm_bL_ops->free_opp_table(cpu_dev);
 	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
 }
 
@@ -337,7 +339,7 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 	if (ret) {
 		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
 				__func__, cpu_dev->id, ret);
-		goto out;
+		goto free_opp_table;
 	}
 
 	name[12] = cluster + '0';
@@ -354,6 +356,9 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 	ret = PTR_ERR(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
 
+free_opp_table:
+	if (arm_bL_ops->free_opp_table)
+		arm_bL_ops->free_opp_table(cpu_dev);
 out:
 	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
 			cluster);
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
index 70f18fc..a211f7d 100644
--- a/drivers/cpufreq/arm_big_little.h
+++ b/drivers/cpufreq/arm_big_little.h
@@ -25,13 +25,16 @@
 
 struct cpufreq_arm_bL_ops {
 	char name[CPUFREQ_NAME_LEN];
-	int (*get_transition_latency)(struct device *cpu_dev);
 
 	/*
 	 * This must set opp table for cpu_dev in a similar way as done by
 	 * of_init_opp_table().
 	 */
 	int (*init_opp_table)(struct device *cpu_dev);
+
+	/* Optional */
+	int (*get_transition_latency)(struct device *cpu_dev);
+	void (*free_opp_table)(struct device *cpu_dev);
 };
 
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops);
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 4550f69..ef0b3f1 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -82,6 +82,7 @@ static struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
 	.init_opp_table = dt_init_opp_table,
+	.free_opp_table = of_free_opp_table,
 };
 
 static int generic_bL_probe(struct platform_device *pdev)
-- 
2.0.3.693.g996b0fd
