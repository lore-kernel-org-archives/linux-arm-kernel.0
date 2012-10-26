From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 26 Oct 2012 18:05:21 +0530
Subject: [PATCH RESEND] cpufreq: Make sure target freq is within limits
Message-ID: <f79c0841be1ae16e1f2bd9084ed9a158eb171eb0.1351254846.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__cpufreq_driver_target() must not pass target frequency beyond the limits of
current policy.

Today most of cpufreq platform drivers are doing this check in their target
routines. Why not move it to __cpufreq_driver_target().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

Resend doesn't contain any change, but fixed commit log

 drivers/cpufreq/cpufreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 28dc134..2f5ac2d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1470,12 +1470,19 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	int retval = -EINVAL;
+	unsigned int old_target_freq = target_freq;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	pr_debug("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
-		target_freq, relation);
+	/* Make sure that target_freq is within supported range */
+	if (target_freq > policy->max)
+		target_freq = policy->max;
+	if (target_freq < policy->min)
+		target_freq = policy->min;
+
+	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
+			policy->cpu, target_freq, relation, old_target_freq);
 
 	if (target_freq == policy->cur)
 		return 0;
-- 
1.7.12.rc2.18.g61b472e
