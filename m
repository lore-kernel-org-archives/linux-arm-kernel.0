From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Feb 2015 09:24:11 +0100
Subject: [PATCH 06/13] clk: mediatek: Add basic clocks for Mediatek MT8173.
In-Reply-To: <CAAFQd5DBYU-_hvMKe86mnXau8Of5KhM1dusg9W+FmhiFuAGdpw@mail.gmail.com>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-7-git-send-email-s.hauer@pengutronix.de>
 <CAAFQd5DBYU-_hvMKe86mnXau8Of5KhM1dusg9W+FmhiFuAGdpw@mail.gmail.com>
Message-ID: <20150219082410.GU12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 06:56:53PM +0900, Tomasz Figa wrote:
> Please find my comments inline.
> 
> On Mon, Feb 9, 2015 at 7:47 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > From: James Liao <jamesjj.liao@mediatek.com>
> >
> > This patch adds basic clocks for MT8173, including TOPCKGEN, PLLs,
> > INFRA and PERI clocks.
> >
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/clk/mediatek/Makefile         |    1 +
> >  drivers/clk/mediatek/clk-mt8173-pll.c |  807 +++++++++++++++++++++++++
> >  drivers/clk/mediatek/clk-mt8173-pll.h |   14 +
> >  drivers/clk/mediatek/clk-mt8173.c     | 1035 +++++++++++++++++++++++++++++++++
> >  4 files changed, 1857 insertions(+)
> >  create mode 100644 drivers/clk/mediatek/clk-mt8173-pll.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8173-pll.h
> >  create mode 100644 drivers/clk/mediatek/clk-mt8173.c
> >
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> > index afb52e5..e030416 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -1,3 +1,4 @@
> >  obj-y += clk-mtk.o clk-pll.o clk-gate.o
> >  obj-$(CONFIG_RESET_CONTROLLER) += reset.o
> >  obj-y += clk-mt8135.o clk-mt8135-pll.o
> > +obj-y += clk-mt8173.o clk-mt8173-pll.o
> > diff --git a/drivers/clk/mediatek/clk-mt8173-pll.c b/drivers/clk/mediatek/clk-mt8173-pll.c
> > new file mode 100644
> > index 0000000..9f6f821
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8173-pll.c
> > @@ -0,0 +1,807 @@
> > +/*
> > + * Copyright (c) 2014 MediaTek Inc.
> > + * Author: James Liao <jamesjj.liao@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/clkdev.h>
> > +
> > +#include "clk-mtk.h"
> > +#include "clk-pll.h"
> > +#include "clk-mt8173-pll.h"
> > +
> > +#define PLL_BASE_EN    BIT(0)
> > +#define PLL_PWR_ON     BIT(0)
> > +#define PLL_ISO_EN     BIT(1)
> > +#define PLL_PCW_CHG    BIT(31)
> > +#define RST_BAR_MASK   BIT(24)
> > +#define AUDPLL_TUNER_EN        BIT(31)
> > +
> > +static const u32 pll_posdiv_map[8] = { 1, 2, 4, 8, 16, 16, 16, 16 };
> 
> It might be nice to have a comment what this array is for and how the
> values were calculated.

It's the table for a power of two divider. This can be calculated, no
need for a table.

> 
> > +
> > +static u32 mtk_calc_pll_vco_freq(
> > +               u32 fin,
> > +               u32 pcw,
> > +               u32 vcodivsel,
> > +               u32 prediv,
> > +               u32 pcwfbits)
> > +{
> > +       /* vco = (fin * pcw * vcodivsel / prediv) >> pcwfbits; */
> > +       u64 vco = fin;
> > +       u8 c = 0;
> > +
> > +       vco = vco * pcw * vcodivsel;
> 
> Could you use here (u64)fin directly for increased readability and
> drop the initialization of vco?

yes

> 
> > +       do_div(vco, prediv);
> > +
> > +       if (vco & GENMASK(pcwfbits - 1, 0))
> > +               c = 1;
> 
> What is c? Could the variable has a more meaningful name?

I have no idea. This is not explained in the datasheet.

