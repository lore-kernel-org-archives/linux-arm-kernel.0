From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 17 Dec 2011 16:29:23 +0800
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <20111216105229.GB3230@totoro>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
 <20111216105229.GB3230@totoro>
Message-ID: <20111217082920.GD2010@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 10:52:29AM +0000, Jamie Iles wrote:
> Hi Richard,
> 
> A couple of questions inline, but otherwise looks nice!
Thanks for your review.
> 
> Jamie
> 
> On Fri, Dec 16, 2011 at 06:30:59PM +0800, Richard Zhao wrote:
> > It support single core and multi-core ARM SoCs. But it assume
> > all cores share the same frequency and voltage.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> [...]
> > diff --git a/drivers/cpufreq/arm-cpufreq.c b/drivers/cpufreq/arm-cpufreq.c
> > new file mode 100644
> > index 0000000..e4d20da
> > --- /dev/null
> > +++ b/drivers/cpufreq/arm-cpufreq.c
> > @@ -0,0 +1,269 @@
> > +/*
> > + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> > + */
> > +
> > +/*
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/clk.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <asm/cpu.h>
> > +
> > +static u32 *cpu_freqs; /* HZ */
> > +static u32 *cpu_volts; /* uV */
> > +static u32 trans_latency; /* ns */
> > +static int cpu_op_nr;
> > +
> > +static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
> > +static unsigned long l_p_j_ref_freq;
> > +
> > +static struct clk *cpu_clk;
> 
> This assumes that all CPU's share the same clk and run at the same rate.  
> Is that a fair/safe assumption?  I honestly don't know the answer to 
> this so it's just a question!!!
As I know, most share the same clk/volt. From the code:
IMX6: yes
Tegra: Yes, but strange it sets CPUFREQ_SHARED_TYPE_ALL.

