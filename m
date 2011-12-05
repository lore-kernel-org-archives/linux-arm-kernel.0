From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  5 Dec 2011 18:22:01 +0000
Subject: [PATCH 1/2] [CPUFREQ] s3c64xx: Use pr_fmt() for consistent log
 messages
Message-ID: <1323109322-24130-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They're already consistent but it saves remembering to do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/cpufreq/s3c64xx-cpufreq.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 3475f65..a5e72cb 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "cpufreq: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -91,7 +93,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (freqs.old == freqs.new)
 		return 0;
 
-	pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
+	pr_debug("Transition %d-%dkHz\n", freqs.old, freqs.new);
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
@@ -101,7 +103,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 					    dvfs->vddarm_min,
 					    dvfs->vddarm_max);
 		if (ret != 0) {
-			pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
+			pr_err("Failed to set VDDARM for %dkHz: %d\n",
 			       freqs.new, ret);
 			goto err;
 		}
@@ -110,7 +112,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	ret = clk_set_rate(armclk, freqs.new * 1000);
 	if (ret < 0) {
-		pr_err("cpufreq: Failed to set rate %dkHz: %d\n",
+		pr_err("Failed to set rate %dkHz: %d\n",
 		       freqs.new, ret);
 		goto err;
 	}
@@ -123,14 +125,14 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 					    dvfs->vddarm_min,
 					    dvfs->vddarm_max);
 		if (ret != 0) {
-			pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
+			pr_err("Failed to set VDDARM for %dkHz: %d\n",
 			       freqs.new, ret);
 			goto err_clk;
 		}
 	}
 #endif
 
-	pr_debug("cpufreq: Set actual frequency %lukHz\n",
+	pr_debug("Set actual frequency %lukHz\n",
 		 clk_get_rate(armclk) / 1000);
 
 	return 0;
@@ -153,7 +155,7 @@ static void __init s3c64xx_cpufreq_config_regulator(void)
 
 	count = regulator_count_voltages(vddarm);
 	if (count < 0) {
-		pr_err("cpufreq: Unable to check supported voltages\n");
+		pr_err("Unable to check supported voltages\n");
 	}
 
 	freq = s3c64xx_freq_table;
@@ -171,7 +173,7 @@ static void __init s3c64xx_cpufreq_config_regulator(void)
 		}
 
 		if (!found) {
-			pr_debug("cpufreq: %dkHz unsupported by regulator\n",
+			pr_debug("%dkHz unsupported by regulator\n",
 				 freq->frequency);
 			freq->frequency = CPUFREQ_ENTRY_INVALID;
 		}
@@ -194,13 +196,13 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 		return -EINVAL;
 
 	if (s3c64xx_freq_table == NULL) {
-		pr_err("cpufreq: No frequency information for this CPU\n");
+		pr_err("No frequency information for this CPU\n");
 		return -ENODEV;
 	}
 
 	armclk = clk_get(NULL, "armclk");
 	if (IS_ERR(armclk)) {
-		pr_err("cpufreq: Unable to obtain ARMCLK: %ld\n",
+		pr_err("Unable to obtain ARMCLK: %ld\n",
 		       PTR_ERR(armclk));
 		return PTR_ERR(armclk);
 	}
@@ -209,12 +211,19 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 	vddarm = regulator_get(NULL, "vddarm");
 	if (IS_ERR(vddarm)) {
 		ret = PTR_ERR(vddarm);
-		pr_err("cpufreq: Failed to obtain VDDARM: %d\n", ret);
-		pr_err("cpufreq: Only frequency scaling available\n");
+		pr_err("Failed to obtain VDDARM: %d\n", ret);
+		pr_err("Only frequency scaling available\n");
 		vddarm = NULL;
 	} else {
 		s3c64xx_cpufreq_config_regulator();
 	}
+
+	vddint = regulator_get(NULL, "vddint");
+	if (IS_ERR(vddint)) {
+		ret = PTR_ERR(vddint);
+		pr_err("Failed to obtain VDDINT: %d\n", ret);
+		vddint = NULL;
+	}
 #endif
 
 	freq = s3c64xx_freq_table;
@@ -225,7 +234,7 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 		r = clk_round_rate(armclk, freq->frequency * 1000);
 		r /= 1000;
 		if (r != freq->frequency) {
-			pr_debug("cpufreq: %dkHz unsupported by clock\n",
+			pr_debug("%dkHz unsupported by clock\n",
 				 freq->frequency);
 			freq->frequency = CPUFREQ_ENTRY_INVALID;
 		}
@@ -248,7 +257,7 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 
 	ret = cpufreq_frequency_table_cpuinfo(policy, s3c64xx_freq_table);
 	if (ret != 0) {
-		pr_err("cpufreq: Failed to configure frequency table: %d\n",
+		pr_err("Failed to configure frequency table: %d\n",
 		       ret);
 		regulator_put(vddarm);
 		clk_put(armclk);
-- 
1.7.7.3
