From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Thu, 15 Dec 2011 12:50:07 -0600
Subject: [RFC V1 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
References: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <4EEA415F.8030901@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comments below. I tested this on the Calxeda Highbank SoC using
QEMU. I found one definite error and a few things I would change.

On 12/15/2011 05:16 AM, Richard Zhao wrote:
> It support single core and multi-core ARM SoCs. But it assume
> all cores share the same frequency and voltage.
>
> Signed-off-by: Richard Zhao<richard.zhao@linaro.org>
> ---

> diff --git a/drivers/cpufreq/arm-cpufreq.c b/drivers/cpufreq/arm-cpufreq.c
> new file mode 100644
> index 0000000..fd9759f
> --- /dev/null
> +++ b/drivers/cpufreq/arm-cpufreq.c
> @@ -0,0 +1,260 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
> +#include<linux/module.h>
> +#include<linux/cpufreq.h>
> +#include<linux/clk.h>
> +#include<linux/err.h>
> +#include<linux/slab.h>
> +#include<linux/of.h>
> +#include<asm/cpu.h>
> +#include<mach/hardware.h>
> +#include<mach/clock.h>

These should probably be replaced by <linux/of_clk.h>. See
below for details.

> +
> +static u32 *cpu_freqs;
> +static u32 *cpu_volts;
> +static u32 trans_latency;
> +static int cpu_op_nr;
> +
> +static int cpu_freq_khz_min;
> +static int cpu_freq_khz_max;
> +
> +static struct clk *cpu_clk;
> +static struct cpufreq_frequency_table *arm_freq_table;
> +
> +static int set_cpu_freq(int freq)
> +{
> +	int ret = 0;
> +	int org_cpu_rate;
> +
> +	org_cpu_rate = clk_get_rate(cpu_clk);
> +	if (org_cpu_rate == freq)
> +		return ret;
> +
> +	ret = clk_set_rate(cpu_clk, freq);
> +	if (ret != 0) {
> +		printk(KERN_DEBUG "cannot set CPU clock rate\n");
> +		return ret;
> +	}
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
> +	int freq_Hz, cpu;
> +	int ret = 0;
> +	unsigned int index;
> +
> +	cpufreq_frequency_table_target(policy, arm_freq_table,
> +			target_freq, relation,&index);
> +	freq_Hz = arm_freq_table[index].frequency * 1000;
> +
> +	freqs.old = clk_get_rate(cpu_clk) / 1000;
> +	freqs.new = clk_round_rate(cpu_clk, freq_Hz);
> +	freqs.new = (freqs.new ? freqs.new : freq_Hz) / 1000;
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
> +	ret = set_cpu_freq(freq_Hz);
> +
> +#ifdef CONFIG_SMP
> +	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
> +	 * So update it for all CPUs.
> +	 */
> +	for_each_possible_cpu(cpu)
> +		per_cpu(cpu_data, cpu).loops_per_jiffy =
> +		cpufreq_scale(per_cpu(cpu_data, cpu).loops_per_jiffy,
> +					freqs.old, freqs.new);
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
> +	printk(KERN_INFO "ARM CPU frequency driver\n");
> +
> +	if (policy->cpu>= num_possible_cpus())
> +		return -EINVAL;
> +
> +	policy->cur = clk_get_rate(cpu_clk) / 1000;
> +	policy->min = policy->cpuinfo.min_freq = cpu_freq_khz_min;
> +	policy->max = policy->cpuinfo.max_freq = cpu_freq_khz_max;
> +	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +	cpumask_setall(policy->cpus);
> +	/* Manual states, that PLL stabilizes in two CLK32 periods */
> +	policy->cpuinfo.transition_latency = trans_latency;
> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, arm_freq_table);
> +
> +	if (ret<  0) {
> +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
> +		       __func__, ret);
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
> +
> +	set_cpu_freq(cpu_freq_khz_max * 1000);
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
> +	int i, ret;
> +
> +	cpu0 = of_find_node_by_path("/cpus/cpu at 0");
> +	if (!cpu0)
> +		return -ENODEV;
> +
> +	pp = of_find_property(cpu0, "cpu_freqs", NULL);
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
> +	of_property_read_u32_array(cpu0, "cpu_freqs", cpu_freqs, cpu_op_nr);
> +
> +	pp = of_find_property(cpu0, "cpu_volts", NULL);
> +	if (pp) {
> +		if (cpu_op_nr == pp->length / sizeof(u32)) {
> +			cpu_volts = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr,
> +						GFP_KERNEL);
> +			if (!cpu_volts)
> +				goto free_cpu_freqs;
> +			of_property_read_u32_array(cpu0, "cpu_volts",
> +						cpu_freqs, cpu_op_nr);

cpu_freqs should clearly be cpu_volts in this instance.

> +		} else
> +			printk(KERN_WARNING "cpufreq: invalid cpu_volts!\n");
> +	}
> +
> +	if (of_property_read_u32(cpu0, "trans_latency",&trans_latency))
> +		trans_latency = CPUFREQ_ETERNAL;

I'm not sure this is an appropriate default value. I suspect it will do
very strange things on actual hardware that fails to define
trans_latency in the device tree.
> +
> +	cpu_freq_khz_min = cpu_freqs[0] / 1000;
> +	cpu_freq_khz_max = cpu_freqs[0] / 1000;
> +
> +	arm_freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
> +				* (cpu_op_nr + 1), GFP_KERNEL);
> +	if (!arm_freq_table)
> +		goto free_cpu_volts;
> +
> +	for (i = 0; i<  cpu_op_nr; i++) {
> +		arm_freq_table[i].index = i;
> +		arm_freq_table[i].frequency = cpu_freqs[i] / 1000;
> +		if ((cpu_freqs[i] / 1000)<  cpu_freq_khz_min)
> +			cpu_freq_khz_min = cpu_freqs[i] / 1000;
> +		if ((cpu_freqs[i] / 1000)>  cpu_freq_khz_max)
> +			cpu_freq_khz_max = cpu_freqs[i] / 1000;
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

I'd prefer to see clk_get90 replaced with of_clk_get() and
get_this_cpu_node() from the clk-cpufreq driver by Jamie Iles that
I resubmitted yesterday. The of_clk_get() doesn't require defining
an arm_clk structure, so it's slightly more portable for mach-
definitions. Also, the of_clk_get() method doesn't require
mach/clock.h and mach/hardware.h, which is good because most
of the mach- definitions don't include them.

--Mark Langsdorf
Calxeda, Inc.
