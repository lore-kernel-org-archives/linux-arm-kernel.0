From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Nov 2015 15:16:48 +0100
Subject: [PATCH] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <5645D5A0.1000502@sigmadesigns.com>
References: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
 <5645D5A0.1000502@sigmadesigns.com>
Message-ID: <5645F0D0.4060503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 01:20 PM, Marc Gonzalez wrote:
> On 13/11/2015 11:58, Daniel Lezcano wrote:
>
>> The current code to initialize, register and read the clocksource is
>> already factored out in mmio.c via the clocksource_mmio_init function.
>>
>> Factor out the code with the clocksource_mmio_init function.
>
> The reason I didn't like clocksource_mmio_init() is because it exports
> 4 generic accessors.
>
> I guess this function makes more sense when all platforms are using it,
> in an ARCH_MULTIPLATFORM kernel. (Also the accessors are probably quite
> small, so the waste is probably minimal.)

Right.

> In my opinion, defining struct clocksource_mmio with reg "outside"
> struct clocksource leads to less efficient(1) and less clear(2) code.
> 1) because of the padding from ____cacheline_aligned
> 2) because of the container_of() gymnastics

I am not sure that would impact the cacheline.

> I tried discussing this in March, but it didn't go anywhere.
> Lemme brush up the patch.
>
> Should the reg field be considered "hot-path data"?

Yes.

> One problem with my patch: if some ports define CLKSRC_MMIO but
> have lots of static struct clocksource, the extra reg field might
> waste memory / worsen cache locality?

Yes. But the current situation is we have the base address always 
defined in different drivers, so that won't change the situation too much.

The clocksource and the clock_event_device have some commons fields.

I am wondering if we can create a common structure for both containing 
those fields and use them, as the network stack does with the routes, we 
should have a common structure to deal with, without using the container of.

For example:

struct clockcommon {
	u32 mult;
	u32 shift;
	int rating;
	void __iomem *base;
	char *name;
	int irq;
};

struct clocksource {
	struct clockcommon common; /* MUST be the first field */
	cycle_t (*read)(struct clocksource *cs);
	cycle_t mask;
	...
};

struct clockevent {
	struct clockcommon common; /* MUST be the first field */
	ktime_t next_event;
	...
};

int clocksource_init(struct clockcommon *clock)
{
	struct clocksource *clksrc = (struct clocksource *)clock;
}

int clockevent_init(struct clockcommon *clock)
{
	struct clockevent *clkevt = (struct clockevent *)clock;
}

Hence we have the base address for both and we can remove the base@ from 
all the drivers.

The good thing with the mmio is, as you mentioned, instead of having 
multiple clocksource structure defined, we have just one allocated at 
init time. The rest falls in the __init section and unloaded.

This approach is valid for the multiplatform and I believe all SoC will 
migrate to it.

> Also, maybe the fields should be copied in ascending order?
>
> Regards.
>
>
>
> diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
> index 1593ade2a815..aba5f24ba346 100644
> --- a/drivers/clocksource/mmio.c
> +++ b/drivers/clocksource/mmio.c
> @@ -10,34 +10,24 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>
> -struct clocksource_mmio {
> -	void __iomem *reg;
> -	struct clocksource clksrc;
> -};
> -
> -static inline struct clocksource_mmio *to_mmio_clksrc(struct clocksource *c)
> -{
> -	return container_of(c, struct clocksource_mmio, clksrc);
> -}
> -
>   cycle_t clocksource_mmio_readl_up(struct clocksource *c)
>   {
> -	return (cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg);
> +	return (cycle_t)readl_relaxed(c->reg);
>   }
>
>   cycle_t clocksource_mmio_readl_down(struct clocksource *c)
>   {
> -	return ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
> +	return ~(cycle_t)readl_relaxed(c->reg) & c->mask;
>   }
>
>   cycle_t clocksource_mmio_readw_up(struct clocksource *c)
>   {
> -	return (cycle_t)readw_relaxed(to_mmio_clksrc(c)->reg);
> +	return (cycle_t)readw_relaxed(c->reg);
>   }
>
>   cycle_t clocksource_mmio_readw_down(struct clocksource *c)
>   {
> -	return ~(cycle_t)readw_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
> +	return ~(cycle_t)readw_relaxed(c->reg) & c->mask;
>   }
>
>   /**
> @@ -53,21 +43,21 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
>   	unsigned long hz, int rating, unsigned bits,
>   	cycle_t (*read)(struct clocksource *))
>   {
> -	struct clocksource_mmio *cs;
> +	struct clocksource *cs;
>
>   	if (bits > 32 || bits < 16)
>   		return -EINVAL;
>
> -	cs = kzalloc(sizeof(struct clocksource_mmio), GFP_KERNEL);
> +	cs = kzalloc(sizeof *cs, GFP_KERNEL);
>   	if (!cs)
>   		return -ENOMEM;
>
>   	cs->reg = base;
> -	cs->clksrc.name = name;
> -	cs->clksrc.rating = rating;
> -	cs->clksrc.read = read;
> -	cs->clksrc.mask = CLOCKSOURCE_MASK(bits);
> -	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +	cs->name = name;
> +	cs->rating = rating;
> +	cs->read = read;
> +	cs->mask = CLOCKSOURCE_MASK(bits);
> +	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
>
> -	return clocksource_register_hz(&cs->clksrc, hz);
> +	return clocksource_register_hz(cs, hz);
>   }
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 278dd279a7a8..03807ca0d54e 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -74,6 +74,9 @@ struct clocksource {
>   	u32 shift;
>   	u64 max_idle_ns;
>   	u32 maxadj;
> +#ifdef CONFIG_CLKSRC_MMIO
> +	void __iomem *reg;
> +#endif
>   #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
>   	struct arch_clocksource_data archdata;
>   #endif
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
