From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 12 Feb 2018 18:45:24 +0000
Subject: [PATCH v5 20/20] cpufreq: scmi: add support for fast frequency
 switching
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1518461124-17371-21-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq core provides option for drivers to implement fast_switch
callback which is invoked for frequency switching from interrupt context.

This patch adds support for fast_switch callback in SCMI cpufreq driver
by making use of polling based SCMI transfer. It also sets the flag
fast_switch_possible.

Cc: linux-pm at vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index d6d35f7692b3..c869c99b2142 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -64,6 +64,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
 }
 
+static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+
+	if (!perf_ops->freq_set(handle, priv->domain_id,
+				target_freq * 1000, true))
+		return target_freq;
+
+	return 0;
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
@@ -163,6 +176,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = latency;
 
+	policy->fast_switch_possible = true;
 	return 0;
 
 out_free_cpufreq_table:
@@ -201,6 +215,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
+	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-- 
2.7.4
