From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 12 Jun 2013 23:04:33 +0200
Subject: [PATCH v4 3/6] clk: samsung: Add set_rate() clk_ops for PLL35xx
In-Reply-To: <1370272196-4346-4-git-send-email-yadi.brar@samsung.com>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
 <1370272196-4346-4-git-send-email-yadi.brar@samsung.com>
Message-ID: <18811812.9vb6COn4ou@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 of June 2013 20:39:53 Yadwinder Singh Brar wrote:
> This patch add set_rate() and round_rate() for PLL35xx
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-pll.c |  104
> ++++++++++++++++++++++++++++++++++++++++- 1 files changed, 103
> insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c
> b/drivers/clk/samsung/clk-pll.c index cba73a4..319b52b 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -27,6 +27,37 @@ struct samsung_clk_pll {
>  #define pll_writel(pll, val, offset)					\
>  		__raw_writel(val, (void __iomem *)(pll->base + (offset)));
> 
> +static const struct samsung_pll_rate_table *samsung_get_pll_settings(
> +				struct samsung_clk_pll *pll, unsigned long 
rate)
> +{
> +	const struct samsung_pll_rate_table  *rate_table = pll-
>rate_table;
> +	int i;
> +
> +	for (i = 0; i < pll->rate_count; i++) {
> +		if (rate == rate_table[i].rate)
> +			return &rate_table[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static long samsung_pll_round_rate(struct clk_hw *hw,
> +			unsigned long drate, unsigned long *prate)
> +{
> +	struct samsung_clk_pll *pll = to_clk_pll(hw);
> +	const struct samsung_pll_rate_table *rate_table = pll->rate_table;
> +	int i;
> +
> +	/* Assumming rate_table is in descending order */
> +	for (i = 0; i < pll->rate_count; i++) {
> +		if (drate >= rate_table[i].rate)
> +			return rate_table[i].rate;
> +	}
> +
> +	/* return minimum supported value */
> +	return rate_table[i - 1].rate;
> +}
> +
>  /*
>   * PLL35xx Clock Type
>   */
> @@ -34,12 +65,17 @@ struct samsung_clk_pll {
>  #define PLL35XX_CON0_OFFSET	(0x100)
>  #define PLL35XX_CON1_OFFSET	(0x104)
> 
> +/* Maximum lock time can be 270 * PDIV cycles */
> +#define PLL35XX_LOCK_FACTOR	(270)
> +
>  #define PLL35XX_MDIV_MASK       (0x3FF)
>  #define PLL35XX_PDIV_MASK       (0x3F)
>  #define PLL35XX_SDIV_MASK       (0x7)
> +#define PLL35XX_LOCK_STAT_MASK  (0x1)
>  #define PLL35XX_MDIV_SHIFT      (16)
>  #define PLL35XX_PDIV_SHIFT      (8)
>  #define PLL35XX_SDIV_SHIFT      (0)
> +#define PLL35XX_LOCK_STAT_SHIFT	(29)
> 
>  static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
>  				unsigned long parent_rate)
> @@ -59,8 +95,72 @@ static unsigned long
> samsung_pll35xx_recalc_rate(struct clk_hw *hw, return (unsigned
> long)fvco;
>  }
> 
> +static inline bool samsung_pll35xx_mp_change(
> +		const struct samsung_pll_rate_table *rate, u32 pll_con)
> +{
> +	u32 old_mdiv, old_pdiv;
> +
> +	old_mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
> +	old_pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
> +
> +	return (rate->mdiv != old_mdiv || rate->pdiv != old_pdiv);
> +}
> +
> +static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long
> drate, +					unsigned long prate)
> +{
> +	struct samsung_clk_pll *pll = to_clk_pll(hw);
> +	const struct samsung_pll_rate_table *rate;
> +	u32 tmp;
> +
> +	/* Get required rate settings from table */
> +	rate = samsung_get_pll_settings(pll, drate);
> +	if (!rate) {
> +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", 
__func__,
> +			drate, __clk_get_name(hw->clk));
> +		return -EINVAL;
> +	}
> +
> +	tmp = pll_readl(pll, PLL35XX_CON0_OFFSET);
> +
> +	if (!(samsung_pll35xx_mp_change(rate, tmp))) {
> +		/* If only s change, change just s value only*/
> +		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
> +		tmp |= rate->sdiv << PLL35XX_SDIV_SHIFT;
> +		pll_writel(pll, tmp, PLL35XX_CON0_OFFSET);

I'd use the same coding style here as in case of PLL36xx, i.e. add return 
0 and move following code outside else.

This makes the code a bit more linear and lowers indentation level.

Otherwise looks good.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

> +	} else {
> +		/* Set PLL lock time. */
> +		pll_writel(pll, rate->pdiv * PLL35XX_LOCK_FACTOR,
> +				PLL35XX_LOCK_OFFSET);
> +
> +		/* Change PLL PMS values */
> +		tmp &= ~((PLL35XX_MDIV_MASK << PLL35XX_MDIV_SHIFT) |
> +				(PLL35XX_PDIV_MASK << PLL35XX_PDIV_SHIFT) 
|
> +				(PLL35XX_SDIV_MASK << 
PLL35XX_SDIV_SHIFT));
> +		tmp |= (rate->mdiv << PLL35XX_MDIV_SHIFT) |
> +				(rate->pdiv << PLL35XX_PDIV_SHIFT) |
> +				(rate->sdiv << PLL35XX_SDIV_SHIFT);
> +		pll_writel(pll, tmp, PLL35XX_CON0_OFFSET);
> +
> +		/* wait_lock_time */
> +		do {
> +			cpu_relax();
> +			tmp = pll_readl(pll, PLL35XX_CON0_OFFSET);
> +		} while (!(tmp & (PLL35XX_LOCK_STAT_MASK
> +				<< PLL35XX_LOCK_STAT_SHIFT)));
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct clk_ops samsung_pll35xx_clk_ops = {
>  	.recalc_rate = samsung_pll35xx_recalc_rate,
> +	.round_rate = samsung_pll_round_rate,
> +	.set_rate = samsung_pll35xx_set_rate,
> +};
> +
> +static const struct clk_ops samsung_pll35xx_clk_min_ops = {
> +	.recalc_rate = samsung_pll35xx_recalc_rate,
>  };
> 
>  struct clk * __init samsung_clk_register_pll35xx(const char *name,
> @@ -79,7 +179,6 @@ struct clk * __init
> samsung_clk_register_pll35xx(const char *name, }
> 
>  	init.name = name;
> -	init.ops = &samsung_pll35xx_clk_ops;
>  	init.flags = CLK_GET_RATE_NOCACHE;
>  	init.parent_names = &pname;
>  	init.num_parents = 1;
> @@ -88,6 +187,9 @@ struct clk * __init
> samsung_clk_register_pll35xx(const char *name, pll->rate_count =
> rate_count;
>  		pll->rate_table = kmemdup(rate_table, rate_count *
>  			sizeof(struct samsung_pll_rate_table), 
GFP_KERNEL);
> +		init.ops = &samsung_pll35xx_clk_ops;
> +	} else {
> +		init.ops = &samsung_pll35xx_clk_min_ops;
>  	}
> 
>  	pll->hw.init = &init;
