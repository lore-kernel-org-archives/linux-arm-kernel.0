From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Jan 2015 15:04:00 +0100
Subject: [PATCH] clocksource: timer-atmel-pit: don't suspend/resume if
 unused
In-Reply-To: <1418911523-28492-1-git-send-email-nicolas.ferre@atmel.com>
References: <1418911523-28492-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <54B3D450.7050405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/12/2014 15:05, Nicolas Ferre a ?crit :
> From: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> Waiting for PIT to stop counting takes a long time:
>   1/(Master clock/prescaler/PIVR)
> = 1/(133 MHz     /16       /2^20)
> = 126 ms
> 
> Up to 126 ms if master clock is set to 133 MHz, skipping suspend/resume
> of the unused PIT device reduce (suspend time + resume time) from ~140 ms
> to ~17 ms.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> [nicolas.ferre at atmel.com: move to newer clocksource driver]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> Hi Sylvain,
> 
> I re-worked (and "Acked") your patch so it can be applied on the newer Mainline
> kernels. Beware, I changed the "subject line" as well. The PIT driver moved
> recently (3.18).
> 
> Daniel,
> Can you take this patch in your tree?

Hi Daniel,

Anything prevents this patch from being merged (aka ping ;-))?

Bye,


> Thanks, bye.
>   Nicolas.
> 
>  drivers/clocksource/timer-atmel-pit.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
> index b5b4d4585c9a..5408bc7c68d8 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -123,6 +123,10 @@ static void at91sam926x_pit_suspend(struct clock_event_device *cedev)
>  {
>  	struct pit_data *data = clkevt_to_pit_data(cedev);
>  
> +	/* Don't suspend PIT if unused */
> +	if (cedev->mode == CLOCK_EVT_MODE_UNUSED)
> +		return;
> +
>  	/* Disable timer */
>  	pit_write(data->base, AT91_PIT_MR, 0);
>  }
> @@ -145,6 +149,10 @@ static void at91sam926x_pit_resume(struct clock_event_device *cedev)
>  {
>  	struct pit_data *data = clkevt_to_pit_data(cedev);
>  
> +	/* Don't resume PIT if unused */
> +	if (cedev->mode == CLOCK_EVT_MODE_UNUSED)
> +		return;
> +
>  	at91sam926x_pit_reset(data);
>  }
>  
> 


-- 
Nicolas Ferre
