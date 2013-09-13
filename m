From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:32:52 +0530
Subject: [PATCH 226/228] cpufreq: spear: use cpufreq_generic_get() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <f2370b329d6ec42e92bd5eac3abb3e64774530fe.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have common infrastructure available with us for getting a CPUs clk rate.
Lets use it for this driver.

Cc: spear-devel at list.st.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 658cfe7..ea2f26e 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -30,11 +30,6 @@ static struct {
 	u32 cnt;
 } spear_cpufreq;
 
-static unsigned int spear_cpufreq_get(unsigned int cpu)
-{
-	return clk_get_rate(spear_cpufreq.clk) / 1000;
-}
-
 static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
 {
 	struct clk *sys_pclk;
@@ -156,6 +151,7 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 
 static int spear_cpufreq_init(struct cpufreq_policy *policy)
 {
+	policy->clk = spear_cpufreq.clk;
 	return cpufreq_generic_init(policy, spear_cpufreq.freq_tbl,
 			spear_cpufreq.transition_latency);
 }
@@ -165,7 +161,7 @@ static struct cpufreq_driver spear_cpufreq_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= spear_cpufreq_target,
-	.get		= spear_cpufreq_get,
+	.get		= cpufreq_generic_get,
 	.init		= spear_cpufreq_init,
 	.exit		= cpufreq_generic_exit,
 	.attr		= cpufreq_generic_attr,
-- 
1.7.12.rc2.18.g61b472e
