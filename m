From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 04 Mar 2011 14:16:09 +0900
Subject: [PATCH] Exynos4: Remove meaningless REGULATOR config option
Message-ID: <20110304051609.GA15121@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

reguration APIs are guarded at its header file
No need to define at codes.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos4/cpufreq.c b/arch/arm/mach-exynos4/cpufreq.c
index 174f080..a16ac35 100644
--- a/arch/arm/mach-exynos4/cpufreq.c
+++ b/arch/arm/mach-exynos4/cpufreq.c
@@ -31,10 +31,8 @@ static struct clk *moutcore;
 static struct clk *mout_mpll;
 static struct clk *mout_apll;
 
-#ifdef CONFIG_REGULATOR
 static struct regulator *arm_regulator;
 static struct regulator *int_regulator;
-#endif
 
 static struct cpufreq_freqs freqs;
 static unsigned int memtype;
@@ -434,10 +432,8 @@ static int exynos4_target(struct cpufreq_policy *policy,
 	/* control regulator */
 	if (freqs.new > freqs.old) {
 		/* Voltage up */
-#ifdef CONFIG_REGULATOR
 		regulator_set_voltage(arm_regulator, arm_volt, arm_volt);
 		regulator_set_voltage(int_regulator, int_volt, int_volt);
-#endif
 	}
 
 	/* Clock Configuration Procedure */
@@ -446,10 +442,8 @@ static int exynos4_target(struct cpufreq_policy *policy,
 	/* control regulator */
 	if (freqs.new < freqs.old) {
 		/* Voltage down */
-#ifdef CONFIG_REGULATOR
 		regulator_set_voltage(arm_regulator, arm_volt, arm_volt);
 		regulator_set_voltage(int_regulator, int_volt, int_volt);
-#endif
 	}
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
@@ -521,7 +515,6 @@ static int __init exynos4_cpufreq_init(void)
 	if (IS_ERR(mout_apll))
 		goto out;
 
-#ifdef CONFIG_REGULATOR
 	arm_regulator = regulator_get(NULL, "vdd_arm");
 	if (IS_ERR(arm_regulator)) {
 		printk(KERN_ERR "failed to get resource %s\n", "vdd_arm");
@@ -533,7 +526,6 @@ static int __init exynos4_cpufreq_init(void)
 		printk(KERN_ERR "failed to get resource %s\n", "vdd_int");
 		goto out;
 	}
-#endif
 
 	/*
 	 * Check DRAM type.
@@ -565,13 +557,11 @@ out:
 	if (!IS_ERR(mout_apll))
 		clk_put(mout_apll);
 
-#ifdef CONFIG_REGULATOR
 	if (!IS_ERR(arm_regulator))
 		regulator_put(arm_regulator);
 
 	if (!IS_ERR(int_regulator))
 		regulator_put(int_regulator);
-#endif
 
 	printk(KERN_ERR "%s: failed initialization\n", __func__);
 
