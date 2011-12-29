From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 29 Dec 2011 20:58:06 +0100
Subject: [RFC] cpufreq: Add S3C2416/S3C2450 cpufreq driver
Message-ID: <201112292058.07448.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C2416/S3C2450 SoCs support two sources for the armclk.

The first source is the so called armdiv which divides the msysclk down
to provide necessary cpu rates. In this mode the core voltage must be
always at 1.3V. The frequency from the armdiv is not allowed to be
lower than the hclk frequency.

In the second mode the armclk can be fed directly from the hclk in the
so called "dynamic voltags scaling" (dvs) mode. Here the armdiv isn't
used at all. Also in this mode the core voltage may be lowered.
Existing hardware and tests with it suggest 1.0V as sufficient.

When changing the clock source to the armdiv from the hclk, the SoC
shows stability issues if the new frequency is higher as the current
hclk frequency. Hence the driver always forces the armdiv to the hclk
frequency before the source change and lets the cpufreq issue another
set_target call for higher frequencies.

To mark the hclk frequency as lower as the corresponding armdiv
frequency it is set 1MHz below the real frequency. This lets the cpufreq
framework change between 133MHz based on hclk and 133MHz based on armdiv
at will.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
As the title says, this is only a RFC and I'd like to solicit comments
for the driver in general and also on the handling of the dvs mode.
I don't know if there are better ways to handle switching back and forth
between the regular clock and the same frequency using the dvs mode than
by the software-only 1MHz difference I'm currently using.

 drivers/cpufreq/Kconfig.arm       |   21 ++
 drivers/cpufreq/Makefile          |    1 +
 drivers/cpufreq/s3c2416-cpufreq.c |  501 +++++++++++++++++++++++++++++++++++++
 3 files changed, 523 insertions(+), 0 deletions(-)
 create mode 100644 drivers/cpufreq/s3c2416-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 72a0044..80367b4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,27 @@
 # ARM CPU Frequency scaling drivers
 #
 
+config ARM_S3C2416_CPUFREQ
+	bool "S3C2416 CPU Frequency scaling support"
+	help
+	  This adds the CPUFreq driver for the Samsung S3C2416 and
+	  S3C2450 SoC. The S3C2416 supports changing the rate of the
+	  armdiv clock source and also entering a so called dynamic
+	  voltage scaling mode in which it is possible to reduce the
+	  core voltage of the cpu.
+
+	  If in doubt, say N.
+
+config ARM_S3C2416_CPUFREQ_VCORESCALE
+	bool "Allow voltage scaling for S3C2416 arm core (DANGEROUS)"
+	depends on ARM_S3C2416_CPUFREQ && REGULATOR
+	help
+	  Enable CPU voltage scaling when entering the dvs mode.
+	  It uses information gathered through existing hardware and
+	  tests but not documented in any datasheet.
+
+	  If in doubt, say N.
+
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ce75fcb..98bb3e7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
 ##################################################################################
 # ARM SoC drivers
 obj-$(CONFIG_UX500_SOC_DB8500)		+= db8500-cpufreq.o
+obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
new file mode 100644
index 0000000..5604a2a
--- /dev/null
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -0,0 +1,501 @@
+/*
+ * S3C2416/2450 CPUfreq Support
+ *
+ * Copyright 2011 Heiko Stuebner <heiko@sntech.de>
+ *
+ * based on s3c64xx_cpufreq.c
+ *
+ * Copyright 2009 Wolfson Microelectronics plc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/regulator/consumer.h>
+#include <linux/module.h>
+
+struct s3c2416_cpufreq_data {
+	struct clk *armdiv;
+	struct clk *armclk;
+	struct clk *hclk;
+
+	unsigned long regulator_latency;
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+	struct regulator *vddarm;
+#endif
+
+	struct cpufreq_frequency_table *freq_table;
+
+	bool is_dvs;
+};
+
+static struct s3c2416_cpufreq_data s3c2416_cpufreq;
+
+#ifdef CONFIG_CPU_S3C2416
+struct s3c2416_dvfs {
+	unsigned int vddarm_min;
+	unsigned int vddarm_max;
+};
+
+/* S3C2416 only supports changing the voltage in the
+ * dynamic voltage scaling mode (dvs)
+ */
+static struct s3c2416_dvfs s3c2416_dvfs_table[] = {
+	[0] = {  950000, 1050000 },
+	[1] = { 1250000, 1350000 },
+};
+
+static struct cpufreq_frequency_table s3c2416_freq_table[] = {
+/* 133MHz can be reached via DSV (armclk=hclk) or armdiv directly */
+	{ 0, 132333 }, /* get an extra freq for dvs */
+	{ 1, 133333 },
+	{ 1, 266666 },
+	{ 1, 400000 },
+	{ 0, CPUFREQ_TABLE_END },
+};
+
+static struct cpufreq_frequency_table s3c2450_freq_table[] = {
+/* 133MHz can be reached via DSV (armclk=hclk) or armdiv directly */
+	{ 0, 132333 }, /* get an extra freq for dvs */
+	{ 1, 133333 },
+	{ 1, 266666 },
+	{ 1, 533333 },
+	{ 0, CPUFREQ_TABLE_END },
+};
+#endif
+
+static int s3c2416_cpufreq_verify_speed(struct cpufreq_policy *policy)
+{
+	struct s3c2416_cpufreq_data *s3c_freq = &s3c2416_cpufreq;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	return cpufreq_frequency_table_verify(policy, s3c_freq->freq_table);
+}
+
+static unsigned int s3c2416_cpufreq_get_speed(unsigned int cpu)
+{
+	struct s3c2416_cpufreq_data *s3c_freq = &s3c2416_cpufreq;
+
+	if (cpu != 0)
+		return 0;
+
+	/* return our pseudo-frequency when in dvs mode */
+	if (s3c_freq->is_dvs)
+		return 132333;
+
+	return clk_get_rate(s3c_freq->armclk) / 1000;
+}
+
+static int s3c2416_cpufreq_set_armdiv(struct s3c2416_cpufreq_data *s3c_freq,
+				      unsigned int freq)
+{
+	int ret;
+
+	if (clk_get_rate(s3c_freq->armdiv) / 1000 != freq) {
+		ret = clk_set_rate(s3c_freq->armdiv, freq * 1000);
+			if (ret < 0) {
+				pr_err("cpufreq: Failed to set armdiv rate %dkHz: %d\n",
+				       freq, ret);
+				return ret;
+			}
+		}
+
+	return 0;
+}
+
+static int s3c2416_cpufreq_enter_dvs(struct s3c2416_cpufreq_data *s3c_freq,
+				     unsigned int i)
+{
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+	struct s3c2416_dvfs *dvfs;
+	int idx;
+#endif
+	int ret;
+
+	if (s3c_freq->is_dvs) {
+		pr_debug("cpufreq: already in dvs mode, nothing to do\n");
+		return 0;
+	}
+
+	if (!s3c_freq->hclk) {
+		pr_err("cpufreq: want to switch armclk to hclk, but hclk not available\n");
+		return -EINVAL;
+	}
+
+	pr_debug("cpufreq: switching armclk to hclk (%lukHz)\n",
+		 clk_get_rate(s3c_freq->hclk) / 1000);
+	ret = clk_set_parent(s3c_freq->armclk, s3c_freq->hclk);
+	if (ret < 0) {
+		pr_err("cpufreq: Failed to switch cpu clock to hclk (%dkHz): %d\n",
+		       s3c_freq->freq_table[i].frequency, ret);
+		return ret;
+	}
+
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+	/* changing the core voltage is only allowed when in dvs mode */
+	if (s3c_freq->vddarm) {
+		idx = s3c_freq->freq_table[i].index;
+		dvfs = &s3c2416_dvfs_table[idx];
+
+		ret = regulator_set_voltage(s3c_freq->vddarm,
+					    dvfs->vddarm_min,
+					    dvfs->vddarm_max);
+
+		/* when lowering the voltage failed, there is nothing to do */
+		if (ret != 0)
+			pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
+			       s3c_freq->freq_table[i].frequency, ret);
+	}
+#endif
+
+	s3c_freq->is_dvs = 1;
+
+	return 0;
+}
+
+static int s3c2416_cpufreq_leave_dvs(struct s3c2416_cpufreq_data *s3c_freq,
+				     unsigned int i)
+{
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+	struct s3c2416_dvfs *dvfs;
+	int idx;
+#endif
+	int ret;
+
+	if (!s3c_freq->is_dvs) {
+		pr_debug("cpufreq: not in dvs mode, so can't leave\n");
+		return 0;
+	}
+
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+	if (s3c_freq->vddarm) {
+		idx = s3c_freq->freq_table[i].index;
+		dvfs = &s3c2416_dvfs_table[idx];
+
+		ret = regulator_set_voltage(s3c_freq->vddarm,
+					    dvfs->vddarm_min,
+					    dvfs->vddarm_max);
+		if (ret != 0) {
+			pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
+			       s3c_freq->freq_table[i].frequency, ret);
+			return ret;
+		}
+	}
+#endif
+
+	/* force armdiv to hclk frequency for transition from dvs*/
+	if (clk_get_rate(s3c_freq->armdiv) > clk_get_rate(s3c_freq->hclk)) {
+		pr_debug("cpufreq: force armdiv to hclk frequency (%lukHz)\n",
+			 clk_get_rate(s3c_freq->hclk) / 1000);
+		ret = s3c2416_cpufreq_set_armdiv(s3c_freq,
+						 clk_get_rate(s3c_freq->hclk) /
+						 1000);
+		if (ret < 0) {
+			pr_err("cpufreq: Failed to to set the armdiv to %lukHz: %d\n",
+			       clk_get_rate(s3c_freq->hclk) / 1000, ret);
+			return ret;
+		}
+	}
+
+	pr_debug("cpufreq: switching armclk parent to armdiv (%lukHz)\n",
+			clk_get_rate(s3c_freq->armdiv) / 1000);
+
+	ret = clk_set_parent(s3c_freq->armclk, s3c_freq->armdiv);
+	if (ret < 0) {
+		pr_err("cpufreq: Failed to switch armclk clock parent to armdiv: %d\n",
+		       ret);
+		return ret;
+	}
+
+	s3c_freq->is_dvs = 0;
+
+	return 0;
+}
+
+static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
+				      unsigned int target_freq,
+				      unsigned int relation)
+{
+	struct s3c2416_cpufreq_data *s3c_freq = &s3c2416_cpufreq;
+	int ret, dvs = 0;
+	unsigned int i;
+	struct cpufreq_freqs freqs;
+	struct s3c2416_dvfs *dvfs;
+
+	pr_debug("cpufreq: to %dKHz, relation %d\n", target_freq, relation);
+
+	ret = cpufreq_frequency_table_target(policy,
+					     s3c_freq->freq_table,
+					     target_freq, relation, &i);
+	if (ret != 0)
+		return ret;
+
+	freqs.cpu = 0;
+	freqs.old = clk_get_rate(s3c_freq->armclk) / 1000;
+	freqs.new = s3c_freq->freq_table[i].frequency;
+	freqs.flags = 0;
+	dvfs = &s3c2416_dvfs_table[s3c_freq->freq_table[i].index];
+
+	/* check if we switch to DVS mode (indicated by index 0) */
+	if (s3c_freq->hclk && s3c_freq->freq_table[i].index == 0)
+		dvs = 1;
+
+	if (!dvs && freqs.old == freqs.new)
+		return 0;
+
+	pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	if (dvs) {
+		pr_debug("cpufreq: enter dvs\n");
+		ret = s3c2416_cpufreq_enter_dvs(s3c_freq, i);
+	} else if (s3c_freq->is_dvs) {
+		pr_debug("cpufreq: leave dvs\n");
+		ret = s3c2416_cpufreq_leave_dvs(s3c_freq, i);
+		freqs.new = 133333; /* we always switch to 133MHz */
+	} else {
+		pr_debug("cpufreq: change armdiv to %dkHz\n", freqs.new);
+		ret = s3c2416_cpufreq_set_armdiv(s3c_freq, freqs.new);
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return ret;
+}
+
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+static void __init s3c2416_cpufreq_config_regulator(
+					struct s3c2416_cpufreq_data *s3c_freq)
+{
+	int count, v, i, found;
+	struct cpufreq_frequency_table *freq;
+	struct s3c2416_dvfs *dvfs;
+
+	count = regulator_count_voltages(s3c_freq->vddarm);
+	if (count < 0) {
+		pr_err("cpufreq: Unable to check supported voltages\n");
+		return;
+	}
+
+	freq = s3c_freq->freq_table;
+	while (count > 0 && freq->frequency != CPUFREQ_TABLE_END) {
+		if (freq->frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		dvfs = &s3c2416_dvfs_table[freq->index];
+		found = 0;
+
+		/*
+		 * Check only the min-voltage, as more is always ok
+		 * for the S3C2416.
+		 */
+		for (i = 0; i < count; i++) {
+			v = regulator_list_voltage(s3c_freq->vddarm, i);
+			if (v >= dvfs->vddarm_min)
+				found = 1;
+		}
+
+		if (!found) {
+			pr_debug("cpufreq: %dkHz unsupported by regulator\n",
+				 freq->frequency);
+			freq->frequency = CPUFREQ_ENTRY_INVALID;
+		}
+
+		freq++;
+	}
+
+	/* Guessed */
+	s3c_freq->regulator_latency = 1 * 1000 * 1000;
+}
+#endif
+
+static int __init s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
+{
+	struct s3c2416_cpufreq_data *s3c_freq = &s3c2416_cpufreq;
+	struct cpufreq_frequency_table *freq;
+	struct clk *msysclk;
+	unsigned long rate;
+	int ret;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	msysclk = clk_get(NULL, "msysclk");
+	if (IS_ERR(msysclk)) {
+		pr_err("cpufreq: Unable to obtain msysclk: %ld\n",
+		       PTR_ERR(msysclk));
+		return PTR_ERR(msysclk);
+	}
+
+	/*
+	 * S3C2416 and S3C2450 share the same processor-ID and also provide no
+	 * other means to distinguish them other than through the rate of
+	 * msysclk. On S3C2416 msysclk runs at 800MHz and on S3C2450 at 533MHz.
+	 */
+	rate = clk_get_rate(msysclk);
+	if (rate >= 800000000) {
+		pr_info("cpufreq: msysclk running at %lukHz, using S3C2416 frequency table\n",
+			rate / 1000);
+		s3c_freq->freq_table = s3c2416_freq_table;
+		policy->cpuinfo.max_freq = 400000;
+	} else if (rate >= 533000000) {
+		pr_info("cpufreq: msysclk running at %lukHz, using S3C2450 frequency table\n",
+			rate / 1000);
+		s3c_freq->freq_table = s3c2450_freq_table;
+		policy->cpuinfo.max_freq = 533333;
+	}
+
+	if (s3c_freq->freq_table == NULL) {
+		pr_err("cpufreq: No frequency information for this CPU\n");
+		return -ENODEV;
+	}
+
+	/* not needed anymore */
+	clk_put(msysclk);
+
+	s3c_freq->is_dvs = 0;
+
+	/*
+	 * Core can be supplied from MPLL through the divider,
+	 * or directly from HCLK (DVS mode).
+	 * MPLL divided by ARMDIV is named 'armdiv' and should be equal
+	 * or greater than hclk
+	 */
+	s3c_freq->armdiv = clk_get(NULL, "armdiv");
+	if (IS_ERR(s3c_freq->armdiv)) {
+		pr_err("cpufreq: Unable to obtain ARMDIV: %ld\n",
+		       PTR_ERR(s3c_freq->armdiv));
+		return PTR_ERR(s3c_freq->armdiv);
+	}
+
+	s3c_freq->hclk = clk_get(NULL, "hclk");
+	if (IS_ERR(s3c_freq->hclk)) {
+		pr_warn("cpufreq: Unable to obtain HCLK: %ld\n",
+		       PTR_ERR(s3c_freq->hclk));
+		s3c_freq->hclk = NULL; /*we can live without hclk */
+	}
+
+	s3c_freq->armclk = clk_get(NULL, "armclk");
+	if (IS_ERR(s3c_freq->armclk)) {
+		pr_err("cpufreq: Unable to obtain ARMCLK: %ld\n",
+		       PTR_ERR(s3c_freq->armclk));
+		return PTR_ERR(s3c_freq->armclk);
+	}
+
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+	s3c_freq->vddarm = regulator_get(NULL, "vddarm");
+	if (IS_ERR(s3c_freq->vddarm)) {
+		ret = PTR_ERR(s3c_freq->vddarm);
+		pr_err("cpufreq: Failed to obtain VDDARM: %d\n", ret);
+		pr_err("cpufreq: Only frequency scaling available\n");
+		s3c_freq->vddarm = NULL;
+		s3c_freq->regulator_latency = 0;
+	} else {
+		s3c2416_cpufreq_config_regulator(s3c_freq);
+	}
+#else
+	s3c_freq->regulator_latency = 0;
+#endif
+
+	freq = s3c_freq->freq_table;
+	while (freq->frequency != CPUFREQ_TABLE_END) {
+		/* special handling for dvs mode */
+		if (freq->index == 0) {
+			if (!s3c_freq->hclk) {
+				pr_debug("cpufreq: %dkHz unsupported as it would need unavailable dvs mode\n",
+					 freq->frequency);
+				freq->frequency = CPUFREQ_ENTRY_INVALID;
+			} else {
+				freq++;
+				continue;
+			}
+		}
+
+		/* Check for frequencies we can generate */
+		rate = clk_round_rate(s3c_freq->armdiv,
+				      freq->frequency * 1000);
+		rate /= 1000;
+		if (rate != freq->frequency) {
+			pr_debug("cpufreq: %dkHz unsupported by clock (clk_round_rate return %lu)\n",
+				 freq->frequency, rate);
+			freq->frequency = CPUFREQ_ENTRY_INVALID;
+		}
+
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+		/* If we have no regulator then assume startup
+		 * frequency is the maximum we can support. */
+		if (!s3c_freq->vddarm &&
+		    freq->frequency > s3c2416_cpufreq_get_speed(0))
+			freq->frequency = CPUFREQ_ENTRY_INVALID;
+#else
+		if (freq->frequency > s3c2416_cpufreq_get_speed(0))
+			freq->frequency = CPUFREQ_ENTRY_INVALID;
+#endif
+
+		freq++;
+	}
+
+	policy->cur = clk_get_rate(s3c_freq->armclk) / 1000;
+
+	/* Datasheet says PLL stabalisation time must be at least 300us,
+	 * so but add some fudge. (reference in LOCKCON0 register description)
+	 */
+	policy->cpuinfo.transition_latency = (500 * 1000) +
+					     s3c_freq->regulator_latency;
+
+	ret = cpufreq_frequency_table_cpuinfo(policy, s3c_freq->freq_table);
+	if (ret != 0) {
+		pr_err("cpufreq: Failed to configure frequency table: %d\n",
+		       ret);
+#ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
+		regulator_put(s3c_freq->vddarm);
+#endif
+		clk_put(s3c_freq->armclk);
+		if (s3c_freq->hclk)
+			clk_put(s3c_freq->hclk);
+		clk_put(s3c_freq->armdiv);
+	}
+
+	cpufreq_frequency_table_get_attr(s3c_freq->freq_table, 0);
+
+	return ret;
+}
+
+static int s3c2416_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(0);
+	return 0;
+}
+
+static struct freq_attr *s3c2416_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver s3c2416_cpufreq_driver = {
+	.owner		= THIS_MODULE,
+	.flags          = 0,
+	.verify		= s3c2416_cpufreq_verify_speed,
+	.target		= s3c2416_cpufreq_set_target,
+	.get		= s3c2416_cpufreq_get_speed,
+	.init		= s3c2416_cpufreq_driver_init,
+	.exit		= s3c2416_cpufreq_cpu_exit,
+	.name		= "s3c2416",
+	.attr		= s3c2416_cpufreq_attr,
+};
+
+static int __init s3c2416_cpufreq_init(void)
+{
+	return cpufreq_register_driver(&s3c2416_cpufreq_driver);
+}
+module_init(s3c2416_cpufreq_init);
-- 
1.7.2.3
