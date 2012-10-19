From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 20 Oct 2012 01:42:05 +0530
Subject: [PATCH 1/2] cpufreq: return early from __cpufreq_driver_getavg()
Message-ID: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to do cpufreq_get_cpu() and cpufreq_put_cpu() for drivers that
don't support getavg() routine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85df538..f552d5f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1511,12 +1511,14 @@ int __cpufreq_driver_getavg(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	int ret = 0;
 
+	if (!(cpu_online(cpu) && cpufreq_driver->getavg))
+		return 0;
+
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
 
-	if (cpu_online(cpu) && cpufreq_driver->getavg)
-		ret = cpufreq_driver->getavg(policy, cpu);
+	ret = cpufreq_driver->getavg(policy, cpu);
 
 	cpufreq_cpu_put(policy);
 	return ret;
-- 
1.7.12.rc2.18.g61b472e
