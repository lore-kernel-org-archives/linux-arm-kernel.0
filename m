From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 13:21:34 +0100
Subject: [PATCH 1/7] clk: samsung: add plls used in s3c2416 and s3c2443
In-Reply-To: <513F1B42.7000201@samsung.com>
References: <201303120141.31262.heiko@sntech.de>
 <201303120142.19842.heiko@sntech.de> <513F1B42.7000201@samsung.com>
Message-ID: <201303121321.34338.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 12. M?rz 2013, 13:10:42 schrieb Sylwester Nawrocki:
> Hi,
> 
> On 03/12/2013 01:42 AM, Heiko St?bner wrote:
> > This adds support for pll2126x, pll3000x, pll6552x and pll6553x.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/clk/samsung/clk-pll.c |  376
> >  +++++++++++++++++++++++++++++++++++++++++ drivers/clk/samsung/clk-pll.h
> >  |    8 +
> >  2 files changed, 384 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/samsung/clk-pll.c
> > b/drivers/clk/samsung/clk-pll.c index 4b24511..b772f9e 100644
> > --- a/drivers/clk/samsung/clk-pll.c
> > +++ b/drivers/clk/samsung/clk-pll.c
> > @@ -400,6 +400,97 @@ struct clk * __init
> > samsung_clk_register_pll46xx(const char *name,
> 
> ...
> 
> > +struct samsung_clk_pll2126x {
> > +	struct clk_hw		hw;
> > +	const void __iomem	*con_reg;
> > +};
> > +
> > +#define to_clk_pll2126x(_hw) container_of(_hw, struct
> > samsung_clk_pll2126x, hw) +
> > +static unsigned long samsung_pll2126x_recalc_rate(struct clk_hw *hw,
> > +				unsigned long parent_rate)
> > +{
> > +	struct samsung_clk_pll2126x *pll = to_clk_pll2126x(hw);
> > +	u32 pll_con, mdiv, pdiv, sdiv;
> > +	u64 fvco = parent_rate;
> > +
> > +	pll_con = __raw_readl(pll->con_reg);
> > +	mdiv = (pll_con >> PLL2126X_MDIV_SHIFT) & PLL2126X_MDIV_MASK;
> > +	pdiv = (pll_con >> PLL2126X_PDIV_SHIFT) & PLL2126X_PDIV_MASK;
> > +	sdiv = (pll_con >> PLL2126X_SDIV_SHIFT) & PLL2126X_SDIV_MASK;
> > +
> > +	fvco *= (mdiv + 8);
> > +	do_div(fvco, (pdiv + 2) << sdiv);
> > +
> > +	return (unsigned long)fvco;
> > +}
> > +
> > +/* todo: implement pll2126x clock round rate operation */
> > +static long samsung_pll2126x_round_rate(struct clk_hw *hw,
> > +				unsigned long drate, unsigned long *prate)
> > +{
> > +	return -ENOTSUPP;
> > +}
> 
> If you look at __clk_round_rate() in drivers/clk/clk.c it calls
> clk->ops->round_rate() recursively on the parent clock if
> CLK_SET_RATE_PARENT flag is set. But if the clock provides round_rate
> operation __clk_round_rate() will use it and will cast -ENOTSUPP
> you return above to unsigned long. Unless you want to loose some hair
> later and waste time on debugging I suggest to either remove all these
> callbacks that return -ENOSUPP or implement them properly right away.

Thanks for the hint ... this is what I rightfully get for mindlessly copying 
from the other plls in the file;-) .

What about the other plls in the pll-file, they should be affected in the same 
way, right?


> I'm just wondering why __clk_round_rate() return value type is unsigned
> long despite the struct clk_ops round_rate return long, which might
> indicate the negative values round_rate might callback are properly
> handled by the clk core code.
> 
> Somewhat similar situation is with clk_mux_get_parent() in clk-mux.c
> which can return -EINVAL which is then casted to u8.
> 
> I still have sending a patch for clk_mux_get_parent() on my todo list.
> I guess we could just put a WARN_ON() there and return 0.
> 
> > +/* todo: implement pll2126x clock set rate */
> > +static int samsung_pll2126x_set_rate(struct clk_hw *hw, unsigned long
> > drate, +				unsigned long prate)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static const struct clk_ops samsung_pll2126x_clk_ops = {
> > +	.recalc_rate = samsung_pll2126x_recalc_rate,
> > +	.round_rate = samsung_pll2126x_round_rate,
> > +	.set_rate = samsung_pll2126x_set_rate,
> > +};
> 
> --
> 
> Thanks,
> Sylwester
