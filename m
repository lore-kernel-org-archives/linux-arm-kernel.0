From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 16 Jul 2012 17:12:31 -0400
Subject: [RFC PATCH 1/4] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <1341566422-20368-2-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
 <1341566422-20368-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <500483BF.704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/06/2012 05:20 AM, Marc Zyngier wrote:
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.
> 
> This patch enables the use of both the virtual timer, unless no
> interrupt is provided in the DT for it, in which case is falls
> back to the physical timer.

[...]

> @@ -44,7 +62,37 @@ static struct clock_event_device __percpu **arch_timer_evt;
>  #define ARCH_TIMER_REG_FREQ		1
>  #define ARCH_TIMER_REG_TVAL		2
>  
> -static void arch_timer_reg_write(int reg, u32 val)
> +static inline void arch_timer_reg_write(int reg, u32 val)

Will GCC fail to inline without the hint?

> +{
> +	(*__this_cpu_ptr(arch_timer_reg_ops))->reg_write(reg, val);
> +}
> +
> +static inline u32 arch_timer_reg_read(int reg)
> +{
> +	return (*__this_cpu_ptr(arch_timer_reg_ops))->reg_read(reg);
> +}
> +
> +static inline cycle_t arch_timer_counter_read(void)
> +{
> +	return (*__this_cpu_ptr(arch_timer_reg_ops))->counter_read();
> +}
> +
> +static u32 arch_timer_common_reg_read(int reg)
> +{
> +	u32 val;
> +
> +	switch (reg) {
> +	case ARCH_TIMER_REG_FREQ:
> +		asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return val;
> +}
> +
> +static void arch_timer_phys_reg_write(int reg, u32 val)
>  {
>  	switch (reg) {
>  	case ARCH_TIMER_REG_CTRL:

[...]

> @@ -329,10 +443,24 @@ int __init arch_timer_of_register(void)
>  	if (!of_property_read_u32(np, "clock-frequency", &freq))
>  		arch_timer_rate = freq;
>  
> -	arch_timer_ppi = irq_of_parse_and_map(np, 0);
> -	arch_timer_ppi2 = irq_of_parse_and_map(np, 1);
> -	pr_info("arch_timer: found %s irqs %d %d\n",
> -		np->name, arch_timer_ppi, arch_timer_ppi2);
> +	pr_info("arch_timer: found %s irqs ", np->name);
> +
> +	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++) {
> +		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
> +		if (!arch_timer_ppi[i]) {
> +			/*
> +			 * No interrupt provided for virtual timer,
> +			 * we'll have to stick to the physical timer.
> +			 */
> +			if (i == VIRT_PPI)
> +				arch_timer_use_virtual = false;
> +			

It seems like it would be more straightforward to set the
arch_timer_use_virtual variable outside of the loop, directly indexing
into the array of timer PPI's. On a trivial note you've also got
trailing whitespace here.

> +			continue;
> +		}
> +		pr_cont("%d ", arch_timer_ppi[i]);
> +	}
> +
> +	pr_cont("\n");
>  
>  	return arch_timer_register();
>  }
> @@ -345,6 +473,6 @@ int __init arch_timer_sched_clock_init(void)
>  	if (err)
>  		return err;
>  
> -	setup_sched_clock(arch_counter_get_cntvct32, 32, arch_timer_rate);
> +	setup_sched_clock(arch_counter_get_cnt32, 32, arch_timer_rate);
>  	return 0;
>  }

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
