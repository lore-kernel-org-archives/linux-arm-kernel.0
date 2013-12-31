From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 31 Dec 2013 21:03:16 +0100
Subject: [PATCH v4 2/7] clk: samsung: add plls used by the s3c2443
In-Reply-To: <20131223200755.25490.91898@quantum>
References: <201312101614.29781.heiko@sntech.de>
 <201312101615.39088.heiko@sntech.de> <20131223200755.25490.91898@quantum>
Message-ID: <1561704.n1QFeDVIXH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Am Montag, 23. Dezember 2013, 12:07:55 schrieb Mike Turquette:
> Quoting Heiko St?bner (2013-12-10 07:15:38)
> 
> > The s3c2443 uses different plls that are not present yet. Therefore
> > add the two needed types.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-by: Tomasz Figa <t.figa@samsung.com>
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

did you also take a look at the real clock driver too in
 "[4/7] clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450"

because it looks like didn't get any response so far from you
(and I just saw you acking the later s3c2410 driver)


Thanks
Heiko

> 
> > ---
> > 
> >  drivers/clk/samsung/clk-pll.c |   72
> >  +++++++++++++++++++++++++++++++++++++++++ drivers/clk/samsung/clk-pll.h
> >  |    2 ++
> >  2 files changed, 74 insertions(+)
> > 
> > diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> > index c37d033..461a6bf 100644
> > --- a/drivers/clk/samsung/clk-pll.c
> > +++ b/drivers/clk/samsung/clk-pll.c
> > @@ -59,6 +59,72 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
> > 
> >  }
> >  
> >  /*
> > 
> > + * PLL2126 Clock Type
> > + */
> > +
> > +#define PLL2126_MDIV_MASK      (0xff)
> > +#define PLL2126_PDIV_MASK      (0x3f)
> > +#define PLL2126_SDIV_MASK      (0x3)
> > +#define PLL2126_MDIV_SHIFT     (16)
> > +#define PLL2126_PDIV_SHIFT     (8)
> > +#define PLL2126_SDIV_SHIFT     (0)
> > +
> > +static unsigned long samsung_pll2126_recalc_rate(struct clk_hw *hw,
> > +                               unsigned long parent_rate)
> > +{
> > +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> > +       u32 pll_con, mdiv, pdiv, sdiv;
> > +       u64 fvco = parent_rate;
> > +
> > +       pll_con = __raw_readl(pll->con_reg);
> > +       mdiv = (pll_con >> PLL2126_MDIV_SHIFT) & PLL2126_MDIV_MASK;
> > +       pdiv = (pll_con >> PLL2126_PDIV_SHIFT) & PLL2126_PDIV_MASK;
> > +       sdiv = (pll_con >> PLL2126_SDIV_SHIFT) & PLL2126_SDIV_MASK;
> > +
> > +       fvco *= (mdiv + 8);
> > +       do_div(fvco, (pdiv + 2) << sdiv);
> > +
> > +       return (unsigned long)fvco;
> > +}
> > +
> > +static const struct clk_ops samsung_pll2126_clk_ops = {
> > +       .recalc_rate = samsung_pll2126_recalc_rate,
> > +};
> > +
> > +/*
> > + * PLL3000 Clock Type
> > + */
> > +
> > +#define PLL3000_MDIV_MASK      (0xff)
> > +#define PLL3000_PDIV_MASK      (0x3)
> > +#define PLL3000_SDIV_MASK      (0x3)
> > +#define PLL3000_MDIV_SHIFT     (16)
> > +#define PLL3000_PDIV_SHIFT     (8)
> > +#define PLL3000_SDIV_SHIFT     (0)
> > +
> > +static unsigned long samsung_pll3000_recalc_rate(struct clk_hw *hw,
> > +                               unsigned long parent_rate)
> > +{
> > +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> > +       u32 pll_con, mdiv, pdiv, sdiv;
> > +       u64 fvco = parent_rate;
> > +
> > +       pll_con = __raw_readl(pll->con_reg);
> > +       mdiv = (pll_con >> PLL3000_MDIV_SHIFT) & PLL3000_MDIV_MASK;
> > +       pdiv = (pll_con >> PLL3000_PDIV_SHIFT) & PLL3000_PDIV_MASK;
> > +       sdiv = (pll_con >> PLL3000_SDIV_SHIFT) & PLL3000_SDIV_MASK;
> > +
> > +       fvco *= (2 * (mdiv + 8));
> > +       do_div(fvco, pdiv << sdiv);
> > +
> > +       return (unsigned long)fvco;
> > +}
> > +
> > +static const struct clk_ops samsung_pll3000_clk_ops = {
> > +       .recalc_rate = samsung_pll3000_recalc_rate,
> > +};
> > +
> > +/*
> > 
> >   * PLL35xx Clock Type
> >   */
> >  
> >  /* Maximum lock time can be 270 * PDIV cycles */
> > 
> > @@ -753,6 +819,12 @@ static void __init _samsung_clk_register_pll(struct
> > samsung_pll_clock *pll_clk,> 
> >         }
> >         
> >         switch (pll_clk->type) {
> > 
> > +       case pll_2126:
> > +               init.ops = &samsung_pll2126_clk_ops;
> > +               break;
> > +       case pll_3000:
> > +               init.ops = &samsung_pll3000_clk_ops;
> > +               break;
> > 
> >         /* clk_ops for 35xx and 2550 are similar */
> >         case pll_35xx:
> > 
> >         case pll_2550:
> > diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
> > index ddf9029..5b64bdb 100644
> > --- a/drivers/clk/samsung/clk-pll.h
> > +++ b/drivers/clk/samsung/clk-pll.h
> > @@ -13,6 +13,8 @@
> > 
> >  #define __SAMSUNG_CLK_PLL_H
> >  
> >  enum samsung_pll_type {
> > 
> > +       pll_2126,
> > +       pll_3000,
> > 
> >         pll_35xx,
> >         pll_36xx,
> >         pll_2550,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
