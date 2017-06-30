From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 29 Jun 2017 18:44:52 -0700
Subject: [PATCH V1 7/9] clk: sprd: add adjustable pll support
In-Reply-To: <CAAfSe-sMy3aM9=LwpVivvHKy4hVw3GEd3U-hZe17pXM5fJRxPg@mail.gmail.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-8-chunyan.zhang@spreadtrum.com>
 <20170620013710.GJ4493@codeaurora.org>
 <CAAfSe-sMy3aM9=LwpVivvHKy4hVw3GEd3U-hZe17pXM5fJRxPg@mail.gmail.com>
Message-ID: <20170630014452.GL22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22, Chunyan Zhang wrote:
> On 20 June 2017 at 09:37, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/18, Chunyan Zhang wrote:
> >> diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
> >> index 83232e5..c593a93 100644
> >> --- a/drivers/clk/sprd/Makefile
> >> +++ b/drivers/clk/sprd/Makefile
> >> @@ -1,3 +1,3 @@
> >>  ifneq ($(CONFIG_OF),)
> >> -obj-y        += ccu_common.o ccu_gate.o ccu_mux.o ccu_div.o ccu_composite.o
> >> +obj-y        += ccu_common.o ccu_gate.o ccu_mux.o ccu_div.o ccu_composite.o ccu_pll.o
> >>  endif
> >> diff --git a/drivers/clk/sprd/ccu_pll.c b/drivers/clk/sprd/ccu_pll.c
> >> new file mode 100644
> >> index 0000000..6c908e4
> >> --- /dev/null
> >> +++ b/drivers/clk/sprd/ccu_pll.c
> >> @@ -0,0 +1,241 @@
> >> +/*
> >> + * Spreadtrum pll clock driver
> >> + *
> >> + * Copyright (C) 2015~2017 Spreadtrum, Inc.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0
> >> + */
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/clk.h>
> >
> > Is this include used? Should be clk-provider?
> 
> Right, will remove it.
> 
> >
> >> +#include <linux/err.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include "ccu_pll.h"
> >> +
> >> +#define CCU_PLL_1M   1000000
> >> +#define CCU_PLL_10M  (CCU_PLL_1M * 10)
> >> +
> >> +#define pindex(pll, member)          \
> >> +     (pll->factors[member].shift / (8 * sizeof(pll->regs[0])))
> >> +
> >> +#define pshift(pll, member)          \
> >> +     (pll->factors[member].shift % (8 * sizeof(pll->regs[0])))
> >> +
> >> +#define pwidth(pll, member)          \
> >> +     pll->factors[member].width
> >> +
> >> +#define pmask(pll, member)                                   \
> >> +     ((pwidth(pll, member)) ?                                \
> >> +     GENMASK(pwidth(pll, member) + pshift(pll, member) - 1,  \
> >> +     pshift(pll, member)) : 0)
> >> +
> >> +#define pinternal(pll, cfg, member)  \
> >> +     (cfg[pindex(pll, member)] & pmask(pll, member))
> >> +
> >> +#define pinternal_val(pll, cfg, member)      \
> >> +     (pinternal(pll, cfg, member) >> pshift(pll, member))
> >> +
> >> +static unsigned long pll_get_refin_rate(struct ccu_pll *pll)
> >
> > pll could be const?
> 
> What this function returns is a factor used to calculate the pll rate
> later, I will rename this function in the next iterator.
> 

