From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 25 May 2013 00:19:11 +0200
Subject: [RESEND PATCH 3/5] clk: samsung: Add set_rate() clk_ops for
 PLL35xx
In-Reply-To: <1369391478-7665-4-git-send-email-vikas.sajjan@linaro.org>
References: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
 <1369391478-7665-4-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <2621811.AH1nnyyD7h@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 24 of May 2013 16:01:16 Vikas Sajjan wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
> 
> Adds set_rate() and round_rate() clk_ops for PLL35xx
> 
> The round_rate() implemenation as of now is dummy, it returns the same
> rate which is passed as input.
> 
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-pll.c |   95
> ++++++++++++++++++++++++++++++++++++++++- 1 file changed, 94
> insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c
> b/drivers/clk/samsung/clk-pll.c index b8c0260..291cc9e 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -11,6 +11,7 @@
> 
>  #include <linux/errno.h>
>  #include <linux/sort.h>
> +#include <linux/bsearch.h>
>  #include "clk.h"
>  #include "clk-pll.h"
> 
> @@ -36,6 +37,21 @@ static int samsung_compare_rate(const void *_a, const
> void *_b) return a->rate - b->rate;
>  }
> 
> +static struct samsung_pll_rate_table *samsung_get_pll_settings(
> +				struct samsung_clk_pll *pll, unsigned long 
rate)
> +{
> +	struct samsung_pll_rate_table req_rate, *tmp;
> +
> +	req_rate.rate = rate;
> +	tmp = bsearch(&req_rate, pll->rate_table, pll->rate_count,
> +			sizeof(struct samsung_pll_rate_table),
> +			samsung_compare_rate);

Binary search over < 10 entries? Isn't it a bit of overkill?

> +	if (tmp)
> +		return tmp;
> +
> +	return NULL;
> +}
> +
>  /*
>   * PLL35xx Clock Type
>   */
> @@ -46,9 +62,15 @@ static int samsung_compare_rate(const void *_a, const
> void *_b) #define PLL35XX_MDIV_MASK       (0x3FF)
>  #define PLL35XX_PDIV_MASK       (0x3F)
>  #define PLL35XX_SDIV_MASK       (0x7)
> +#define PLL35XX_LOCK_STAT_MASK  (0x1)
>  #define PLL35XX_MDIV_SHIFT      (16)
>  #define PLL35XX_PDIV_SHIFT      (8)
>  #define PLL35XX_SDIV_SHIFT      (0)
> +#define PLL35XX_LOCK_STAT_SHIFT (29)
> +
> +#define PLL35XX_MDIV(_tmp) ((_tmp) & (PLL35XX_MDIV_MASK <<
> PLL35XX_MDIV_SHIFT)) +#define PLL35XX_PDIV(_tmp) ((_tmp) &
> (PLL35XX_PDIV_MASK << PLL35XX_PDIV_SHIFT)) +#define PLL35XX_SDIV(_tmp)
> ((_tmp) & (PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT))
> 
>  static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
>  				unsigned long parent_rate)
> @@ -68,8 +90,76 @@ static unsigned long
> samsung_pll35xx_recalc_rate(struct clk_hw *hw, return (unsigned
> long)fvco;
>  }
> 
> -static const struct clk_ops samsung_pll35xx_clk_ops = {
> +static inline bool samsung_pll35xx_mp_change(u32 mdiv, u32 pdiv, u32
> pll_con) +{
> +	if ((mdiv != PLL35XX_MDIV(pll_con)) || (pdiv !=
> PLL35XX_PDIV(pll_con))) +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long
> drate, +					unsigned long prate)
> +{
> +	struct samsung_clk_pll *pll = to_clk_pll(hw);
> +	struct samsung_pll_rate_table *rate;
> +
> +	u32 tmp, mdiv, pdiv, sdiv;
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
> +	mdiv = PLL35XX_MDIV(rate->pll_con0);
> +	pdiv = PLL35XX_PDIV(rate->pll_con0);
> +	sdiv = PLL35XX_SDIV(rate->pll_con0);

You wouldn't need to use those macros if all coefficients were stored as 
separate fields in the struct.

> +
> +	tmp = pll_readl(pll, PLL35XX_CON0_OFFSET);
> +
> +	if (!(samsung_pll35xx_mp_change(mdiv, pdiv, tmp))) {
> +		/* If only s change, change just s value only*/
> +		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
> +		tmp |= sdiv;

This line is correct, but it looks like it wasn't, because:
a) the name suggests that it contains the raw value of S coefficient
b) it's real value is hidden between a macro, name of which suggests the 
same as in a) as well.

This makes the code hard to read.

> +		pll_writel(pll, tmp, PLL35XX_CON0_OFFSET);
> +	} else {
> +		/* Set PLL lock time.
> +		   Maximum lock time can be 270 * PDIV cycles */
> +		pll_writel(pll, (pdiv >> PLL35XX_PDIV_SHIFT) * 270,
> +				PLL35XX_LOCK_OFFSET);

Hmm, magic constant in the code? Shouldn't it be defined as a macro?

> +
> +		/* Change PLL PMS values */
> +		tmp &= ~((PLL35XX_MDIV_MASK << PLL35XX_MDIV_SHIFT) |
> +				(PLL35XX_PDIV_MASK << PLL35XX_PDIV_SHIFT) 
|
> +				(PLL35XX_SDIV_MASK << 
PLL35XX_SDIV_SHIFT));
> +		tmp |= mdiv | pdiv | sdiv;

This looks strange as well, even if it's correct.

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
> +static long samsung_pll35xx_round_rate(struct clk_hw *hw,
> +			unsigned long drate, unsigned long *prate)
> +{
> +	/* Clock framework cries without this, so implemented dummy */

This is completely wrong. Have you tested this code or read how Common 
Clock Framework works?

clk_set_rate() first calls ->round_rate() to get a rate supported by the 
clock that is nearest and not higher than requested rate and only then it 
calls ->set_rate() with the rate returned by ->round_rate().

So the round_rate() callback must return the highest supported rate with 
parent clock at prate and not higher than drate.

> +	return drate;
> +}
> +
> +static struct clk_ops samsung_pll35xx_clk_ops = {
>  	.recalc_rate = samsung_pll35xx_recalc_rate,
> +	.round_rate = samsung_pll35xx_round_rate,
> +	.set_rate = samsung_pll35xx_set_rate,
>  };
> 
>  struct clk * __init samsung_clk_register_pll35xx(const char *name,
> @@ -102,6 +192,9 @@ struct clk * __init
> samsung_clk_register_pll35xx(const char *name, sort(pll->rate_table,
> pll->rate_count,
>  			sizeof(struct samsung_pll_rate_table),
>  			samsung_compare_rate, NULL);
> +	} else {
> +		samsung_pll35xx_clk_ops.round_rate = NULL;
> +		samsung_pll35xx_clk_ops.set_rate = NULL;

This is completely wrong. You are changing a static structure that is used 
for all instances of PLL35xx, not only the one being registered at the 
moment.

Best regards,
Tomasz

>  	}
> 
>  	clk = clk_register(NULL, &pll->hw);
