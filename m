From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:01 +0530
Subject: [PATCH 115/228] cpufreq: powernow: don't initialize part of policy
 that is set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <878d14d018cba46cdd161e21d801dc0f4a0c3189.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernow-k6.c | 1 -
 drivers/cpufreq/powernow-k7.c | 2 --
 drivers/cpufreq/powernow-k8.c | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index ff05d28..eda1702 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -151,7 +151,6 @@ static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 200000;
-	policy->cur = busfreq * max_multiplier;
 
 	return cpufreq_table_validate_and_show(policy, clock_ratio);
 }
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 14cd98f..44d345b 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -673,8 +673,6 @@ static int powernow_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 		cpufreq_scale(2000000UL, fsb, latency);
 
-	policy->cur = powernow_get(0);
-
 	return cpufreq_table_validate_and_show(policy, powernow_table);
 }
 
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index f054d5b..8721744 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1161,9 +1161,6 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 	cpumask_copy(pol->cpus, cpu_core_mask(pol->cpu));
 	data->available_cores = pol->cpus;
 
-	pol->cur = find_khz_freq_from_fid(data->currfid);
-	pr_debug("policy current frequency %d kHz\n", pol->cur);
-
 	/* min/max the cpu is capable of */
 	if (cpufreq_table_validate_and_show(pol, data->powernow_table)) {
 		printk(KERN_ERR FW_BUG PFX "invalid powernow_table\n");
-- 
1.7.12.rc2.18.g61b472e
