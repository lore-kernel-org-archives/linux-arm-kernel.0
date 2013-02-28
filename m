From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Feb 2013 20:49:27 -0800
Subject: [PATCH 3/5] cpufreq: omap: scale regulator from clk notifier
In-Reply-To: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
Message-ID: <1362026969-11457-4-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves direct control of the MPU voltage regulator out of the
cpufreq driver .target callback and instead uses the common dvfs clk
rate-change notifier infrastructure.

Ideally it would be nice to reduce the .target callback for omap's
cpufreq driver to a simple call to clk_set_rate.  For now there is still
some other stuff needed there (jiffies per loop, rounding the rate, etc
etc).

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c |   82 ++++++++++------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 1f3417a..6bec1c4 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -37,7 +37,7 @@ static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
 static struct device *mpu_dev;
-static struct regulator *mpu_reg;
+static struct dvfs_info *di;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -62,10 +62,9 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int relation)
 {
 	unsigned int i;
-	int r, ret = 0;
+	int ret = 0;
 	struct cpufreq_freqs freqs;
-	struct opp *opp;
-	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
+	unsigned long freq;
 
 	if (!freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
@@ -109,50 +108,13 @@ static int omap_target(struct cpufreq_policy *policy,
 	}
 	freq = ret;
 
-	if (mpu_reg) {
-		opp = opp_find_freq_ceil(mpu_dev, &freq);
-		if (IS_ERR(opp)) {
-			dev_err(mpu_dev, "%s: unable to find MPU OPP for %d\n",
-				__func__, freqs.new);
-			return -EINVAL;
-		}
-		volt = opp_get_voltage(opp);
-		tol = volt * OPP_TOLERANCE / 100;
-		volt_old = regulator_get_voltage(mpu_reg);
-	}
-
-	dev_dbg(mpu_dev, "cpufreq-omap: %u MHz, %ld mV --> %u MHz, %ld mV\n", 
-		freqs.old / 1000, volt_old ? volt_old / 1000 : -1,
-		freqs.new / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (mpu_reg && (freqs.new > freqs.old)) {
-		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage up.\n",
-				 __func__);
-			freqs.new = freqs.old;
-			goto done;
-		}
-	}
+	dev_dbg(mpu_dev, "cpufreq-omap: %u MHz --> %u MHz\n",
+			freqs.old / 1000, freqs.new / 1000); 
 
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 
-	/* scaling down?  scale voltage after frequency */
-	if (mpu_reg && (freqs.new < freqs.old)) {
-		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
-				 __func__);
-			ret = clk_set_rate(mpu_clk, freqs.old * 1000);
-			freqs.new = freqs.old;
-			goto done;
-		}
-	}
-
 	freqs.new = omap_getspeed(policy->cpu);
 
-done:
 	/* notifiers */
 	for_each_cpu(i, policy->cpus) {
 		freqs.cpu = i;
@@ -172,10 +134,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 
-	mpu_clk = clk_get(NULL, "cpufreq_ck");
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
-
 	if (policy->cpu >= NR_CPUS) {
 		result = -EINVAL;
 		goto fail_ck;
@@ -253,34 +211,34 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
+	struct dvfs_info_init dii;
+
+	mpu_clk = clk_get(NULL, "cpufreq_ck");
+	if (IS_ERR(mpu_clk))
+		return PTR_ERR(mpu_clk);
+
 	mpu_dev = get_cpu_device(0);
 	if (!mpu_dev) {
 		pr_warning("%s: unable to get the mpu device\n", __func__);
 		return -EINVAL;
 	}
 
-	mpu_reg = regulator_get(mpu_dev, "vcc");
-	if (IS_ERR(mpu_reg)) {
-		pr_warning("%s: unable to get MPU regulator\n", __func__);
-		mpu_reg = NULL;
-	} else {
-		/* 
-		 * Ensure physical regulator is present.
-		 * (e.g. could be dummy regulator.)
-		 */
-		if (regulator_get_voltage(mpu_reg) < 0) {
-			pr_warn("%s: physical regulator not present for MPU\n",
+	dii.dev = mpu_dev;
+	dii.con_id = "cpufreq_ck";
+	dii.reg_id = "vcc";
+	dii.tol = OPP_TOLERANCE;
+
+	di = dvfs_clk_notifier_register(&dii);
+	if (IS_ERR(di))
+		pr_warning("%s: failed to register dvfs clk notifier\n",
 				__func__);
-			regulator_put(mpu_reg);
-			mpu_reg = NULL;
-		}
-	}
 
 	return cpufreq_register_driver(&omap_driver);
 }
 
 static void __exit omap_cpufreq_exit(void)
 {
+	dvfs_clk_notifier_unregister(di);
 	cpufreq_unregister_driver(&omap_driver);
 }
 
-- 
1.7.10.4
