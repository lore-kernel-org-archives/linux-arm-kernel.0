From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:05 +0530
Subject: [PATCH 059/228] cpufreq: blackfin: Use generic cpufreq routines
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <47d7b682a43f352686a9a927642cb84fc74e8399.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 84d446a..48888cf 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -191,11 +191,6 @@ static int bfin_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int bfin_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, bfin_freq_table);
-}
-
 static int __bfin_cpu_init(struct cpufreq_policy *policy)
 {
 
@@ -213,25 +208,14 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
-static int __bfin_cpu_exit(struct cpufreq_policy *policy)
-{
-
-	cpufreq_frequency_table_put_attr(policy->cpu);
-}
-
-static struct freq_attr *bfin_freq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver bfin_driver = {
-	.verify = bfin_verify_speed,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = bfin_target,
 	.get = bfin_getfreq_khz,
 	.init = __bfin_cpu_init,
-	.exit = __bfin_cpu_exit,
+	.exit = cpufreq_generic_exit,
 	.name = "bfin cpufreq",
-	.attr = bfin_freq_attr,
+	.attr = cpufreq_generic_attr,
 };
 
 static int __init bfin_cpu_init(void)
-- 
1.7.12.rc2.18.g61b472e
