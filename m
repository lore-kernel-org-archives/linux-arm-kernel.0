From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 15:16:55 -0700
Subject: [PATCH v4 5/7] clk: zx: add clock support to zx296702
In-Reply-To: <CABymUCOeFLd2Za8dGhoJs587xTxn-TUrS=0CZh+uYL=cKuZ1Yg@mail.gmail.com>
References: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
 <1430212691-16009-6-git-send-email-jun.nie@linaro.org>
 <CABymUCOeFLd2Za8dGhoJs587xTxn-TUrS=0CZh+uYL=cKuZ1Yg@mail.gmail.com>
Message-ID: <20150528221655.GH24204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18, Jun Nie wrote:
> 2015-04-28 17:18 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
> > It adds a clock driver for zx296702 SoC to register the clock tree to
> > Common Clock Framework.  All the clocks of bus topology and some the
> > peripheral clocks are ready with this commit. Some missing leaf clocks
> > for peripherals will be added later when needed.
> >
> Mike & Stephen,
> 
> Could you help review and ack this patch? So that this patch set can
> be merged together in Arnd side.

A bit late, but here it goes!

> > diff --git a/drivers/clk/zte/clk-pll.c b/drivers/clk/zte/clk-pll.c
> > new file mode 100644
> > index 0000000..f0ff0cb
> > --- /dev/null
> > +++ b/drivers/clk/zte/clk-pll.c
> > @@ -0,0 +1,180 @@
> > +
> > +static int zx_pll_enable(struct clk_hw *hw)
> > +{
> > +       struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
> > +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
> > +       u32 reg;
> > +
> > +       reg = readl_relaxed(zx_pll->reg_base);
> > +       writel_relaxed(reg & ~POWER_DOWN, zx_pll->reg_base);
> > +       while (!(readl_relaxed(zx_pll->reg_base) & LOCK_FLAG)) {
> > +               if (time_after(jiffies, timeout)) {

How does this work? zx_pll_enable() will be called with
interrupts disabled so it's possible that jiffies will never
increment while we're inside this loop. For polling bits we have
iopoll.h now, so maybe you can use that?

> > +                       pr_err("clk %s enable timeout\n",
> > +                               __clk_get_name(hw->clk));
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
[..]
> > +struct clk *clk_register_zx_pll(const char *name, const char *parent_name,
> > +       unsigned long flags, void __iomem *reg_base,
> > +       const struct zx_pll_config *lookup_table, int count, spinlock_t *lock)
> > +{
> > +       struct clk_zx_pll *zx_pll;
> > +       struct clk *clk;
> > +       struct clk_init_data init;
> > +
> > +       zx_pll = kzalloc(sizeof(*zx_pll), GFP_KERNEL);
> > +       if (!zx_pll)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.name = name;
> > +       init.ops = &zx_pll_ops;
> > +       init.flags = flags;
> > +       init.parent_names = (parent_name ? &parent_name : NULL);
> > +       init.num_parents = (parent_name ? 1 : 0);

Useless parentheses.

> > +
> > +       zx_pll->reg_base = reg_base;
> > +       zx_pll->lookup_table = lookup_table;
> > +       zx_pll->count = count;
> > +       zx_pll->lock = lock;
> > +       zx_pll->hw.init = &init;
> > +
> > +       clk = clk_register(NULL, &zx_pll->hw);
> > +
> > +       if (IS_ERR(clk))

Why the extra newline?

> > +               kfree(zx_pll);
> > +
> > +       return clk;
> > +}
> > diff --git a/drivers/clk/zte/clk-zx296702.c b/drivers/clk/zte/clk-zx296702.c
> > new file mode 100644
> > index 0000000..5f4d7ed
> > --- /dev/null
> > +++ b/drivers/clk/zte/clk-zx296702.c
> > @@ -0,0 +1,658 @@
> > +/*
> > + * Copyright 2014 Linaro Ltd.
> > + * Copyright (C) 2014 ZTE Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk.h>

Do you need this include? Applies to all files in this patch.

> > +#include <linux/clk-provider.h>
> > +#include <linux/of_address.h>
> > +#include <dt-bindings/clock/zx296702-clock.h>
> > +#include "clk.h"
> > +
> > +static DEFINE_SPINLOCK(reg_lock);
> > +
> > +static void __iomem *topcrm_base;
> > +static void __iomem *lsp0crpm_base;
> > +static void __iomem *lsp1crpm_base;
> > +
> > +static struct clk *topclk[ZX296702_TOPCLK_END];
> > +static struct clk *lsp0clk[ZX296702_LSP0CLK_END];
> > +static struct clk *lsp1clk[ZX296702_LSP1CLK_END];
> > +
> > +static struct clk_onecell_data topclk_data;
> > +static struct clk_onecell_data lsp0clk_data;
> > +static struct clk_onecell_data lsp1clk_data;
> > +
> > +#define CLK_MUX                        (topcrm_base + 0x04)
> > +#define CLK_DIV                        (topcrm_base + 0x08)
> > +#define CLK_EN0                        (topcrm_base + 0x0c)
> > +#define CLK_EN1                        (topcrm_base + 0x10)
> > +#define VOU_LOCAL_CLKEN                (topcrm_base + 0x68)
> > +#define VOU_LOCAL_CLKSEL       (topcrm_base + 0x70)
> > +#define VOU_LOCAL_DIV2_SET     (topcrm_base + 0x74)
> > +#define CLK_MUX1               (topcrm_base + 0x8c)
> > +
> > +#define CLK_SDMMC1             (lsp0crpm_base + 0x0c)
> > +
> > +#define CLK_UART0              (lsp1crpm_base + 0x20)
> > +#define CLK_UART1              (lsp1crpm_base + 0x24)
> > +#define CLK_SDMMC0             (lsp1crpm_base + 0x2c)
> > +
> > +static const struct zx_pll_config pll_a9_config[] = {
> > +       { .rate = 700000000, .cfg0 = 0x800405d1, .cfg1 = 0x04555555 },
> > +       { .rate = 800000000, .cfg0 = 0x80040691, .cfg1 = 0x04aaaaaa },
> > +       { .rate = 900000000, .cfg0 = 0x80040791, .cfg1 = 0x04000000 },
> > +       { .rate = 1000000000, .cfg0 = 0x80040851, .cfg1 = 0x04555555 },
> > +       { .rate = 1100000000, .cfg0 = 0x80040911, .cfg1 = 0x04aaaaaa },
> > +       { .rate = 1200000000, .cfg0 = 0x80040a11, .cfg1 = 0x04000000 },
> > +};
> > +
> > +static const struct clk_div_table main_hlk_div[] = {
> > +       { .val = 1, .div = 2, },
> > +       { .val = 3, .div = 4, },
> > +       { /* sentinel */ }
> > +};
> > +
> > +static const struct clk_div_table a9_as1_aclk_divider[] = {
> > +       { .val = 0, .div = 1, },
> > +       { .val = 1, .div = 2, },
> > +       { .val = 3, .div = 4, },
> > +       { /* sentinel */ }
> > +};
> > +
> > +static const struct clk_div_table sec_wclk_divider[] = {
> > +       { .val = 0, .div = 1, },
> > +       { .val = 1, .div = 2, },
> > +       { .val = 3, .div = 4, },
> > +       { .val = 5, .div = 6, },
> > +       { .val = 7, .div = 8, },
> > +       { /* sentinel */ }
> > +};
> > +
> > +static const char const *matrix_aclk_sel[] = {
> > +       "pll_mm0_198M",
> > +       "osc",
> > +       "clk_148M5",
> > +       "pll_lsp_104M",
> > +};
> > +
> > +static const char const *a9_wclk_sel[] = {
> > +       "pll_a9",
> > +       "osc",
> > +       "clk_500",
> > +       "clk_250",
> > +};
> > +
> > +static const char const *a9_as1_aclk_sel[] = {
> > +       "clk_250",
> > +       "osc",
> > +       "pll_mm0_396M",
> > +       "pll_mac_333M",
> > +};
> > +
> > +static const char const *a9_trace_clkin_sel[] = {
> > +       "clk_74M25",
> > +       "pll_mm1_108M",
> > +       "clk_125",
> > +       "clk_148M5",
> > +};
> > +
> > +static const char const *decppu_aclk_sel[] = {

const char const doesn't make any sense. Did you mean const char
* const instead? If so, you'll need the patch in clk-next that
* allows that to work.

> > +       "clk_250",
> > +       "pll_mm0_198M",
> > +       "pll_lsp_104M",
> > +       "pll_audio_294M912",
> > +};
> > +
> > +static const char const *vou_main_wclk_sel[] = {
> > +       "clk_148M5",
> > +       "clk_74M25",
[..]
> > diff --git a/drivers/clk/zte/clk.h b/drivers/clk/zte/clk.h
> > new file mode 100644
> > index 0000000..419d93b
> > --- /dev/null
> > +++ b/drivers/clk/zte/clk.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Copyright 2014 Linaro Ltd.
> > + * Copyright (C) 2014 ZTE Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __ZTE_CLK_H
> > +#define __ZTE_CLK_H

#include <linux/clk-provider.h> for clk_hw usage?
#include <linux/spinlock.h> for spinlock_t usage?

> > +
> > +struct zx_pll_config {
> > +       unsigned long rate;
> > +       u32 cfg0;
> > +       u32 cfg1;
> > +};
> > +
> > +struct clk_zx_pll {
> > +       struct clk_hw hw;
> > +       void __iomem *reg_base;
> > +       const struct zx_pll_config *lookup_table; /* order by rate asc */
> > +       int count;
> > +       spinlock_t *lock;
> > +};
> > +
> > +struct clk *clk_register_zx_pll(const char *name, const char *parent_name,
> > +       unsigned long flags, void __iomem *reg_base,
> > +       const struct zx_pll_config *lookup_table, int count, spinlock_t *lock);
> > +#endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
