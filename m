From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 16:40:00 +0200
Subject: [PATCH 31/41] clocksource: atmel-st: Migrate to new 'set-state'
 interface
In-Reply-To: <641cb53b1a3f8697340ae8a96e6734be44c7de47.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <641cb53b1a3f8697340ae8a96e6734be44c7de47.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <20150618144000.GH27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/2015 at 16:24:45 +0530, Viresh Kumar wrote :
> Migrate atmel-st driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I think that anyway I'm the only one booting a kernel from after 3.0 on
the rm9200. I'll test boot that when 4.3-rc1 is released.

> ---
>  drivers/clocksource/timer-atmel-st.c | 69 ++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> index 1692e17e096b..41b7b6dc1d0d 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -106,36 +106,47 @@ static struct clocksource clk32k = {
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> -static void
> -clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> +static void clkdev32k_disable_and_flush_irq(void)
>  {
>  	unsigned int val;
>  
>  	/* Disable and flush pending timer interrupts */
>  	regmap_write(regmap_st, AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
>  	regmap_read(regmap_st, AT91_ST_SR, &val);
> -
>  	last_crtr = read_CRTR();
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		/* PIT for periodic irqs; fixed rate of 1/HZ */
> -		irqmask = AT91_ST_PITS;
> -		regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
> -		break;
> -	case CLOCK_EVT_MODE_ONESHOT:
> -		/* ALM for oneshot irqs, set by next_event()
> -		 * before 32 seconds have passed
> -		 */
> -		irqmask = AT91_ST_ALMS;
> -		regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
> -		break;
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_RESUME:
> -		irqmask = 0;
> -		break;
> -	}
> +}
> +
> +static int clkevt32k_shutdown(struct clock_event_device *evt)
> +{
> +	clkdev32k_disable_and_flush_irq();
> +	irqmask = 0;
> +	regmap_write(regmap_st, AT91_ST_IER, irqmask);
> +	return 0;
> +}
> +
> +static int clkevt32k_set_oneshot(struct clock_event_device *dev)
> +{
> +	clkdev32k_disable_and_flush_irq();
> +
> +	/*
> +	 * ALM for oneshot irqs, set by next_event()
> +	 * before 32 seconds have passed.
> +	 */
> +	irqmask = AT91_ST_ALMS;
> +	regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
>  	regmap_write(regmap_st, AT91_ST_IER, irqmask);
> +	return 0;
> +}
> +
> +static int clkevt32k_set_periodic(struct clock_event_device *dev)
> +{
> +	clkdev32k_disable_and_flush_irq();
> +
> +	/* PIT for periodic irqs; fixed rate of 1/HZ */
> +	irqmask = AT91_ST_PITS;
> +	regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
> +	regmap_write(regmap_st, AT91_ST_IER, irqmask);
> +	return 0;
>  }
>  
>  static int
> @@ -170,11 +181,15 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  }
>  
>  static struct clock_event_device clkevt = {
> -	.name		= "at91_tick",
> -	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> -	.rating		= 150,
> -	.set_next_event	= clkevt32k_next_event,
> -	.set_mode	= clkevt32k_mode,
> +	.name			= "at91_tick",
> +	.features		= CLOCK_EVT_FEAT_PERIODIC |
> +				  CLOCK_EVT_FEAT_ONESHOT,
> +	.rating			= 150,
> +	.set_next_event		= clkevt32k_next_event,
> +	.set_state_shutdown	= clkevt32k_shutdown,
> +	.set_state_periodic	= clkevt32k_set_periodic,
> +	.set_state_oneshot	= clkevt32k_set_oneshot,
> +	.tick_resume		= clkevt32k_shutdown,
>  };
>  
>  /*
> -- 
> 2.4.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
