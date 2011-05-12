From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 May 2011 13:23:39 -0700
Subject: [RFC PATCH v2 08/12] ARM: msm: use remapped PPI interrupts for
	local timer
In-Reply-To: <1304677997-26947-9-git-send-email-marc.zyngier@arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
	<1304677997-26947-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DCC41CB.3050802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/6/2011 3:33 AM, Marc Zyngier wrote:
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 38b95e9..f063860 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
> @@ -83,18 +85,7 @@ enum {
>  
>  
>  static struct msm_clock msm_clocks[];
> -static struct clock_event_device *local_clock_event;
> -
> -static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
> -{
> -	struct clock_event_device *evt = dev_id;
> -	if (smp_processor_id() != 0)
> -		evt = local_clock_event;
> -	if (evt->event_handler == NULL)
> -		return IRQ_HANDLED;

We just lost this important line. This prevents spurious interrupts from
crashing the system.

> -	evt->event_handler(evt);
> -	return IRQ_HANDLED;
> -}

I would prefer to keep the whole interrupt function because 1) MSM
doesn't have a local_timer_ack() to implement and 2) I want to put code
in here to stop the timer so that the timer doesn't wrap and cause
another interrupt (yes the patches haven't been sent yet).

> +static int local_timer_inited;
>  
>  static cycle_t msm_read_timer_count(struct clocksource *cs)
>  {
> @@ -140,6 +131,8 @@ static void msm_timer_set_mode(enum clock_event_mode mode,
>  		writel(TIMER_ENABLE_EN, clock->regbase + TIMER_ENABLE);
>  		break;
>  	case CLOCK_EVT_MODE_UNUSED:
> +		free_irq(evt->irq, evt);

This is crashing because evt->irq is never assigned in the case of
CPU0's timer.

> @@ -253,10 +235,13 @@ static void __init msm_timer_init(void)
>  			printk(KERN_ERR "msm_timer_init: clocksource_register "
>  			       "failed for %s\n", cs->name);
>  
> -		res = setup_irq(clock->irq.irq, &clock->irq);
> +		irq = gic_ppi_to_vppi(clock->irq);
> +		res = request_irq(irq, percpu_timer_handler,
> +				  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
> +				  ce->name, ce);

How about assigning evt->irq to gic_ppi_to_vppi() and then use that
instead of a local variable? That would fix the free_irq() bug up above.

Also, percpu_timer_handler() is only defined in arm/kernel/smp.c which
isn't going to be compiled in on non-SMP targets. This timer driver is
common to all MSMs so it needs to work with SMP and non-SMP.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
