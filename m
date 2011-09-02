From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 2 Sep 2011 10:47:04 +0200 (CEST)
Subject: [RFC PATCH] genirq: set pending flag for disabled level interrupt
In-Reply-To: <1312820566-5842-1-git-send-email-adharmap@codeaurora.org>
References: <1312820566-5842-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1109021046240.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 8 Aug 2011, Abhijeet Dharmapurikar wrote:

> For hardware which has no wakeup source configuration facility, it needs
> its wakeup interrupts unmasked.
> If a wakeup edge interrupt triggered while the system was suspending the
> edge flow handler marks it pending and masks the interrupt. The kernel
> checks pending flag on wakeup interrupts and aborts suspend if one is set.
> 
> If a wakeup level interrupt triggered while the system was suspending the
> level flow handler masks the interrupt without setting the pending flag.
> Suspend won't be aborted. This is fine as it is expected that a level
> triggered interrupt will stay triggered and cause the system to resume.
> This however doesn't work on chips that don't have wakeup configuration
> in hardware because such chips need that interrupt unmasked for causing
> a resume.
> 
> Address that shortcoming by making the level flow handler set the pending
> flag if a wakeup interrupt controlled by such a chip is triggered while
> it is suspended.

And how is that supposed to work ?

check_irq_resend()
{
        if (irq_settings_is_level(desc))
                return;
...
 
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> ---
> If a level interrupt irq triggered right while the system was doing
> suspend_noirqs, the level flow handler will mask that interrupt and when the
> system went in to power collapse the interrupt controller did not wakeup the
> phone. The interrupt controller needs an interrupt triggered and masked to
> wakeup the phone - it does not have any wakeup interrupt configuration.
> The solution presented here is to mark that level triggered
> wakeup interrupt pending for chips with IRQCHIP_MASK_ON_SUSPEND. This will cause
> check_wakeup_irqs to abort suspend.
> Other solution would be to unmask such level interrupt in check_wakeup_irqs()
> but that seemed like I was expanding and complicating check_wakeup_irqs()
> duties - let me know if you think otherwise. 
> Note that we cannot unmask the interrupt in the level flow handler, that will
> cause an interrupt storm.
> 
>  include/linux/irq.h |    4 +++-
>  kernel/irq/chip.c   |   16 +++++++++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 87a06f3..0019385 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -332,7 +332,9 @@ struct irq_chip {
>   *
>   * IRQCHIP_SET_TYPE_MASKED:	Mask before calling chip.irq_set_type()
>   * IRQCHIP_EOI_IF_HANDLED:	Only issue irq_eoi() when irq was handled
> - * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path
> + * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path,
> + *				mark wakeup level interrupts pending
> + *				if suspended and triggered
>   * IRQCHIP_ONOFFLINE_ENABLED:	Only call irq_on/off_line callbacks
>   *				when irq enabled
>   */
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index d5a3009..0199871 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -339,9 +339,23 @@ handle_level_irq(unsigned int irq, struct irq_desc *desc)
>  	 * If its disabled or no action available
>  	 * keep it masked and get out of here
>  	 */
> -	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data)))
> +	if (unlikely(!desc->action))
>  		goto out_unlock;
>  
> +	if (irqd_irq_disabled(&desc->irq_data)) {
> +		/*
> +		 * Hardware which has no wakeup source configuration facility,
> +		 * needs its wakeup interrupts unmasked and triggered to cause
> +		 * a wakeup. Since the interrupt will be masked, mark it pending
> +		 * if it were suspended so that suspend will be aborted later.
> +		 */
> +		if (desc->istate & IRQS_SUSPENDED &&
> +		    irqd_is_wakeup_set(&desc->irq_data) &&
> +		    irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
> +			desc->istate |= IRQS_PENDING;
> +		goto out_unlock;
> +	}
> +
>  	handle_irq_event(desc);
>  
>  	if (!irqd_irq_disabled(&desc->irq_data) && !(desc->istate & IRQS_ONESHOT))
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> 
