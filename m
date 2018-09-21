From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 20 Sep 2018 17:01:56 -0700
Subject: [PATCH v7 4/5] clk: imx: add imx composite clock
In-Reply-To: <1537438000-20313-5-git-send-email-abel.vesa@nxp.com>
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
 <1537438000-20313-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAHQ1cqEZ4_xR+Xhbt6Deiqn9dFPx7hfVKfsMXjfGTe6QisVG_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 3:07 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one composite clock,
> but we need to deal with both predivider and divider at the same time and
> therefore we add the imx_clk_composite_divider_ops and register the composite
> clock with those.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-composite.c | 155 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h           |  11 +++
>  3 files changed, 167 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b87513c..4fabb0a 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -3,6 +3,7 @@
>  obj-y += \
>         clk.o \
>         clk-busy.o \
> +       clk-composite.o \
>         clk-cpu.o \
>         clk-fixup-div.o \
>         clk-fixup-mux.o \
> diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
> new file mode 100644
> index 0000000..40c2aa8
> --- /dev/null
> +++ b/drivers/clk/imx/clk-composite.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +
> +#include "clk.h"
> +
> +#define PCG_PREDIV_SHIFT       16
> +#define PCG_PREDIV_WIDTH       3
> +
> +#define PCG_DIV_SHIFT          0
> +#define PCG_DIV_WIDTH          6
> +
> +#define PCG_PCS_SHIFT          24
> +#define PCG_PCS_MASK           0x7
> +
> +#define PCG_CGC_SHIFT          28
> +
> +static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +       unsigned int prediv_value;
> +       unsigned int div_value;
> +
> +       prediv_value = clk_readl(divider->reg) >> divider->shift;
> +       prediv_value &= clk_div_mask(divider->width);
> +
> +       prediv_rate = divider_recalc_rate(hw, parent_rate, prediv_value,
> +                                               NULL, divider->flags,
> +                                               divider->width);
> +
> +       div_value = clk_readl(divider->reg) >> PCG_DIV_SHIFT;
> +       div_value &= clk_div_mask(PCG_DIV_WIDTH);
> +
> +       return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
> +                                  divider->flags, PCG_DIV_WIDTH);
> +}
> +
> +static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
> +                                               unsigned long rate,
> +                                               unsigned long *prate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +
> +       prediv_rate = divider_round_rate(hw, rate, prate, divider->table,
> +                                 divider->width, divider->flags);
> +       return divider_round_rate(hw, rate, &prediv_rate, divider->table,
> +                                 PCG_DIV_WIDTH, divider->flags);
> +}
> +
> +static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
> +                                       unsigned long rate,
> +                                       unsigned long parent_rate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +       unsigned long flags = 0;
> +       int prediv_value;
> +       int div_value;
> +       u32 val;
> +
> +       prediv_value = divider_get_val(rate, parent_rate, NULL,
> +                               PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +       if (prediv_value < 0)
> +               return prediv_value;
> +
> +       prediv_rate = DIV_ROUND_UP_ULL((u64)parent_rate, prediv_value + 1);
> +
> +       div_value = divider_get_val(rate, prediv_rate, NULL,
> +                               PCG_DIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +       if (div_value < 0)
> +               return div_value;
> +
> +       spin_lock_irqsave(divider->lock, flags);
> +
> +       val = clk_readl(divider->reg);
> +       val &= ~((clk_div_mask(divider->width) << divider->shift) |
> +                       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
> +
> +       val |= (u32)prediv_value << divider->shift;
> +       val |= (u32)div_value << PCG_DIV_SHIFT;
> +       clk_writel(val, divider->reg);
> +
> +       spin_unlock_irqrestore(divider->lock, flags);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops imx_clk_composite_divider_ops = {
> +       .recalc_rate = imx_clk_composite_divider_recalc_rate,
> +       .round_rate = imx_clk_composite_divider_round_rate,
> +       .set_rate = imx_clk_composite_divider_set_rate,
> +};
> +
> +struct clk *imx_clk_composite_flags(const char *name,
> +                                       const char **parent_names,
> +                                       int num_parents, void __iomem *reg,
> +                                       unsigned long flags)
> +{
> +       struct clk_hw *mux_hw = NULL, *div_hw = NULL, *gate_hw = NULL;
> +       struct clk_divider *div = NULL;
> +       struct clk_gate *gate = NULL;
> +       struct clk_mux *mux = NULL;
> +       struct clk *clk;
> +
> +       mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +       if (!mux)
> +               return ERR_PTR(-ENOMEM);
> +       mux_hw = &mux->hw;
> +       mux->reg = reg;
> +       mux->shift = PCG_PCS_SHIFT;
> +       mux->mask = PCG_PCS_MASK;
> +
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div) {
> +               kfree(mux);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       div_hw = &div->hw;
> +       div->reg = reg;
> +       div->shift = PCG_PREDIV_SHIFT;
> +       div->width = PCG_PREDIV_WIDTH;
> +       div->lock = &imx_ccm_lock;
> +       div->flags = CLK_DIVIDER_ROUND_CLOSEST;
> +
> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate) {
> +               kfree(mux);
> +               kfree(div);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       gate_hw = &gate->hw;
> +       gate->reg = reg;
> +       gate->bit_idx = PCG_CGC_SHIFT;
> +
> +       clk = clk_register_composite(NULL, name, parent_names, num_parents,
> +                                       mux_hw, &clk_mux_ops, div_hw,
> +                                       &imx_clk_composite_divider_ops, gate_hw,
> +                                       &clk_gate_ops, flags);
> +       if (IS_ERR(clk)) {
> +               kfree(mux);
> +               kfree(div);
> +               kfree(gate);

Minor suggestion: using goto to free resource in this case might be
more straightforward and require less repeatition.

> +       }
> +
> +       return clk;
> +}
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 12b3fd6..74d8d46 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -232,4 +232,15 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
>                 struct clk *div, struct clk *mux, struct clk *pll,
>                 struct clk *step);
>
> +struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
> +               int num_parents, void __iomem *reg, unsigned long flags);
> +
> +#define imx_clk_composite(name, parent_names, reg) \
> +       imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
> +                                       CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> +
> +#define imx_clk_composite_critical(name, parent_names, reg) \
> +       imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
> +                               CLK_IS_CRITICAL | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)

Another minor suggestion is to define a intermediary macro and define
both imx_clk_composite_critical() and imx_clk_composite() in terms of
it. Say:

#define __imx_clk_composite(name, parent_names, reg, flags) \
    imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
                                             flags |
CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)

#define imx_clk_composite(name, parent_names, reg)
__imx_clk_composite_flags(name, parent_names, reg, 0)
#define imx_clk_composite_critical(name, parent_names, reg)
__imx_clk_composite_flags(name, parent_names, reg, CLK_IS_CRITICAL)

this way it might be a bit easier to spot that the only difference
between the two is CLK_IS_CRITICAL.

Thanks,
Andrey Smirnov
