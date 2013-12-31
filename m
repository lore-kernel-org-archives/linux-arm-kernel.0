From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 31 Dec 2013 11:45:29 -0800
Subject: [PATCH 06/12] clk: samsung: add plls used by the early s3c24xx
 cpus
In-Reply-To: <201312131400.55201.heiko@sntech.de>
References: <201312131356.40755.heiko@sntech.de>
 <201312131400.55201.heiko@sntech.de>
Message-ID: <20131231194529.12054.56504@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2013-12-13 05:00:54)
> The manuals do not give them explicit names like in later socs, so more
> generic names with a s3c2410-prefix were used for them.
> 
> As it was common to do so in the previous implementation, functionality
> to change the pll rate is already included.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/samsung/clk-pll.c |  182 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-pll.h |    3 +
>  2 files changed, 185 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index 461a6bf..39573bd 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/hrtimer.h>
> +#include <linux/delay.h>
>  #include "clk.h"
>  #include "clk-pll.h"
>  
> @@ -701,6 +702,169 @@ static const struct clk_ops samsung_pll6553_clk_ops = {
>  };
>  
>  /*
> + * PLL Clock Type of S3C24XX before S3C2443
> + */
> +
> +#define PLLS3C2410_MDIV_MASK           (0xff)
> +#define PLLS3C2410_PDIV_MASK           (0x1f)
> +#define PLLS3C2410_SDIV_MASK           (0x3)
> +#define PLLS3C2410_MDIV_SHIFT          (12)
> +#define PLLS3C2410_PDIV_SHIFT          (4)
> +#define PLLS3C2410_SDIV_SHIFT          (0)
> +
> +#define PLLS3C2410_ENABLE_REG_OFFSET   0x10
> +
> +static unsigned long samsung_s3c2410_pll_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> +       u32 pll_con, mdiv, pdiv, sdiv;
> +       u64 fvco = parent_rate;
> +
> +       pll_con = __raw_readl(pll->con_reg);
> +       mdiv = (pll_con >> PLLS3C2410_MDIV_SHIFT) & PLLS3C2410_MDIV_MASK;
> +       pdiv = (pll_con >> PLLS3C2410_PDIV_SHIFT) & PLLS3C2410_PDIV_MASK;
> +       sdiv = (pll_con >> PLLS3C2410_SDIV_SHIFT) & PLLS3C2410_SDIV_MASK;
> +
> +       fvco *= (mdiv + 8);
> +       do_div(fvco, (pdiv + 2) << sdiv);
> +
> +       return (unsigned int)fvco;
> +}
> +
> +static unsigned long samsung_s3c2440_mpll_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> +       u32 pll_con, mdiv, pdiv, sdiv;
> +       u64 fvco = parent_rate;
> +
> +       pll_con = __raw_readl(pll->con_reg);
> +       mdiv = (pll_con >> PLLS3C2410_MDIV_SHIFT) & PLLS3C2410_MDIV_MASK;
> +       pdiv = (pll_con >> PLLS3C2410_PDIV_SHIFT) & PLLS3C2410_PDIV_MASK;
> +       sdiv = (pll_con >> PLLS3C2410_SDIV_SHIFT) & PLLS3C2410_SDIV_MASK;
> +
> +       fvco *= (2 * (mdiv + 8));
> +       do_div(fvco, (pdiv + 2) << sdiv);
> +
> +       return (unsigned int)fvco;
> +}
> +
> +static int samsung_s3c2410_pll_set_rate(struct clk_hw *hw, unsigned long drate,
> +                                       unsigned long prate)
> +{
> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> +       const struct samsung_pll_rate_table *rate;
> +       u32 tmp;
> +
> +       /* Get required rate settings from table */
> +       rate = samsung_get_pll_settings(pll, drate);
> +       if (!rate) {
> +               pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
> +                       drate, __clk_get_name(hw->clk));
> +               return -EINVAL;
> +       }
> +
> +       tmp = __raw_readl(pll->con_reg);
> +
> +       /* Change PLL PMS values */
> +       tmp &= ~((PLLS3C2410_MDIV_MASK << PLLS3C2410_MDIV_SHIFT) |
> +                       (PLLS3C2410_PDIV_MASK << PLLS3C2410_PDIV_SHIFT) |
> +                       (PLLS3C2410_SDIV_MASK << PLLS3C2410_SDIV_SHIFT));
> +       tmp |= (rate->mdiv << PLLS3C2410_MDIV_SHIFT) |
> +                       (rate->pdiv << PLLS3C2410_PDIV_SHIFT) |
> +                       (rate->sdiv << PLLS3C2410_SDIV_SHIFT);
> +       __raw_writel(tmp, pll->con_reg);
> +
> +       /* Time to settle according to the manual */
> +       udelay(300);
> +
> +       return 0;
> +}
> +
> +static int samsung_s3c2410_pll_enable(struct clk_hw *hw, int bit, bool enable)
> +{
> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> +       u32 pll_en = __raw_readl(pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
> +       u32 pll_en_orig = pll_en;
> +
> +       if (enable)
> +               pll_en &= ~BIT(bit);
> +       else
> +               pll_en |= BIT(bit);
> +
> +       __raw_writel(pll_en, pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
> +
> +       /* if we started the UPLL, then allow to settle */
> +       if (enable && (pll_en_orig & BIT(bit)))
> +               udelay(300);
> +
> +       return 0;
> +}
> +
> +static int samsung_s3c2410_mpll_enable(struct clk_hw *hw)
> +{
> +       return samsung_s3c2410_pll_enable(hw, 5, true);
> +}
> +
> +static void samsung_s3c2410_mpll_disable(struct clk_hw *hw)
> +{
> +       samsung_s3c2410_pll_enable(hw, 5, false);
> +}
> +
> +static int samsung_s3c2410_upll_enable(struct clk_hw *hw)
> +{
> +       return samsung_s3c2410_pll_enable(hw, 7, true);
> +}
> +
> +static void samsung_s3c2410_upll_disable(struct clk_hw *hw)
> +{
> +       samsung_s3c2410_pll_enable(hw, 7, false);
> +}
> +
> +static const struct clk_ops samsung_s3c2410_mpll_clk_min_ops = {
> +       .recalc_rate = samsung_s3c2410_pll_recalc_rate,
> +       .enable = samsung_s3c2410_mpll_enable,
> +       .disable = samsung_s3c2410_mpll_disable,
> +};
> +
> +static const struct clk_ops samsung_s3c2410_upll_clk_min_ops = {
> +       .recalc_rate = samsung_s3c2410_pll_recalc_rate,
> +       .enable = samsung_s3c2410_upll_enable,
> +       .disable = samsung_s3c2410_upll_disable,
> +};
> +
> +static const struct clk_ops samsung_s3c2440_mpll_clk_min_ops = {
> +       .recalc_rate = samsung_s3c2440_mpll_recalc_rate,
> +       .enable = samsung_s3c2410_mpll_enable,
> +       .disable = samsung_s3c2410_mpll_disable,
> +};
> +
> +static const struct clk_ops samsung_s3c2410_mpll_clk_ops = {
> +       .recalc_rate = samsung_s3c2410_pll_recalc_rate,
> +       .enable = samsung_s3c2410_mpll_enable,
> +       .disable = samsung_s3c2410_mpll_disable,
> +       .round_rate = samsung_pll_round_rate,
> +       .set_rate = samsung_s3c2410_pll_set_rate,
> +};
> +
> +static const struct clk_ops samsung_s3c2410_upll_clk_ops = {
> +       .recalc_rate = samsung_s3c2410_pll_recalc_rate,
> +       .enable = samsung_s3c2410_upll_enable,
> +       .disable = samsung_s3c2410_upll_disable,
> +       .round_rate = samsung_pll_round_rate,
> +       .set_rate = samsung_s3c2410_pll_set_rate,
> +};
> +
> +static const struct clk_ops samsung_s3c2440_mpll_clk_ops = {
> +       .recalc_rate = samsung_s3c2440_mpll_recalc_rate,
> +       .enable = samsung_s3c2410_mpll_enable,
> +       .disable = samsung_s3c2410_mpll_disable,
> +       .round_rate = samsung_pll_round_rate,
> +       .set_rate = samsung_s3c2410_pll_set_rate,
> +};
> +
> +/*
>   * PLL2550x Clock Type
>   */
>  
> @@ -866,6 +1030,24 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
>                 else
>                         init.ops = &samsung_pll46xx_clk_ops;
>                 break;
> +       case pll_s3c2410_mpll:
> +               if (!pll->rate_table)
> +                       init.ops = &samsung_s3c2410_mpll_clk_min_ops;
> +               else
> +                       init.ops = &samsung_s3c2410_mpll_clk_ops;
> +               break;
> +       case pll_s3c2410_upll:
> +               if (!pll->rate_table)
> +                       init.ops = &samsung_s3c2410_upll_clk_min_ops;
> +               else
> +                       init.ops = &samsung_s3c2410_upll_clk_ops;
> +               break;
> +       case pll_s3c2440_mpll:
> +               if (!pll->rate_table)
> +                       init.ops = &samsung_s3c2440_mpll_clk_min_ops;
> +               else
> +                       init.ops = &samsung_s3c2440_mpll_clk_ops;
> +               break;
>         default:
>                 pr_warn("%s: Unknown pll type for pll clk %s\n",
>                         __func__, pll_clk->name);
> diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
> index 5b64bdb..6428bcc 100644
> --- a/drivers/clk/samsung/clk-pll.h
> +++ b/drivers/clk/samsung/clk-pll.h
> @@ -28,6 +28,9 @@ enum samsung_pll_type {
>         pll_6552,
>         pll_6552_s3c2416,
>         pll_6553,
> +       pll_s3c2410_mpll,
> +       pll_s3c2410_upll,
> +       pll_s3c2440_mpll,
>  };
>  
>  #define PLL_35XX_RATE(_rate, _m, _p, _s)                       \
> -- 
> 1.7.10.4
> 
