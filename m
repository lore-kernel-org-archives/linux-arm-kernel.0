From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 16 May 2011 22:31:25 +0800
Subject: [PATCH 12/13] clocksource: convert MXS timrotv2 to 32-bit down
	counting clocksource
In-Reply-To: <E1QJhSC-0000z6-H6@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhSC-0000z6-H6@rmk-PC.arm.linux.org.uk>
Message-ID: <20110516143124.GA24880@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 08:34:00AM +0100, Russell King - ARM Linux wrote:
> Convert the MXS timrotv2 32-bit down counting clocksource to the
> generic clocksource infrastructure.
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig          |    1 +
>  arch/arm/mach-mxs/timer.c |   20 +++++++-------------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cbc27fb..43f003a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -376,6 +376,7 @@ config ARCH_MXS
>  	select GENERIC_CLOCKEVENTS
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
> +	select CLKSRC_MMIO
>  	help
>  	  Support for Freescale MXS-based family of processors
>  
> diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
> index 13647f3..27bebf2 100644
> --- a/arch/arm/mach-mxs/timer.c
> +++ b/arch/arm/mach-mxs/timer.c
> @@ -101,11 +101,6 @@ static cycle_t timrotv1_get_cycles(struct clocksource *cs)
>  			& 0xffff0000) >> 16);
>  }
>  
> -static cycle_t timrotv2_get_cycles(struct clocksource *cs)
> -{
> -	return ~__raw_readl(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1));
> -}
> -
>  static int timrotv1_set_next_event(unsigned long evt,
>  					struct clock_event_device *dev)
>  {
> @@ -230,8 +225,8 @@ static int __init mxs_clockevent_init(struct clk *timer_clk)
>  static struct clocksource clocksource_mxs = {
>  	.name		= "mxs_timer",
>  	.rating		= 200,
> -	.read		= timrotv2_get_cycles,
> -	.mask		= CLOCKSOURCE_MASK(32),
> +	.read		= timrotv1_get_cycles,
> +	.mask		= CLOCKSOURCE_MASK(16),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> @@ -239,12 +234,11 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
>  {
>  	unsigned int c = clk_get_rate(timer_clk);
>  
> -	if (timrot_is_v1()) {
> -		clocksource_mxs.read = timrotv1_get_cycles;
> -		clocksource_mxs.mask = CLOCKSOURCE_MASK(16);
> -	}
> -
> -	clocksource_register_hz(&clocksource_mxs, c);
> +	if (timrot_is_v1())
> +		clocksource_register_hz(&clocksource_mxs, c);
> +	else
> +		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1)),
                                                                                   ^
Mismatched parenthesis

> +			"mxs_timer", c, 200, 32, clocksource_mmio_readl_down);
>  
>  	return 0;
>  }

-- 
Regards,
Shawn
