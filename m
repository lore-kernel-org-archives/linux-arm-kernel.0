From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Feb 2018 10:38:49 +0530
Subject: [PATCH 06/27] cpufreq: brcmstb: Don't validate the frequency table
 twice
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
Message-ID: <7d2bc4de102c81503c30a64503179c4ccebe6287.1519620578.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq core is already validating the CPU frequency table after
calling the ->init() callback of the cpufreq drivers and the drivers
don't need to do the same anymore. Though they need to set the
policy->freq_table field directly from the ->init() callback now.

Stop validating the frequency table from brcmstb driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 7281a2c19c36..6cdac1aaf23c 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -902,11 +902,7 @@ static int brcm_avs_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	ret = cpufreq_table_validate_and_show(policy, freq_table);
-	if (ret) {
-		dev_err(dev, "invalid frequency table: %d\n", ret);
-		return ret;
-	}
+	policy->freq_table = freq_table;
 
 	/* All cores share the same clock and thus the same policy. */
 	cpumask_setall(policy->cpus);
-- 
2.15.0.194.g9af6a3dea062
