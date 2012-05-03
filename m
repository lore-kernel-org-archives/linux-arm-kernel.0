From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 May 2012 14:08:21 +0200
Subject: [PATCH V4] clk: add a fixed factor clock
In-Reply-To: <85453b2bb4d448d0dcd291579bd76e70c1b48e5b.1336039424.git.viresh.kumar@st.com>
References: <85453b2bb4d448d0dcd291579bd76e70c1b48e5b.1336039424.git.viresh.kumar@st.com>
Message-ID: <20120503120821.GJ4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 03:36:14PM +0530, Viresh Kumar wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Having fixed factors/dividers in hardware is a common pattern, so
> add a basic clock type doing this. It basically describes a fixed
> factor clock using a nominator and a denominator.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
> Reviewed-by: Mike Turquette <mturquette@linaro.org>
> ---
> 
> Hi Mike,
> 
> This patch contains all the fixups that i sent separately. It is based on your
> latest clk-next branch.
> 
>  drivers/clk/Makefile           |    2 +-
>  drivers/clk/clk-fixed-factor.c |   97 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-private.h    |   20 ++++++++
>  include/linux/clk-provider.h   |   23 +++++++++
>  4 files changed, 141 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/clk/clk-fixed-factor.c
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 1f736bc..24aa714 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,4 +1,4 @@
>  
>  obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
> -				   clk-mux.o clk-divider.o
> +				   clk-mux.o clk-divider.o clk-fixed-factor.o
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> new file mode 100644
> index 0000000..0e8782b
> --- /dev/null
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Standard functionality for the common clock API.
> + */
> +#include <linux/module.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +/*
> + * DOC: basic fixed multiplier and divider clock that cannot gate
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is fixed.  clk->rate = parent->rate / div * mult
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +#define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
> +
> +static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
> +
> +	return (parent_rate / fix->div) * fix->mult;
> +}
> +
> +static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *prate)
> +{
> +	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
> +
> +	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
> +		unsigned long best_parent;
> +
> +		best_parent = (rate / fix->mult) * fix->div;
> +		*prate = __clk_round_rate(__clk_get_parent(hw->clk),
> +				best_parent);
> +	}
> +
> +	return (*prate / fix->div) * fix->mult;
> +}
> +
> +static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	return 0;
> +}
> +
> +struct clk_ops clk_fixed_factor_ops = {
> +	.round_rate = clk_factor_round_rate,
> +	.set_rate = clk_factor_set_rate,
> +	.recalc_rate = clk_factor_recalc_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
> +
> +struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
> +		const char *parent_name, unsigned long flags,
> +		unsigned int mult, unsigned int div)
> +{
> +	struct clk_fixed_factor *fix;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +
> +	fix = kmalloc(sizeof(*fix), GFP_KERNEL);
> +	if (!fix) {
> +		pr_err("%s: could not allocate fixed factor clk\n", __func__);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* struct clk_fixed_factor assignments */
> +	fix->mult = mult;
> +	fix->div = div;
> +	fix->hw.init = &init;
> +
> +	init.name = name;
> +	init.ops = &clk_fixed_factor_ops;
> +	init.flags = flags;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +
> +	clk = clk_register(dev, &fix->hw);
> +
> +	if (clk)
> +		return clk;

	if (!IS_ERR(clk))
		...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
