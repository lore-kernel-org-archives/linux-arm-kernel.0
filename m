From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 12 Oct 2013 21:52:02 +0530
Subject: [PATCH] ARM: davinci: convert to clockevents_config_and_register
In-Reply-To: <1380060159-12008-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380060159-12008-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5259772A.3050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 September 2013 03:32 AM, Uwe Kleine-K?nig wrote:
> clockevents_config_and_register is superior compared to setting
> shift/mult and {min,max}_delta_ns by hand.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I wonder where the 50 us limit comes from. This is not a hardware limit,
> is it?
> 
> Best regards
> Uwe
> 
>  arch/arm/mach-davinci/time.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
> index 7a55b5c..627bf8b 100644
> --- a/arch/arm/mach-davinci/time.c
> +++ b/arch/arm/mach-davinci/time.c
> @@ -331,7 +331,6 @@ static void davinci_set_mode(enum clock_event_mode mode,
>  
>  static struct clock_event_device clockevent_davinci = {
>  	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> -	.shift		= 32,
>  	.set_next_event	= davinci_set_next_event,
>  	.set_mode	= davinci_set_mode,
>  };
> @@ -397,14 +396,11 @@ void __init davinci_timer_init(void)
>  
>  	/* setup clockevent */
>  	clockevent_davinci.name = id_to_name[timers[TID_CLOCKEVENT].id];
> -	clockevent_davinci.mult = div_sc(davinci_clock_tick_rate, NSEC_PER_SEC,
> -					 clockevent_davinci.shift);
> -	clockevent_davinci.max_delta_ns =
> -		clockevent_delta2ns(0xfffffffe, &clockevent_davinci);
> -	clockevent_davinci.min_delta_ns = 50000; /* 50 usec */
>  
>  	clockevent_davinci.cpumask = cpumask_of(0);
> -	clockevents_register_device(&clockevent_davinci);
> +	/* min tick corresponds to 50 usec assuming a 24 MHz clock */
> +	clockevents_config_and_register(&clockevent_davinci,
> +		davinci_clock_tick_rate, 1200, 0xfffffffe);

Min ticks can be set to 1, IMO. I think the 50usec limit used earlier
should have actually been 50ns assuming a 24MHz clock.

Prabhakar,

Can you please test this patch on a DaVinci platform you have with 1200
replaced with 1. I currently do not have access to a board.

Thanks,
Sekhar
