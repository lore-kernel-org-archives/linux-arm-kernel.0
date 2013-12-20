From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 Dec 2013 19:35:22 +0800
Subject: [PATCH 1/2] ARM: AT91: PIT: Remove irq handler when clock event
 is unused
In-Reply-To: <1387536341-7452-2-git-send-email-bigeasy@linutronix.de>
References: <1387536341-7452-1-git-send-email-bigeasy@linutronix.de>
 <1387536341-7452-2-git-send-email-bigeasy@linutronix.de>
Message-ID: <BB6D8A98-942B-4B2E-A668-5D47DDC0DBF7@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACK
On Dec 20, 2013, at 6:45 PM, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Benedikt Spranger <b.spranger@linutronix.de>
> 
> Setup and remove the interrupt handler in clock event mode selection.
> This avoids calling the (shared) interrupt handler when the device is
> not used.
> 
> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: redo the patch with NR_IRQS_LEGACY which is probably required since
> commit 8fe82a55 ("ARM: at91: sparse irq support") which is included since v3.6.
> Patch based on what Sami Pietik?inen <Sami.Pietikainen@wapice.com> suggested].
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/arm/mach-at91/at91rm9200_time.c  | 1 +
> arch/arm/mach-at91/at91sam926x_time.c | 5 ++++-
> 2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index bc7b363..fd34d55 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -134,6 +134,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> 		break;
> 	case CLOCK_EVT_MODE_SHUTDOWN:
> 	case CLOCK_EVT_MODE_UNUSED:
> +		remove_irq(NR_IRQS_LEGACY + AT91_ID_SYS, &at91rm9200_timer_irq);

I?m a fan of copy and paste NR_IRQS_LEGACY + AT91_ID_SYS but ok

Best Regards,
J.
> 	case CLOCK_EVT_MODE_RESUME:
> 		irqmask = 0;
> 		break;
> diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
> index bb39232..1c4c487 100644
> --- a/arch/arm/mach-at91/at91sam926x_time.c
> +++ b/arch/arm/mach-at91/at91sam926x_time.c
> @@ -77,7 +77,7 @@ static struct clocksource pit_clk = {
> 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> };
> 
> -
> +static struct irqaction at91sam926x_pit_irq;
> /*
>  * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
>  */
> @@ -86,6 +86,8 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> {
> 	switch (mode) {
> 	case CLOCK_EVT_MODE_PERIODIC:
> +		/* Set up irq handler */
> +		setup_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
> 		/* update clocksource counter */
> 		pit_cnt += pit_cycle * PIT_PICNT(pit_read(AT91_PIT_PIVR));
> 		pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
> @@ -98,6 +100,7 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> 	case CLOCK_EVT_MODE_UNUSED:
> 		/* disable irq, leaving the clocksource active */
> 		pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
> +		remove_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
> 		break;
> 	case CLOCK_EVT_MODE_RESUME:
> 		break;
> -- 
> 1.8.5.1
> 
