From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 24 Nov 2012 21:45:06 +0100
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
Message-ID: <5721240.go8BZZ50Vf@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, November 25, 2012 01:09:28 AM Viresh Kumar wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
> 
> SPEAr is an ARM based family of SoCs. This patch adds in support of cpufreq
> driver for SPEAr SoCs. It is supported via DT only and so bindings are present
> in binding document.

I'm not going to take this for v3.8.  Please resubmit after v3.8-rc1 has been
released.

Thanks,
Rafael


> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-spear.txt  |  29 ++
>  arch/arm/Kconfig                                   |   1 +
>  drivers/cpufreq/Kconfig.arm                        |   7 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/spear-cpufreq.c                    | 291 +++++++++++++++++++++
>  5 files changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
>  create mode 100644 drivers/cpufreq/spear-cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
> new file mode 100644
> index 0000000..4cf2819
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
> @@ -0,0 +1,29 @@
> +SPEAr cpufreq driver
> +-------------------
> +
> +SPEAr SoC cpufreq driver for CPU frequency scaling.
> +It supports both uniprocessor (UP) and symmetric multiprocessor (SMP) systems
> +which share clock across all CPUs.
> +
> +Required properties:
> +- compatible: "st,cpufreq-spear"
> +- cpufreq_tbl: Table of frequencies CPU could be transitioned into, in the
> +  increasing order.
> +
> +Optional properties:
> +- clock-latency: Specify the possible maximum transition latency for clock, in
> +  unit of nanoseconds.
> +
> +Examples:
> +--------
> +
> +cpufreq {
> +	compatible = "st,cpufreq-spear";
> +	cpufreq_tbl = < 166000
> +			200000
> +			250000
> +			300000
> +			400000
> +			500000
> +			600000 >;
> +};
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 14f8160..44bb5cf 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -902,6 +902,7 @@ config ARCH_NOMADIK
>  
>  config PLAT_SPEAR
>  	bool "ST SPEAr"
> +	select ARCH_HAS_CPUFREQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select CLKDEV_LOOKUP
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index b63c335..ee0ef07 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -76,3 +76,10 @@ config ARM_EXYNOS5250_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver for Samsung EXYNOS5250
>  	  SoC.
> +
> +config ARM_SPEAR_CPUFREQ
> +	bool "SPEAr CPUFreq support"
> +	depends on PLAT_SPEAR
> +	default y
> +	help
> +	  This adds the CPUFreq driver support for SPEAr SOCs.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 5b1413e..1f254ec0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
> +obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  
>  ##################################################################################
>  # PowerPC platform drivers
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> new file mode 100644
> index 0000000..a7fe880
> --- /dev/null
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -0,0 +1,291 @@
> +/*
> + * drivers/cpufreq/spear-cpufreq.c
> + *
> + * CPU Frequency Scaling for SPEAr platform
> + *
> + * Copyright (C) 2012 ST Microelectronics
> + * Deepak Sikri <deepak.sikri@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +/* SPEAr CPUFreq driver data structure */
> +static struct {
> +	struct clk *clk;
> +	unsigned int transition_latency;
> +	struct cpufreq_frequency_table *freq_tbl;
> +	u32 cnt;
> +} spear_cpufreq;
> +
> +int spear_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, spear_cpufreq.freq_tbl);
> +}
> +
> +static unsigned int spear_cpufreq_get(unsigned int cpu)
> +{
> +	return clk_get_rate(spear_cpufreq.clk) / 1000;
> +}
> +
> +static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
> +{
> +	struct clk *sys_pclk;
> +	int pclk;
> +	/*
> +	 * In SPEAr1340, cpu clk's parent sys clk can take input from
> +	 * following sources
> +	 */
> +	const char *sys_clk_src[] = {
> +		"sys_syn_clk",
> +		"pll1_clk",
> +		"pll2_clk",
> +		"pll3_clk",
> +	};
> +
> +	/*
> +	 * As sys clk can have multiple source with their own range
> +	 * limitation so we choose possible sources accordingly
> +	 */
> +	if (newfreq <= 300000000)
> +		pclk = 0; /* src is sys_syn_clk */
> +	else if (newfreq > 300000000 && newfreq <= 500000000)
> +		pclk = 3; /* src is pll3_clk */
> +	else if (newfreq == 600000000)
> +		pclk = 1; /* src is pll1_clk */
> +	else
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Get parent to sys clock */
> +	sys_pclk = clk_get(NULL, sys_clk_src[pclk]);
> +	if (IS_ERR(sys_pclk))
> +		pr_err("Failed to get %s clock\n", sys_clk_src[pclk]);
> +
> +	return sys_pclk;
> +}
> +
> +/*
> + * In SPEAr1340, we cannot use newfreq directly because we need to actually
> + * access a source clock (clk) which might not be ancestor of cpu at present.
> + * Hence in SPEAr1340 we would operate on source clock directly before switching
> + * cpu clock to it.
> + */
> +static int spear1340_set_cpu_rate(struct clk *sys_pclk, unsigned long newfreq)
> +{
> +	struct clk *sys_clk;
> +	int ret = 0;
> +
> +	sys_clk = clk_get_parent(spear_cpufreq.clk);
> +	if (IS_ERR(sys_clk)) {
> +		pr_err("failed to get cpu's parent (sys) clock\n");
> +		return PTR_ERR(sys_clk);
> +	}
> +
> +	/* Set the rate of the source clock before changing the parent */
> +	ret = clk_set_rate(sys_pclk, newfreq);
> +	if (ret) {
> +		pr_err("Failed to set sys clk rate to %lu\n", newfreq);
> +		return ret;
> +	}
> +
> +	ret = clk_set_parent(sys_clk, sys_pclk);
> +	if (ret) {
> +		pr_err("Failed to set sys clk parent\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spear_cpufreq_target(struct cpufreq_policy *policy,
> +		unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	unsigned long newfreq;
> +	struct clk *srcclk;
> +	int index, ret, mult = 1;
> +
> +	if (cpufreq_frequency_table_target(policy, spear_cpufreq.freq_tbl,
> +				target_freq, relation, &index))
> +		return -EINVAL;
> +
> +	freqs.cpu = policy->cpu;
> +	freqs.old = spear_cpufreq_get(0);
> +
> +	newfreq = spear_cpufreq.freq_tbl[index].frequency * 1000;
> +	if (of_machine_is_compatible("st,spear1340")) {
> +		/*
> +		 * SPEAr1340 is special in the sense that due to the possibility
> +		 * of multiple clock sources for cpu clk's parent we can have
> +		 * different clock source for different frequency of cpu clk.
> +		 * Hence we need to choose one from amongst these possible clock
> +		 * sources.
> +		 */
> +		srcclk = spear1340_cpu_get_possible_parent(newfreq);
> +		if (IS_ERR(srcclk)) {
> +			pr_err("Failed to get src clk\n");
> +			return PTR_ERR(srcclk);
> +		}
> +
> +		/* SPEAr1340: src clk is always 2 * intended cpu clk */
> +		mult = 2;
> +	} else {
> +		/*
> +		 * src clock to be altered is ancestor of cpu clock. Hence we
> +		 * can directly work on cpu clk
> +		 */
> +		srcclk = spear_cpufreq.clk;
> +	}
> +
> +	newfreq = clk_round_rate(srcclk, newfreq * mult);
> +	if (newfreq < 0) {
> +		pr_err("clk_round_rate failed for cpu src clock\n");
> +		return newfreq;
> +	}
> +
> +	freqs.new = newfreq / 1000;
> +	freqs.new /= mult;
> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +	if (mult == 2)
> +		ret = spear1340_set_cpu_rate(srcclk, newfreq);
> +	else
> +		ret = clk_set_rate(spear_cpufreq.clk, newfreq);
> +
> +	/* Get current rate after clk_set_rate, in case of failure */
> +	if (ret) {
> +		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
> +		freqs.new = clk_get_rate(spear_cpufreq.clk) / 1000;
> +	}
> +
> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	return ret;
> +}
> +
> +static int spear_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, spear_cpufreq.freq_tbl);
> +	if (ret) {
> +		pr_err("cpufreq_frequency_table_cpuinfo() failed");
> +		return ret;
> +	}
> +
> +	cpufreq_frequency_table_get_attr(spear_cpufreq.freq_tbl, policy->cpu);
> +	policy->cpuinfo.transition_latency = spear_cpufreq.transition_latency;
> +	policy->cur = spear_cpufreq_get(0);
> +
> +	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
> +	cpumask_copy(policy->related_cpus, policy->cpus);
> +
> +	return 0;
> +}
> +
> +static int spear_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_frequency_table_put_attr(policy->cpu);
> +	return 0;
> +}
> +
> +static struct freq_attr *spear_cpufreq_attr[] = {
> +	 &cpufreq_freq_attr_scaling_available_freqs,
> +	 NULL,
> +};
> +
> +static struct cpufreq_driver spear_cpufreq_driver = {
> +	.name		= "cpufreq-spear",
> +	.flags		= CPUFREQ_STICKY,
> +	.verify		= spear_cpufreq_verify,
> +	.target		= spear_cpufreq_target,
> +	.get		= spear_cpufreq_get,
> +	.init		= spear_cpufreq_init,
> +	.exit		= spear_cpufreq_exit,
> +	.attr		= spear_cpufreq_attr,
> +};
> +
> +static int spear_cpufreq_driver_init(void)
> +{
> +	struct device_node *np;
> +	const struct property *prop;
> +	struct cpufreq_frequency_table *freq_tbl;
> +	const __be32 *val;
> +	int cnt, i, ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "st,cpufreq-spear");
> +	if (!np) {
> +		pr_err("No cpufreq node found");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_u32(np, "clock-latency",
> +				&spear_cpufreq.transition_latency))
> +		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
> +
> +	prop = of_find_property(np, "cpufreq_tbl", NULL);
> +	if (!prop || !prop->value) {
> +		pr_err("Invalid cpufreq_tbl");
> +		ret = -ENODEV;
> +		goto out_put_node;
> +	}
> +
> +	cnt = prop->length / sizeof(u32);
> +	val = prop->value;
> +
> +	freq_tbl = kmalloc(sizeof(*freq_tbl) * (cnt + 1), GFP_KERNEL);
> +	if (!freq_tbl) {
> +		ret = -ENOMEM;
> +		goto out_put_node;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		freq_tbl[i].index = i;
> +		freq_tbl[i].frequency = be32_to_cpup(val++);
> +	}
> +
> +	freq_tbl[i].index = i;
> +	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
> +
> +	spear_cpufreq.freq_tbl = freq_tbl;
> +
> +	of_node_put(np);
> +
> +	spear_cpufreq.clk = clk_get(NULL, "cpu_clk");
> +	if (IS_ERR(spear_cpufreq.clk)) {
> +		pr_err("Unable to get CPU clock\n");
> +		ret = PTR_ERR(spear_cpufreq.clk);
> +		goto out_put_mem;
> +	}
> +
> +	ret = cpufreq_register_driver(&spear_cpufreq_driver);
> +	if (!ret)
> +		return 0;
> +
> +	pr_err("failed register driver: %d\n", ret);
> +	clk_put(spear_cpufreq.clk);
> +
> +out_put_mem:
> +	kfree(freq_tbl);
> +	return ret;
> +
> +out_put_node:
> +	of_node_put(np);
> +	return ret;
> +}
> +late_initcall(spear_cpufreq_driver_init);
> +
> +MODULE_AUTHOR("Deepak Sikri <deepak.sikri@st.com>");
> +MODULE_DESCRIPTION("SPEAr CPUFreq driver");
> +MODULE_LICENSE("GPL");
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
