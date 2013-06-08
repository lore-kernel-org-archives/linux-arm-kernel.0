From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Jun 2013 14:12:07 +0200
Subject: [PATCH v3 3/6] clk: samsung: Add set_rate() clk_ops for PLL35xx
In-Reply-To: <1370003496-19288-4-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-4-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1616829.TWUbCl0XIK@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 of May 2013 18:01:33 Vikas Sajjan wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
> 
> This patch add set_rate() and round_rate() for PLL35xx
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-pll.c |  103
> ++++++++++++++++++++++++++++++++++++++++- 1 file changed, 102
> insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c
> b/drivers/clk/samsung/clk-pll.c index 8226528..9591560 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -27,6 +27,36 @@ struct samsung_clk_pll {
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
>  /*
>   * PLL35xx Clock Type
>   */
> @@ -34,12 +64,17 @@ struct samsung_clk_pll {
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
> @@ -59,8 +94,70 @@ static unsigned long
> samsung_pll35xx_recalc_rate(struct clk_hw *hw, return (unsigned
> long)fvco;
>  }
> 
> +static inline bool samsung_pll35xx_mp_change(u32 mdiv, u32 pdiv, u32
> pll_con) +{
> +	if ((mdiv != ((pll_con >> PLL35XX_MDIV_SHIFT) & 
PLL35XX_MDIV_MASK)) ||
> +		(pdiv != ((pll_con >> PLL35XX_PDIV_SHIFT) & 
PLL35XX_PDIV_MASK)))
> +		return 1;
> +	else
> +		return 0;

Readability of this function could be improved by moving some code out of 
the if clause, like:

static inline bool samsung_pll35xx_mp_change(u32 mdiv,
						u32 pdiv, u32 pll_con)
{
	u32 old_mdiv, old_pdiv;

	old_mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
	old_pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;

	return (mdiv != old_mdiv || pdiv != old_pdiv);
}

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
> +	if (!(samsung_pll35xx_mp_change(rate->mdiv, rate->pdiv, tmp))) {
> +		/* If only s change, change just s value only*/
> +		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
> +		tmp |= rate->sdiv << PLL35XX_SDIV_SHIFT;
> +		pll_writel(pll, tmp, PLL35XX_CON0_OFFSET);

To improve readability of this code, return 0 could be added here and 
following code could be moved out of the else clause.

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
> @@ -79,11 +176,15 @@ struct clk * __init
> samsung_clk_register_pll35xx(const char *name, }
> 
>  	init.name = name;
> -	init.ops = &samsung_pll35xx_clk_ops;
>  	init.flags = CLK_GET_RATE_NOCACHE;
>  	init.parent_names = &pname;
>  	init.num_parents = 1;
> 
> +	if (rate_table && rate_count)
> +		init.ops = &samsung_pll35xx_clk_ops;
> +	else
> +		init.ops = &samsung_pll35xx_clk_min_ops;
> +
>  	pll->hw.init = &init;
>  	pll->base = base;
>  	pll->rate_table = rate_table;
