From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 24 Dec 2011 13:10:40 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
 <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111224131040.GA3965@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

This is looking really nice.  A couple of really minor nits inline, 
otherwise:

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

On Thu, Dec 22, 2011 at 03:09:10PM +0800, Richard Zhao wrote:
> The driver get cpu operation point table from device tree cpu0 node,
> and adjusts operating points using clk and regulator APIs.
> 
> It support single core and multi-core ARM SoCs. But currently it assume
> all cores share the same frequency and voltage.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/clk-reg-cpufreq    |    7 +
>  drivers/cpufreq/Kconfig                            |   10 +
>  drivers/cpufreq/Makefile                           |    2 +
>  drivers/cpufreq/clk-reg-cpufreq.c                  |  289 ++++++++++++++++++++
>  4 files changed, 308 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/clk-reg-cpufreq
>  create mode 100644 drivers/cpufreq/clk-reg-cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/clk-reg-cpufreq b/Documentation/devicetree/bindings/cpufreq/clk-reg-cpufreq
> new file mode 100644
> index 0000000..bf07c1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/clk-reg-cpufreq
> @@ -0,0 +1,7 @@
> +Generic cpufreq driver based on clk and regulator APIs
> +
> +Required properties in /cpus/cpu at 0:
> +- cpu-freqs : cpu frequency points it support, in unit of Hz.
> +- cpu-volts : cpu voltages required by the frequency point at the same index,
> +	      in unit of uV.

Perhaps clarify here that these are arrays of u32's?  It may be worth 
giving an example node just to be clear?