> 
> > +
> > +       vco >>= pcwfbits;
> > +
> > +       if (c)
> > +               ++vco;
> > +
> > +       return (u32)vco;
> > +}
> > +
> > +static u32 mtk_freq_limit(u32 freq)
> > +{
> > +       static const u64 freq_max = 3000UL * 1000 * 1000;       /* 3000 MHz */
> 
> 3 GHz probably? Could you define (if not defined somewhere already) a
> macro for GHZ and write this as 3 * GHZ?

Did that.

> 
> > +       static const u32 freq_min = 1000 * 1000 * 1000 / 16;    /* 62.5 MHz */
> 
> Why don't you write it as 62500 * KHZ or 62 * MHZ + 500 * KHZ?
> 
> > +
> > +       if (freq <= freq_min)
> > +               freq = freq_min + 16;
> 
> Could you explain what's happening here? Where does the 16 come from
> and why it is not defined as a macro?

I don't know what's going on here. What I find suspicious is that when
freq is between freq_min and freq_min + 16 it is not changed. I just
dropped this. Whoever thinks he needs this can probably explain what
it's good for.

> 
> > +       else if (freq > freq_max)
> > +               freq = freq_max;
> > +
> > +       return freq;
> > +}
> > +
> > +static int mtk_calc_pll_freq_cfg(
> > +               u32 *pcw,
> > +               u32 *postdiv_idx,
> > +               u32 freq,
> > +               u32 fin,
> > +               int pcwfbits)
> > +{
> > +       static const u64 freq_max = 3000UL * 1000 * 1000;       /* 3000 MHz */
> > +       static const u64 freq_min = 1000 * 1000 * 1000;         /* 1000 MHz */
> > +       static const u64 postdiv[] = { 1, 2, 4, 8, 16 };
> > +       u64 n_info;
> > +       u32 idx;
> > +
> > +       /* search suitable postdiv */
> > +       for (idx = *postdiv_idx;
> > +               idx < ARRAY_SIZE(postdiv) && postdiv[idx] * freq <= freq_min;
> > +               idx++)
> > +               ;
> 
> Please document the arguments of this function. It is not obvious why
> the value at postdiv_idx is used as starting point, even though this
> pointer is also used to store the output value...

It seems it is used by some callers to ensure a minimum divider.

> 
> > +
> > +       if (idx >= ARRAY_SIZE(postdiv))
> > +               return -EINVAL; /* freq is out of range (too low) */
> > +       else if (postdiv[idx] * freq > freq_max)
> > +               return -EINVAL; /* freq is out of range (too high) */
> > +
> > +       /* n_info = freq * postdiv / 26MHz * 2^pcwfbits */
> > +       n_info = (postdiv[idx] * freq) << pcwfbits;
> > +       do_div(n_info, fin);
> > +
> > +       *postdiv_idx = idx;
> > +       *pcw = (u32)n_info;
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_clk_pll_is_enabled(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> > +
> > +       return (readl_relaxed(pll->base_addr) & PLL_BASE_EN) != 0;
> > +}
> > +
> > +static int mtk_clk_pll_prepare(struct clk_hw *hw)
> 
> Hmm, contents of this function don't seem to sleep. Maybe this should
> be enable instead of prepare?

Hm, I think I rather use usleep_range instead of udelay and keep it in
the prepare/unprepare path. I don't think there's need to enable/disable
the PLLs in the hot pathes.

> > +const struct clk_ops mt8173_arm_pll_ops = {
> > +       .is_enabled     = mtk_clk_pll_is_enabled,
> > +       .prepare        = mtk_clk_pll_prepare,
> > +       .unprepare      = mtk_clk_pll_unprepare,
> 
> Uhh, this is incorrect. If you provide prepare+unprepare, you also
> need to provide is_prepared, not is_enabled. However, considering my
> comments above, it should be possible to use enable+disable instead.

I will decide for one of both.

> 
> > +       .recalc_rate    = mtk_clk_arm_pll_recalc_rate,
> > +       .round_rate     = mtk_clk_pll_round_rate,
> > +       .set_rate       = mtk_clk_arm_pll_set_rate,
> > +};
> > +
> > +static long mtk_clk_mm_pll_round_rate(
> > +               struct clk_hw *hw,
> > +               unsigned long rate,
> > +               unsigned long *prate)
> > +{
> > +       u32 pcwfbits = 14;
> > +       u32 pcw = 0;
> > +       u32 postdiv = 0;
> > +       u32 r;
> > +
> > +       if (rate <= 702000000)
> > +               postdiv = 2;
> > +
> > +       *prate = *prate ? *prate : 26000000;
> 
> I feel like it wouldn't really be a bad idea to define all the numeric
> constants as macros.

The above is unnecessary. The clk framework will never call us with
prate == NULL.

> > +       /* postdiv */
> > +       con0 &= ~UNIV_PLL_POSTDIV_MASK;
> > +       con0 |= postdiv_idx << UNIV_PLL_POSTDIV_L;
> > +
> > +       /* fkbdiv */
> > +       con1 &= ~UNIV_PLL_FBKDIV_MASK;
> > +       con1 |= pcw << UNIV_PLL_FBKDIV_L;
> > +
> > +       writel_relaxed(con0, con0_addr);
> > +       writel_relaxed(con1, con1_addr);
> > +
> > +       if (pll_en) {
> > +               wmb();  /* sync write before delay */
> 
> The comment should say why, not what, because you can easily see that
> from the code (wmb() before udelay(20) obviously can't be anything
> else than "sync write before delay").

I'll drop the comment.

> > +       parent_rate = parent_rate ? parent_rate : 26000000;
> > +       r = mtk_calc_pll_freq_cfg(&pcw, &postdiv_idx, rate,
> > +                       parent_rate, pcwfbits);
> > +
> > +       if (r == 0)
> 
> I wonder if you shouldn't consider adding an error message to opposite case.

I'l refactor this so that mtk_calc_pll_freq_cfg() can't fail. This won't
be necessary anymore.

> > +static int mtk_clk_aud_pll_prepare(struct clk_hw *hw)
> > +{
> > +       unsigned long flags = 0;
> 
> No need to initialize.
> 
> > +       struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> > +       void __iomem *con0_addr = pll->base_addr;
> > +       void __iomem *con2_addr = pll->base_addr + 8;
> 
> A macro for the offset would look better.
> 
> > +       u32 r;
> > +
> > +       spin_lock_irqsave(pll->lock, flags);
> > +
> > +       r = readl_relaxed(pll->pwr_addr) | PLL_PWR_ON;
> > +       writel_relaxed(r, pll->pwr_addr);
> > +       wmb();  /* sync write before delay */
> 
> Why? And couldn't you use writel() instead of writel_relaxed() + wmb()?

The original author claims this is needed. I can't prove the opposite,
so I kept it.

Anyway, it seems that writel() is writel_relaxed() + a wmb(), so I'll
change it.

> > +#include <dt-bindings/clock/mt8173-clk.h>
> > +
> > +/* ROOT */
> > +#define clk_null               "clk_null"
> > +#define clk26m                 "clk26m"
> > +#define clk32k                 "clk32k"
> 
> Hmm, what's this? What's the purpose of defining the same string, just
> without the quotation marks?

I think the intention was to let the compiler detect typos when using
the same strings multiple times. I don't like this either, will drop.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
