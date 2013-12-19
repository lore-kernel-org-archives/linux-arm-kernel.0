From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 20:50:50 -0800
Subject: [PATCH v3 04/12] clk: Add regmap core helpers for
 enable/disable/is_enabled
In-Reply-To: <1381909214-12693-5-git-send-email-sboyd@codeaurora.org>
References: <1381909214-12693-1-git-send-email-sboyd@codeaurora.org>
 <1381909214-12693-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131219045050.23538.94293@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2013-10-16 00:40:06)
> The clock framework already has support for simple gate clocks
> but if drivers want to use the gate clock functionality they need
> to wrap the gate clock in another struct and chain the ops by
> calling the gate ops from their own custom ops. Plus the gate
> clock implementation only supports MMIO accessors so other bus
> type clocks don't benefit from the potential code reuse. Add some
> simple regmap helpers for enable/disable/is_enabled that drivers
> can use as drop in replacements for their clock ops or as simple
> functions they call from their own custom ops.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/clk.c            | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h | 13 ++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8042c00..7cc8cb0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -742,6 +742,76 @@ out:
>         return best;
>  }
>  
> +/**
> + * clk_is_enabled_regmap - standard is_enabled() for regmap users
> + *
> + * @hw: clk to operate on
> + *
> + * Clocks that use regmap for their register I/O can set the
> + * enable_reg and enable_mask fields in their struct clk_hw and then use
> + * this as their is_enabled operation, saving some code.
> + */
> +int clk_is_enabled_regmap(struct clk_hw *hw)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       ret = regmap_read(hw->regmap, hw->enable_reg, &val);
> +       if (ret != 0)
> +               return ret;
> +
> +       if (hw->enable_is_inverted)
> +               return (val & hw->enable_mask) == 0;
> +       else
> +               return (val & hw->enable_mask) != 0;
> +}
> +EXPORT_SYMBOL_GPL(clk_is_enabled_regmap);
> +
> +/**
> + * clk_enable_regmap - standard enable() for regmap users
> + *
> + * @hw: clk to operate on
> + *
> + * Clocks that use regmap for their register I/O can set the
> + * enable_reg and enable_mask fields in their struct clk_hw and then use
> + * this as their enable() operation, saving some code.
> + */
> +int clk_enable_regmap(struct clk_hw *hw)
> +{
> +       unsigned int val;
> +
> +       if (hw->enable_is_inverted)
> +               val = 0;
> +       else
> +               val = hw->enable_mask;
> +
> +       return regmap_update_bits(hw->regmap, hw->enable_reg,
> +                                 hw->enable_mask, val);
> +}
> +EXPORT_SYMBOL_GPL(clk_enable_regmap);
> +
> +/**
> + * clk_disable_regmap - standard disable() for regmap users
> + *
> + * @hw: clk to operate on
> + *
> + * Clocks that use regmap for their register I/O can set the
> + * enable_reg and enable_mask fields in their struct clk_hw and then use
> + * this as their disable() operation, saving some code.
> + */
> +void clk_disable_regmap(struct clk_hw *hw)
> +{
> +       unsigned int val;
> +
> +       if (hw->enable_is_inverted)
> +               val = hw->enable_mask;
> +       else
> +               val = 0;
> +
> +       regmap_update_bits(hw->regmap, hw->enable_reg, hw->enable_mask, val);
> +}
> +EXPORT_SYMBOL_GPL(clk_disable_regmap);
> +
>  /***        clk api        ***/
>  
>  void __clk_unprepare(struct clk *clk)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 6ed62f1..4087a9b 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -177,11 +177,21 @@ struct clk_init_data {
>   * with the common clock framework.
>   *
>   * @regmap: regmap to use for regmap helpers and/or by providers
> + *
> + * @enable_reg: register when using regmap enable/disable ops
> + *
> + * @enable_mask: mask when using regmap enable/disable ops
> + *
> + * @enable_is_inverted: flag to indicate set enable_mask bits to disable
> + *                      when using clock_enable_regmap and friends APIs.
>   */
>  struct clk_hw {
>         struct clk *clk;
>         const struct clk_init_data *init;
>         struct regmap *regmap;
> +       unsigned int enable_reg;
> +       unsigned int enable_mask;
> +       bool enable_is_inverted;

Thanks for submitting this patch.

Adding all of this stuff to struct clk_hw makes me a sad panda. You are
essentially sharing a common set of ops for clocks that use regmap as
their io operation back-end, and that is a good thing.

However, why not just do this as drivers/clk/clk-regmap.c, or
drivers/clk/clk-gate-regmap.c? Putting the clk_ops callback functions in
drivers/clk/clk.c is a little weird and putting those struct members
into struct clk_hw is definitely strange.

Regards,
Mike

>  };
>  
>  /*
> @@ -447,6 +457,9 @@ struct clk *__clk_lookup(const char *name);
>  long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
>                               unsigned long *best_parent_rate,
>                               struct clk **best_parent_p);
> +int clk_is_enabled_regmap(struct clk_hw *hw);
> +int clk_enable_regmap(struct clk_hw *hw);
> +void clk_disable_regmap(struct clk_hw *hw);
>  
>  /*
>   * FIXME clock api without lock protection
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
