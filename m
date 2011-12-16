From: robherring2@gmail.com (Rob Herring)
Date: Fri, 16 Dec 2011 08:32:35 -0600
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <4EEB5683.7000409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2011 04:30 AM, Richard Zhao wrote:
> It support single core and multi-core ARM SoCs. But it assume
> all cores share the same frequency and voltage.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm   |    8 ++
>  drivers/cpufreq/Makefile      |    1 +
>  drivers/cpufreq/arm-cpufreq.c |  269 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 278 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/cpufreq/arm-cpufreq.c
> 

What makes this specific to ARM and not a generic DT + clk api +
regulator api driver?

Also, you need documentation of the DT bindings.

Rob

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 72a0044..a0f7d35 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -2,6 +2,14 @@
>  # ARM CPU Frequency scaling drivers
>  #
>  
> +config ARM_GENERIC_CPUFREQ
> +	bool "ARM generic"
> +	help
> +	  This adds ARM generic CPUFreq driver. It assumes all
> +	  cores of the SoC share the same clock and voltage.
> +
> +	  If in doubt, say N.
> +
>  config ARM_S3C64XX_CPUFREQ
>  	bool "Samsung S3C64XX"
>  	depends on CPU_S3C6410
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ce75fcb..6ccf02d 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
>  
>  ##################################################################################
>  # ARM SoC drivers
> +obj-$(CONFIG_ARM_GENERIC_CPUFREQ)	+= arm-cpufreq.o
>  obj-$(CONFIG_UX500_SOC_DB8500)		+= db8500-cpufreq.o
>  obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
>  obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
> diff --git a/drivers/cpufreq/arm-cpufreq.c b/drivers/cpufreq/arm-cpufreq.c
> new file mode 100644
> index 0000000..e4d20da
> --- /dev/null
> +++ b/drivers/cpufreq/arm-cpufreq.c
> @@ -0,0 +1,269 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <asm/cpu.h>
> +
> +static u32 *cpu_freqs; /* HZ */
> +static u32 *cpu_volts; /* uV */
> +static u32 trans_latency; /* ns */
> +static int cpu_op_nr;
> +
> +static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
> +static unsigned long l_p_j_ref_freq;
> +
> +static struct clk *cpu_clk;
> +static struct regulator *cpu_reg;
> +static struct cpufreq_frequency_table *arm_freq_table;
> +
> +static int set_cpu_freq(unsigned long freq, int index, int higher)
> +{
> +	int ret = 0;
> +
> +	if (higher && cpu_reg)
> +		regulator_set_voltage(cpu_reg,
> +				cpu_volts[index], cpu_volts[index]);
> +
> +	ret = clk_set_rate(cpu_clk, freq);
> +	if (ret != 0) {
> +		printk(KERN_DEBUG "cannot set CPU clock rate\n");
> +		return ret;
> +	}
> +
> +	if (!higher && cpu_reg)
> +		regulator_set_voltage(cpu_reg,
> +				cpu_volts[index], cpu_volts[index]);
> +
> +	return ret;
> +}
> +
> +static int arm_verify_speed(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, arm_freq_table);
> +}
> +
> +static unsigned int arm_get_speed(unsigned int cpu)
> +{
> +	return clk_get_rate(cpu_clk) / 1000;
> +}
> +
> +static int arm_set_target(struct cpufreq_policy *policy,
> +			  unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	unsigned long freq_Hz;
> +	int cpu;
> +	int ret = 0;
> +	unsigned int index;
> +
> +	cpufreq_frequency_table_target(policy, arm_freq_table,
> +			target_freq, relation, &index);
> +	freq_Hz = clk_round_rate(cpu_clk, cpu_freqs[index]);
> +	freq_Hz = freq_Hz ? freq_Hz : cpu_freqs[index];
> +	freqs.old = clk_get_rate(cpu_clk) / 1000;
> +	freqs.new = clk_round_rate(cpu_clk, cpu_freqs[index]);
> +	freqs.new = freq_Hz / 1000;
> +	freqs.flags = 0;
> +
> +	if (freqs.old == freqs.new)
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		freqs.cpu = cpu;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +	}
> +
> +	ret = set_cpu_freq(freq_Hz, index, (freqs.new > freqs.old));
> +
> +#ifdef CONFIG_SMP
> +	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
> +	 * So update it for all CPUs.
> +	 */
> +	for_each_possible_cpu(cpu)
> +		per_cpu(cpu_data, cpu).loops_per_jiffy =
> +		cpufreq_scale(per_cpu(l_p_j_ref, cpu), l_p_j_ref_freq,
> +							freqs.new);
> +#endif
> +
> +	for_each_possible_cpu(cpu) {
> +		freqs.cpu = cpu;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	}
> +
> +	return ret;
> +}
> +
> +static int arm_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	if (policy->cpu >= num_possible_cpus())
> +		return -EINVAL;
> +
> +	policy->cur = clk_get_rate(cpu_clk) / 1000;
> +	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +	cpumask_setall(policy->cpus);
> +	/* Manual states, that PLL stabilizes in two CLK32 periods */
> +	policy->cpuinfo.transition_latency = trans_latency;
> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, arm_freq_table);
> +
> +	if (ret < 0) {
> +		printk(KERN_ERR "%s: invalid frequency table for cpu %d\n",
> +		       __func__, policy->cpu);
> +		return ret;
> +	}
> +
> +	cpufreq_frequency_table_get_attr(arm_freq_table, policy->cpu);
> +	return 0;
> +}
> +
> +static int arm_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_frequency_table_put_attr(policy->cpu);
> +	return 0;
> +}
> +
> +static struct cpufreq_driver arm_cpufreq_driver = {
> +	.flags = CPUFREQ_STICKY,
> +	.verify = arm_verify_speed,
> +	.target = arm_set_target,
> +	.get = arm_get_speed,
> +	.init = arm_cpufreq_init,
> +	.exit = arm_cpufreq_exit,
> +	.name = "arm",
> +};
> +
> +static int __devinit arm_cpufreq_driver_init(void)
> +{
> +	struct device_node *cpu0;
> +	const struct property *pp;
> +	int cpu, i, ret;
> +
> +	printk(KERN_INFO "ARM SoC generic CPU frequency driver\n");
> +
> +	cpu0 = of_find_node_by_path("/cpus/cpu at 0");
> +	if (!cpu0)
> +		return -ENODEV;
> +
> +	pp = of_find_property(cpu0, "cpu-freqs", NULL);
> +	if (!pp) {
> +		ret = -ENODEV;
> +		goto put_node;
> +	}
> +	cpu_op_nr = pp->length / sizeof(u32);
> +	if (!cpu_op_nr) {
> +		ret = -ENODEV;
> +		goto put_node;
> +	}
> +	ret = -ENOMEM;
> +	cpu_freqs = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr, GFP_KERNEL);
> +	if (!cpu_freqs)
> +		goto put_node;
> +	of_property_read_u32_array(cpu0, "cpu-freqs", cpu_freqs, cpu_op_nr);
> +
> +	pp = of_find_property(cpu0, "cpu-volts", NULL);
> +	if (pp) {
> +		if (cpu_op_nr == pp->length / sizeof(u32)) {
> +			cpu_volts = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr,
> +						GFP_KERNEL);
> +			if (!cpu_volts)
> +				goto free_cpu_freqs;
> +			of_property_read_u32_array(cpu0, "cpu-volts",
> +						cpu_volts, cpu_op_nr);
> +		} else
> +			printk(KERN_WARNING "cpufreq: invalid cpu_volts!\n");
> +	}
> +
> +	if (of_property_read_u32(cpu0, "trans-latency", &trans_latency))
> +		trans_latency = CPUFREQ_ETERNAL;
> +
> +	arm_freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
> +				* (cpu_op_nr + 1), GFP_KERNEL);
> +	if (!arm_freq_table)
> +		goto free_cpu_volts;
> +
> +	for (i = 0; i < cpu_op_nr; i++) {
> +		arm_freq_table[i].index = i;
> +		arm_freq_table[i].frequency = cpu_freqs[i] / 1000;
> +	}
> +
> +	arm_freq_table[i].index = i;
> +	arm_freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	cpu_clk = clk_get(NULL, "cpu");
> +	if (IS_ERR(cpu_clk)) {
> +		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
> +		ret = PTR_ERR(cpu_clk);
> +		goto free_freq_table;
> +	}
> +
> +	if (cpu_volts) {
> +		cpu_reg = regulator_get(NULL, "cpu");
> +		if (IS_ERR(cpu_reg)) {
> +			printk(KERN_WARNING
> +				"cpufreq: regulator cpu get failed.\n");
> +			cpu_reg = NULL;
> +		}
> +	}
> +
> +	l_p_j_ref_freq = clk_get_rate(cpu_clk);
> +	for_each_possible_cpu(cpu)
> +		per_cpu(l_p_j_ref, cpu) =
> +			per_cpu(cpu_data, cpu).loops_per_jiffy;
> +
> +	ret = cpufreq_register_driver(&arm_cpufreq_driver);
> +	if (ret)
> +		goto reg_put;
> +
> +	of_node_put(cpu0);
> +
> +	return 0;
> +
> +reg_put:
> +	if (cpu_reg)
> +		regulator_put(cpu_reg);
> +	clk_put(cpu_clk);
> +free_freq_table:
> +	kfree(arm_freq_table);
> +free_cpu_volts:
> +	kfree(cpu_volts);
> +free_cpu_freqs:
> +	kfree(cpu_freqs);
> +put_node:
> +	of_node_put(cpu0);
> +
> +	return ret;
> +}
> +
> +static void arm_cpufreq_driver_exit(void)
> +{
> +	cpufreq_unregister_driver(&arm_cpufreq_driver);
> +	kfree(cpu_freqs);
> +	kfree(cpu_volts);
> +	kfree(arm_freq_table);
> +	clk_put(cpu_clk);
> +}
> +
> +module_init(arm_cpufreq_driver_init);
> +module_exit(arm_cpufreq_driver_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor Inc. Richard Zhao <richard.zhao@freescale.com>");
> +MODULE_DESCRIPTION("ARM SoC generic CPUFreq driver");
> +MODULE_LICENSE("GPL");
