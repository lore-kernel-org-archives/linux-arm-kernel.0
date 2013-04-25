From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 25 Apr 2013 16:21:58 +0200 (CEST)
Subject: RFC: [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
References: <517687AB.1040309@pengutronix.de>
 <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1304251618590.21884@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Marc Kleine-Budde wrote:
> The commit
> 
>     77cc982 clocksource: use clockevents_config_and_register() where possible
> 
> switches from manually calculating min_delta_ns (and others) and
> clockevents_register_device() to automatic calculation via
> clockevents_config_and_register(). During this conversation the "+ 1" in
> 
>     min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;
> 
> was lost. This leads to problems with schedule_delayed_work() with a delay of
> "1". Resulting in the work not scheduled in time.

Errm. How is schedule_delayed_work() related to this?

schedule_delayed_work() is jiffies based and has absolutely nothing to
do with clockevents.
 
> This patch fixes the problem by increasing the min_delta to "2" ticks.

This changelog sucks.

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/clocksource/tcb_clksrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 8a61872..7cf6dc7 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -197,7 +197,7 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
>  
>  	clkevt.clkevt.cpumask = cpumask_of(0);
>  
> -	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
> +	clockevents_config_and_register(&clkevt.clkevt, 32768, 2, 0xffff);
>  
>  	setup_irq(irq, &tc_irqaction);
>  }
> -- 
> 1.8.2.rc2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