Rename is fine, but pll can still be marked const?
> 
> >
> >> +             nint = pinternal_val(pll, cfg, PLL_NINT);
> >> +             if (pinternal(pll, cfg, PLL_SDM_EN))
> >> +                     kint = pinternal_val(pll, cfg, PLL_KINT);
> >> +
> >> +             mask = pmask(pll, PLL_KINT);
> >> +#ifdef CONFIG_64BIT
> >> +             k1 = 1000;
> >> +             k2 = 1000;
> >> +             rate = DIV_ROUND_CLOSEST(refin * kint * k1,
> >> +                                      ((mask >> __ffs(mask)) + 1)) *
> >> +                                      k2 + refin * nint * CCU_PLL_1M;
> >> +#else
> >> +             k1 = 100;
> >> +             k2 = 10000;
> >> +             i = pwidth(pll, PLL_KINT);
> >> +             i = i < 21 ? 0 : i - 21;
> >> +             rate = DIV_ROUND_CLOSEST(refin * (kint >> i) * k1,
> >> +                                      ((mask >> (__ffs(mask) + i)) + 1)) *
> >> +                                      k2 + refin * nint * CCU_PLL_1M;
> >> +#endif
> >> +     }
> >> +
> >> +     return rate;
> >> +}
> >> +
> >> +static int ccu_pll_helper_set_rate(struct ccu_pll *pll,
> >> +                                unsigned long rate,
> >> +                                unsigned long parent_rate)
> >> +{
> >> +     u32 mask, shift, width, ibias_val, index, kint, nint;
> >> +     u32 reg_num = pll->regs[0], i = 0;
> >> +     unsigned long refin, fvco = rate;
> >> +     struct reg_cfg *cfg;
> >> +
> >> +     cfg = kcalloc(reg_num, sizeof(*cfg), GFP_KERNEL);
> >> +     if (!cfg)
> >> +             return -ENOMEM;
> >> +
> >> +     refin = pll_get_refin_rate(pll);
> >> +
> >> +     mask = pmask(pll, PLL_PREDIV);
> >> +     index = pindex(pll, PLL_PREDIV);
> >> +     width = pwidth(pll, PLL_PREDIV);
> >> +     if (width && (ccu_pll_readl(pll, index) & mask))
> >> +             refin = refin * 2;
> >> +
> >> +     mask = pmask(pll, PLL_POSTDIV);
> >> +     index = pindex(pll, PLL_POSTDIV);
> >> +     width = pwidth(pll, PLL_POSTDIV);
> >> +     cfg[index].msk = mask;
> >> +     if (width && ((pll->fflag == 1 && fvco <= pll->fvco) ||
> >> +                   (pll->fflag == 0 && fvco > pll->fvco)))
> >> +             cfg[index].val |= mask;
> >> +
> >> +     if (width && fvco <= pll->fvco)
> >> +             fvco = fvco * 2;
> >> +
> >> +     mask = pmask(pll, PLL_DIV_S);
> >> +     index = pindex(pll, PLL_DIV_S);
> >> +     cfg[index].val |= mask;
> >> +     cfg[index].msk |= mask;
> >> +
> >> +     mask = pmask(pll, PLL_SDM_EN);
> >> +     index = pindex(pll, PLL_SDM_EN);
> >> +     cfg[index].val |= mask;
> >> +     cfg[index].msk |= mask;
> >> +
> >> +     nint  = fvco/(refin * CCU_PLL_1M);
> >> +
> >> +     mask = pmask(pll, PLL_NINT);
> >> +     index = pindex(pll, PLL_NINT);
> >> +     shift = pshift(pll, PLL_NINT);
> >> +     cfg[index].val |= (nint << shift) & mask;
> >> +     cfg[index].msk |= mask;
> >> +
> >> +     mask = pmask(pll, PLL_KINT);
> >> +     index = pindex(pll, PLL_KINT);
> >> +     width = pwidth(pll, PLL_KINT);
> >> +     shift = pshift(pll, PLL_KINT);
> >> +#ifndef CONFIG_64BIT
> >> +     i = width < 21 ? 0 : i - 21;
> >> +#endif
> >
> > What's this? Why do we depend on CONFIG_64BIT?
> 
> On 32-bit SoCs, the largest width we can support is limited due to the
> limitation of calculation precision.

Does the hardware width change? Still not clear to me what's
going on here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
