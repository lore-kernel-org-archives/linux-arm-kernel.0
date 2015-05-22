From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 22 May 2015 12:35:35 +0800
Subject: [PATCH v2 1/7] clk: Add a basic factor clock
In-Reply-To: <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 22, 2015 at 4:54 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some clocks are using a factor component, however, unlike their mux, gate
> or divider counterpart, these factors don't have a basic clock
> implementation.

I think "multiplier" would be a better name here, considering it is the
counterpart of "divider". "factor" implies you can multiply and/or divide
the clock rate.

Unless of course you plan to add that? :)

ChenYu

> This leads to code duplication across platforms that want to use that kind
> of clocks, and the impossibility to use the composite clocks with such a
> clock without defining your own rate operations.
>
> Create such a driver in order to remove these issues, and hopefully factor
> the implementations, reducing code size across platforms and consolidating
> the various implementations.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/Makefile         |   1 +
>  drivers/clk/clk-factor.c     | 176 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h |  41 ++++++++++
>  3 files changed, 218 insertions(+)
>  create mode 100644 drivers/clk/clk-factor.c
>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 3d00c25382c5..d38b71d15ffa 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_HAVE_CLK)          += clk-devres.o
>  obj-$(CONFIG_CLKDEV_LOOKUP)    += clkdev.o
>  obj-$(CONFIG_COMMON_CLK)       += clk.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-divider.o
> +obj-$(CONFIG_COMMON_CLK)       += clk-factor.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-factor.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-rate.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
> diff --git a/drivers/clk/clk-factor.c b/drivers/clk/clk-factor.c
> new file mode 100644
> index 000000000000..17f83852cdb6
> --- /dev/null
> +++ b/drivers/clk/clk-factor.c
> @@ -0,0 +1,176 @@
> +/*
> + * Copyright (C) 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/module.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +
> +#define to_clk_factor(_hw) container_of(_hw, struct clk_factor, hw)
> +
> +static unsigned long __get_mult(struct clk_factor *factor,
> +                               unsigned long rate,
> +                               unsigned long parent_rate)
> +{
> +       if (factor->flags & CLK_FACTOR_ROUND_CLOSEST)
> +               return DIV_ROUND_CLOSEST(rate, parent_rate);
> +
> +       return rate / parent_rate;
> +}
> +
> +static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct clk_factor *factor = to_clk_factor(hw);
> +       unsigned long val;
> +
> +       val = clk_readl(factor->reg) >> factor->shift;
> +       val &= GENMASK(factor->width, 0);
> +
> +       if (!val && factor->flags & CLK_FACTOR_ZERO_BYPASS)
> +               val = 1;
> +
> +       return parent_rate * val;
> +}
> +
> +static bool __is_best_rate(unsigned long rate, unsigned long new,
> +                          unsigned long best, unsigned long flags)
> +{
> +       if (flags & CLK_FACTOR_ROUND_CLOSEST)
> +               return abs(rate - new) < abs(rate - best);
> +
> +       return new >= rate && new < best;
> +}
> +
> +static unsigned long clk_factor_bestmult(struct clk_hw *hw, unsigned long rate,
> +                                        unsigned long *best_parent_rate,
> +                                        u8 width, unsigned long flags)
> +{
> +       unsigned long orig_parent_rate = *best_parent_rate;
> +       unsigned long parent_rate, current_rate, best_rate = ~0;
> +       unsigned int i, bestmult = 0;
> +
> +       if (!(__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT))
> +               return rate / *best_parent_rate;
> +
> +       for (i = 1; i < ((1 << width) - 1); i++) {
> +               if (rate * i == orig_parent_rate) {
> +                       /*
> +                        * This is the best case for us if we have a
> +                        * perfect match without changing the parent
> +                        * rate.
> +                        */
> +                       *best_parent_rate = orig_parent_rate;
> +                       return i;
> +               }
> +
> +               parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
> +                                              rate / i);
> +               current_rate = parent_rate * i;
> +
> +               if (__is_best_rate(rate, current_rate, best_rate, flags)) {
> +                       bestmult = i;
> +                       best_rate = current_rate;
> +                       *best_parent_rate = parent_rate;
> +               }
> +       }
> +
> +       return bestmult;
> +}
> +
> +static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long *parent_rate)
> +{
> +       struct clk_factor *factor = to_clk_factor(hw);
> +       unsigned long mult = clk_factor_bestmult(hw, rate, parent_rate,
> +                                                factor->width, factor->flags);
> +
> +       return *parent_rate * mult;
> +}
> +
> +static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       struct clk_factor *factor = to_clk_factor(hw);
> +       unsigned long mult = __get_mult(factor, rate, parent_rate);
> +       unsigned long uninitialized_var(flags);
> +       struct clk *clk = hw->clk;
> +       unsigned long val;
> +
> +       if (factor->lock)
> +               spin_lock_irqsave(factor->lock, flags);
> +
> +       val = clk_readl(factor->reg);
> +       val &= ~GENMASK(factor->width + factor->shift, factor->shift);
> +       val |= mult << factor->shift;
> +       clk_writel(val, factor->reg);
> +
> +       if (factor->lock)
> +               spin_unlock_irqrestore(factor->lock, flags);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops clk_factor_ops = {
> +       .recalc_rate    = clk_factor_recalc_rate,
> +       .round_rate     = clk_factor_round_rate,
> +       .set_rate       = clk_factor_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_factor_ops);
> +
> +struct clk *clk_register_factor(struct device *dev, const char *name,
> +                               const char *parent_name, unsigned long flags,
> +                               void __iomem *reg, u8 shift, u8 width,
> +                               u8 clk_factor_flags, spinlock_t *lock)
> +{
> +       struct clk_init_data init;
> +       struct clk_factor *factor;
> +       struct clk *clk;
> +
> +       factor = kmalloc(sizeof(*factor), GFP_KERNEL);
> +       if (!factor) {
> +               pr_err("%s: could not allocate fixed factor clk\n", __func__);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       init.name = name;
> +       init.ops = &clk_factor_ops;
> +       init.flags = flags | CLK_IS_BASIC;
> +       init.parent_names = &parent_name;
> +       init.num_parents = 1;
> +
> +       factor->reg = reg;
> +       factor->shift = shift;
> +       factor->width = width;
> +       factor->flags = clk_factor_flags;
> +       factor->lock = lock;
> +       factor->hw.init = &init;
> +
> +       clk = clk_register(dev, &factor->hw);
> +       if (IS_ERR(clk))
> +               kfree(factor);
> +
> +       return clk;
> +}
> +EXPORT_SYMBOL_GPL(clk_register_factor);
> +
> +void clk_unregister_factor(struct clk *clk)
> +{
> +       struct clk_factor *factor;
> +       struct clk_hw *hw;
> +
> +       hw = __clk_get_hw(clk);
> +       if (!hw)
> +               return;
> +
> +       factor = to_clk_factor(hw);
> +
> +       clk_unregister(clk);
> +       kfree(factor);
> +}
> +EXPORT_SYMBOL_GPL(clk_unregister_factor);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index df695313f975..543918c378f5 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -493,6 +493,47 @@ struct clk *clk_register_fractional_divider(struct device *dev,
>                 void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
>                 u8 clk_divider_flags, spinlock_t *lock);
>
> +/**
> + * struct clk_factor - adjustable factor clock
> + *
> + * @hw:                handle between common and hardware-specific interfaces
> + * @reg:       register containing the factor
> + * @shift:     shift to the factor bit field
> + * @width:     width of the factor bit field
> + * @lock:      register lock
> + *
> + * Clock with an adjustable factor affecting its output frequency.
> + * Implements .recalc_rate, .set_rate and .round_rate
> + *
> + * Flags:
> + * CLK_FACTOR_ZERO_BYPASS - By default, the factor is the value read
> + *     from the register, with 0 being a valid value effectively
> + *     zeroing the output clock rate. If CLK_FACTOR_ZERO_BYPASS is
> + *     set, then a null factor will be considered as a bypass,
> + *     leaving the parent rate unmodified.
> + * CLK_FACTOR_ROUND_CLOSEST - Makes the best calculated divider to be
> + *     rounded to the closest integer instead of the down one.
> + */
> +struct clk_factor {
> +       struct clk_hw   hw;
> +       void __iomem    *reg;
> +       u8              shift;
> +       u8              width;
> +       u8              flags;
> +       spinlock_t      *lock;
> +};
> +
> +#define CLK_FACTOR_ZERO_BYPASS         BIT(0)
> +#define CLK_FACTOR_ROUND_CLOSEST       BIT(1)
> +
> +extern const struct clk_ops clk_factor_ops;
> +
> +struct clk *clk_register_factor(struct device *dev, const char *name,
> +                               const char *parent_name, unsigned long flags,
> +                               void __iomem *reg, u8 shift, u8 width,
> +                               u8 clk_factor_flags, spinlock_t *lock);
> +void clk_unregister_factor(struct clk *clk);
> +
>  /***
>   * struct clk_composite - aggregate clock of mux, divider and gate clocks
>   *
> --
> 2.4.1
>
