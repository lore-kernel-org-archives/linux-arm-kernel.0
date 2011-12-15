From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 15 Dec 2011 19:16:35 +0800
Subject: [RFC V1 1/4] cpufreq: add arm soc generic cpufreq driver
Message-ID: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It support single core and multi-core ARM SoCs. But it assume
all cores share the same frequency and voltage.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/cpufreq/Kconfig.arm   |    8 ++
 drivers/cpufreq/Makefile      |    1 +
 drivers/cpufreq/arm-cpufreq.c |  260 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+), 0 deletions(-)
 create mode 100644 drivers/cpufreq/arm-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 72a0044..a0f7d35 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,14 @@
 # ARM CPU Frequency scaling drivers
 #
 
+config ARM_GENERIC_CPUFREQ
+	bool "ARM generic"
+	help
+	  This adds ARM generic CPUFreq driver. It assumes all
+	  cores of the SoC share the same clock and voltage.
+
+	  If in doubt, say N.
+
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ce75fcb..6ccf02d 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_GENERIC_CPUFREQ)	+= arm-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= db8500-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
diff --git a/drivers/cpufreq/arm-cpufreq.c b/drivers/cpufreq/arm-cpufreq.c
new file mode 100644
index 0000000..fd9759f
--- /dev/null
+++ b/drivers/cpufreq/arm-cpufreq.c
@@ -0,0 +1,260 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <asm/cpu.h>
+#include <mach/hardware.h>
+#include <mach/clock.h>
+
+static u32 *cpu_freqs;
+static u32 *cpu_volts;
+static u32 trans_latency;
+static int cpu_op_nr;
+
+static int cpu_freq_khz_min;
+static int cpu_freq_khz_max;
+
+static struct clk *cpu_clk;
+static struct cpufreq_frequency_table *arm_freq_table;
+
+static int set_cpu_freq(int freq)
+{
+	int ret = 0;
+	int org_cpu_rate;
+
+	org_cpu_rate = clk_get_rate(cpu_clk);
+	if (org_cpu_rate == freq)
+		return ret;
+
+	ret = clk_set_rate(cpu_clk, freq);
+	if (ret != 0) {
+		printk(KERN_DEBUG "cannot set CPU clock rate\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int arm_verify_speed(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, arm_freq_table);
+}
+
+static unsigned int arm_get_speed(unsigned int cpu)
+{
+	return clk_get_rate(cpu_clk) / 1000;
+}
+
+static int arm_set_target(struct cpufreq_policy *policy,
+			  unsigned int target_freq, unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	int freq_Hz, cpu;
+	int ret = 0;
+	unsigned int index;
+
+	cpufreq_frequency_table_target(policy, arm_freq_table,
+			target_freq, relation, &index);
+	freq_Hz = arm_freq_table[index].frequency * 1000;
+
+	freqs.old = clk_get_rate(cpu_clk) / 1000;
+	freqs.new = clk_round_rate(cpu_clk, freq_Hz);
+	freqs.new = (freqs.new ? freqs.new : freq_Hz) / 1000;
+	freqs.flags = 0;
+
+	if (freqs.old == freqs.new)
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		freqs.cpu = cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
+
+	ret = set_cpu_freq(freq_Hz);
+
+#ifdef CONFIG_SMP
+	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
+	 * So update it for all CPUs.
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(cpu_data, cpu).loops_per_jiffy =
+		cpufreq_scale(per_cpu(cpu_data, cpu).loops_per_jiffy,
+					freqs.old, freqs.new);
+#endif
+
+	for_each_possible_cpu(cpu) {
+		freqs.cpu = cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
+
+	return ret;
+}
+
+static int arm_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	printk(KERN_INFO "ARM CPU frequency driver\n");
+
+	if (policy->cpu >= num_possible_cpus())
+		return -EINVAL;
+
+	policy->cur = clk_get_rate(cpu_clk) / 1000;
+	policy->min = policy->cpuinfo.min_freq = cpu_freq_khz_min;
+	policy->max = policy->cpuinfo.max_freq = cpu_freq_khz_max;
+	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+	cpumask_setall(policy->cpus);
+	/* Manual states, that PLL stabilizes in two CLK32 periods */
+	policy->cpuinfo.transition_latency = trans_latency;
+
+	ret = cpufreq_frequency_table_cpuinfo(policy, arm_freq_table);
+
+	if (ret < 0) {
+		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	cpufreq_frequency_table_get_attr(arm_freq_table, policy->cpu);
+	return 0;
+}
+
+static int arm_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+
+	set_cpu_freq(cpu_freq_khz_max * 1000);
+	return 0;
+}
+
+static struct cpufreq_driver arm_cpufreq_driver = {
+	.flags = CPUFREQ_STICKY,
+	.verify = arm_verify_speed,
+	.target = arm_set_target,
+	.get = arm_get_speed,
+	.init = arm_cpufreq_init,
+	.exit = arm_cpufreq_exit,
+	.name = "arm",
+};
+
+static int __devinit arm_cpufreq_driver_init(void)
+{
+	struct device_node *cpu0;
+	const struct property *pp;
+	int i, ret;
+
+	cpu0 = of_find_node_by_path("/cpus/cpu at 0");
+	if (!cpu0)
+		return -ENODEV;
+
+	pp = of_find_property(cpu0, "cpu_freqs", NULL);
+	if (!pp) {
+		ret = -ENODEV;
+		goto put_node;
+	}
+	cpu_op_nr = pp->length / sizeof(u32);
+	if (!cpu_op_nr) {
+		ret = -ENODEV;
+		goto put_node;
+	}
+	ret = -ENOMEM;
+	cpu_freqs = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr, GFP_KERNEL);
+	if (!cpu_freqs)
+		goto put_node;
+	of_property_read_u32_array(cpu0, "cpu_freqs", cpu_freqs, cpu_op_nr);
+
+	pp = of_find_property(cpu0, "cpu_volts", NULL);
+	if (pp) {
+		if (cpu_op_nr == pp->length / sizeof(u32)) {
+			cpu_volts = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr,
+						GFP_KERNEL);
+			if (!cpu_volts)
+				goto free_cpu_freqs;
+			of_property_read_u32_array(cpu0, "cpu_volts",
+						cpu_freqs, cpu_op_nr);
+		} else
+			printk(KERN_WARNING "cpufreq: invalid cpu_volts!\n");
+	}
+
+	if (of_property_read_u32(cpu0, "trans_latency", &trans_latency))
+		trans_latency = CPUFREQ_ETERNAL;
+
+	cpu_freq_khz_min = cpu_freqs[0] / 1000;
+	cpu_freq_khz_max = cpu_freqs[0] / 1000;
+
+	arm_freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
+				* (cpu_op_nr + 1), GFP_KERNEL);
+	if (!arm_freq_table)
+		goto free_cpu_volts;
+
+	for (i = 0; i < cpu_op_nr; i++) {
+		arm_freq_table[i].index = i;
+		arm_freq_table[i].frequency = cpu_freqs[i] / 1000;
+		if ((cpu_freqs[i] / 1000) < cpu_freq_khz_min)
+			cpu_freq_khz_min = cpu_freqs[i] / 1000;
+		if ((cpu_freqs[i] / 1000) > cpu_freq_khz_max)
+			cpu_freq_khz_max = cpu_freqs[i] / 1000;
+	}
+
+	arm_freq_table[i].index = i;
+	arm_freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	cpu_clk = clk_get(NULL, "cpu");
+	if (IS_ERR(cpu_clk)) {
+		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
+		ret = PTR_ERR(cpu_clk);
+		goto free_freq_table;
+	}
+
+	ret = cpufreq_register_driver(&arm_cpufreq_driver);
+	if (ret)
+		goto clock_put;
+
+	of_node_put(cpu0);
+
+	return 0;
+
+clock_put:
+	clk_put(cpu_clk);
+free_freq_table:
+	kfree(arm_freq_table);
+free_cpu_volts:
+	kfree(cpu_volts);
+free_cpu_freqs:
+	kfree(cpu_freqs);
+put_node:
+	of_node_put(cpu0);
+
+	return ret;
+}
+
+static void arm_cpufreq_driver_exit(void)
+{
+	cpufreq_unregister_driver(&arm_cpufreq_driver);
+	kfree(cpu_freqs);
+	kfree(cpu_volts);
+	kfree(arm_freq_table);
+	clk_put(cpu_clk);
+}
+
+module_init(arm_cpufreq_driver_init);
+module_exit(arm_cpufreq_driver_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor Inc. Richard Zhao <richard.zhao@freescale.com>");
+MODULE_DESCRIPTION("ARM SoC generic CPUFreq driver");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
