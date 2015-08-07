From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 07 Aug 2015 13:50:30 +0200
Subject: [PATCH] cpufreq-dt: make scaling_boost_freqs sysfs attr available when
 boost is enabled
Message-ID: <4591050.xDpgbpsIAB@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make scaling_boost_freqs sysfs attribute is available when
cpufreq-dt driver is used and boost support is enabled.

Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Rafael, please apply for v4.3.  Thanks!

 drivers/cpufreq/cpufreq-dt.c | 11 ++++++++++-
 include/linux/cpufreq.h      |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b9259ab..c6a3b98 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -36,6 +36,12 @@ struct private_data {
 	unsigned int voltage_tolerance; /* in percentage */
 };
 
+static struct freq_attr *cpufreq_dt_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,   /* Extra space for boost-attr if required */
+	NULL,
+};
+
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct dev_pm_opp *opp;
@@ -182,6 +188,8 @@ try_again:
 	return ret;
 }
 
+static struct cpufreq_driver dt_cpufreq_driver;
+
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
@@ -336,6 +344,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		ret = cpufreq_enable_boost_support();
 		if (ret)
 			goto out_free_cpufreq_table;
+		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
@@ -411,7 +420,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.exit = cpufreq_exit,
 	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
-	.attr = cpufreq_generic_attr,
+	.attr = cpufreq_dt_attr,
 };
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f0186..657542d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -609,6 +609,7 @@ struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
+extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
 extern struct freq_attr *cpufreq_generic_attr[];
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
-- 
1.9.1
