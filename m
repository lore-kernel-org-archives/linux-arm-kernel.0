From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 11:48:07 +0200
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
Message-ID: <20120502094807.GE20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 12:20:30PM +0530, Viresh Kumar wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Having fixed factors/dividers in hardware is a common pattern, so
> add a basic clock type doing this. It basically describes a fixed
> factor clock using a nominator and a denominator.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Sascha,
> 
> I have this patch in my set, because i need this to get SPEAr stuff pushed by
> Mike. I have updated your original patch, with all the review comments you got
> on it. Please check see if i have corrupted something.
> 
>  drivers/clk/Makefile           |    2 +-
>  drivers/clk/clk-fixed-factor.c |   94 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-private.h    |   20 ++++++++
>  include/linux/clk-provider.h   |   23 ++++++++++
>  4 files changed, 138 insertions(+), 1 deletions(-)
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
> index 0000000..7453efe
> --- /dev/null
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -0,0 +1,94 @@
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
> +	if (prate) {
> +		unsigned long best_parent;
> +		best_parent = (rate / fix->mult) * fix->div;
> +		*prate = __clk_round_rate(__clk_get_parent(hw->clk),
> +				best_parent);
> +		return (*prate / fix->div) * fix->mult;
> +	} else {
> +		return (__clk_get_rate(__clk_get_parent(hw->clk)) / fix->div) *
> +			fix->mult;
> +	}
> +}

This needs a fixup. The clock framework used to pass in a NULL pointer
as prate when a clk is not allowed to change a parents clock. This
is no longer true, so we have to check for

__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT

instead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
