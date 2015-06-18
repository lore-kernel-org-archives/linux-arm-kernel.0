From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 18 Jun 2015 16:10:20 +0300
Subject: [PATCH 22/41] clocksource: sh_tmu: Migrate to new 'set-state'
 interface
In-Reply-To: <e3e76df10e37347e95579ce678d52792408d9c99.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <e3e76df10e37347e95579ce678d52792408d9c99.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <1464671.HykE1u2CLD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

Thank you for the patch.

On Thursday 18 June 2015 16:24:36 Viresh Kumar wrote:
> Migrate sh_tmu driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Cc: Magnus Damm <damm+renesas@opensource.se>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/clocksource/sh_tmu.c | 63 +++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index b6b8fa3cd211..43c98143f79a 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -240,7 +240,7 @@ static irqreturn_t sh_tmu_interrupt(int irq, void
> *dev_id) struct sh_tmu_channel *ch = dev_id;
> 
>  	/* disable or acknowledge interrupt */
> -	if (ch->ced.mode == CLOCK_EVT_MODE_ONESHOT)
> +	if (clockevent_state_oneshot(&ch->ced))
>  		sh_tmu_write(ch, TCR, TCR_TPSC_CLK4);
>  	else
>  		sh_tmu_write(ch, TCR, TCR_UNIE | TCR_TPSC_CLK4);
> @@ -358,42 +358,37 @@ static void sh_tmu_clock_event_start(struct
> sh_tmu_channel *ch, int periodic) }
>  }
> 
> -static void sh_tmu_clock_event_mode(enum clock_event_mode mode,
> -				    struct clock_event_device *ced)
> +static int sh_tmu_clock_event_shutdown(struct clock_event_device *ced)
> +{
> +	struct sh_tmu_channel *ch = ced_to_sh_tmu(ced);
> +
> +	sh_tmu_disable(ch);
> +	return 0;
> +}
> +
> +static int sh_tmu_clock_event_set_state(struct clock_event_device *ced,
> +					int periodic)
>  {
>  	struct sh_tmu_channel *ch = ced_to_sh_tmu(ced);
> -	int disabled = 0;
> 
>  	/* deal with old setting first */
> -	switch (ced->mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -	case CLOCK_EVT_MODE_ONESHOT:
> +	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
>  		sh_tmu_disable(ch);
> -		disabled = 1;
> -		break;
> -	default:
> -		break;
> -	}
> 
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		dev_info(&ch->tmu->pdev->dev,
> -			 "ch%u: used for periodic clock events\n", ch->index);
> -		sh_tmu_clock_event_start(ch, 1);
> -		break;
> -	case CLOCK_EVT_MODE_ONESHOT:
> -		dev_info(&ch->tmu->pdev->dev,
> -			 "ch%u: used for oneshot clock events\n", ch->index);
> -		sh_tmu_clock_event_start(ch, 0);
> -		break;
> -	case CLOCK_EVT_MODE_UNUSED:
> -		if (!disabled)
> -			sh_tmu_disable(ch);
> -		break;
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -	default:
> -		break;
> -	}
> +	dev_info(&ch->tmu->pdev->dev, "ch%u: used for %s clock events\n",
> +		 ch->index, periodic ? "periodic" : "oneshot");
> +	sh_tmu_clock_event_start(ch, periodic);
> +	return 0;
> +}
> +
> +static int sh_tmu_clock_event_set_oneshot(struct clock_event_device *ced)
> +{
> +	return sh_tmu_clock_event_set_state(ced, 0);
> +}
> +
> +static int sh_tmu_clock_event_set_periodic(struct clock_event_device *ced)
> +{
> +	return sh_tmu_clock_event_set_state(ced, 1);
>  }
> 
>  static int sh_tmu_clock_event_next(unsigned long delta,
> @@ -401,7 +396,7 @@ static int sh_tmu_clock_event_next(unsigned long delta,
>  {
>  	struct sh_tmu_channel *ch = ced_to_sh_tmu(ced);
> 
> -	BUG_ON(ced->mode != CLOCK_EVT_MODE_ONESHOT);
> +	BUG_ON(!clockevent_state_oneshot(ced));
> 
>  	/* program new delta value */
>  	sh_tmu_set_next(ch, delta, 0);
> @@ -430,7 +425,9 @@ static void sh_tmu_register_clockevent(struct
> sh_tmu_channel *ch, ced->rating = 200;
>  	ced->cpumask = cpu_possible_mask;
>  	ced->set_next_event = sh_tmu_clock_event_next;
> -	ced->set_mode = sh_tmu_clock_event_mode;
> +	ced->set_state_shutdown = sh_tmu_clock_event_shutdown;
> +	ced->set_state_periodic = sh_tmu_clock_event_set_periodic;
> +	ced->set_state_oneshot = sh_tmu_clock_event_set_oneshot;
>  	ced->suspend = sh_tmu_clock_event_suspend;
>  	ced->resume = sh_tmu_clock_event_resume;

-- 
Regards,

Laurent Pinchart
