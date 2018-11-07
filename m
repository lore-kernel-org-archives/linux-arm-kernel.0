From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 7 Nov 2018 12:25:59 +0000
Subject: [PATCH v9 2/5] clk: imx: add fractional PLL output clock
In-Reply-To: <153980638471.5275.2935268205764106887@swboyd.mtv.corp.google.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-3-git-send-email-abel.vesa@nxp.com>
 <153980638471.5275.2935268205764106887@swboyd.mtv.corp.google.com>
Message-ID: <20181107122558.mlul4keytay4lrtc@fsr-ub1664-175>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:59:44PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:54)
> > From: Lucas Stach <l.stach@pengutronix.de>
> > 
> > This is a new clock type introduced on i.MX8.
> 
> Ok, what's the clock type? Add another sentence please.
> 

Added in the next version a link with the pdf describing the hardware
and specified in the commit message that is a fractional clock.

> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> [..]
> > diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
> > new file mode 100644
> > index 0000000..030df76
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-frac-pll.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2018 NXP.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/jiffies.h>
> 
> Is this used for something?
>

Removed in the next version.

> > +#include <linux/slab.h>
> > +#include <linux/bitfield.h>
> > +
> > +#include "clk.h"
> [...]
> > +
> > +static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> > +                                        unsigned long parent_rate)
> > +{
> > +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> > +       u32 val, divff, divfi, divq;
> > +       u64 temp64;
> > +
> > +       val = readl_relaxed(pll->base + PLL_CFG0);
> > +       divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
> > +       val = readl_relaxed(pll->base + PLL_CFG1);
> > +       divff = FIELD_GET(PLL_FRAC_DIV_MASK, val);
> > +       divfi = (val & PLL_INT_DIV_MASK);
> 
> Nitpick: Drop useless parenthesis please.
> 

Removed in the next version.

> > +
> > +       temp64 = (u64)parent_rate * 8;
> > +       temp64 *= divff;
> > +       do_div(temp64, PLL_FRAC_DENOM);
> > +       temp64 /= divq;
> > +
> > +       return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
> > +}
> > +
> > +static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                              unsigned long *prate)
> > +{
> > +       unsigned long parent_rate = *prate;
> > +       u32 divff, divfi;
> > +       u64 temp64;
> > +
> > +       parent_rate *= 8;
> 
> And parent_rate can't overflow if it's a u32? Maybe it could be a u64 so
> that we don't need casting later on in this function.
> 

Fixed in the next version.

> > +       rate *= 2;
> > +       divfi = rate / parent_rate;
> > +       temp64 = (u64)(rate - divfi * parent_rate);
> > +       temp64 *= PLL_FRAC_DENOM;
> > +       do_div(temp64, parent_rate);
> > +       divff = temp64;
> > +
> > +       temp64 = (u64)parent_rate;
> > +       temp64 *= divff;
> > +       do_div(temp64, PLL_FRAC_DENOM);
> > +
> > +       return (parent_rate * divfi + (unsigned long)temp64) / 2;
> > +}
> > +
> > +/*
> > + * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' at zero
> > + * (means the PLL output will be divided by 2). So the PLL output can use
> > + * the below formula:
> > + * pllout = parent_rate * 8 / 2 * DIVF_VAL;
> > + * where DIVF_VAL = 1 + DIVFI + DIVFF / 2^24.
> > + */
> > +static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                           unsigned long parent_rate)
> > +{
> > +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> > +       u32 val, divfi, divff;
> > +       u64 temp64;
> > +       int ret;
> > +
> > +       parent_rate *= 8;
> > +       rate *= 2;
> > +       divfi = rate / parent_rate;
> > +       temp64 = (u64) (rate - divfi * parent_rate);
> > +       temp64 *= PLL_FRAC_DENOM;
> > +       do_div(temp64, parent_rate);
> > +       divff = temp64;
> > +
> > +       val = readl_relaxed(pll->base + PLL_CFG1);
> > +       val &= ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
> > +       val |= ((divff << 7) | (divfi - 1));
> 
> Nitpick: Drop the extra parenthesis please.
> 

Removed in the next version.

> > +       writel_relaxed(val, pll->base + PLL_CFG1);
> > +
> > +       val = readl_relaxed(pll->base + PLL_CFG0);
> > +       val &= ~0x1f;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       /* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
> > +       val = readl_relaxed(pll->base + PLL_CFG0);
> > +       val |= PLL_NEWDIV_VAL;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       ret = clk_wait_ack(pll);
> > +
> > +       /* clear the NEV_DIV_VAL */
> > +       val = readl_relaxed(pll->base + PLL_CFG0);
> > +       val &= ~PLL_NEWDIV_VAL;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct clk_ops clk_frac_pll_ops = {
> > +       .prepare        = clk_pll_prepare,
> > +       .unprepare      = clk_pll_unprepare,
> > +       .is_prepared    = clk_pll_is_prepared,
> > +       .recalc_rate    = clk_pll_recalc_rate,
> > +       .round_rate     = clk_pll_round_rate,
> > +       .set_rate       = clk_pll_set_rate,
> > +};
> > +
> > +struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
> > +                            void __iomem *base)
> > +{
> > +       struct clk_init_data init;
> > +       struct clk_frac_pll *pll;
> > +       struct clk *clk;
> > +
> > +       pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> > +       if (!pll)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       pll->base = base;
> > +       init.name = name;
> > +       init.ops = &clk_frac_pll_ops;
> > +       init.flags = 0;
> > +       init.parent_names = &parent_name;
> > +       init.num_parents = 1;
> > +
> > +       pll->hw.init = &init;
> > +
> > +       clk = clk_register(NULL, &pll->hw);
> 
> clk_hw based please.
> 

Fixed in the next version.

> > +       if (IS_ERR(clk))
> > +               kfree(pll);
> > +
> > +       return clk;
> > +}

-- 
