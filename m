From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 22 May 2016 00:18:26 +0800
Subject: [PATCH 05/16] clk: sunxi-ng: Add mux clock support
In-Reply-To: <1462737711-10017-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66FShuDB_YH37x+VymjrpD+Q9OA2D=b3=MyaLkfFySvmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some clocks in the Allwinner SoCs clocks unit are just muxes.
>
> However, those muxes might also be found in some other complicated clocks
> that would benefit from the code in there to deal with "advanced" features,
> like pre-dividers.
>
> Introduce a set of helpers to reduce the code duplication in such cases.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile  |   1 +
>  drivers/clk/sunxi-ng/ccu_mux.c | 187 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_mux.h |  80 +++++++++++++++++-
>  3 files changed, 264 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_mux.c
>
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index fc01127b3b45..aa5c411ff8ea 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -3,3 +3,4 @@ obj-y += ccu_reset.o
>
>  obj-y += ccu_fixed_factor.o
>  obj-y += ccu_gate.o
> +obj-y += ccu_mux.o
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
> new file mode 100644
> index 000000000000..cb54a8931de3
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (C) 2016 Maxime Ripard
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_gate.h"
> +#include "ccu_mux.h"
> +
> +void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
> +                                            struct ccu_mux_internal *cm,
> +                                            int parent_index,
> +                                            unsigned long *parent_rate)
> +{
> +       u8 prediv = 1;
> +       u32 reg;
> +
> +       if (!((common->features & CCU_FEATURE_FIXED_PREDIV) ||
> +             (common->features & CCU_FEATURE_VARIABLE_PREDIV)))
> +               return;
> +
> +       reg = readl(common->base + common->reg);
> +       if (parent_index < 0) {
> +               parent_index = reg >> cm->shift;
> +               parent_index &= (1 << cm->width) - 1;
> +       }
> +
> +       if (common->features & CCU_FEATURE_FIXED_PREDIV)
> +               if (parent_index == cm->fixed_prediv.index)
> +                       prediv = cm->fixed_prediv.div;
> +
> +       if (common->features & CCU_FEATURE_VARIABLE_PREDIV)
> +               if (parent_index == cm->variable_prediv.index) {
> +                       u8 div;
> +
> +                       div = reg >> cm->variable_prediv.shift;
> +                       div &= (1 << cm->variable_prediv.width) - 1;
> +                       prediv = div + 1;
> +               }
> +
> +       *parent_rate = *parent_rate / prediv;
> +}
> +
> +int ccu_mux_helper_determine_rate(struct ccu_common *common,
> +                                 struct ccu_mux_internal *cm,
> +                                 struct clk_rate_request *req,
> +                                 unsigned long (*round)(struct ccu_mux_internal *,
> +                                                        unsigned long,
> +                                                        unsigned long,
> +                                                        void *),
> +                                 void *data)
> +{
> +       unsigned long best_parent_rate = 0, best_rate = 0;
> +       struct clk_hw *best_parent, *hw = &common->hw;
> +       unsigned int i;
> +
> +       for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> +               unsigned long tmp_rate, parent_rate;
> +               struct clk_hw *parent;
> +
> +               parent = clk_hw_get_parent_by_index(hw, i);
> +               if (!parent)
> +                       continue;
> +
> +               parent_rate = clk_hw_get_rate(parent);

Using clk-mux.c as a reference, you should honor CLK_SET_RATE_PARENT here.

> +               ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
> +                                                       &parent_rate);

ccu_mux_helper_adjust_parent_for_prediv can modify parent_rate. You
should probably save a copy...