> +- trans-latency :  transition_latency, in unit of ns.
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index e24a2a1..95470f1 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -179,6 +179,16 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  	  If in doubt, say N.
>  
> +config CLK_REG_CPUFREQ_DRIVER
> +	tristate "Generic cpufreq driver using clk and regulator APIs"
> +	depends on HAVE_CLK && OF && REGULATOR
> +	select CPU_FREQ_TABLE
> +	help
> +	  This adds generic CPUFreq driver based on clk and regulator APIs.
> +	  It assumes all cores of the CPU share the same clock and voltage.
> +
> +	  If in doubt, say N.
> +
>  menu "x86 CPU frequency scaling drivers"
>  depends on X86
>  source "drivers/cpufreq/Kconfig.x86"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ce75fcb..2c4eb33 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -13,6 +13,8 @@ obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
>  # CPUfreq cross-arch helpers
>  obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
>  
> +obj-$(CONFIG_CLK_REG_CPUFREQ_DRIVER)	+= clk-reg-cpufreq.o
> +
>  ##################################################################################
>  # x86 drivers.
>  # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> diff --git a/drivers/cpufreq/clk-reg-cpufreq.c b/drivers/cpufreq/clk-reg-cpufreq.c
> new file mode 100644
> index 0000000..c30d2c5
> --- /dev/null
> +++ b/drivers/cpufreq/clk-reg-cpufreq.c
> @@ -0,0 +1,289 @@
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
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +
> +static u32 *cpu_freqs; /* Hz */
> +static u32 *cpu_volts; /* uV */
> +static u32 trans_latency; /* ns */
> +static int cpu_op_nr;
> +static unsigned int cur_index;
> +
> +static struct clk *cpu_clk;
> +static struct regulator *cpu_reg;
> +static struct cpufreq_frequency_table *freq_table;
> +
> +static int set_cpu_freq(unsigned long freq, int index, int higher)
> +{
> +	int ret = 0;
> +
> +	if (higher && cpu_reg) {
> +		ret = regulator_set_voltage(cpu_reg,
> +				cpu_volts[index * 2], cpu_volts[index * 2 + 1]);
> +		if (ret) {
> +			pr_err("set cpu voltage failed!\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_set_rate(cpu_clk, freq);
> +	if (ret) {
> +		if (cpu_reg)
> +			regulator_set_voltage(cpu_reg, cpu_volts[cur_index * 2],
> +						cpu_volts[cur_index * 2 + 1]);
> +		pr_err("cannot set CPU clock rate\n");
> +		return ret;
> +	}
> +
> +	if (!higher && cpu_reg) {
> +		ret = regulator_set_voltage(cpu_reg,
> +				cpu_volts[index * 2], cpu_volts[index * 2 + 1]);
> +		if (ret)
> +			pr_warn("set cpu voltage failed, might run on"
> +				" higher voltage!\n");
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static int clk_reg_verify_speed(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, freq_table);
> +}
> +
> +static unsigned int clk_reg_get_speed(unsigned int cpu)
> +{
> +	return clk_get_rate(cpu_clk) / 1000;
> +}
> +
> +static int clk_reg_set_target(struct cpufreq_policy *policy,
> +			  unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	unsigned long freq_Hz;
> +	int cpu;
> +	int ret = 0;
> +	unsigned int index;
> +
> +	cpufreq_frequency_table_target(policy, freq_table,
> +			target_freq, relation, &index);
> +	freq_Hz = clk_round_rate(cpu_clk, cpu_freqs[index]);
> +	freq_Hz = freq_Hz ? freq_Hz : cpu_freqs[index];
> +	freqs.old = clk_get_rate(cpu_clk) / 1000;
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
> +	if (ret)
> +		freqs.new = clk_get_rate(cpu_clk) / 1000;
> +	else
> +		cur_index = index;
> +
> +	for_each_possible_cpu(cpu) {
> +		freqs.cpu = cpu;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	}
> +
> +	return ret;
> +}
> +
> +static int clk_reg_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	if (policy->cpu >= num_possible_cpus())
> +		return -EINVAL;
> +
> +	policy->cur = clk_get_rate(cpu_clk) / 1000;
> +	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +	cpumask_setall(policy->cpus);
> +	policy->cpuinfo.transition_latency = trans_latency;
> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> +
> +	if (ret < 0) {
> +		pr_err("invalid frequency table for cpu %d\n",
> +			policy->cpu);
> +		return ret;
> +	}
> +
> +	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> +	cpufreq_frequency_table_target(policy, freq_table, policy->cur,
> +					CPUFREQ_RELATION_H, &cur_index);
> +	return 0;
> +}
> +
> +static int clk_reg_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_frequency_table_put_attr(policy->cpu);
> +	return 0;
> +}
> +
> +static struct cpufreq_driver clk_reg_cpufreq_driver = {
> +	.flags = CPUFREQ_STICKY,
> +	.verify = clk_reg_verify_speed,
> +	.target = clk_reg_set_target,
> +	.get = clk_reg_get_speed,
> +	.init = clk_reg_cpufreq_init,
> +	.exit = clk_reg_cpufreq_exit,
> +	.name = "clk-reg",
> +};
> +
> +

Drop the extra newline?

> +static u32 max_freq = UINT_MAX / 1000; /* kHz */
> +module_param(max_freq, uint, 0);
> +MODULE_PARM_DESC(max_freq, "max cpu frequency in unit of kHz");
> +
> +static int __devinit clk_reg_cpufreq_driver_init(void)
> +{
> +	struct device_node *cpu0;
> +	const struct property *pp;
> +	int i, ret;
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
> +		if (cpu_op_nr * 2 == pp->length / sizeof(u32)) {
> +			cpu_volts = kzalloc(sizeof(*cpu_volts) * cpu_op_nr * 2,
> +						GFP_KERNEL);
> +			if (!cpu_volts)
> +				goto free_cpu_freqs;
> +			of_property_read_u32_array(cpu0, "cpu-volts",
> +						cpu_volts, cpu_op_nr * 2);
> +		} else
> +			pr_warn("invalid cpu_volts!\n");
> +	}
> +
> +	if (of_property_read_u32(cpu0, "trans-latency", &trans_latency))
> +		trans_latency = CPUFREQ_ETERNAL;
> +
> +	cpu_clk = clk_get(NULL, "cpu");
> +	if (IS_ERR(cpu_clk)) {
> +		pr_err("failed to get cpu clock\n");
> +		ret = PTR_ERR(cpu_clk);
> +		goto free_cpu_volts;
> +	}
> +
> +	if (cpu_volts) {
> +		cpu_reg = regulator_get(NULL, "cpu");
> +		if (IS_ERR(cpu_reg)) {
> +			pr_warn("regulator cpu get failed.\n");
> +			cpu_reg = NULL;
> +		}
> +	}
> +
> +	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
> +				* (cpu_op_nr + 1), GFP_KERNEL);
> +	if (!freq_table) {
> +		ret = -ENOMEM;
> +		goto reg_put;
> +	}
> +
> +	for (i = 0; i < cpu_op_nr; i++) {
> +		freq_table[i].index = i;
> +		if (cpu_freqs[i] > max_freq * 1000) {
> +			freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +			continue;
> +		}
> +
> +		if (cpu_reg) {
> +			ret = regulator_is_supported_voltage(cpu_reg,
> +					cpu_volts[i * 2], cpu_volts[i * 2 + 1]);
> +			if (ret <= 0) {
> +				freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +				continue;
> +			}
> +		}
> +		freq_table[i].frequency = cpu_freqs[i] / 1000;
> +	}
> +
> +	freq_table[i].index = i;
> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	ret = cpufreq_register_driver(&clk_reg_cpufreq_driver);
> +	if (ret)
> +		goto free_freq_table;
> +
> +	of_node_put(cpu0);
> +
> +	return 0;
> +
> +free_freq_table:
> +	kfree(freq_table);
> +reg_put:
> +	if (cpu_reg)
> +		regulator_put(cpu_reg);
> +	clk_put(cpu_clk);
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
> +static void clk_reg_cpufreq_driver_exit(void)
> +{
> +	cpufreq_unregister_driver(&clk_reg_cpufreq_driver);
> +	kfree(cpu_freqs);
> +	kfree(cpu_volts);
> +	clk_put(cpu_clk);
> +	if (cpu_reg)
> +		regulator_put(cpu_reg);
> +	kfree(freq_table);
> +}
> +
> +module_init(clk_reg_cpufreq_driver_init);
> +module_exit(clk_reg_cpufreq_driver_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor Inc. Richard Zhao <richard.zhao@freescale.com>");
> +MODULE_DESCRIPTION("Generic CPUFreq driver based on clk and regulator APIs");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.5.4
> 
> 