MSM is an exception. I can support the case, but I have to make sure it's
handy to use.
> 
> > +static struct regulator *cpu_reg;
> > +static struct cpufreq_frequency_table *arm_freq_table;
> > +
> > +static int set_cpu_freq(unsigned long freq, int index, int higher)
> > +{
> > +	int ret = 0;
> > +
> > +	if (higher && cpu_reg)
> > +		regulator_set_voltage(cpu_reg,
> > +				cpu_volts[index], cpu_volts[index]);
> > +
> > +	ret = clk_set_rate(cpu_clk, freq);
> > +	if (ret != 0) {
> > +		printk(KERN_DEBUG "cannot set CPU clock rate\n");
> 
> Perhaps use pr_debug() and friends throughout this driver?
ok. Thanks.
> 
> > +		return ret;
> > +	}
> > +
> > +	if (!higher && cpu_reg)
> > +		regulator_set_voltage(cpu_reg,
> > +				cpu_volts[index], cpu_volts[index]);
> > +
> > +	return ret;
> > +}
> > +
> > +static int arm_verify_speed(struct cpufreq_policy *policy)
> > +{
> > +	return cpufreq_frequency_table_verify(policy, arm_freq_table);
> > +}
> > +
> > +static unsigned int arm_get_speed(unsigned int cpu)
> > +{
> > +	return clk_get_rate(cpu_clk) / 1000;
> > +}
> > +
> > +static int arm_set_target(struct cpufreq_policy *policy,
> > +			  unsigned int target_freq, unsigned int relation)
> > +{
> > +	struct cpufreq_freqs freqs;
> > +	unsigned long freq_Hz;
> > +	int cpu;
> > +	int ret = 0;
> > +	unsigned int index;
> > +
> > +	cpufreq_frequency_table_target(policy, arm_freq_table,
> > +			target_freq, relation, &index);
> > +	freq_Hz = clk_round_rate(cpu_clk, cpu_freqs[index]);
> > +	freq_Hz = freq_Hz ? freq_Hz : cpu_freqs[index];
> > +	freqs.old = clk_get_rate(cpu_clk) / 1000;
> > +	freqs.new = clk_round_rate(cpu_clk, cpu_freqs[index]);
I forgot to delete this line.
> > +	freqs.new = freq_Hz / 1000;
> 
> Why round the rate then overwrite it?  Should this be freqs.new /= 1000?
> 
> > +	freqs.flags = 0;
> > +
> > +	if (freqs.old == freqs.new)
> > +		return 0;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		freqs.cpu = cpu;
> > +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +	}
> > +
> > +	ret = set_cpu_freq(freq_Hz, index, (freqs.new > freqs.old));
> > +
> > +#ifdef CONFIG_SMP
> > +	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
> > +	 * So update it for all CPUs.
> > +	 */
> > +	for_each_possible_cpu(cpu)
> > +		per_cpu(cpu_data, cpu).loops_per_jiffy =
> > +		cpufreq_scale(per_cpu(l_p_j_ref, cpu), l_p_j_ref_freq,
> > +							freqs.new);
> > +#endif
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		freqs.cpu = cpu;
> > +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int arm_cpufreq_init(struct cpufreq_policy *policy)
> > +{
> > +	int ret;
> > +
> > +	if (policy->cpu >= num_possible_cpus())
> > +		return -EINVAL;
> > +
> > +	policy->cur = clk_get_rate(cpu_clk) / 1000;
> > +	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> > +	cpumask_setall(policy->cpus);
> > +	/* Manual states, that PLL stabilizes in two CLK32 periods */
> > +	policy->cpuinfo.transition_latency = trans_latency;
> > +
> > +	ret = cpufreq_frequency_table_cpuinfo(policy, arm_freq_table);
> > +
> > +	if (ret < 0) {
> > +		printk(KERN_ERR "%s: invalid frequency table for cpu %d\n",
> > +		       __func__, policy->cpu);
> > +		return ret;
> > +	}
> > +
> > +	cpufreq_frequency_table_get_attr(arm_freq_table, policy->cpu);
> > +	return 0;
> > +}
> > +
> > +static int arm_cpufreq_exit(struct cpufreq_policy *policy)
> > +{
> > +	cpufreq_frequency_table_put_attr(policy->cpu);
> > +	return 0;
> > +}
> > +
> > +static struct cpufreq_driver arm_cpufreq_driver = {
> > +	.flags = CPUFREQ_STICKY,
> > +	.verify = arm_verify_speed,
> > +	.target = arm_set_target,
> > +	.get = arm_get_speed,
> > +	.init = arm_cpufreq_init,
> > +	.exit = arm_cpufreq_exit,
> > +	.name = "arm",
> 
> Is this really just for ARM or can it be a generic-clk driver?  I can't 
> see any ARM specifics here.
If we make recalculating smp loops_per_jiffy portable, this driver will
be portable too.
> 
> > +};
> > +
> > +static int __devinit arm_cpufreq_driver_init(void)
> > +{
> > +	struct device_node *cpu0;
> > +	const struct property *pp;
> > +	int cpu, i, ret;
> > +
> > +	printk(KERN_INFO "ARM SoC generic CPU frequency driver\n");
> > +
> > +	cpu0 = of_find_node_by_path("/cpus/cpu at 0");
> > +	if (!cpu0)
> > +		return -ENODEV;
> > +
> > +	pp = of_find_property(cpu0, "cpu-freqs", NULL);
> > +	if (!pp) {
> > +		ret = -ENODEV;
> > +		goto put_node;
> > +	}
> > +	cpu_op_nr = pp->length / sizeof(u32);
> > +	if (!cpu_op_nr) {
> > +		ret = -ENODEV;
> > +		goto put_node;
> > +	}
> > +	ret = -ENOMEM;
> > +	cpu_freqs = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr, GFP_KERNEL);
> > +	if (!cpu_freqs)
> > +		goto put_node;
> > +	of_property_read_u32_array(cpu0, "cpu-freqs", cpu_freqs, cpu_op_nr);
> > +
> > +	pp = of_find_property(cpu0, "cpu-volts", NULL);
> > +	if (pp) {
> > +		if (cpu_op_nr == pp->length / sizeof(u32)) {
> > +			cpu_volts = kzalloc(sizeof(*cpu_freqs) * cpu_op_nr,
> > +						GFP_KERNEL);
> > +			if (!cpu_volts)
> > +				goto free_cpu_freqs;
> > +			of_property_read_u32_array(cpu0, "cpu-volts",
> > +						cpu_volts, cpu_op_nr);
> > +		} else
> > +			printk(KERN_WARNING "cpufreq: invalid cpu_volts!\n");
> > +	}
> > +
> > +	if (of_property_read_u32(cpu0, "trans-latency", &trans_latency))
> > +		trans_latency = CPUFREQ_ETERNAL;
> > +
> > +	arm_freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
> > +				* (cpu_op_nr + 1), GFP_KERNEL);
> > +	if (!arm_freq_table)
> > +		goto free_cpu_volts;
> > +
> > +	for (i = 0; i < cpu_op_nr; i++) {
> > +		arm_freq_table[i].index = i;
> > +		arm_freq_table[i].frequency = cpu_freqs[i] / 1000;
> > +	}
> > +
> > +	arm_freq_table[i].index = i;
> > +	arm_freq_table[i].frequency = CPUFREQ_TABLE_END;
> > +
> > +	cpu_clk = clk_get(NULL, "cpu");
> > +	if (IS_ERR(cpu_clk)) {
> > +		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
> > +		ret = PTR_ERR(cpu_clk);
> > +		goto free_freq_table;
> > +	}
> 
> Should there be a clk_prepare() + clk_enable() pair here?  I can't see 
> it would really be needed but maybe for completeness?  Again, just a 
> question!
The cpu clock should already be prepared/enabled. The same to the regulator.
IMHO, cpufreq is not used to handle cpu clk/power gating. The gating should be
handled by cpu hotplug, idle and suspend/resume.
Please correct me if I'm wrong.
> 
> > +
> > +	if (cpu_volts) {
> > +		cpu_reg = regulator_get(NULL, "cpu");
> > +		if (IS_ERR(cpu_reg)) {
> > +			printk(KERN_WARNING
> > +				"cpufreq: regulator cpu get failed.\n");
> > +			cpu_reg = NULL;
> > +		}
> > +	}
> > +
> > +	l_p_j_ref_freq = clk_get_rate(cpu_clk);
> > +	for_each_possible_cpu(cpu)
> > +		per_cpu(l_p_j_ref, cpu) =
> > +			per_cpu(cpu_data, cpu).loops_per_jiffy;
> > +
> > +	ret = cpufreq_register_driver(&arm_cpufreq_driver);
> > +	if (ret)
> > +		goto reg_put;
> > +
> > +	of_node_put(cpu0);
> > +
> > +	return 0;
> > +
> > +reg_put:
> > +	if (cpu_reg)
> > +		regulator_put(cpu_reg);
> > +	clk_put(cpu_clk);
> > +free_freq_table:
> > +	kfree(arm_freq_table);
> > +free_cpu_volts:
> > +	kfree(cpu_volts);
> > +free_cpu_freqs:
> > +	kfree(cpu_freqs);
> > +put_node:
> > +	of_node_put(cpu0);
> > +
> > +	return ret;
> > +}
> > +
> > +static void arm_cpufreq_driver_exit(void)
> > +{
> > +	cpufreq_unregister_driver(&arm_cpufreq_driver);
> > +	kfree(cpu_freqs);
> > +	kfree(cpu_volts);
> > +	kfree(arm_freq_table);
> > +	clk_put(cpu_clk);
> > +}
> > +
> > +module_init(arm_cpufreq_driver_init);
> > +module_exit(arm_cpufreq_driver_exit);
> 
> Are there any ARM platforms that wouldn't be able to use this driver?  
> If there are then should platforms "opt-in" by calling a register 
> function rather than having it auto registering as when we have multiple 
> platforms in a single zImage the probe errors might not be too nice.
Good point. But would it be better to check cpu node compatible property?

Thanks
Richard
> 
> > +
> > +MODULE_AUTHOR("Freescale Semiconductor Inc. Richard Zhao <richard.zhao@freescale.com>");
> > +MODULE_DESCRIPTION("ARM SoC generic CPUFreq driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 1.7.5.4
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
