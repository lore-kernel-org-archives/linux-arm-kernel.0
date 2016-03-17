From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Mar 2016 17:40:13 +0100
Subject: [PATCH v2 01/18] clocksource: sp804: Add support for non-32bit
 width counter
In-Reply-To: <1457519060-6038-2-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <56EADDED.3020606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2016 11:24 AM, Neil Armstrong wrote:
> Some vendor variants can implement norrower counter width, add
> an optional DT property changing the clocksource width and the
> clockevent mask, but keeping 32bit as default for legacy interface.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/clocksource/timer-sp804.c | 38 +++++++++++++++++++++++++++-----------
>   include/clocksource/timer-sp804.h | 11 ++++++-----
>   2 files changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index 5f45b9a..8acf524 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -80,7 +80,8 @@ void __init sp804_timer_disable(void __iomem *base)
>   void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
>   						     const char *name,
>   						     struct clk *clk,
> -						     int use_sched_clock)
> +						     int use_sched_clock,
> +						     unsigned width)
>   {
>   	long rate;
>
> @@ -93,6 +94,9 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
>   		}
>   	}
>
> +	if (!width || width > 32)
> +		width = 32;
> +

check comment below in the caller function.

>   	rate = sp804_get_clock_rate(clk);
>
>   	if (rate < 0)
> @@ -106,11 +110,11 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
>   		base + TIMER_CTRL);
>
>   	clocksource_mmio_init(base + TIMER_VALUE, name,
> -		rate, 200, 32, clocksource_mmio_readl_down);
> +		rate, 200, width, clocksource_mmio_readl_down);
>
>   	if (use_sched_clock) {
>   		sched_clock_base = base;
> -		sched_clock_register(sp804_read, 32, rate);
> +		sched_clock_register(sp804_read, width, rate);
>   	}
>   }
>
> @@ -186,7 +190,9 @@ static struct irqaction sp804_timer_irq = {
>   	.dev_id		= &sp804_clockevent,
>   };
>
> -void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
> +void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq,
> +				     struct clk *clk, const char *name,
> +				     unsigned width)
>   {
>   	struct clock_event_device *evt = &sp804_clockevent;
>   	long rate;
> @@ -199,6 +205,9 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
>   		return;
>   	}
>
> +	if (!width || width > 32)
> +		width = 32;

Check comment below in the caller function.

>   	rate = sp804_get_clock_rate(clk);
>   	if (rate < 0)
>   		return;
> @@ -212,7 +221,7 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
>   	writel(0, base + TIMER_CTRL);
>
>   	setup_irq(irq, &sp804_timer_irq);
> -	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
> +	clockevents_config_and_register(evt, rate, 0xf, GENMASK(width-1, 0));

This GENMASK is strange here. Nothing else than this ?

>   }
>
>   static void __init sp804_of_init(struct device_node *np)
> @@ -223,6 +232,7 @@ static void __init sp804_of_init(struct device_node *np)
>   	u32 irq_num = 0;
>   	struct clk *clk1, *clk2;
>   	const char *name = of_get_property(np, "compatible", NULL);
> +	u32 width = 32;
>
>   	base = of_iomap(np, 0);
>   	if (WARN_ON(!base))
> @@ -254,14 +264,19 @@ static void __init sp804_of_init(struct device_node *np)
>   	if (irq <= 0)
>   		goto err;
>
> +	/* Some vendor variants can have a different counter width */
> +	of_property_read_u32(np, "arm,timer-width", &width);
> +

Better to do the sanity check when the value is read.

Here, you can default to 32 if the width is 0 instead of initializing to 
32 then read the property and call __sp804_clockevents_init which in 
turn check zero or more and set it to 32 again.

>   	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
>   	if (irq_num == 2) {
> -		__sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
> -		__sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
> +		__sp804_clockevents_init(base + TIMER_2_BASE, irq,
> +					 clk2, name, width);
> +		__sp804_clocksource_and_sched_clock_init(base, name,
> +							 clk1, 1, width);
>   	} else {
> -		__sp804_clockevents_init(base, irq, clk1 , name);
> +		__sp804_clockevents_init(base, irq, clk1, name, width);
>   		__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
> -							 name, clk2, 1);
> +							 name, clk2, 1, width);
>   	}
>   	initialized = true;
>
> @@ -293,13 +308,14 @@ static void __init integrator_cp_of_init(struct device_node *np)
>   		goto err;
>
>   	if (!init_count)
> -		__sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
> +		__sp804_clocksource_and_sched_clock_init(base, name,
> +							 clk, 0, 32);
>   	else {
>   		irq = irq_of_parse_and_map(np, 0);
>   		if (irq <= 0)
>   			goto err;
>
> -		__sp804_clockevents_init(base, irq, clk, name);
> +		__sp804_clockevents_init(base, irq, clk, name, 32);
>   	}
>
>   	init_count++;
> diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
> index 1f8a1ca..ad71fcb 100644
> --- a/include/clocksource/timer-sp804.h
> +++ b/include/clocksource/timer-sp804.h
> @@ -4,25 +4,26 @@
>   struct clk;
>
>   void __sp804_clocksource_and_sched_clock_init(void __iomem *,
> -					      const char *, struct clk *, int);
> +					      const char *, struct clk *,
> +					      int, unsigned);
>   void __sp804_clockevents_init(void __iomem *, unsigned int,
> -			      struct clk *, const char *);
> +			      struct clk *, const char *, unsigned);
>   void sp804_timer_disable(void __iomem *);
>
>   static inline void sp804_clocksource_init(void __iomem *base, const char *name)
>   {
> -	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
> +	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0, 32);
>   }
>
>   static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
>   							  const char *name)
>   {
> -	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
> +	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1, 32);
>   }
>
>   static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
>   {
> -	__sp804_clockevents_init(base, irq, NULL, name);
> +	__sp804_clockevents_init(base, irq, NULL, name, 32);
>
>   }
>   #endif
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
