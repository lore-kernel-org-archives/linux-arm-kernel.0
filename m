From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Jun 2012 12:45:47 +0200
Subject: [PATCH v3 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <1339746250-26650-2-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120615104547.GK26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +void __init armada_370_xp_timer_init(void)
> +{
> +	u32 u;
> +	struct device_node *np;
> +	unsigned int timer_clk;
> +	int ret;
> +	np = of_find_compatible_node(NULL, NULL, "marvell,timer");
> +	timer_base = of_iomap(np, 0);
> +	WARN_ON(!timer_base);
> +
> +	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
> +		/* The fixed 25MHz timer is available so let's use it */
> +		u = readl(timer_base + TIMER_CTRL_OFF);
> +		writel(u | TIMER0_25MHZ | TIMER1_25MHZ,
> +		       timer_base + TIMER_CTRL_OFF);
> +		timer_clk = 25000000;
> +	} else {
> +		u32 clk = 0;
> +		ret = of_property_read_u32(np, "clock-frequency", &clk);
> +		WARN_ON(!clk || ret < 0);
> +		u = readl(timer_base + TIMER_CTRL_OFF);
> +		writel(u & ~(TIMER0_25MHZ | TIMER1_25MHZ),
> +		       timer_base + TIMER_CTRL_OFF);
> +		timer_clk = clk / TIMER_DIVIDER;
> +	}

Hi Gregory

This all looks very similar to plat-orion/timer.c. The biggest
difference is the support for this 25Mhz timer mode. Maybe, so long as
this property is not used, the code will work for all orion platforms.
If so, we should drop all the armada_370_xp prefixes and just call it
orion.

I will try to test it on a Kirkwood today/tomorrow.

   Andrew
