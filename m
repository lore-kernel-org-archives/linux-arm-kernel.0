From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:29:38 +0530
Subject: [PATCH 032/228] cpufreq: pmac: use cpufreq_table_validate_and_show()
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <c270f0e9d1fda00a68a354dda359d1a08fad5289.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 3 +--
 drivers/cpufreq/pmac64-cpufreq.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index a096cd3..470b555 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -408,8 +408,7 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency	= transition_latency;
 	policy->cur = cur_freq;
 
-	cpufreq_frequency_table_get_attr(pmac_cpu_freqs, policy->cpu);
-	return cpufreq_frequency_table_cpuinfo(policy, pmac_cpu_freqs);
+	return cpufreq_table_validate_and_show(policy, pmac_cpu_freqs);
 }
 
 static u32 read_gpio(struct device_node *np)
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 3a51ad7..41fa89e 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -363,10 +363,8 @@ static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
 	cpumask_copy(policy->cpus, cpu_online_mask);
-	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 
-	return cpufreq_frequency_table_cpuinfo(policy,
-		g5_cpu_freqs);
+	return cpufreq_table_validate_and_show(policy, g5_cpu_freqs);
 }
 
 
-- 
1.7.12.rc2.18.g61b472e