> +
> +               tmp_rate = round(cm, clk_hw_get_rate(parent), req->rate, data);
> +               if (tmp_rate == req->rate) {
> +                       best_parent = parent;
> +                       best_parent_rate = parent_rate;

... to assign to best_parent_rate. The returned best_parent_rate is used
to change the parent clock rate. This happens if CLK_SET_RATE_PARENT is set.
The CCF doesn't know about our predivs, so you should pass back the original
rate, not the one after the prediv.

I suppose you didn't run into problems as CLK_SET_RATE_PARENT was not used
anywhere?

Regards
ChenYu

> +                       best_rate = tmp_rate;
> +                       goto out;
> +               }
> +
> +               if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> +                       best_rate = tmp_rate;
> +                       best_parent_rate = parent_rate;
> +                       best_parent = parent;
> +               }
> +       }
> +
> +       if (best_rate == 0)
> +               return -EINVAL;
> +
> +out:
> +       req->best_parent_hw = best_parent;
> +       req->best_parent_rate = best_parent_rate;
> +       req->rate = best_rate;
> +       return 0;
> +}
> +
> +u8 ccu_mux_helper_get_parent(struct ccu_common *common,
> +                            struct ccu_mux_internal *cm)
> +{
> +       u32 reg;
> +       u8 parent;
> +
> +       reg = readl(common->base + common->reg);
> +       parent = reg >> cm->shift;
> +       parent &= (1 << cm->width) - 1;
> +
> +       return parent;
> +}
> +
> +int ccu_mux_helper_set_parent(struct ccu_common *common,
> +                             struct ccu_mux_internal *cm,
> +                             u8 index)
> +{
> +       unsigned long flags;
> +       u32 reg;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       reg = readl(common->base + common->reg);
> +       reg &= ~GENMASK(cm->width + cm->shift, cm->shift);
> +       writel(reg | (index << cm->shift), common->base + common->reg);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void ccu_mux_disable(struct clk_hw *hw)
> +{
> +       struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +       return ccu_gate_helper_disable(&cm->common, cm->enable);
> +}
> +
> +static int ccu_mux_enable(struct clk_hw *hw)
> +{
> +       struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +       return ccu_gate_helper_enable(&cm->common, cm->enable);
> +}
> +
> +static int ccu_mux_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +       return ccu_gate_helper_is_enabled(&cm->common, cm->enable);
> +}
> +
> +static u8 ccu_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +       return ccu_mux_helper_get_parent(&cm->common, &cm->mux);
> +}
> +
> +static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +       return ccu_mux_helper_set_parent(&cm->common, &cm->mux, index);
> +}
> +
> +static unsigned long ccu_mux_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +       ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
> +                                               &parent_rate);
> +
> +       return parent_rate;
> +}
> +
> +const struct clk_ops ccu_mux_ops = {
> +       .disable        = ccu_mux_disable,
> +       .enable         = ccu_mux_enable,
> +       .is_enabled     = ccu_mux_is_enabled,
> +
> +       .get_parent     = ccu_mux_get_parent,
> +       .set_parent     = ccu_mux_set_parent,
> +
> +       .determine_rate = __clk_mux_determine_rate,
> +       .recalc_rate    = ccu_mux_recalc_rate,
> +};
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
> index 17cedad4e433..c85707f80f68 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.h
> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
> @@ -1,20 +1,92 @@
>  #ifndef _CCU_MUX_H_
>  #define _CCU_MUX_H_
>
> -#include "common.h"
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
>
>  struct ccu_mux_internal {
>         u8      shift;
>         u8      width;
>
> -       u8      *map;
> +       struct {
> +               u8      index;
> +               u8      div;
> +       } fixed_prediv;
> +
> +       struct {
> +               u8      index;
> +               u8      shift;
> +               u8      width;
> +       } variable_prediv;
>  };
>
> -#define SUNXI_CLK_MUX(_shift, _width, _map)    \
> +#define SUNXI_CLK_MUX(_shift, _width)  \
>         {                                       \
> -               .map    = _map,                 \
>                 .shift  = _shift,               \
>                 .width  = _width,               \
>         }
>
> +struct ccu_mux {
> +       u16                     reg;
> +       u32                     enable;
> +
> +       struct ccu_mux_internal mux;
> +       struct ccu_common       common;
> +};
> +
> +#define SUNXI_CCU_MUX(_struct, _name, _parents, _reg, _shift, _width, _flags) \
> +       struct ccu_mux _struct = {                                      \
> +               .mux    = SUNXI_CLK_MUX(_shift, _width),                \
> +               .common = {                                             \
> +                       .reg            = _reg,                         \
> +                       .hw.init        = SUNXI_HW_INIT_PARENTS(_name,  \
> +                                                               _parents, \
> +                                                               &ccu_mux_ops, \
> +                                                               _flags), \
> +               }                                                       \
> +       }
> +
> +#define SUNXI_CCU_MUX_WITH_GATE(_struct, _name, _parents, _reg,                \
> +                               _shift, _width, _gate, _flags)          \
> +       struct ccu_mux _struct = {                                      \
> +               .enable = _gate,                                        \
> +               .mux    = SUNXI_CLK_MUX(_shift, _width),                \
> +               .common = {                                             \
> +                       .reg            = _reg,                         \
> +                       .features       = CCU_FEATURE_GATE,             \
> +                       .hw.init        = SUNXI_HW_INIT_PARENTS(_name,  \
> +                                                               _parents, \
> +                                                               &ccu_mux_ops, \
> +                                                               _flags), \
> +               }                                                       \
> +       }
> +
> +static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
> +{
> +       struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +       return container_of(common, struct ccu_mux, common);
> +}
> +
> +extern const struct clk_ops ccu_mux_ops;
> +
> +void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
> +                                            struct ccu_mux_internal *cm,
> +                                            int parent_index,
> +                                            unsigned long *parent_rate);
> +int ccu_mux_helper_determine_rate(struct ccu_common *common,
> +                                 struct ccu_mux_internal *cm,
> +                                 struct clk_rate_request *req,
> +                                 unsigned long (*round)(struct ccu_mux_internal *,
> +                                                        unsigned long,
> +                                                        unsigned long,
> +                                                        void *),
> +                                 void *data);
> +u8 ccu_mux_helper_get_parent(struct ccu_common *common,
> +                            struct ccu_mux_internal *cm);
> +int ccu_mux_helper_set_parent(struct ccu_common *common,
> +                             struct ccu_mux_internal *cm,
> +                             u8 index);
> +
>  #endif /* _CCU_MUX_H_ */
> --
> 2.8.2
>
