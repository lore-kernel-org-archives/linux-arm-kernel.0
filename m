From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 17 Sep 2013 11:56:00 +0200
Subject: [PATCH] [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <1379077365-18458-1-git-send-email-mkl@pengutronix.de>
References: <1379077365-18458-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130917095600.GJ26819@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

On Fri, Sep 13, 2013 at 03:02:45PM +0200, Marc Kleine-Budde wrote:
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
> was lost. This leads to problems when programming clock events, resuling in
> e.g. a sleep(2) sleeping more than 3 seconds. The "+ 1" was added in the
> original code to fix a rounding problem in clockevent_delta2ns(), see
> http://permalink.gmane.org/gmane.linux.kernel/549744 for background
> information.
> 
> This patch fixes the problem by increasing the min_delta to "2" ticks.

Any reason to not do this:

--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -144,6 +144,9 @@ static void tc_mode(enum clock_event_mode m, struct
clock_event_device *d)
 
 static int tc_next_event(unsigned long delta, struct clock_event_device
*d)
 {
+       if (delta < d->min_delta_ticks)
+               delta = d->min_delta_ticks;
+
        __raw_writel(delta, tcaddr + ATMEL_TC_REG(2, RC));
 
        /* go go gadget! */

Then we can keep the same min_delta.


One more question why doing the correction here and not in the delta2ns
conversion function?

Regards

Ludovic

> 
> Cc: Marc Pignat <marc.pignat@hevs.ch>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v1:
> - Improved description. Thanks to Ronald Wahl.
> 
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
> 1.8.4.rc3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
