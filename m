From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Mar 2016 17:13:05 +0100
Subject: [PATCH] clockevents/drivers/arm_global_timer: Fix erratum 740657
 workaround
In-Reply-To: <1459238917-2240-1-git-send-email-rabin.vincent@axis.com>
References: <1459238917-2240-1-git-send-email-rabin.vincent@axis.com>
Message-ID: <56FAA991.1080401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

On 29/03/16 09:08, Rabin Vincent wrote:
> From: Rabin Vincent <rabinv@axis.com>
> 
> According to the errata document for the Cortex A9 MPCore, the correct
> code sequence in the interrupt handler to workaround erratum 740657
> "Global Timer can send two interrupts for the same event" is:
> 
>  (1) Read the ICCIAR (Interrupt Acknowledge) register
>  (2) Modify the comparator value, to set it to a higher value
>  (3) Clear the Global Timer flag
>  (4) Clear the Pending Status information for Interrupt 27 (Global
>      Timer interrupt) in the Distributor of the Interrupt Controller.
>  (5) Write the ICCEOIR (End of Interrupt) register
> 
> (1) and (5) are done by the GIC driver and (2) and (3) are done by the
> Global Timer driver.  However, nobody does (4) and thus the workaround
> is inactive and the timer triggers many spurious interrupts:
> 
>  <idle>-0 [001] d.h2 99.850527: irq_handler_entry: irq=16 name=gt
>  <idle>-0 [001] d.h2 99.850538: irq_handler_exit: irq=16 ret=handled
>  <idle>-0 [001] d.H2 99.850540: irq_handler_entry: irq=16 name=gt
>  <idle>-0 [001] d.H2 99.850542: irq_handler_exit: irq=16 ret=unhandled
>  <idle>-0 [001] d.h2 99.987832: irq_handler_entry: irq=16 name=gt
>  <idle>-0 [001] dnh2 99.987845: irq_handler_exit: irq=16 ret=handled
>  <idle>-0 [001] dnh2 99.987848: irq_handler_entry: irq=16 name=gt
>  <idle>-0 [001] dnh2 99.987850: irq_handler_exit: irq=16 ret=unhandled
> 
> Make the Global Timer driver perform step (4) via the GIC driver with
> the help of the irq_set_irqchip_state() function, to prevent the
> spurious interrupts.
> 
> Signed-off-by: Rabin Vincent <rabinv@axis.com>
> ---
>  drivers/clocksource/arm_global_timer.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 9df0d16..b9d0f86 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -140,26 +140,31 @@ static int gt_clockevent_set_next_event(unsigned long evt,
>  static irqreturn_t gt_clockevent_interrupt(int irq, void *dev_id)
>  {
>  	struct clock_event_device *evt = dev_id;
> +	bool workaround = clockevent_state_oneshot(evt);
>  
>  	if (!(readl_relaxed(gt_base + GT_INT_STATUS) &
>  				GT_INT_STATUS_EVENT_FLAG))
>  		return IRQ_NONE;
>  
>  	/**
> -	 * ERRATA 740657( Global Timer can send 2 interrupts for
> +	 * ERRATA 740657 (Global Timer can send 2 interrupts for
>  	 * the same event in single-shot mode)
>  	 * Workaround:
> -	 *	Either disable single-shot mode.
> -	 *	Or
> -	 *	Modify the Interrupt Handler to avoid the
> -	 *	offending sequence. This is achieved by clearing
> -	 *	the Global Timer flag _after_ having incremented
> -	 *	the Comparator register	value to a higher value.
> +	 * - Read the ICCIAR (Interrupt Acknowledge) register
> +	 * - Modify the comparator value, to set it to a higher value
> +	 * - Clear the Global Timer flag
> +	 * - Clear the Pending Status information for Interrupt 27 (Global
> +	 *   Timer interrupt) in the Distributor of the Interrupt Controller.
> +	 * - Write the ICCEOIR (End of Interrupt) register
>  	 */
> -	if (clockevent_state_oneshot(evt))
> +	if (workaround)
>  		gt_compare_set(ULONG_MAX, 0);
>  
>  	writel_relaxed(GT_INT_STATUS_EVENT_FLAG, gt_base + GT_INT_STATUS);
> +
> +	if (workaround)
> +		irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, false);
> +

This raises a few questions:

- What if my timer is not connected to a controller that implements this
API? Something that is not a GIC, for example?

- How does it work when the GIC (with EOImode==1) performs a priority
drop (by writing to the EOI register) before calling into the timer
handler, and finishing the handling with a write to DIR?

- What are the comparative costs of taking a spurious (but nonetheless
harmless) interrupt vs poking the distributor (which is by no mean a
cheap operation)?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
