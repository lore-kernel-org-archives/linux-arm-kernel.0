From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 Dec 2017 11:34:19 +0100
Subject: [PATCH] clk: divider: fix incorrect usage of container_of
In-Reply-To: <20171221163054.13600-1-jbrunet@baylibre.com>
References: <20171221163054.13600-1-jbrunet@baylibre.com>
Message-ID: <20171222103419.GB18255@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/12/2017 at 17:30:54 +0100, Jerome Brunet wrote:
> divider_recalc_rate() is an helper function used by clock divider of
> different types, so the structure containing the 'hw' pointer is not
> always a 'struct clk_divider'
> 
> At the following line:
> > div = _get_div(table, val, flags, divider->width);
> 
> in several cases, the value of 'divider->width' is garbage as the actual
> structure behind this memory is not a 'struct clk_divider'
> 
> Fortunately, this width value is used by _get_val() only when
> CLK_DIVIDER_MAX_AT_ZERO flag is set. This has never been the case so
> far when the structure is not a 'struct clk_divider'. This is probably
> why we did not notice this bug before
> 
> Fixes: afe76c8fd030 ("clk: allow a clk divider with max divisor when zero")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

For RTC:
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> Hi Stephen, Mike,
> 
> In addition to clock, this patch also touch the rtc and drm directories.
> As it is changing the API of the helper function, I have this fix in a
> single commit to avoid breaking bisect.
> 
> Please let me know if you prefer to do differently.
> 
> Cheers
> Jerome
> 
> drivers/clk/clk-divider.c                  | 7 +++----
>  drivers/clk/hisilicon/clkdivider-hi6220.c  | 2 +-
>  drivers/clk/nxp/clk-lpc32xx.c              | 2 +-
>  drivers/clk/qcom/clk-regmap-divider.c      | 2 +-
>  drivers/clk/sunxi-ng/ccu_div.c             | 2 +-
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c | 2 +-
>  drivers/rtc/rtc-ac100.c                    | 6 ++++--
>  include/linux/clk-provider.h               | 2 +-
>  8 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 4ed516cb7276..b49942b9fe50 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -118,12 +118,11 @@ static unsigned int _get_val(const struct clk_div_table *table,
>  unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
>  				  unsigned int val,
>  				  const struct clk_div_table *table,
> -				  unsigned long flags)
> +				  unsigned long flags, unsigned long width)
>  {
> -	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int div;
>  
> -	div = _get_div(table, val, flags, divider->width);
> +	div = _get_div(table, val, flags, width);
>  	if (!div) {
>  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
>  			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
> @@ -145,7 +144,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	val &= div_mask(divider->width);
>  
>  	return divider_recalc_rate(hw, parent_rate, val, divider->table,
> -				   divider->flags);
> +				   divider->flags, divider->width);
>  }
>  
>  static bool _is_valid_table_div(const struct clk_div_table *table,
> diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
> index a1c1f684ad58..9f46cf9dcc65 100644
> --- a/drivers/clk/hisilicon/clkdivider-hi6220.c
> +++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
> @@ -56,7 +56,7 @@ static unsigned long hi6220_clkdiv_recalc_rate(struct clk_hw *hw,
>  	val &= div_mask(dclk->width);
>  
>  	return divider_recalc_rate(hw, parent_rate, val, dclk->table,
> -				   CLK_DIVIDER_ROUND_CLOSEST);
> +				   CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
>  }
>  
>  static long hi6220_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate,
> diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> index b669a5c10fee..f5d815f577e0 100644
> --- a/drivers/clk/nxp/clk-lpc32xx.c
> +++ b/drivers/clk/nxp/clk-lpc32xx.c
> @@ -956,7 +956,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	val &= div_mask(divider->width);
>  
>  	return divider_recalc_rate(hw, parent_rate, val, divider->table,
> -				   divider->flags);
> +				   divider->flags, divider->width);
>  }
>  
>  static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/clk-regmap-divider.c
> index 53484912301e..928fcc16ee27 100644
> --- a/drivers/clk/qcom/clk-regmap-divider.c
> +++ b/drivers/clk/qcom/clk-regmap-divider.c
> @@ -59,7 +59,7 @@ static unsigned long div_recalc_rate(struct clk_hw *hw,
>  	div &= BIT(divider->width) - 1;
>  
>  	return divider_recalc_rate(hw, parent_rate, div, NULL,
> -				   CLK_DIVIDER_ROUND_CLOSEST);
> +				   CLK_DIVIDER_ROUND_CLOSEST, divider->width);
>  }
>  
>  const struct clk_ops clk_regmap_div_ops = {
> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
> index baa3cf96507b..302a18efd39f 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.c
> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> @@ -71,7 +71,7 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
>  						  parent_rate);
>  
>  	val = divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> -				  cd->div.flags);
> +				  cd->div.flags, cd->div.width);
>  
>  	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		val /= cd->fixed_post_div;
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> index fe15aa64086f..71fe60e5f01f 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> @@ -698,7 +698,7 @@ static unsigned long dsi_pll_14nm_postdiv_recalc_rate(struct clk_hw *hw,
>  	val &= div_mask(width);
>  
>  	return divider_recalc_rate(hw, parent_rate, val, NULL,
> -				   postdiv->flags);
> +				   postdiv->flags, width);
>  }
>  
>  static long dsi_pll_14nm_postdiv_round_rate(struct clk_hw *hw,
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index 9e336184491c..0282ccc6181c 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -137,13 +137,15 @@ static unsigned long ac100_clkout_recalc_rate(struct clk_hw *hw,
>  		div = (reg >> AC100_CLKOUT_PRE_DIV_SHIFT) &
>  			((1 << AC100_CLKOUT_PRE_DIV_WIDTH) - 1);
>  		prate = divider_recalc_rate(hw, prate, div,
> -					    ac100_clkout_prediv, 0);
> +					    ac100_clkout_prediv, 0,
> +					    AC100_CLKOUT_PRE_DIV_WIDTH);
>  	}
>  
>  	div = (reg >> AC100_CLKOUT_DIV_SHIFT) &
>  		(BIT(AC100_CLKOUT_DIV_WIDTH) - 1);
>  	return divider_recalc_rate(hw, prate, div, NULL,
> -				   CLK_DIVIDER_POWER_OF_TWO);
> +				   CLK_DIVIDER_POWER_OF_TWO,
> +				   AC100_CLKOUT_DIV_WIDTH);
>  }
>  
>  static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 73ac87f34df9..4c4001086447 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -412,7 +412,7 @@ extern const struct clk_ops clk_divider_ro_ops;
>  
>  unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
>  		unsigned int val, const struct clk_div_table *table,
> -		unsigned long flags);
> +		unsigned long flags, unsigned long width);
>  long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
>  			       unsigned long rate, unsigned long *prate,
>  			       const struct clk_div_table *table,
> -- 
> 2.14.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
