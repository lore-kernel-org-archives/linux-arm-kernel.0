From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 17 Jul 2012 15:02:09 -0400
Subject: [RFC PATCH 4/4] ARM: arch_timers: dynamic switch to physical
 timer and virtual timer offloading
In-Reply-To: <1341566422-20368-5-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
 <1341566422-20368-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <5005B6B1.8060804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/06/2012 05:20 AM, Marc Zyngier wrote:
> In an environment supporting virtualization (KVM), the virtual timer
> is reserved to the guests, while we rely on the physical timer for
> the host.
> 
> For this, we need to:
> - switch the host CPUs from the virtual timer to the physical one
> - provide an interrupt handler that is called by the virtual
>   timer's interrupt handler.
> 
> The new function arch_timer_switch_to_phys() performs this task.

It might be useful to CC the KVM mailing list to get their feedback.

I feel like it's hard to give useful feedback without the context of the
calling code. If the calling code is some kind of virtual clockchip,
then could you use the existing clock event distribution mechanism
rather than the custom hook?

[...]

> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index 4473f66..1bb632a 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -50,6 +50,8 @@ struct arch_timer_reg_ops {
>  
>  static struct arch_timer_reg_ops __percpu **arch_timer_reg_ops;
>  
> +static irq_handler_t arch_timer_virt_external_handler;
> +
>  /*
>   * Architected system timer support.
>   */
> @@ -204,6 +206,19 @@ static irqreturn_t arch_timer_handler(int irq, void *dev_id)
>  
>  static irqreturn_t arch_timer_virt_handler(int irq, void *dev_id)
>  {
> +	if (arch_timer_virt_external_handler) {
> +		unsigned long ctrl;
> +
> +		ctrl = arch_timer_virt_reg_read(ARCH_TIMER_REG_CTRL);
> +		if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
> +			ctrl |= ARCH_TIMER_CTRL_IT_MASK;
> +			arch_timer_virt_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
> +			return arch_timer_virt_external_handler(irq, NULL);
> +		}
> +
> +		return IRQ_NONE;
> +	}
> +
>  	return arch_timer_handler(irq, dev_id);
>  }

Perhaps you could avoid some code duplication by calling
arch_timer_handler at the beginning, stashing its return value, calling
the external hook if it's defined, then returning whichever return value
is appropriate.

>  
> @@ -509,3 +524,37 @@ int __init arch_timer_sched_clock_init(void)
>  	setup_sched_clock(arch_counter_get_cnt32, 32, arch_timer_rate);
>  	return 0;
>  }
> +
> +static void arch_timer_switch_cpu_to_phys(void *dummy)
> +{
> +	u32 cvall, cvalh, val;
> +
> +	pr_info("Switching CPU%d to physical timer\n", smp_processor_id());
> +
> +	asm volatile("mrrc p15, 3, %0, %1, c14	\n" /* Read CNTV_CVAL */
> +		     "mcrr p15, 2, %0, %1, c14	\n" /* Write CNTP_CVAL */
> +		     : "=r" (cvall), "=r" (cvalh));

I take it you don't use the easily readable helpers here because you're
afraid of losing a few ticks? That makes me wonder if the
mrc/mcr/mrrc/mcrr helpers could be expanded and improved to make them
usable under these circumstances.

> +
> +	isb();
> +	

(Trailing whitespace)

> +	val = arch_timer_virt_reg_read(ARCH_TIMER_REG_CTRL);
> +	arch_timer_virt_reg_write(ARCH_TIMER_REG_CTRL,
> +				  val & ~ARCH_TIMER_CTRL_ENABLE);
> +	arch_timer_phys_reg_write(ARCH_TIMER_REG_CTRL, val);
> +	*__this_cpu_ptr(arch_timer_reg_ops) = &arch_timer_phys_ops;
> +}
> +
> +void arch_timer_switch_to_phys(irq_handler_t handler)
> +{
> +	int cpu;
> +
> +	if (!arch_timer_use_virtual)
> +		return;

What will call this function? Won't it want to know the call failed?

> +
> +	for_each_online_cpu(cpu)
> +		smp_call_function_single(cpu, arch_timer_switch_cpu_to_phys,
> +					 NULL, 1);
> +
> +	arch_timer_use_virtual = false;
> +	arch_timer_virt_external_handler = handler;
> +}

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
