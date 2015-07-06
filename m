From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 6 Jul 2015 08:21:00 -0700
Subject: [PATCH 13/18] ARM/omap1/timer32: Migrate to new 'set-state'
 interface
In-Reply-To: <e4a4fce79b8edf36384d1b352028fdc3244bc043.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
 <e4a4fce79b8edf36384d1b352028fdc3244bc043.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <559A9CDC.1030908@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2015 3:54 AM, Viresh Kumar wrote:
> Migrate omap timer32 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

>   arch/arm/mach-omap1/timer32k.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 36bf174b3fac..0ae6c52a7d70 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -114,29 +114,28 @@ static int omap_32k_timer_set_next_event(unsigned long delta,
>   	return 0;
>   }
>
> -static void omap_32k_timer_set_mode(enum clock_event_mode mode,
> -				    struct clock_event_device *evt)
> +static int omap_32k_timer_shutdown(struct clock_event_device *evt)
>   {
>   	omap_32k_timer_stop();
> +	return 0;
> +}
>
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
> -		break;
> -	case CLOCK_EVT_MODE_ONESHOT:
> -	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -		break;
> -	case CLOCK_EVT_MODE_RESUME:
> -		break;
> -	}
> +static int omap_32k_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	omap_32k_timer_stop();
> +	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
> +	return 0;
>   }
>
>   static struct clock_event_device clockevent_32k_timer = {
> -	.name		= "32k-timer",
> -	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> -	.set_next_event	= omap_32k_timer_set_next_event,
> -	.set_mode	= omap_32k_timer_set_mode,
> +	.name			= "32k-timer",
> +	.features		= CLOCK_EVT_FEAT_PERIODIC |
> +				  CLOCK_EVT_FEAT_ONESHOT,
> +	.set_next_event		= omap_32k_timer_set_next_event,
> +	.set_state_shutdown	= omap_32k_timer_shutdown,
> +	.set_state_periodic	= omap_32k_timer_set_periodic,
> +	.set_state_oneshot	= omap_32k_timer_shutdown,
> +	.tick_resume		= omap_32k_timer_shutdown,
>   };
>
>   static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
>
