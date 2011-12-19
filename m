From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 19 Dec 2011 10:05:12 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111219100512.GC2459@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, Dec 19, 2011 at 11:21:40AM +0800, Richard Zhao wrote:
> It support single core and multi-core ARM SoCs. But currently it assume
> all cores share the same frequency and voltage.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/generic-cpufreq    |    7 +
>  drivers/cpufreq/Kconfig                            |    8 +
>  drivers/cpufreq/Makefile                           |    2 +
>  drivers/cpufreq/generic-cpufreq.c                  |  251 ++++++++++++++++++++
>  4 files changed, 268 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/generic-cpufreq
>  create mode 100644 drivers/cpufreq/generic-cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/generic-cpufreq b/Documentation/devicetree/bindings/cpufreq/generic-cpufreq
> new file mode 100644
> index 0000000..15dd780
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/generic-cpufreq
> @@ -0,0 +1,7 @@
> +Generic cpufreq driver
> +
> +Required properties in /cpus/cpu at 0:
> +- compatible : "generic-cpufreq"

I'm not convinced this is the best way to do this.  By requiring a 
generic-cpufreq compatible string we're encoding Linux driver 
information into the hardware description.  The only way I can see to 
avoid this is to provide a generic_clk_cpufreq_init() function that 
platforms can call in their machine init code to use the driver.

> +- cpu-freqs : cpu frequency points it support
> +- cpu-volts : cpu voltages required by the frequency point at the same index
> +- trans-latency :  transition_latency
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index e24a2a1..216eecd 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -179,6 +179,14 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  	  If in doubt, say N.
>  
> +config GENERIC_CPUFREQ_DRIVER
> +	bool "Generic cpufreq driver using clock/regulator/devicetree"
> +	help
> +	  This adds generic CPUFreq driver. It assumes all
> +	  cores of the CPU share the same clock and voltage.
> +
> +	  If in doubt, say N.

I think this needs dependencies on HAVE_CLK, OF and REGULATOR.

> +
>  menu "x86 CPU frequency scaling drivers"
>  depends on X86
>  source "drivers/cpufreq/Kconfig.x86"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ce75fcb..2dbdab1 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -13,6 +13,8 @@ obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
>  # CPUfreq cross-arch helpers
>  obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
>  
> +obj-$(CONFIG_GENERIC_CPUFREQ_DRIVER)	+= generic-cpufreq.o
> +
>  ##################################################################################
>  # x86 drivers.
>  # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> diff --git a/drivers/cpufreq/generic-cpufreq.c b/drivers/cpufreq/generic-cpufreq.c
> new file mode 100644
> index 0000000..781bb9b
> --- /dev/null
> +++ b/drivers/cpufreq/generic-cpufreq.c
> @@ -0,0 +1,251 @@
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
> +
> +static u32 *cpu_freqs; /* HZ */
> +static u32 *cpu_volts; /* uV */
> +static u32 trans_latency; /* ns */
> +static int cpu_op_nr;
> +
> +static struct clk *cpu_clk;
> +static struct regulator *cpu_reg;
> +static struct cpufreq_frequency_table *freq_table;
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
> +		pr_err("generic-cpufreq: cannot set CPU clock rate\n");
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
> +static int generic_verify_speed(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, freq_table);
> +}
> +
> +static unsigned int generic_get_speed(unsigned int cpu)
> +{
> +	return clk_get_rate(cpu_clk) / 1000;
> +}
> +
> +static int generic_set_target(struct cpufreq_policy *policy,
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

If this fails then we'll still be notifying the transition at the 
requested rate even though it didn't work.  I guess we should really get 
the rate of the clk and put that into freqs for the POSTCHANGE 
notification.

> +
> +	for_each_possible_cpu(cpu) {
> +		freqs.cpu = cpu;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	}
> +
> +	return ret;
> +}
> +
> +static int generic_cpufreq_init(struct cpufreq_policy *policy)
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
> +	ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> +
> +	if (ret < 0) {
> +		pr_err("%s: invalid frequency table for cpu %d\n",
> +		       __func__, policy->cpu);
> +		return ret;
> +	}
> +
> +	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> +	return 0;
> +}
> +
> +static int generic_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_frequency_table_put_attr(policy->cpu);
> +	return 0;
> +}
> +
> +static struct cpufreq_driver generic_cpufreq_driver = {
> +	.flags = CPUFREQ_STICKY,
> +	.verify = generic_verify_speed,
> +	.target = generic_set_target,
> +	.get = generic_get_speed,
> +	.init = generic_cpufreq_init,
> +	.exit = generic_cpufreq_exit,
> +	.name = "generic",

This may be a little too generic?  "generic-reg-clk"?

> +};
> +
> +static int __devinit generic_cpufreq_driver_init(void)
> +{
> +	struct device_node *cpu0;
> +	const struct property *pp;
> +	int i, ret;
> +
> +	pr_info("Generic CPU frequency driver\n");
> +
> +	cpu0 = of_find_node_by_path("/cpus/cpu at 0");
> +	if (!cpu0)
> +		return -ENODEV;
> +
> +	if (!of_device_is_compatible(cpu0, "generic-cpufreq"))
> +		return -ENODEV;

As above, I'd personally rather not use compatible strings, but if you 
do, then I think return 0 here rather than -ENODEV else I believe you'll 
get a potentially confusing message on the console for platforms that 
don't use this.

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
> +			pr_warn("%s: invalid cpu_volts!\n", __func__);
> +	}
> +
> +	if (of_property_read_u32(cpu0, "trans-latency", &trans_latency))
> +		trans_latency = CPUFREQ_ETERNAL;
> +
> +	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
> +				* (cpu_op_nr + 1), GFP_KERNEL);
> +	if (!freq_table)
> +		goto free_cpu_volts;
> +
> +	for (i = 0; i < cpu_op_nr; i++) {
> +		freq_table[i].index = i;
> +		freq_table[i].frequency = cpu_freqs[i] / 1000;
> +	}
> +
> +	freq_table[i].index = i;
> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	cpu_clk = clk_get(NULL, "cpu");
> +	if (IS_ERR(cpu_clk)) {
> +		pr_err("%s: failed to get cpu clock\n", __func__);
> +		ret = PTR_ERR(cpu_clk);
> +		goto free_freq_table;
> +	}
> +
> +	if (cpu_volts) {
> +		cpu_reg = regulator_get(NULL, "cpu");
> +		if (IS_ERR(cpu_reg)) {
> +			pr_warn("%s: regulator cpu get failed.\n", __func__);
> +			cpu_reg = NULL;
> +		}
> +	}
> +
> +	ret = cpufreq_register_driver(&generic_cpufreq_driver);
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
> +	kfree(freq_table);
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
> +static void generic_cpufreq_driver_exit(void)
> +{
> +	cpufreq_unregister_driver(&generic_cpufreq_driver);
> +	kfree(cpu_freqs);
> +	kfree(cpu_volts);
> +	kfree(freq_table);
> +	clk_put(cpu_clk);

Should this do something with the regulator too?

Jamie
