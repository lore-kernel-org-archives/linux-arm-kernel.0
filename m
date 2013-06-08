From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Jun 2013 14:17:30 +0200
Subject: [PATCH v3 4/6] clk: samsung: Add set_rate() clk_ops for PLL36xx
In-Reply-To: <1370003496-19288-5-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-5-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <22845343.Is6jxxntJZ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 of May 2013 18:01:34 Vikas Sajjan wrote:
> This patch adds set_rate and round_rate clk_ops for PLL36xx
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c |   59
> +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 59
> insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c
> b/drivers/clk/samsung/clk-pll.c index 9591560..7143ed89 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -210,6 +210,9 @@ struct clk * __init
> samsung_clk_register_pll35xx(const char *name, #define
> PLL36XX_CON0_OFFSET	(0x100)
>  #define PLL36XX_CON1_OFFSET	(0x104)
> 
> +/* Maximum lock time can be 3000 * PDIV cycles */
> +#define PLL36XX_LOCK_FACTOR	(3000)
> +
>  #define PLL36XX_KDIV_MASK	(0xFFFF)
>  #define PLL36XX_MDIV_MASK	(0x1FF)
>  #define PLL36XX_PDIV_MASK	(0x3F)
> @@ -217,6 +220,8 @@ struct clk * __init
> samsung_clk_register_pll35xx(const char *name, #define
> PLL36XX_MDIV_SHIFT	(16)
>  #define PLL36XX_PDIV_SHIFT	(8)
>  #define PLL36XX_SDIV_SHIFT	(0)
> +#define PLL36XX_KDIV_SHIFT	(0)
> +#define PLL36XX_LOCK_STAT_SHIFT	(29)
> 
>  static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
>  				unsigned long parent_rate)
> @@ -239,8 +244,57 @@ static unsigned long
> samsung_pll36xx_recalc_rate(struct clk_hw *hw, return (unsigned
> long)fvco;
>  }
> 
> +static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long
> drate, +					unsigned long parent_rate)
> +{
> +	struct samsung_clk_pll *pll = to_clk_pll(hw);
> +	u32 tmp, pll_con0, pll_con1;
> +	const struct samsung_pll_rate_table *rate;
> +
> +	rate = samsung_get_pll_settings(pll, drate);
> +	if (!rate) {
> +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", 
__func__,
> +			drate, __clk_get_name(hw->clk));
> +		return -EINVAL;
> +	}
> +
> +	pll_con0 = pll_readl(pll, PLL36XX_CON0_OFFSET);
> +	pll_con1 = pll_readl(pll, PLL36XX_CON1_OFFSET);

Hmm, PLL35xx has a fast path when only the S divisor changes. I'm not sure 
about any technical differences between these two PLLs (other than having 
the extra K factor and some more tunnables), but maybe it is possible for 
this one as well?

Otherwise looks fine.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

> +
> +	/* Set PLL lock time. */
> +	pll_writel(pll, (rate->pdiv * PLL36XX_LOCK_FACTOR),
> +			PLL36XX_LOCK_OFFSET);
> +
> +	 /* Change PLL PMS values */
> +	pll_con0 &= ~((PLL36XX_MDIV_MASK << PLL36XX_MDIV_SHIFT) |
> +			(PLL36XX_PDIV_MASK << PLL36XX_PDIV_SHIFT) |
> +			(PLL36XX_SDIV_MASK << PLL36XX_SDIV_SHIFT));
> +	pll_con0 |= (rate->mdiv << PLL36XX_MDIV_SHIFT) |
> +			(rate->pdiv << PLL36XX_PDIV_SHIFT) |
> +			(rate->sdiv << PLL36XX_SDIV_SHIFT);
> +	pll_writel(pll, pll_con0, PLL36XX_CON0_OFFSET);
> +
> +	pll_con1 &= ~(PLL36XX_KDIV_MASK << PLL36XX_KDIV_SHIFT);
> +	pll_con1 |= rate->kdiv << PLL36XX_KDIV_SHIFT;
> +	pll_writel(pll, pll_con1, PLL36XX_CON1_OFFSET);
> +
> +	/* wait_lock_time */
> +	do {
> +		cpu_relax();
> +		tmp = pll_readl(pll, PLL36XX_CON0_OFFSET);
> +	} while (!(tmp & (1 << PLL36XX_LOCK_STAT_SHIFT)));
> +
> +	return 0;
> +}
> +
>  static const struct clk_ops samsung_pll36xx_clk_ops = {
>  	.recalc_rate = samsung_pll36xx_recalc_rate,
> +	.set_rate = samsung_pll36xx_set_rate,
> +	.round_rate = samsung_pll_round_rate,
> +};
> +
> +static const struct clk_ops samsung_pll36xx_clk_min_ops = {
> +	.recalc_rate = samsung_pll36xx_recalc_rate,
>  };
> 
>  struct clk * __init samsung_clk_register_pll36xx(const char *name,
> @@ -264,6 +318,11 @@ struct clk * __init
> samsung_clk_register_pll36xx(const char *name, init.parent_names =
> &pname;
>  	init.num_parents = 1;
> 
> +	if (rate_table && rate_count)
> +		init.ops = &samsung_pll36xx_clk_ops;
> +	else
> +		init.ops = &samsung_pll36xx_clk_min_ops;
> +
>  	pll->hw.init = &init;
>  	pll->base = base;
>  	pll->rate_table = rate_table;
