From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 13 Aug 2013 19:02:35 +0530
Subject: [PATCH V2 22/35] cpufreq: pasemi: Covert to light weight
 ->target_index() routine
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Message-ID: <b3b626a47599c9da7aebc561a6baebae03824f0e.1376392602.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 16f2508..aaee5fa 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -247,19 +247,11 @@ static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 }
 
 static int pas_cpufreq_target(struct cpufreq_policy *policy,
-			      unsigned int target_freq,
-			      unsigned int relation)
+			      unsigned int pas_astate_new)
 {
 	struct cpufreq_freqs freqs;
-	int pas_astate_new;
 	int i;
 
-	cpufreq_frequency_table_target(policy,
-				       pas_freqs,
-				       target_freq,
-				       relation,
-				       &pas_astate_new);
-
 	freqs.old = policy->cur;
 	freqs.new = pas_freqs[pas_astate_new].frequency;
 
@@ -289,7 +281,7 @@ static struct cpufreq_driver pas_cpufreq_driver = {
 	.init		= pas_cpufreq_cpu_init,
 	.exit		= pas_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= pas_cpufreq_target,
+	.target_index	= pas_cpufreq_target,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
1.7.12.rc2.18.g61b472e
