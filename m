From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Jul 2010 12:59:42 +0100
Subject: [PATCH 5/5] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <1279184768-28971-6-git-send-email-myungjoo.ham@samsung.com>
References: <1279184768-28971-1-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-2-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-3-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-4-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-5-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-6-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100715115942.GA15919@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 06:06:08PM +0900, MyungJoo Ham wrote:

> +/* Based on MAX8998 default RAMP time: 10mV/us */
> +#define PMIC_RAMP_UP		(10)

This should be handled within the regulator API, not by hard coding
numbers into the CPUfreq drivers.  With many regulators there will be no
need at all for a ramp delay, they can ramp effectively instantaneously.
Doing this through the regulator API avoids hard coding details of an
individual regulator in your driver and ensures that all users of this
regulator can handle the ramp rate.

I did have most of a patch to introduce this, I'll go and dust it off
soon.  You should just be able to remove the ramp rate code from the
CPUfreq driver.

> +       if (s3c_freqs.freqs.new >= s3c_freqs.freqs.old) {
> +               /* Voltage up code: increase ARM first */
> +               if (!IS_ERR(arm_regulator) && !IS_ERR(internal_regulator)) {
> +                       regulator_set_voltage(arm_regulator,
> +                                       arm_volt, arm_volt);
> +                       regulator_set_voltage(internal_regulator,
> +                                       int_volt, int_volt);
> +               }

You shouldn't be specifying an exact voltage here - there's no guarantee
that the exact voltage you request will be delivered by the regulator,
and some boards may wish to use constraints to eliminate some voltages
(eg, to restrict the maximum operating point for the CPU).

What you'd normally have here is that the minimum voltage would be the
desired operating point for the CPU and the maximum voltage would be
fixed at the maximum rated supply for the part.  This will allow the
regulator API to select the lowest voltage it is able to deliver.

> +#ifdef CONFIG_REGULATOR
> +       arm_regulator = regulator_get_exclusive(NULL, "vddarm");
> +       if (IS_ERR(arm_regulator)) {
> +               printk(KERN_ERR "failed to get regulater resource vddarm\n");
> +               goto error;
> +       }
> +       internal_regulator = regulator_get_exclusive(NULL, "vddint");
> +       if (IS_ERR(internal_regulator)) {
> +               printk(KERN_ERR "failed to get regulater resource vddint\n");
> +               goto error;
> +       }
> +#endif

Remove these ifdefs, they're not needed - the regulator API will stub
out the regulators.  You should also have code to check that the voltage
ranges for all the operating modes of the CPU can be supported.  This is
particularly important the way you've got the code at the minute
specifying exact voltages.

> +#if defined(CONFIG_REGULATOR)
> +#ifdef CONFIG_REGULATOR_MAX8998
> +	reg = __raw_readl(S5P_CLK_OUT);
> +	reg &= ~(0x1f << 12 | 0xf << 20); /* CLKSEL and DIVVAL*/
> +	apllreg = __raw_readl(S5P_APLL_CON);

This ifdef for a particular regulator looks *very* suspicious.  What's
going on here?

> +#ifdef CPUFREQ_DISABLE_1GHZ
> +	reg |= (0x0 << 12 | 0x9 << 20);	/* (800/4) / (9+1) = 20 */
> +#else
> +	if (((apllreg << 16) & 0x3ff) == 0xfa) /* APLL=1GHz */
> +		reg |= (0x0 << 12 | 0xb << 20);	/* (1000/4) / (11+1) = 20.833 */
> +	else /* APLL=800MHz */
> +		reg |= (0x0 << 12 | 0x9 << 20);	/* (800/4) / (9+1) = 20 */
> +#endif
> +	__raw_writel(reg, S5P_CLK_OUT);
> +#endif
> +#endif
> +
> +	if (policy->cpu != 0) {
> +		printk(KERN_ERR "S5PV210 CPUFREQ cannot get proper cpu(%d)\n",
> +				policy->cpu);
> +		return -EINVAL;
> +	}
> +	policy->cur = policy->min = policy->max = s5pv210_getspeed(0);
> +
> +	cpufreq_frequency_table_get_attr(s5pv210_freq_table, policy->cpu);
> +
> +	policy->cpuinfo.transition_latency = 40000;	/*1us*/
> +
> +	rate = clk_get_rate(mpu_clk);
> +	i = 0;
> +
> +	while (s5pv210_freq_table[i].frequency != CPUFREQ_TABLE_END) {
> +		if (s5pv210_freq_table[i].frequency * 1000 == rate) {
> +			level = s5pv210_freq_table[i].index;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (level == CPUFREQ_TABLE_END) { /* Not found */
> +		printk(KERN_ERR "[%s:%d] clock speed does not match: "
> +				"%d. Using L1 of 800MHz.\n",
> +				__FILE__, __LINE__, rate);
> +		level = L1;
> +	}
> +
> +	printk(KERN_INFO "S5PV210 CPUFREQ Initialized.\n");
> +
> +	memcpy(&s3c_freqs.old, &s5pv210_clk_info[level],
> +			sizeof(struct s3c_freq));
> +	previous_arm_volt = s5pv210_dvs_conf[level].arm_volt;
> +
> +	return cpufreq_frequency_table_cpuinfo(policy, s5pv210_freq_table);
> +}
> +
> +static struct cpufreq_driver s5pv210_driver = {
> +	.flags		= CPUFREQ_STICKY,
> +	.verify		= s5pv210_verify_speed,
> +	.target		= s5pv210_target,
> +	.get		= s5pv210_getspeed,
> +	.init		= s5pv210_cpu_init,
> +	.name		= "s5pv210",
> +#ifdef CONFIG_PM
> +	.suspend	= s5pv210_cpufreq_suspend,
> +	.resume		= s5pv210_cpufreq_resume,
> +#endif
> +};
> +
> +static int __init s5pv210_cpufreq_init(void)
> +{
> +	printk(KERN_INFO "S5PV210 CPUFREQ Init.\n");
> +#ifdef CONFIG_REGULATOR
> +	arm_regulator = regulator_get_exclusive(NULL, "vddarm");
> +	if (IS_ERR(arm_regulator)) {
> +		printk(KERN_ERR "failed to get regulater resource vddarm\n");
> +		goto error;
> +	}
> +	internal_regulator = regulator_get_exclusive(NULL, "vddint");
> +	if (IS_ERR(internal_regulator)) {
> +		printk(KERN_ERR "failed to get regulater resource vddint\n");
> +		goto error;
> +	}
> +#endif
> +	goto finish;
> +error:
> +	printk(KERN_WARNING "Cannot get vddarm or vddint. CPUFREQ Will not"
> +		       " change the voltage.\n");
> +finish:
> +	return cpufreq_register_driver(&s5pv210_driver);
> +}
> +
> +late_initcall(s5pv210_cpufreq_init);
> diff --git a/arch/arm/mach-s5pv210/include/mach/cpu-freq.h b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> new file mode 100644
> index 0000000..d3c31b2
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> @@ -0,0 +1,50 @@
> +/* arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * 	MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * S5PV210/S5PC110 CPU frequency scaling support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_
> +#define _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_
> +
> +#include <linux/cpufreq.h>
> +
> +#ifdef CONFIG_CPU_S5PV210
> +
> +#define USE_FREQ_TABLE
> +
> +#define KHZ_T           1000
> +
> +#define MPU_CLK         "armclk"
> +
> +enum perf_level {
> +	L0 = 0,
> +	L1,
> +	L2,
> +	L3,
> +	L4,
> +};
> +
> +#define CLK_DIV0_MASK   ((0x7<<0)|(0x7<<8)|(0x7<<12))   /* APLL,HCLK_MSYS,PCLK_MSYS mask value  */
> +
> +#ifdef CONFIG_PM
> +#define SLEEP_FREQ      (800 * 1000) /* Use 800MHz when entering sleep */
> +
> +/* additional symantics for "relation" in cpufreq with pm */
> +#define DISABLE_FURTHER_CPUFREQ         0x10
> +#define ENABLE_FURTHER_CPUFREQ          0x20
> +#define MASK_FURTHER_CPUFREQ            0x30
> +/* With 0x00(NOCHANGE), it depends on the previous "further" status */
> +
> +#endif
> +
> +
> +#endif /* CONFIG_CPU_S5PV210 */
> +#endif /* _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_ */
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
