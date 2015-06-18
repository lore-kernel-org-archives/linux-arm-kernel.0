From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 16:28:01 +0200
Subject: [PATCH 30/41] clocksource: atmel: Migrate to new 'set-state'
 interface
In-Reply-To: <f6fdf1f810de1cd9ad4d9e3d45f7c5065156c79e.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <f6fdf1f810de1cd9ad4d9e3d45f7c5065156c79e.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <20150618142801.GG27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/2015 at 16:24:44 +0530, Viresh Kumar wrote :
> Migrate atmel driver to the new 'set-state' interface provided by
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

> ---
>  drivers/clocksource/timer-atmel-pit.c | 41 +++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
> index c0304ff608b0..58753223585b 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -90,33 +90,27 @@ static cycle_t read_pit_clk(struct clocksource *cs)
>  	return elapsed;
>  }
>  
> +static int pit_clkevt_shutdown(struct clock_event_device *dev)
> +{
> +	struct pit_data *data = clkevt_to_pit_data(dev);
> +
> +	/* disable irq, leaving the clocksource active */
> +	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
> +	return 0;
> +}
> +
>  /*
>   * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
>   */
> -static void
> -pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> +static int pit_clkevt_set_periodic(struct clock_event_device *dev)
>  {
>  	struct pit_data *data = clkevt_to_pit_data(dev);
>  
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		/* update clocksource counter */
> -		data->cnt += data->cycle * PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
> -		pit_write(data->base, AT91_PIT_MR,
> -			  (data->cycle - 1) | AT91_PIT_PITEN | AT91_PIT_PITIEN);
> -		break;
> -	case CLOCK_EVT_MODE_ONESHOT:
> -		BUG();
> -		/* FALLTHROUGH */
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -	case CLOCK_EVT_MODE_UNUSED:
> -		/* disable irq, leaving the clocksource active */
> -		pit_write(data->base, AT91_PIT_MR,
> -			  (data->cycle - 1) | AT91_PIT_PITEN);
> -		break;
> -	case CLOCK_EVT_MODE_RESUME:
> -		break;
> -	}
> +	/* update clocksource counter */
> +	data->cnt += data->cycle * PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
> +	pit_write(data->base, AT91_PIT_MR,
> +		  (data->cycle - 1) | AT91_PIT_PITEN | AT91_PIT_PITIEN);
> +	return 0;
>  }
>  
>  static void at91sam926x_pit_suspend(struct clock_event_device *cedev)
> @@ -162,7 +156,7 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
>  	WARN_ON_ONCE(!irqs_disabled());
>  
>  	/* The PIT interrupt may be disabled, and is shared */
> -	if ((data->clkevt.mode == CLOCK_EVT_MODE_PERIODIC) &&
> +	if (clockevent_state_periodic(&data->clkevt) &&
>  	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
>  		unsigned nr_ticks;
>  
> @@ -227,7 +221,8 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
>  	data->clkevt.rating = 100;
>  	data->clkevt.cpumask = cpumask_of(0);
>  
> -	data->clkevt.set_mode = pit_clkevt_mode;
> +	data->clkevt.set_state_shutdown = pit_clkevt_shutdown;
> +	data->clkevt.set_state_periodic = pit_clkevt_set_periodic;
>  	data->clkevt.resume = at91sam926x_pit_resume;
>  	data->clkevt.suspend = at91sam926x_pit_suspend;
>  	clockevents_register_device(&data->clkevt);
> -- 
> 2.4.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
