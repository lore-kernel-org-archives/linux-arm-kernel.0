From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 18 Jul 2015 10:20:53 +0200 (CEST)
Subject: [PATCH 3/3] clocksource: atmel-pit: Remove irq handler when
 clock event is unused
In-Reply-To: <1437161608-26782-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1507181013050.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015, Alexandre Belloni wrote:
>  /*
> + * IRQ handler for the timer.
> + */
> +static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
> +{
> +	struct pit_data *data = dev_id;
> +
> +	/*
> +	 * irqs should be disabled here, but as the irq is shared they are only
> +	 * guaranteed to be off if the timer irq is registered first.

That's wrong. We run all handlers with interrupts disabled for about 5
years now.

> +	 */
> +	WARN_ON_ONCE(!irqs_disabled());


> +	/* The PIT interrupt may be disabled, and is shared */
> +	if (clockevent_state_periodic(&data->clkevt) &&
> +	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
> +		unsigned nr_ticks;
> +
> +		/* Get number of ticks performed before irq, and ack it */
> +		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
> +		do {
> +			data->cnt += data->cycle;
> +			data->clkevt.event_handler(&data->clkevt);
> +			nr_ticks--;
> +		} while (nr_ticks);

I don't think you need this loop. You have a proper clocksource
registered so the timekeeping code will handle the lost ticks nicely.


Thanks,

	tglx
