From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:29:31 +0530
Subject: [PATCH 025/228] cpufreq: kirkwood: use
 cpufreq_table_validate_and_show()
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <cb6a141e05f3d1ca1b47823591008908d90956ac.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index ba10658..59cbb35 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -125,19 +125,11 @@ static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
 /* Module init and exit code */
 static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int result;
-
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 5000; /* 5uS */
 	policy->cur = kirkwood_cpufreq_get_cpu_frequency(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, kirkwood_freq_table);
-	if (result)
-		return result;
-
-	cpufreq_frequency_table_get_attr(kirkwood_freq_table, policy->cpu);
-
-	return 0;
+	return cpufreq_table_validate_and_show(policy, kirkwood_freq_table);
 }
 
 static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e
