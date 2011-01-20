From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 20 Jan 2011 14:49:41 +0000
Subject: [PATCH V5 39/63] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <403ef0da274038357f72e84e2378dc4e55be8cb0.1295499395.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<403ef0da274038357f72e84e2378dc4e55be8cb0.1295499395.git.viresh.kumar@st.com>
Message-ID: <20110120144941.GB25954@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh, Deepak,

Two minor nitpicks below but otherwise it looks nice to me!

On Thu, Jan 20, 2011 at 12:56:17PM +0530, Viresh Kumar wrote:
> diff --git a/arch/arm/plat-spear/cpufreq.c 
> b/arch/arm/plat-spear/cpufreq.c
> new file mode 100644
> index 0000000..c9c5dce
> --- /dev/null
> +++ b/arch/arm/plat-spear/cpufreq.c
> @@ -0,0 +1,166 @@
> +/*
> + * arch/arm/plat-spear/cpufreq.c
> + *
> + * CPU Frequency Scaling for SPEAr platform
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Deepak Sikri<deepak.sikri@st.com>
> + *
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <asm/system.h>
> +#include <mach/hardware.h>
> +
> +#define CPU_CLK		"cpu_clk"
> +
> +#ifdef CONFIG_ARCH_SPEAR13XX
> +#define MIN_CPU_FREQ	200000
> +#define MAX_CPU_FREQ	500000
> +
> +static u32 spear_cpu_freq[] = {
> +	200000, /* 200 MHZ */
> +	250000, /* 250 MHZ */
> +	332000, /* 332 MHZ */
> +	400000, /* 400 MHZ */
> +	500000, /* 500 MHZ */
> +};
> +#elif defined(CONFIG_ARCH_SPEAR6XX) || defined(CONFIG_ARCH_SPEAR3XX)
> +#define MIN_CPU_FREQ	166000
> +#define MAX_CPU_FREQ	332000
> +
> +static u32 spear_cpu_freq[] = {
> +	166000, /* 166 MHZ */
> +	266000, /* 266 MHZ */
> +	332000, /* 333 MHZ */
> +};
> +#endif
> +
> +static struct
> +	cpufreq_frequency_table spear_freq_tbl[ARRAY_SIZE(spear_cpu_freq) + 1];
> +static struct clk *cpu_clk;
> +
> +int spear_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, spear_freq_tbl);
> +}
> +
> +static unsigned int spear_cpufreq_get(unsigned int cpu)
> +{
> +	return cpu ? 0 : clk_get_rate(cpu_clk) / 1000;
> +}
> +
> +static int spear_cpufreq_target(struct cpufreq_policy *policy,
> +		unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	int index, ret;
> +	long newfreq;
> +
> +	if (policy->cpu != 0)
> +		return -EINVAL;
> +
> +	if (cpufreq_frequency_table_target(policy, spear_freq_tbl,
> +				target_freq, relation, &index))
> +		return -EINVAL;
> +
> +	freqs.old = spear_cpufreq_get(0);
> +	freqs.new = spear_cpu_freq[index];
> +	freqs.cpu = policy->cpu;
> +
> +	if (freqs.old == target_freq)
> +		return 0;
> +
> +	newfreq = clk_round_rate(cpu_clk, freqs.new * 1000);
> +	if (newfreq < 0) {
> +		pr_err("CPU Freq: clk_round_rate failed: %ld\n", newfreq);
> +		freqs.new = freqs.old;

Nitpick, you don't need to assign freqs.new here as you return 
immediately after.

> +		return newfreq;
> +	}
> +
> +	freqs.new = newfreq / 1000;
> +
> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +	/* Get current rate after clk_set_rate, for both success and failure */
> +	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
> +	if (ret) {
> +		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
> +		freqs.new = clk_get_rate(cpu_clk) / 1000;
> +	}
> +
> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	return 0;

Shouldn't this return 'ret' here in case clk_set_rate() failed?

Jamie
