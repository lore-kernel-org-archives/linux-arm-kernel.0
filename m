From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 10:32:10 +0000
Subject: [PATCH 4/7] ARM: sa1100: clean up of the clock support
In-Reply-To: <1329815096-6200-5-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120223103210.GN22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:04:53PM +0800, Haojian Zhuang wrote:
> From: Jett.Zhou <jtzhou@marvell.com>
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/Kconfig             |    2 +-
>  arch/arm/mach-sa1100/clock.c |   91 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 67 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a48aecc..6e40039 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -754,7 +754,7 @@ config ARCH_SA1100
>  	select ARCH_HAS_CPUFREQ
>  	select CPU_FREQ
>  	select GENERIC_CLOCKEVENTS
> -	select HAVE_CLK
> +	select CLKDEV_LOOKUP
>  	select HAVE_SCHED_CLOCK
>  	select TICK_ONESHOT
>  	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
> index dab3c63..d6df9f6 100644
> --- a/arch/arm/mach-sa1100/clock.c
> +++ b/arch/arm/mach-sa1100/clock.c
> @@ -11,17 +11,39 @@
>  #include <linux/clk.h>
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
> +#include <linux/io.h>
> +#include <linux/clkdev.h>
>  
>  #include <mach/hardware.h>
>  
> -/*
> - * Very simple clock implementation - we only have one clock to deal with.
> - */
> +struct clkops {
> +	void			(*enable)(struct clk *);
> +	void			(*disable)(struct clk *);
> +	unsigned long		(*getrate)(struct clk *);

Is getrate() used?  If not, please get rid of it.

> +};
> +
>  struct clk {
> +	const struct clkops	*ops;
> +	unsigned long		rate;
>  	unsigned int		enabled;
>  };
>  
> -static void clk_gpio27_enable(void)
> +#define INIT_CLKREG(_clk, _devname, _conname)		\
> +	{						\
> +		.clk		= _clk,			\
> +		.dev_id		= _devname,		\
> +		.con_id		= _conname,		\
> +	}

This should use CLKDEV_INIT() rather than defining its own.

> +
> +#define DEFINE_CLK(_name, _ops, _rate)			\
> +struct clk clk_##_name = {				\
> +		.ops	= _ops,				\
> +		.rate	= _rate,			\
> +	}
> +
> +static DEFINE_SPINLOCK(clocks_lock);
> +
> +static void clk_gpio27_enable(struct clk *clk)
>  {
>  	/*
>  	 * First, set up the 3.6864MHz clock on GPIO 27 for the SA-1111:
> @@ -32,38 +54,22 @@ static void clk_gpio27_enable(void)
>  	TUCR = TUCR_3_6864MHz;
>  }
>  
> -static void clk_gpio27_disable(void)
> +static void clk_gpio27_disable(struct clk *clk)
>  {
>  	TUCR = 0;
>  	GPDR &= ~GPIO_32_768kHz;
>  	GAFR &= ~GPIO_32_768kHz;
>  }
>  
> -static struct clk clk_gpio27;
> -
> -static DEFINE_SPINLOCK(clocks_lock);
> -
> -struct clk *clk_get(struct device *dev, const char *id)
> -{
> -	const char *devname = dev_name(dev);
> -
> -	return strcmp(devname, "sa1111.0") ? ERR_PTR(-ENOENT) : &clk_gpio27;
> -}
> -EXPORT_SYMBOL(clk_get);
> -
> -void clk_put(struct clk *clk)
> -{
> -}
> -EXPORT_SYMBOL(clk_put);
> -
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
>  

	if (clk) {

>  	spin_lock_irqsave(&clocks_lock, flags);
>  	if (clk->enabled++ == 0)
> -		clk_gpio27_enable();
> +		clk->ops->enable(clk);
>  	spin_unlock_irqrestore(&clocks_lock, flags);

	}

> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(clk_enable);
> @@ -76,13 +82,48 @@ void clk_disable(struct clk *clk)
>  

	if (clk) {

>  	spin_lock_irqsave(&clocks_lock, flags);
>  	if (--clk->enabled == 0)
> -		clk_gpio27_disable();
> +		clk->ops->disable(clk);
>  	spin_unlock_irqrestore(&clocks_lock, flags);

	}

>  }
>  EXPORT_SYMBOL(clk_disable);
>  
>  unsigned long clk_get_rate(struct clk *clk)
>  {
> -	return 3686400;
> +	unsigned long rate;
> +

	unsigned long rate = 0;
	if (clk) {

> +	rate = clk->rate;
> +	if (clk->ops->getrate)
> +		rate = clk->ops->getrate(clk);

	}

> +
> +	return rate;
>  }
>  EXPORT_SYMBOL(clk_get_rate);
> +
> +const struct clkops clk_gpio27_ops = {
> +	.enable		= clk_gpio27_enable,
> +	.disable	= clk_gpio27_disable,
> +};
> +
> +static void clk_dummy_enable(struct clk *clk) { }
> +static void clk_dummy_disable(struct clk *clk) { }
> +
> +const struct clkops clk_dummy_ops = {
> +	.enable		= clk_dummy_enable,
> +	.disable	= clk_dummy_disable,
> +};
> +
> +static DEFINE_CLK(gpio27, &clk_gpio27_ops, 3686400);
> +static DEFINE_CLK(dummy, &clk_dummy_ops, 0);

Get rid of the dummy clock...

> +
> +static struct clk_lookup sa11xx_clkregs[] = {
> +	INIT_CLKREG(&clk_gpio27, "sa1111.0", NULL),
> +	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),

	CLKDEV_INIT("sa1100-rtc", NULL, NULL),

> +};
> +
> +static int __init sa11xx_clk_init(void)
> +{
> +	clkdev_add_table(sa11xx_clkregs, ARRAY_SIZE(sa11xx_clkregs));
> +	return 0;
> +}
> +
> +postcore_initcall(sa11xx_clk_init);

Why postcore?  There's nothing stopping this being done earlier.
