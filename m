From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 24 Feb 2016 17:15:08 +0100
Subject: [PATCH v2] clocksource: atmel-pit: register as a sched_clock
In-Reply-To: <1456329882-20709-1-git-send-email-romain.izard.pro@gmail.com>
References: <1456329882-20709-1-git-send-email-romain.izard.pro@gmail.com>
Message-ID: <20160224161508.GJ10681@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/2016 at 17:04:42 +0100, Romain Izard wrote :
> Register the counter of the Periodic Interval Timer as a possible source
> for sched_clock. Keep the timer running even if the related clockevent
> is disabled.
> 
> This provides a better precision than the jiffies-based default. The
> TCB clocksource does not work, as it is registered too late in the
> initialization sequence.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
> Changelog:
> v2:
> - Keep the tick counter updated when the clocksource is disabled
> - Ensure that sched_clock is a 64 bit counter
> 
>  drivers/clocksource/timer-atmel-pit.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
> index d911c5dca8f1..609892bbf9da 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
> +#include <linux/sched_clock.h>
>  
>  #define AT91_PIT_MR		0x00			/* Mode Register */
>  #define AT91_PIT_PITIEN			BIT(25)			/* Timer Interrupt Enable */
> @@ -44,7 +45,7 @@ struct pit_data {
>  
>  	void __iomem	*base;
>  	u32		cycle;
> -	u32		cnt;
> +	u64		cnt;
>  	unsigned int	irq;
>  	struct clk	*mck;
>  };
> @@ -77,7 +78,7 @@ static cycle_t read_pit_clk(struct clocksource *cs)
>  {
>  	struct pit_data *data = clksrc_to_pit_data(cs);
>  	unsigned long flags;
> -	u32 elapsed;
> +	u64 elapsed;
>  	u32 t;
>  
>  	raw_local_irq_save(flags);
> @@ -90,15 +91,6 @@ static cycle_t read_pit_clk(struct clocksource *cs)
>  	return elapsed;
>  }
>  
> -static int pit_clkevt_shutdown(struct clock_event_device *dev)
> -{
> -	struct pit_data *data = clkevt_to_pit_data(dev);
> -
> -	/* disable irq, leaving the clocksource active */
> -	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
> -	return 0;
> -}
> -

What about preempt-rt where really we want to disable the pit?

>  /*
>   * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
>   */
> @@ -156,15 +148,15 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
>  	WARN_ON_ONCE(!irqs_disabled());
>  
>  	/* The PIT interrupt may be disabled, and is shared */
> -	if (clockevent_state_periodic(&data->clkevt) &&
> -	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
> +	if (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS) {
>  		unsigned nr_ticks;
>  
>  		/* Get number of ticks performed before irq, and ack it */
>  		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
>  		do {
>  			data->cnt += data->cycle;
> -			data->clkevt.event_handler(&data->clkevt);
> +			if (clockevent_state_periodic(&data->clkevt))
> +				data->clkevt.event_handler(&data->clkevt);
>  			nr_ticks--;
>  		} while (nr_ticks);
>  
> @@ -174,6 +166,13 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> +static struct clocksource *pit_sched_clock;
> +
> +static u64 pit_sched_clock_read(void)
> +{
> +	return read_pit_clk(pit_sched_clock);
> +}
> +
>  /*
>   * Set up both clocksource and clockevent support.
>   */
> @@ -206,6 +205,9 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
>  	data->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>  	clocksource_register_hz(&data->clksrc, pit_rate);
>  
> +	pit_sched_clock = &data->clksrc;
> +	sched_clock_register(pit_sched_clock_read, bits, pit_rate);
> +
>  	/* Set up irq handler */
>  	ret = request_irq(data->irq, at91sam926x_pit_interrupt,
>  			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
> @@ -221,7 +223,6 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
>  	data->clkevt.rating = 100;
>  	data->clkevt.cpumask = cpumask_of(0);
>  
> -	data->clkevt.set_state_shutdown = pit_clkevt_shutdown;
>  	data->clkevt.set_state_periodic = pit_clkevt_set_periodic;
>  	data->clkevt.resume = at91sam926x_pit_resume;
>  	data->clkevt.suspend = at91sam926x_pit_suspend;
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
