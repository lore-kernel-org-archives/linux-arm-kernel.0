From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 May 2013 12:08:20 +0200
Subject: [PATCH 1/1] ARM: at91: rm9200 fix time support
In-Reply-To: <20130505202025.GE24282@game.jcrosoft.org>
References: <20130505202025.GE24282@game.jcrosoft.org>
Message-ID: <51935E94.2020506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2013 22:20, Jean-Christophe PLAGNIOL-VILLARD :
> since commit 838a2ae80a6ab52139fb1bf0a93ea8c5eff94488
> Author: Shawn Guo <shawn.guo@linaro.org>
> Date:   Sat Jan 12 11:50:05 2013 +0000
>
> ARM: use clockevents_config_and_register() where possible
>
> The timer is wrongly configured and result in since crash
> so revert it on rm9200 timer

What is strange is that this function is widely used now. So before 
reverting its use for rm9200, we may have to find why it is not working 
properly...

Best regards,

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Greg,
>
> 	if possible apply it to v3.8 and v3.9 stable
>
> 	I'll apply it for mainline
>
> Best Regards,
> J.
>   arch/arm/mach-at91/at91rm9200_time.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index 2acdff4..180b302 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -174,6 +174,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>   static struct clock_event_device clkevt = {
>   	.name		= "at91_tick",
>   	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.shift		= 32,
>   	.rating		= 150,
>   	.set_next_event	= clkevt32k_next_event,
>   	.set_mode	= clkevt32k_mode,
> @@ -264,9 +265,11 @@ void __init at91rm9200_timer_init(void)
>   	at91_st_write(AT91_ST_RTMR, 1);
>
>   	/* Setup timer clockevent, with minimum of two ticks (important!!) */
> +	clkevt.mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift);
> +	clkevt.max_delta_ns = clockevent_delta2ns(AT91_ST_ALMV, &clkevt);
> +	clkevt.min_delta_ns = clockevent_delta2ns(2, &clkevt) + 1;
>   	clkevt.cpumask = cpumask_of(0);
> -	clockevents_config_and_register(&clkevt, AT91_SLOW_CLOCK,
> -					2, AT91_ST_ALMV);
> +	clockevents_register_device(&clkevt);
>
>   	/* register clocksource */
>   	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
>


-- 
Nicolas Ferre
