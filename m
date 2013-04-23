From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 23 Apr 2013 15:07:55 +0200
Subject: BUG: Re: [PATCH v2 3/3] clocksource: use
 clockevents_config_and_register() where possible
In-Reply-To: <1357991406-22778-4-git-send-email-shawn.guo@linaro.org>
References: <1357991406-22778-1-git-send-email-shawn.guo@linaro.org>
 <1357991406-22778-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <517687AB.1040309@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 01/12/2013 12:50 PM, Shawn Guo wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Andres Salomon <dilinger@queued.net>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

[...]

I just bisected a timer problem down to this commit.

> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 32cb929..8a61872 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -157,7 +157,6 @@ static struct tc_clkevt_device clkevt = {
>  		.name		= "tc_clkevt",
>  		.features	= CLOCK_EVT_FEAT_PERIODIC
>  					| CLOCK_EVT_FEAT_ONESHOT,
> -		.shift		= 32,
>  		/* Should be lower than at91rm9200's system timer */
>  		.rating		= 125,
>  		.set_next_event	= tc_next_event,
> @@ -196,13 +195,9 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
>  
>  	timer_clock = clk32k_divisor_idx;
>  
> -	clkevt.clkevt.mult = div_sc(32768, NSEC_PER_SEC, clkevt.clkevt.shift);
> -	clkevt.clkevt.max_delta_ns
> -		= clockevent_delta2ns(0xffff, &clkevt.clkevt);
> -	clkevt.clkevt.min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;
                                                                           ^^^^^^

With this patch, the "+ 1" gets lost, resulting in a different
"min_delta_ns".

good:
setup_clkevents: shift=32 mult=140737 min=30518 max=1999976422

bad:
setup_clkevents: shift=32 mult=140737 min=30517 max=1999976422

This leads to problems with schedule_delayed_work() with a delay of
"1". These worksqueues seem to be hanging for several seconds. I'll
send a RFC patch.

>  	clkevt.clkevt.cpumask = cpumask_of(0);
>  
> -	clockevents_register_device(&clkevt.clkevt);
> +	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
>  
>  	setup_irq(irq, &tc_irqaction);
>  }
> 

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/63f7b390/attachment.sig>
