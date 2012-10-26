From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 26 Oct 2012 15:06:26 +0530
Subject: [PATCH] cpufreq: Avoid calling cpufreq driver's target() routine if
 target_freq == policy->cur
Message-ID: <1d7b6e421a335255da956804b43ce3517538409c.1351244153.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid calling cpufreq driver's target() routine if new frequency is same as
policies current frequency.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 261ef65..28dc134 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1476,6 +1476,10 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 
 	pr_debug("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
+
+	if (target_freq == policy->cur)
+		return 0;
+
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
 
-- 
1.7.12.rc2.18.g61b472e
