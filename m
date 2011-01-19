From: deepak.sikri@st.com (deepaksi)
Date: Wed, 19 Jan 2011 07:43:05 +0530
Subject: [PATCH V4 38/62] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <20110119002046.GC2209@gallagher>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<0f47958e70aa830f749fe1a5e8c03b853740d701.1295333959.git.viresh.kumar@st.com>
	<20110119002046.GC2209@gallagher>
Message-ID: <4D3648B1.4030807@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 1/19/2011 5:50 AM, Jamie Iles wrote:
> Hi,
>
> On Tue, Jan 18, 2011 at 12:42:05PM +0530, Viresh Kumar wrote:
>   
>> From: Deepak Sikri <deepak.sikri@st.com>
>>
>> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
>> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
>>     
> [...]
>   
>> diff --git a/arch/arm/plat-spear/cpufreq.c b/arch/arm/plat-spear/cpufreq.c
>> new file mode 100644
>> index 0000000..9384d65
>> --- /dev/null
>> +++ b/arch/arm/plat-spear/cpufreq.c
>> @@ -0,0 +1,159 @@
>> +/*
>> + * arch/arm/plat-spear/cpufreq.c
>> + *
>> + * CPU Frequency Scaling for SPEAr platform
>> + *
>> + * Copyright (C) 2010 ST Microelectronics
>> + * Deepak Sikri<deepak.sikri@st.com>
>> + *
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sched.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/delay.h>
>> +#include <linux/init.h>
>> +#include <linux/err.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <asm/system.h>
>> +#include <mach/hardware.h>
>> +
>> +#define CPU_CLK		"cpu_clk"
>> +
>> +#ifdef CONFIG_ARCH_SPEAR13XX
>> +#define MIN_CPU_FREQ	200000
>> +#define MAX_CPU_FREQ	500000
>> +
>> +static u32 spear_cpu_freq[] = {
>> +	200000,	/* 200 MHZ */
>> +	250000,	/* 250 MHZ */
>> +	332000,	/* 332 MHZ */
>> +	400000,	/* 400 MHZ */
>> +	500000,	/* 500 MHZ */
>> +};
>> +#elif defined(CONFIG_ARCH_SPEAR6XX) || defined(CONFIG_ARCH_SPEAR3XX)
>> +#define MIN_CPU_FREQ	166000
>> +#define MAX_CPU_FREQ	332000
>> +
>> +static u32 spear_cpu_freq[] = {
>> +	166000,	/* 166 MHZ */
>> +	266000,	/* 266 MHZ */
>> +	332000,	/* 333 MHZ */
>> +};
>> +#endif
>> +
>> +static struct
>> +	cpufreq_frequency_table spear_freq_tbl[ARRAY_SIZE(spear_cpu_freq) + 1];
>> +static struct clk *cpu_clk;
>> +
>> +int spear_cpufreq_verify(struct cpufreq_policy *policy)
>> +{
>> +	return cpufreq_frequency_table_verify(policy, spear_freq_tbl);
>> +}
>> +
>> +unsigned int spear_cpufreq_get(unsigned int cpu)
>> +{
>> +	unsigned long rate;
>> +
>> +	if (cpu)
>> +		return 0;
>> +
>> +	rate = clk_get_rate(cpu_clk) / 1000;
>> +	return rate;
>> +}
>>     
> Can this be simplified to:
>
> 	unsigned int spear_cpufreq_get(unsigned int cpu)
> 	{
> 		return cpu ? 0 : clk_get_rate(cpu_clk) / 1000;
> 	}
>
> ?  It could also be made static.
>
>   
Agreed, we will update this in the next patch
>> +
>> +static int spear_cpufreq_target(struct cpufreq_policy *policy,
>> +		unsigned int target_freq, unsigned int relation)
>> +{
>> +	struct cpufreq_freqs freqs;
>> +	int ret = 0;
>> +	int index;
>> +
>> +	if (policy->cpu != 0)
>> +		return -EINVAL;
>> +
>> +	if (cpufreq_frequency_table_target(policy, spear_freq_tbl,
>> +				target_freq, relation, &index))
>> +		return -EINVAL;
>> +
>> +	freqs.old = spear_cpufreq_get(0);
>> +	freqs.new = spear_cpu_freq[index];
>> +	freqs.cpu = policy->cpu;
>> +
>> +	if (freqs.old == target_freq)
>> +		return 0;
>> +
>> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> +	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
>> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>>     
> If clk_set_rate() failed then do you need to do freqs.new = 
> clk_get_rate(cpu_clk) before doing the CPUFREQ_POSTCHANGE to make sure you 
> don't notify the wrong frequency?
>
>   
I do have a point over here. In few of the drivers where the the pre
notifiers have been added, the operations have been stopped (assume a
network driver where we stalled a dma operation), and then we set the
clock rate, followed by a post notifier where driver resumes it operations.

Now lets take the case, when the clock set rate fails (  Most failure
could only be when the driver is unable to find any clock rate which is
less then/equal to requested rate) .
The post transition notifier should happen so as to allow the driver to
resume its functions. If there are no clock rate changes because of set
rate failures, the driver would be aware of that by using calls such as
clk_get_rate, and would carry forward it's operations accordingly.

How do you suggest to go about it ?
>> +
>> +	return ret;
>> +}
>> +
>> +static int spear_cpufreq_init(struct cpufreq_policy *policy)
>> +{
>> +	int result;
>> +	int i = 0;
>> +
>> +	if (policy->cpu != 0)
>> +		return -EINVAL;
>> +
>> +	cpu_clk = clk_get(NULL, CPU_CLK);
>> +	if (IS_ERR(cpu_clk))
>> +		return PTR_ERR(cpu_clk);
>> +
>> +	policy->cpuinfo.min_freq = MIN_CPU_FREQ;
>> +	policy->cpuinfo.max_freq = MAX_CPU_FREQ;
>> +	policy->cur = policy->min = policy->max = spear_cpufreq_get(0);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(spear_cpu_freq); i++) {
>> +		spear_freq_tbl[i].index = i;
>> +		spear_freq_tbl[i].frequency = spear_cpu_freq[i];
>> +	}
>> +
>> +	spear_freq_tbl[i].index = i;
>> +	spear_freq_tbl[i].frequency = CPUFREQ_TABLE_END;
>> +	result = cpufreq_frequency_table_cpuinfo(policy, spear_freq_tbl);
>> +	if (!result)
>> +		cpufreq_frequency_table_get_attr(spear_freq_tbl,
>> +				policy->cpu);
>>     
> result doesn't appear to be used to do anything other than check the return of 
> cpufreq_frequency_table_cpuinfo() so could tou just eliminate that local 
> variable?
>
>   
We will do it
>> +
>> +	policy->cpuinfo.transition_latency = 300*1000; /*250 uS*/
>>     
> The comment doesn't appear to match the value here.
>
>   
Will update the comment
>> +
>> +	return 0;
>> +}
>> +
>> +static int spear_cpufreq_exit(struct cpufreq_policy *policy)
>> +{
>> +	clk_put(cpu_clk);
>> +	return 0;
>> +}
>> +
>> +static struct freq_attr *spear_cpufreq_attr[] = {
>> +	 &cpufreq_freq_attr_scaling_available_freqs,
>> +	 NULL,
>> +};
>> +
>> +static struct cpufreq_driver spear_driver = {
>> +	.flags		= CPUFREQ_STICKY,
>> +	.verify		= spear_cpufreq_verify,
>> +	.target		= spear_cpufreq_target,
>> +	.get		= spear_cpufreq_get,
>> +	.init		= spear_cpufreq_init,
>> +	.exit		= spear_cpufreq_exit,
>> +	.name		= "spear_cpufreq",
>> +	.attr		= spear_cpufreq_attr,
>> +};
>> +
>> +static int __init spear_cpufreq_register(void)
>> +{
>> +	return cpufreq_register_driver(&spear_driver);
>> +}
>> +
>> +arch_initcall(spear_cpufreq_register);
>>     
> Jamie
> .
>
>   
regards
Deepak
