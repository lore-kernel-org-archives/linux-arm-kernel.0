From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:32:47 +0530
Subject: [PATCH 221/228] cpufreq: loongson2: use cpufreq_generic_get() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <f5aaff9b7623faf69b6b38884d866619a75ef15f.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have common infrastructure available with us for getting a CPUs clk rate.
Lets use it for this driver.

We don't need a global variable to hold clock anymore.

Cc: John Crispin <blogic@openwrt.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index a436092..b6581ab 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -24,8 +24,6 @@
 
 static uint nowait;
 
-static struct clk *cpuclk;
-
 static void (*saved_cpu_wait) (void);
 
 static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
@@ -44,11 +42,6 @@ static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
 	return 0;
 }
 
-static unsigned int loongson2_cpufreq_get(unsigned int cpu)
-{
-	return clk_get_rate(cpuclk);
-}
-
 /*
  * Here we notify other drivers of the proposed change and the final change.
  */
@@ -69,13 +62,14 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 
 	/* setting the cpu frequency */
-	clk_set_rate(cpuclk, freq);
+	clk_set_rate(policy->clk, freq);
 
 	return 0;
 }
 
 static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
+	static struct clk *cpuclk;
 	int i;
 	unsigned long rate;
 	int ret;
@@ -104,13 +98,14 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
+	policy->clk = cpuclk;
 	return cpufreq_generic_init(policy, &loongson2_clockmod_table[0], 0);
 }
 
 static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_put_attr(policy->cpu);
-	clk_put(cpuclk);
+	clk_put(policy->clk);
 	return 0;
 }
 
@@ -119,7 +114,7 @@ static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.init = loongson2_cpufreq_cpu_init,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = loongson2_cpufreq_target,
-	.get = loongson2_cpufreq_get,
+	.get = cpufreq_generic_get,
 	.exit = loongson2_cpufreq_exit,
 	.attr = cpufreq_generic_attr,
 };
-- 
1.7.12.rc2.18.g61b472e
