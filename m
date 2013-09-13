From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:06 +0530
Subject: [PATCH 120/228] cpufreq: sa11x0: don't initialize part of policy that
 is set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <8e8853f66fadd4816a5d0fc5284c0c1b6a7816ba.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sa1100-cpufreq.c | 1 -
 drivers/cpufreq/sa1110-cpufreq.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index 80a4fde..a1d1bb7 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -220,7 +220,6 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index a38d904..9da940e 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -334,7 +334,6 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
-- 
1.7.12.rc2.18.g61b472e
