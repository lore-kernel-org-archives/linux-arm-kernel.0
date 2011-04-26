From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Apr 2011 09:23:52 +0200
Subject: [patch 13/16] arm plat-mxc: Use clocksource based sched_clock
In-Reply-To: <20110423205132.860828603@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.860828603@linutronix.de>
Message-ID: <20110426072351.GK14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2011 at 08:54:53PM -0000, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/plat-mxc/time.c |   28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> 
> Index: linux-2.6-tip/arch/arm/plat-mxc/time.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/plat-mxc/time.c
> +++ linux-2.6-tip/arch/arm/plat-mxc/time.c
> @@ -27,7 +27,6 @@
>  #include <linux/clk.h>
>  
>  #include <mach/hardware.h>
> -#include <asm/sched_clock.h>
>  #include <asm/mach/time.h>
>  #include <mach/common.h>
>  
> @@ -106,17 +105,12 @@ static void gpt_irq_acknowledge(void)
>  		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
>  }
>  
> -static cycle_t dummy_get_cycles(struct clocksource *cs)
> -{
> -	return 0;
> -}
> -
> -static cycle_t mx1_2_get_cycles(struct clocksource *cs)
> +static cycle_t notrace mx1_2_get_cycles(struct clocksource *cs)
>  {
>  	return __raw_readl(timer_base + MX1_2_TCN);
>  }
>  
> -static cycle_t v2_get_cycles(struct clocksource *cs)
> +static cycle_t notrace v2_get_cycles(struct clocksource *cs)
>  {
>  	return __raw_readl(timer_base + V2_TCN);
>  }
> @@ -124,25 +118,10 @@ static cycle_t v2_get_cycles(struct cloc
>  static struct clocksource clocksource_mxc = {
>  	.name 		= "mxc_timer1",
>  	.rating		= 200,
> -	.read		= dummy_get_cycles,
>  	.mask		= CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SCHED_CLOCK,
>  };
>  
> -static DEFINE_CLOCK_DATA(cd);
> -unsigned long long notrace sched_clock(void)
> -{
> -	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
> -
> -	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
> -}
> -
> -static void notrace mxc_update_sched_clock(void)
> -{
> -	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
> -	update_sched_clock(&cd, cyc, (u32)~0);
> -}
> -
>  static int __init mxc_clocksource_init(struct clk *timer_clk)
>  {
>  	unsigned int c = clk_get_rate(timer_clk);
> @@ -152,7 +131,6 @@ static int __init mxc_clocksource_init(s
>  	else
>  		clocksource_mxc.read = mx1_2_get_cycles;
>  
> -	init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
>  	clocksource_register_hz(&clocksource_mxc, c);
>  
>  	return 0;
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
