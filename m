From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Feb 2018 09:38:28 +0530
Subject: [PATCH] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
Message-ID: <6b737a9c285840b4b2036fa51b692ee835664ec8.1519358505.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit a307a1e6bc0d ("cpufreq: s3c: use cpufreq_generic_init()")
accidentally broke cpufreq on s3c2410 and s3c2412. These two platforms
don't have a CPU frequency table and used to skip calling
cpufreq_table_validate_and_show() for them. But with the above commit,
we started calling it unconditionally and that will eventually fail as
the frequency table pointer is NULL.

Fix this by calling cpufreq_table_validate_and_show() conditionally
again.

Cc: stable at vger.kernel.org # v3.13+
Fixes: a307a1e6bc0d ("cpufreq: s3c: use cpufreq_generic_init()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 7b596fa38ad2..6bebc1f9f55a 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -351,7 +351,13 @@ struct clk *s3c_cpufreq_clk_get(struct device *dev, const char *name)
 static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = clk_arm;
-	return cpufreq_generic_init(policy, ftab, cpu_cur.info->latency);
+
+	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
+
+	if (ftab)
+		return cpufreq_table_validate_and_show(policy, ftab);
+
+	return 0;
 }
 
 static int __init s3c_cpufreq_initclks(void)
-- 
2.15.0.194.g9af6a3dea062
