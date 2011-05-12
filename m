From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 May 2011 10:59:52 -0700
Subject: [RFC PATCH v2 02/12] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <1304677997-26947-3-git-send-email-marc.zyngier@arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
	<1304677997-26947-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DCC2018.3030007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/6/2011 3:33 AM, Marc Zyngier wrote:
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index f29b8a2..30201a0 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -452,6 +452,18 @@ asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
>  	set_irq_regs(old_regs);
>  }
>  
> +irqreturn_t percpu_timer_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	if (local_timer_ack()) {
> +		evt->event_handler(evt);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +

MSM needs this second patch again. I suppose it's not titled correctly?
I'd rather not have MSM use this function at all though. Perhaps its
better to just hide this in smp_twd.c along with local_timer_ack()?

What is going on with mach-exynos4/mct.c? Their local_timer_ack() is a
return 0 and they do a setup_irq() in their local_timer_setup() path.
That all seems very broken and I would be surprised if hotplug and local
timer stats worked on that system.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
