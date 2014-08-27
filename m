From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Aug 2014 14:10:13 +0200
Subject: [PATCH 01/14] clk: samsung: add support for 145xx and 1460x PLLs
In-Reply-To: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
References: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <53FDCAA5.1080302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.08.2014 11:48, Naveen Krishna Chatradhi wrote:
> By registers bits and offsets the 145xx PLL is similar to
> pll_type "pll_35xx". Also, 1460x PLL is similar to pll_type
> "pll_46xx".
> 
> Hence, reusing the functions defined for pll_35xx and pll_46xx
> to support 145xx and 1460x PLLs respectively.

[snip]

> @@ -139,6 +140,7 @@ static const struct clk_ops samsung_pll3000_clk_ops = {
>  #define PLL35XX_PDIV_SHIFT      (8)
>  #define PLL35XX_SDIV_SHIFT      (0)
>  #define PLL35XX_LOCK_STAT_SHIFT	(29)
> +#define PLL145XX_ENABLE		BIT(31)

The same bit is also present in PLL35XX.

>  
>  static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
>  				unsigned long parent_rate)
> @@ -186,6 +188,10 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  
>  	tmp = __raw_readl(pll->con_reg);
>  
> +	/* Enable PLL */
> +	if (pll->type == (pll_1450x || pll_1451x || pll_1452x))
> +		tmp |= PLL145XX_ENABLE;

I believe that the need to enable the PLL is not really specific to
pll_145xx. Any PLL which is initially disabled, should be enabled before
trying to wait until it stabilizes.

> +
>  	if (!(samsung_pll35xx_mp_change(rate, tmp))) {
>  		/* If only s change, change just s value only*/
>  		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
> @@ -196,8 +202,12 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	}
>  
>  	/* Set PLL lock time. */
> -	__raw_writel(rate->pdiv * PLL35XX_LOCK_FACTOR,
> -			pll->lock_reg);
> +	if (pll->type == (pll_1450x || pll_1451x || pll_1452x))
> +		__raw_writel(rate->pdiv * PLL145XX_LOCK_FACTOR,
> +				pll->lock_reg);

If we already have lock_reg in pll, then maybe lock_factor could be
added there too and this code simply parametrized?

> +	else
> +		__raw_writel(rate->pdiv * PLL35XX_LOCK_FACTOR,
> +				pll->lock_reg);
>  
>  	/* Change PLL PMS values */
>  	tmp &= ~((PLL35XX_MDIV_MASK << PLL35XX_MDIV_SHIFT) |
> @@ -356,7 +366,6 @@ static const struct clk_ops samsung_pll36xx_clk_min_ops = {
>  
>  #define PLL45XX_ENABLE		BIT(31)
>  #define PLL45XX_LOCKED		BIT(29)
> -

Stray change?

>  static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
>  				unsigned long parent_rate)
>  {

[snip]

> @@ -573,14 +588,23 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  		lock = 0xffff;
>  
>  	/* Set PLL PMS and VSEL values. */
> -	con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
> +	if (pll->type == pll_1460x) {
> +		con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |

Shouldn't PLL1460X_MDIV_MASK be used here instead?

Best regards,
Tomasz
