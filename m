From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Apr 2011 11:49:09 +0200
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110418094909.GE31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:08:10PM +0200, Sascha Hauer wrote:
> This patch adds support for the most common type of divider,
> which expects a register, width and shift values to desacribe
> the location of the divider. The divider can be zero based
> or one based (div = reg_val + 1 vs. div = reg_val).
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> ---
>  drivers/clk/Kconfig       |    3 +
>  drivers/clk/Makefile      |    1 +
>  drivers/clk/clk-divider.c |  132 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h       |   31 +++++++++++
>  4 files changed, 167 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/clk-divider.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 6e3ae54..76bb4c9 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -5,3 +5,6 @@ config CLKDEV_LOOKUP
>  
>  config USE_COMMON_STRUCT_CLK
>  	bool
> +
> +config USE_COMMON_CLK_DIVIDER
> +	bool
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index a1a06d3..723d884 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,3 +1,4 @@
>  
>  obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
>  obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
> +obj-$(CONFIG_USE_COMMON_CLK_DIVIDER) += clk-divider.o
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> new file mode 100644
> index 0000000..2de94df
> --- /dev/null
> +++ b/drivers/clk/clk-divider.c
> @@ -0,0 +1,132 @@
> +/*
> + * Copyright (C) 2011 Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Standard functionality for the common clock API.
> + */
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))
> +
> +static unsigned long clk_divider_get_rate(struct clk *clk)
> +{
> +	struct clk_divider *divider = to_clk_divider(clk);
> +	unsigned long rate = clk_get_rate(divider->parent);
> +	unsigned int div;
> +
> +	div = readl(divider->reg) >> divider->shift;
> +	div &= (1 << divider->width) - 1;
> +
> +	if (!(divider->flags & CLK_DIVIDER_FLAG_ONE_BASED))
> +		div++;
> +
> +	return rate / div;
DIV_ROUND_UP(rate, div)? (There is DIV_ROUND_CLOSEST, too, but I think
you need to round up, see below.)

> +}
> +
> +static int clk_divider_bestdiv(struct clk *clk, unsigned long rate,
> +		unsigned long *best_parent_rate)
conceptually this returns an unsigned value

> +{
> +	struct clk_divider *divider = to_clk_divider(clk);
> +	int i, bestdiv = 0;
> +	unsigned long parent_rate, best = 0, now, maxdiv;
> +
> +	maxdiv = (1 << divider->width);
Is divider->width == 32 a valid scenario? If so, this overflows.

> +
> +	if (divider->flags & CLK_DIVIDER_FLAG_ONE_BASED)
> +		maxdiv--;
> +
> +	/*
> +	 * The maximum divider we can use without overflowing
> +	 * unsigned long in rate * i below
> +	 */
> +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +	for (i = 1; i <= maxdiv; i++) {
> +		parent_rate = clk_round_rate(divider->parent, (rate + 1) * i);
> +		now = parent_rate / i;
This is buggy, take rate = 25, i = 4. You request the parent to set
104. If you get that, the resulting rate is 26. (And even if
clk_round_rate only return 101 this might be too much.)

I think you need:

	parent_rate = clk_round_rate(divider->parent, rate * i)
	now = DIV_ROUND_UP(parent_rate, i);

I think you really need DIV_ROUND_UP here, DIV_ROUND_CLOSEST won't work.
Consider that a rate of 25 is requested, again with i=4. So the parent
is asked for 100 and might return 97. With DIV_ROUND_CLOSEST you report
to be able to set 24 now, but in fact it's more (24.25). If now further
up in the recursion another divider considers 24 to be a great value to
make 12Hz the value actually provided is too big.

> +
> +		if (now <= rate && now >= best) {
> +			bestdiv = i;
> +			best = now;
> +		}
> +	}
> +
> +	if (!bestdiv) {
> +		bestdiv = (1 << divider->width);
> +		parent_rate = clk_round_rate(divider->parent, 1);
> +	} else {
> +		parent_rate = best * bestdiv;
> +	}
> +
> +	if (best_parent_rate)
> +		*best_parent_rate = parent_rate;
> +
> +	return bestdiv;
> +}
> +
> +static long clk_divider_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	unsigned long best_parent_rate;
> +	int div = clk_divider_bestdiv(clk, rate, &best_parent_rate);
> +
> +	return best_parent_rate / div;
> +}
> +
> +static int clk_divider_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	unsigned long best_parent_rate;
> +	struct clk_divider *divider = to_clk_divider(clk);
> +	unsigned int div;
> +	int ret;
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	div = clk_divider_bestdiv(clk, rate, &best_parent_rate);
> +
> +	if (rate != best_parent_rate / div)
> +		return -EINVAL;
This is too harsh, isn't it. Or can you expect to only get values that
are returned by round_rate? Again you need DIV_ROUND_UP.

> +
> +	ret = clk_set_rate(divider->parent, best_parent_rate);
> +	if (ret)
> +		return ret;
> +
> +	if (divider->lock)
> +		spin_lock_irqsave(divider->lock, flags);
> +
> +	if (!(divider->flags & CLK_DIVIDER_FLAG_ONE_BASED))
> +		div--;
> +
> +	val = readl(divider->reg);
> +	val &= ~(((1 << divider->width) - 1) << divider->shift);
> +	val |= div << divider->shift;
> +	writel(val, divider->reg);
> +
> +	if (divider->lock)
> +		spin_unlock_irqrestore(divider->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct clk *clk_divider_get_parent(struct clk *clk)
> +{
> +	struct clk_divider *divider = to_clk_divider(clk);
> +
> +	return divider->parent;
> +}
> +
> +struct clk_ops clk_divider_ops = {
> +	.prepare = clk_parent_prepare,
> +	.unprepare = clk_parent_unprepare,
> +	.enable = clk_parent_enable,
> +	.disable = clk_parent_disable,
> +	.get_rate = clk_divider_get_rate,
> +	.round_rate = clk_divider_round_rate,
> +	.set_rate = clk_divider_set_rate,
> +	.get_parent = clk_divider_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_divider_ops);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index d014341..6f9771b 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -180,6 +180,37 @@ unsigned long clk_parent_get_rate(struct clk *clk);
>  long clk_parent_round_rate(struct clk *clk, unsigned long rate);
>  int clk_parent_set_rate(struct clk *clk, unsigned long rate);
>  
> +/**
> + * clock divider
> + *
> + * @clk		clock source
> + * @reg		register containing the divider
> + * @shift	shift to the divider
> + * @width	width of the divider
> + * @lock	register lock
"optional register lock"?

> + * @parent	parent clock
@flags is missing here. Maybe use the same ordering as in the struct?

> + *
> + * This clock implements get_rate/set_rate/round_rate. prepare/unprepare and
> + * enable/disable are passed through to the parent.
> + *
> + * The divider is calculated as div = reg_val + 1
> + * or if CLK_DIVIDER_FLAG_ONE_BASED is set as div = reg_val
> + * (with reg_val == 0 considered invalid)
> + */
> +struct clk_divider {
> +	struct clk	clk;
> +	void __iomem	*reg;
> +	unsigned char	shift;
> +	unsigned char	width;
> +	unsigned int	div;
> +	struct clk	*parent;
> +	spinlock_t	*lock;
> +#define CLK_DIVIDER_FLAG_ONE_BASED	(1 << 0)
> +	unsigned int	flags;
> +};
> +
> +extern struct clk_ops clk_divider_ops;
> +
>  #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
>  
>  /*
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
