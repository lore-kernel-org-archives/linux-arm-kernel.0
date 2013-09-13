From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:03 +0530
Subject: [PATCH 057/228] cpufreq: arm_big_little: Use generic cpufreq routines
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <548ca171c8d04596fe22e8b98af24b28453e840d.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 2c7c134..132c966 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -47,14 +47,6 @@ static unsigned int bL_cpufreq_get(unsigned int cpu)
 	return clk_get_rate(clk[cur_cluster]) / 1000;
 }
 
-/* Validate policy frequency range */
-static int bL_cpufreq_verify_policy(struct cpufreq_policy *policy)
-{
-	u32 cur_cluster = cpu_to_cluster(policy->cpu);
-
-	return cpufreq_frequency_table_verify(policy, freq_table[cur_cluster]);
-}
-
 /* Set clock frequency */
 static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
 		unsigned int target_freq, unsigned int relation)
@@ -205,22 +197,16 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-/* Export freq_table to sysfs */
-static struct freq_attr *bL_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver bL_cpufreq_driver = {
 	.name			= "arm-big-little",
 	.flags			= CPUFREQ_STICKY |
 					CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
-	.verify			= bL_cpufreq_verify_policy,
+	.verify			= cpufreq_generic_frequency_table_verify,
 	.target			= bL_cpufreq_set_target,
 	.get			= bL_cpufreq_get,
 	.init			= bL_cpufreq_init,
 	.exit			= bL_cpufreq_exit,
-	.attr			= bL_cpufreq_attr,
+	.attr			= cpufreq_generic_attr,
 };
 
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
-- 
1.7.12.rc2.18.g61b472e
