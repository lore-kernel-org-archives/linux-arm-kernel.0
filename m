From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 22:49:06 +0100
Subject: [PATCH 4/7] clocksource: time-armada-370-xp converted to clk
 framework
In-Reply-To: <1353014906-31566-5-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
 <1353014906-31566-5-git-send-email-andrew@lunn.ch>
Message-ID: <20121115224906.5a5eb7cf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

Title should be "clocksource: convert time-armada-370-xp to the clk
framework".

On Thu, 15 Nov 2012 22:28:23 +0100, Andrew Lunn wrote:

> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 4674f94..a4605fd 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/kernel.h>
> +#include <linux/clk.h>
>  #include <linux/timer.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> @@ -167,7 +168,6 @@ void __init armada_370_xp_timer_init(void)
>  	u32 u;
>  	struct device_node *np;
>  	unsigned int timer_clk;
> -	int ret;
>  	np = of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-timer");
>  	timer_base = of_iomap(np, 0);
>  	WARN_ON(!timer_base);
> @@ -179,13 +179,14 @@ void __init armada_370_xp_timer_init(void)
>  		       timer_base + TIMER_CTRL_OFF);
>  		timer_clk = 25000000;
>  	} else {
> -		u32 clk = 0;
> -		ret = of_property_read_u32(np, "clock-frequency", &clk);
> -		WARN_ON(!clk || ret < 0);
> +		unsigned long rate = 0;
> +		struct clk *clk = of_clk_get(np, 0);
> +		WARN_ON(IS_ERR(clk));
> +		rate =  clk_get_rate(clk);
>  		u = readl(timer_base + TIMER_CTRL_OFF);
>  		writel(u & ~(TIMER0_25MHZ | TIMER1_25MHZ),
>  		       timer_base + TIMER_CTRL_OFF);
> -		timer_clk = clk / TIMER_DIVIDER;
> +		timer_clk = rate / TIMER_DIVIDER;
>  	}
>  
>  	/* We use timer 0 as clocksource, and timer 1 for

This change requires an update to
Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt. The
previous clock-frequency property was not documented, but maybe the new
clocks property should.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
