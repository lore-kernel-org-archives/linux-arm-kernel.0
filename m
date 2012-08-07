From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Aug 2012 15:37:48 +0100
Subject: [PATCH] ARM: ep93xx: clockevent support
In-Reply-To: <1344338474.18237.6.camel@localhost>
References: <1344338474.18237.6.camel@localhost>
Message-ID: <20120807143748.GE18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 02:21:14PM +0300, Yan Burman wrote:
> +/*
> + * timer4 is a 40 Bit timer, separated in a 32bit and a 8 bit
> + * register, EP93XX_TIMER4_VALUE_LOW stores 32 bit word. The
> + * controlregister is in EP93XX_TIMER4_VALUE_HIGH
> + */
> +static cycle_t ep93xx_get_cycles(struct clocksource *unused)
> +{
> +	return __raw_readl(EP93XX_TIMER4_VALUE_LOW);
> +}
>  
> -	/* Enable lost jiffy timer.  */
> -	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
> -			EP93XX_TIMER4_VALUE_HIGH);
> +static struct clocksource clocksource_ep93xx = {
> +	.name		= "ep93xx_timer4",
> +	.rating		= 200,
> +	.read		= ep93xx_get_cycles,
> +	.mask		= 0xFFFFFFFF,
> +	.shift		= 20,
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};

Well done for porting this over to the clockevent/clocksource stuff.

Please have a look at the mmio clocksource helpers in
drivers/clocksource/mmio.c which I think you'll find will do everything
that you need without requiring all this code.
