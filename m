From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Oct 2013 08:49:17 +0530
Subject: [PATCH v2] ARM: davinci: convert to
 clockevents_config_and_register
In-Reply-To: <1381653390-22250-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CA+V-a8v58_ixJ5s5d+tsf19qszD2tLGe8465kfQBKivRV+vRoQ@mail.gmail.com>
 <1381653390-22250-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <525E05B5.8060801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 October 2013 02:06 PM, Uwe Kleine-K?nig wrote:
> clockevents_config_and_register is superior compared to setting
> shift/mult and {min,max}_delta_ns by hand.
> 
> Tested-by: Prabhakar Lad <prabhakar.csengg@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Prabhakar Lad wrote:
>> I have boot tested this patch on OMAP-L138 and tested the uptime
>> (with min ticks set to 1), should that be enough ?
> I don't know for sure, but I guess so. If you agree, here is an updated
> patch.
> 
> Best regards
> Uwe
> 
> 
>  arch/arm/mach-davinci/time.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
> index 7a55b5c..29a1a5d 100644
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
> @@ -397,14 +396,10 @@ void __init davinci_timer_init(void)
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
> +	clockevents_config_and_register(&clockevent_davinci,
> +		davinci_clock_tick_rate, 1, 0xfffffffe);

checkpatch --strict complains about alignment of line break. Fixed locally.

Thanks,
Sekhar
