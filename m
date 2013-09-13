From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:01 +0530
Subject: [PATCH 055/228] cpufreq: define generic .attr,
 .exit() and .verify() routines
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <95b345e71483780f63bd3e77a255769178bae2ec.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch introduces generic .attr, .exit() and .verify() cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 20 ++++++++++++++++++++
 include/linux/cpufreq.h      |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index b9336ed..3458d27 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -86,6 +86,20 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
 
+/*
+ * Generic routine to verify policy & frequency table, requires driver to call
+ * cpufreq_frequency_table_get_attr() prior to it.
+ */
+int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *table =
+		cpufreq_frequency_get_table(policy->cpu);
+	if (!table)
+		return -ENODEV;
+
+	return cpufreq_frequency_table_verify(policy, table);
+}
+EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
@@ -199,6 +213,12 @@ struct freq_attr cpufreq_freq_attr_scaling_available_freqs = {
 };
 EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
 
+struct freq_attr *cpufreq_generic_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
+
 /*
  * if you use these, you must assure that the frequency table is valid
  * all the time between get_attr and put_attr!
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e257407..57d2907 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -415,6 +415,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
+int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
@@ -430,10 +431,17 @@ struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
+extern struct freq_attr *cpufreq_generic_attr[];
 void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table,
 				      unsigned int cpu);
 void cpufreq_frequency_table_put_attr(unsigned int cpu);
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
 
+static inline int cpufreq_generic_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
 #endif /* _LINUX_CPUFREQ_H */
-- 
1.7.12.rc2.18.g61b472e
