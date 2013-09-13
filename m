From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:40 +0530
Subject: [PATCH 154/228] cpufreq: davinci: Convert to light weight
 ->target_index() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <ab455ca448574e3da712a57a37ae08c8aa4f92a3.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 972583b..1f5d8a5 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -66,28 +66,18 @@ static unsigned int davinci_getspeed(unsigned int cpu)
 	return clk_get_rate(cpufreq.armclk) / 1000;
 }
 
-static int davinci_target(struct cpufreq_policy *policy,
-				unsigned int target_freq, unsigned int relation)
+static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	int ret = 0;
-	unsigned int idx;
 	struct cpufreq_freqs freqs;
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
 	struct clk *armclk = cpufreq.armclk;
 
 	freqs.old = davinci_getspeed(0);
-	freqs.new = clk_round_rate(armclk, target_freq * 1000) / 1000;
-
-	if (freqs.old == freqs.new)
-		return ret;
+	freqs.new = pdata->freq_table[idx].frequency;
 
 	dev_dbg(cpufreq.dev, "transition: %u --> %u\n", freqs.old, freqs.new);
 
-	ret = cpufreq_frequency_table_target(policy, pdata->freq_table,
-						freqs.new, relation, &idx);
-	if (ret)
-		return -EINVAL;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* if moving to higher frequency, up the voltage beforehand */
@@ -148,7 +138,7 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver davinci_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= davinci_verify_speed,
-	.target		= davinci_target,
+	.target_index	= davinci_target,
 	.get		= davinci_getspeed,
 	.init		= davinci_cpu_init,
 	.exit		= cpufreq_generic_exit,
-- 
1.7.12.rc2.18.g61b472e
