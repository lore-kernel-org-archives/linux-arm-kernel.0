From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Mar 2013 16:42:21 +0800
Subject: [PATCH] clk: let mxs specific clk-div clock type be a generic
 clock type
In-Reply-To: <1363438201-24938-1-git-send-email-thomas.abraham@linaro.org>
References: <1363438201-24938-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20130318084220.GB12462@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 16, 2013 at 06:20:01PM +0530, Thomas Abraham wrote:
> The mxs platform specific clk-div clock is an extended version of the
> basic integer divider clock type that supports checking the stability
> status of the divider clock output. This type of clock is found on
> some of the Samsung platforms as well. So let the mxs specfic clk-div
> clock type be a generic clock type that all platforms can utilize.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/clk/Makefile             |    1 +
>  drivers/clk/clk-divider-status.c |  119 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/mxs/Makefile         |    2 +-
>  drivers/clk/mxs/clk-div.c        |  110 -----------------------------------
>  drivers/clk/mxs/clk.h            |   12 +++-
>  include/linux/clk-provider.h     |   21 +++++++
>  6 files changed, 151 insertions(+), 114 deletions(-)
>  create mode 100644 drivers/clk/clk-divider-status.c
>  delete mode 100644 drivers/clk/mxs/clk-div.c

>From my quick testing, it seems working for mxs platform.  But it's hard
to review the changes.  Making it two steps might be helpful for
reviewer:

1) git mv drivers/clk/mxs/clk-div.c drivers/clk/clk-divider-status.c
2) make changes on drivers/clk/clk-divider-status.c

Shawn

> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 0147022..0ac851a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
> +obj-$(CONFIG_COMMON_CLK)	+= clk-divider-status.o
>  
>  # SoCs specific
>  obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
> diff --git a/drivers/clk/clk-divider-status.c b/drivers/clk/clk-divider-status.c
> new file mode 100644
> index 0000000..1d66059
> --- /dev/null
> +++ b/drivers/clk/clk-divider-status.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + *
> + * Extension to the adjustable divider clock implementation with support for
> + * divider clock stability checks.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +
> +/*
> + * DOC: Adjustable divider clock with support for divider stability check
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is adjustable.  clk->rate = parent->rate / divisor
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +static inline struct clk_divider_status *to_clk_div(struct clk_hw *hw)
> +{
> +	struct clk_divider *divider = container_of(hw, struct clk_divider, hw);
> +
> +	return container_of(divider, struct clk_divider_status, divider);
> +}
> +
> +static unsigned long clk_divider_status_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct clk_divider_status *div = to_clk_div(hw);
> +
> +	return div->ops->recalc_rate(&div->divider.hw, parent_rate);
> +}
> +
> +static long clk_divider_status_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *prate)
> +{
> +	struct clk_divider_status *div = to_clk_div(hw);
> +
> +	return div->ops->round_rate(&div->divider.hw, rate, prate);
> +}
> +
> +static int clk_divider_status_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct clk_divider_status *div = to_clk_div(hw);
> +	int ret;
> +
> +	ret = div->ops->set_rate(&div->divider.hw, rate, parent_rate);
> +	if (!ret) {
> +		unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +
> +		while (readl_relaxed(div->reg) & (1 << div->busy)) {
> +			if (time_after(jiffies, timeout))
> +				return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static struct clk_ops clk_divider_status_ops = {
> +	.recalc_rate = clk_divider_status_recalc_rate,
> +	.round_rate = clk_divider_status_round_rate,
> +	.set_rate = clk_divider_status_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_divider_status_ops);
> +
> +struct clk *clk_register_divider_status(struct device *dev, const char *name,
> +		const char *parent_name, unsigned long flags, void __iomem *reg,
> +		u8 shift, u8 width, u8 clk_divider_flags,
> +		void __iomem *reg_status, u8 shift_status, spinlock_t *lock)
> +{
> +	struct clk_divider_status *div;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	div = kzalloc(sizeof(*div), GFP_KERNEL);
> +	if (!div) {
> +		pr_err("%s: could not allocate divider-status clk\n", __func__);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	init.name = name;
> +	init.ops = &clk_divider_status_ops;
> +	init.flags = flags;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +
> +	div->reg = reg_status;
> +	div->busy = shift_status;
> +	div->ops = &clk_divider_ops;
> +
> +	div->divider.reg = reg;
> +	div->divider.shift = shift;
> +	div->divider.width = width;
> +	div->divider.flags = clk_divider_flags;
> +	div->divider.lock = lock;
> +	div->divider.hw.init = &init;
> +
> +	clk = clk_register(NULL, &div->divider.hw);
> +	if (IS_ERR(clk))
> +		kfree(div);
> +
> +	return clk;
> +}
> diff --git a/drivers/clk/mxs/Makefile b/drivers/clk/mxs/Makefile
> index a6a2223..8f8f1b3 100644
> --- a/drivers/clk/mxs/Makefile
> +++ b/drivers/clk/mxs/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for mxs specific clk
>  #
>  
> -obj-y += clk.o clk-pll.o clk-ref.o clk-div.o clk-frac.o clk-ssp.o
> +obj-y += clk.o clk-pll.o clk-ref.o clk-frac.o clk-ssp.o
>  
>  obj-$(CONFIG_SOC_IMX23) += clk-imx23.o
>  obj-$(CONFIG_SOC_IMX28) += clk-imx28.o
> diff --git a/drivers/clk/mxs/clk-div.c b/drivers/clk/mxs/clk-div.c
> deleted file mode 100644
> index 90e1da9..0000000
> --- a/drivers/clk/mxs/clk-div.c
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -/*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 or later at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/clk-provider.h>
> -#include <linux/err.h>
> -#include <linux/slab.h>
> -#include "clk.h"
> -
> -/**
> - * struct clk_div - mxs integer divider clock
> - * @divider: the parent class
> - * @ops: pointer to clk_ops of parent class
> - * @reg: register address
> - * @busy: busy bit shift
> - *
> - * The mxs divider clock is a subclass of basic clk_divider with an
> - * addtional busy bit.
> - */
> -struct clk_div {
> -	struct clk_divider divider;
> -	const struct clk_ops *ops;
> -	void __iomem *reg;
> -	u8 busy;
> -};
> -
> -static inline struct clk_div *to_clk_div(struct clk_hw *hw)
> -{
> -	struct clk_divider *divider = container_of(hw, struct clk_divider, hw);
> -
> -	return container_of(divider, struct clk_div, divider);
> -}
> -
> -static unsigned long clk_div_recalc_rate(struct clk_hw *hw,
> -					 unsigned long parent_rate)
> -{
> -	struct clk_div *div = to_clk_div(hw);
> -
> -	return div->ops->recalc_rate(&div->divider.hw, parent_rate);
> -}
> -
> -static long clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
> -			       unsigned long *prate)
> -{
> -	struct clk_div *div = to_clk_div(hw);
> -
> -	return div->ops->round_rate(&div->divider.hw, rate, prate);
> -}
> -
> -static int clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> -			    unsigned long parent_rate)
> -{
> -	struct clk_div *div = to_clk_div(hw);
> -	int ret;
> -
> -	ret = div->ops->set_rate(&div->divider.hw, rate, parent_rate);
> -	if (!ret)
> -		ret = mxs_clk_wait(div->reg, div->busy);
> -
> -	return ret;
> -}
> -
> -static struct clk_ops clk_div_ops = {
> -	.recalc_rate = clk_div_recalc_rate,
> -	.round_rate = clk_div_round_rate,
> -	.set_rate = clk_div_set_rate,
> -};
> -
> -struct clk *mxs_clk_div(const char *name, const char *parent_name,
> -			void __iomem *reg, u8 shift, u8 width, u8 busy)
> -{
> -	struct clk_div *div;
> -	struct clk *clk;
> -	struct clk_init_data init;
> -
> -	div = kzalloc(sizeof(*div), GFP_KERNEL);
> -	if (!div)
> -		return ERR_PTR(-ENOMEM);
> -
> -	init.name = name;
> -	init.ops = &clk_div_ops;
> -	init.flags = CLK_SET_RATE_PARENT;
> -	init.parent_names = (parent_name ? &parent_name: NULL);
> -	init.num_parents = (parent_name ? 1 : 0);
> -
> -	div->reg = reg;
> -	div->busy = busy;
> -
> -	div->divider.reg = reg;
> -	div->divider.shift = shift;
> -	div->divider.width = width;
> -	div->divider.flags = CLK_DIVIDER_ONE_BASED;
> -	div->divider.lock = &mxs_lock;
> -	div->divider.hw.init = &init;
> -	div->ops = &clk_divider_ops;
> -
> -	clk = clk_register(NULL, &div->divider.hw);
> -	if (IS_ERR(clk))
> -		kfree(div);
> -
> -	return clk;
> -}
> diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
> index 81421e2..865f495 100644
> --- a/drivers/clk/mxs/clk.h
> +++ b/drivers/clk/mxs/clk.h
> @@ -29,9 +29,6 @@ struct clk *mxs_clk_pll(const char *name, const char *parent_name,
>  struct clk *mxs_clk_ref(const char *name, const char *parent_name,
>  			void __iomem *reg, u8 idx);
>  
> -struct clk *mxs_clk_div(const char *name, const char *parent_name,
> -			void __iomem *reg, u8 shift, u8 width, u8 busy);
> -
>  struct clk *mxs_clk_frac(const char *name, const char *parent_name,
>  			 void __iomem *reg, u8 shift, u8 width, u8 busy);
>  
> @@ -63,4 +60,13 @@ static inline struct clk *mxs_clk_fixed_factor(const char *name,
>  					 CLK_SET_RATE_PARENT, mult, div);
>  }
>  
> +static inline struct clk *mxs_clk_div(const char *name,
> +			const char *parent_name, void __iomem *reg, u8 shift,
> +			u8 width, u8 busy)
> +{
> +	return clk_register_divider_status(NULL, name, parent_name,
> +				CLK_SET_RATE_PARENT, reg, shift, width,
> +				CLK_DIVIDER_ONE_BASED, reg, busy, &mxs_lock);
> +}
> +
>  #endif /* __MXS_CLK_H */
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 7f197d7..6309335 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -268,6 +268,27 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
>  		spinlock_t *lock);
>  
>  /**
> + * struct clk_divider_status - integer divider clock with additional status bit
> + * @divider: the parent class
> + * @ops: pointer to clk_ops of parent class
> + * @reg: register containing the divider status bit
> + * @busy: divider busy bit shift
> + *
> + * This clock is a subclass of basic clk_divider with an addtional busy bit.
> + */
> +struct clk_divider_status {
> +	struct clk_divider divider;
> +	const struct clk_ops *ops;
> +	void __iomem *reg;
> +	u8 busy;
> +};
> +
> +struct clk *clk_register_divider_status(struct device *dev, const char *name,
> +		const char *parent_name, unsigned long flags, void __iomem *reg,
> +		u8 shift, u8 width, u8 clk_divider_flags,
> +		void __iomem *reg_status, u8 shift_status, spinlock_t *lock);
> +
> +/**
>   * struct clk_mux - multiplexer clock
>   *
>   * @hw:		handle between common and hardware-specific interfaces
> -- 
> 1.7.5.4
> 
