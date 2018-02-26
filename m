From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Feb 2018 10:39:02 +0530
Subject: [PATCH 19/27] cpufreq: s3c24xx: Don't validate the frequency table
 twice
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
Message-ID: <fc79e745f14e9b038256de2546817b35b3846314.1519620578.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq core is already validating the CPU frequency table after
calling the ->init() callback of the cpufreq drivers and the drivers
don't need to do the same anymore. Though they need to set the
policy->freq_table field directly from the ->init() callback now.

Stop validating the frequency table from s3c24xx driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 6bebc1f9f55a..3f0947e119a9 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -351,11 +351,8 @@ struct clk *s3c_cpufreq_clk_get(struct device *dev, const char *name)
 static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = clk_arm;
-
 	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
-
-	if (ftab)
-		return cpufreq_table_validate_and_show(policy, ftab);
+	policy->freq_table = ftab;
 
 	return 0;
 }
-- 
2.15.0.194.g9af6a3dea062
