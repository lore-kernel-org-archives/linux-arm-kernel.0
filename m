From: stefan@agner.ch (Stefan Agner)
Date: Fri, 03 Jul 2015 10:10:12 +0200
Subject: [PATCH 39/41] clocksource: vf_pit: Migrate to new 'set-state'
 interface
In-Reply-To: <c9f030f57a10c1be00f8732ae2190fcc55248db5.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <c9f030f57a10c1be00f8732ae2190fcc55248db5.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <19859bd18fb69fa1f10c07de01b2259d@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-18 12:54, Viresh Kumar wrote:
> Migrate vf_pit driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Cc: Jingchang Lu <b35083@freescale.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/clocksource/vf_pit_timer.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/vf_pit_timer.c
> b/drivers/clocksource/vf_pit_timer.c
> index b45ac6229b57..f07ba9932171 100644
> --- a/drivers/clocksource/vf_pit_timer.c
> +++ b/drivers/clocksource/vf_pit_timer.c
> @@ -86,20 +86,16 @@ static int pit_set_next_event(unsigned long delta,
>  	return 0;
>  }
>  
> -static void pit_set_mode(enum clock_event_mode mode,
> -				struct clock_event_device *evt)
> +static int pit_shutdown(struct clock_event_device *evt)
>  {
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		pit_set_next_event(cycle_per_jiffy, evt);
> -		break;
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -	case CLOCK_EVT_MODE_UNUSED:
> -		pit_timer_disable();
> -		break;
> -	default:
> -		break;
> -	}
> +	pit_timer_disable();
> +	return 0;
> +}
> +
> +static int pit_set_periodic(struct clock_event_device *evt)
> +{
> +	pit_set_next_event(cycle_per_jiffy, evt);
> +	return 0;
>  }
>  
>  static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
> @@ -114,7 +110,7 @@ static irqreturn_t pit_timer_interrupt(int irq,
> void *dev_id)
>  	 * and start the counter again. So software need to disable the timer
>  	 * to stop the counter loop in ONESHOT mode.
>  	 */
> -	if (likely(evt->mode == CLOCK_EVT_MODE_ONESHOT))
> +	if (likely(clockevent_state_oneshot(evt)))
>  		pit_timer_disable();
>  
>  	evt->event_handler(evt);
> @@ -125,7 +121,8 @@ static irqreturn_t pit_timer_interrupt(int irq,
> void *dev_id)
>  static struct clock_event_device clockevent_pit = {
>  	.name		= "VF pit timer",
>  	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> -	.set_mode	= pit_set_mode,
> +	.set_state_shutdown = pit_shutdown,
> +	.set_state_periodic = pit_set_periodic,

I'm not really familiar with the interface, but given that we announce
the feature CLOCK_EVT_FEAT_ONESHOT shouldn't we add a set_state_oneshot
callback here?

--
Stefan

>  	.set_next_event	= pit_set_next_event,
>  	.rating		= 300,
>  };
