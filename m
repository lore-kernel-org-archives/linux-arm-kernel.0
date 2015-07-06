From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 6 Jul 2015 08:20:32 -0700
Subject: [PATCH 12/18] ARM/omap1/time: Migrate to new 'set-state' interface
In-Reply-To: <1680d1e2a6b9dd6b76e12c86bde5d84abcebe705.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
 <1680d1e2a6b9dd6b76e12c86bde5d84abcebe705.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <559A9CC0.5070808@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2015 3:54 AM, Viresh Kumar wrote:
> Migrate omap driver to the new 'set-state' interface provided by
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

>   arch/arm/mach-omap1/time.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
> index a7588cfd0286..524977a31a49 100644
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
> @@ -124,29 +124,26 @@ static int omap_mpu_set_next_event(unsigned long cycles,
>   	return 0;
>   }
>
> -static void omap_mpu_set_mode(enum clock_event_mode mode,
> -			      struct clock_event_device *evt)
> +static int omap_mpu_set_oneshot(struct clock_event_device *evt)
>   {
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		omap_mpu_set_autoreset(0);
> -		break;
> -	case CLOCK_EVT_MODE_ONESHOT:
> -		omap_mpu_timer_stop(0);
> -		omap_mpu_remove_autoreset(0);
> -		break;
> -	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -	case CLOCK_EVT_MODE_RESUME:
> -		break;
> -	}
> +	omap_mpu_timer_stop(0);
> +	omap_mpu_remove_autoreset(0);
> +	return 0;
> +}
> +
> +static int omap_mpu_set_periodic(struct clock_event_device *evt)
> +{
> +	omap_mpu_set_autoreset(0);
> +	return 0;
>   }
>
>   static struct clock_event_device clockevent_mpu_timer1 = {
> -	.name		= "mpu_timer1",
> -	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> -	.set_next_event	= omap_mpu_set_next_event,
> -	.set_mode	= omap_mpu_set_mode,
> +	.name			= "mpu_timer1",
> +	.features		= CLOCK_EVT_FEAT_PERIODIC |
> +				  CLOCK_EVT_FEAT_ONESHOT,
> +	.set_next_event		= omap_mpu_set_next_event,
> +	.set_state_periodic	= omap_mpu_set_periodic,
> +	.set_state_oneshot	= omap_mpu_set_oneshot,
>   };
>
>   static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
>
