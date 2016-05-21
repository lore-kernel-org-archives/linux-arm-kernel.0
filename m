From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 22 May 2016 01:09:09 +0800
Subject: [PATCH 08/16] clk: sunxi-ng: Add M-factor clock support
In-Reply-To: <1462737711-10017-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67wqsLR9QoMihSS6dkqqtyed=HqyBMJEp4adNm_xF-26Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Introduce support for clocks that divide by a linear factor.

I think we can have just one implementation for single divide factor
(either P or M)
clocks, using the CCF divider helpers. Even the divider table clock
could be merged
in.

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile |   1 +
>  drivers/clk/sunxi-ng/ccu_m.c  | 135 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_m.h  | 101 +++++++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_m.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_m.h
>
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index a47a3bbdf285..f41de901c607 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -4,5 +4,6 @@ obj-y += ccu_reset.o
>  obj-y += ccu_div_table.o
>  obj-y += ccu_fixed_factor.o
>  obj-y += ccu_gate.o
> +obj-y += ccu_m.o
>  obj-y += ccu_mux.o
>  obj-y += ccu_phase.o
> diff --git a/drivers/clk/sunxi-ng/ccu_m.c b/drivers/clk/sunxi-ng/ccu_m.c
> new file mode 100644
> index 000000000000..424eb6da0d5b
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_m.c
> @@ -0,0 +1,135 @@
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
> +#include "ccu_m.h"
> +#include "ccu_mux.h"
> +
> +static void ccu_m_find_best(unsigned long parent, unsigned long rate,
> +                           unsigned int max_m, unsigned int *m)
> +{
> +       unsigned int _m = parent / rate;
> +
> +       if (_m > max_m)
> +               _m = max_m;
> +
> +       *m = _m;
> +}

This can go.

> +
> +static unsigned long ccu_m_round_rate(struct ccu_mux_internal *mux,
> +                                      unsigned long parent_rate,
> +                                      unsigned long rate,
> +                                      void *data)
> +{
> +       struct ccu_m *cm = data;
> +       unsigned int m;
> +
> +       ccu_m_find_best(parent_rate, rate, 1 << cm->m.width, &m);
> +
> +       return parent_rate / m;

Use divider_round_rate() helper instead.

> +}
> +
> +
> +static void ccu_m_disable(struct clk_hw *hw)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +
> +       return ccu_gate_helper_disable(&cm->common, cm->enable);
> +}
> +
> +static int ccu_m_enable(struct clk_hw *hw)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +
> +       return ccu_gate_helper_enable(&cm->common, cm->enable);
> +}
> +
> +static int ccu_m_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +
> +       return ccu_gate_helper_is_enabled(&cm->common, cm->enable);
> +}
> +
> +static unsigned long ccu_m_recalc_rate(struct clk_hw *hw,
> +                                      unsigned long parent_rate)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +       unsigned long m;
> +       u32 reg;
> +
> +       reg = readl(cm->common.base + cm->common.reg);
> +
> +       m = reg >> cm->m.shift;
> +       m &= (1 << cm->m.width) - 1;
> +
> +       return parent_rate / (m + 1);

Use divider_recalc_rate() helper.

> +}
> +
> +static int ccu_m_determine_rate(struct clk_hw *hw,
> +                               struct clk_rate_request *req)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +
> +       return ccu_mux_helper_determine_rate(&cm->common, &cm->mux,
> +                                            req, ccu_m_round_rate, cm);
> +}
> +
> +static int ccu_m_set_rate(struct clk_hw *hw, unsigned long rate,
> +                         unsigned long parent_rate)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +       unsigned long flags;
> +       unsigned int m;
> +       u32 reg;
> +
> +       ccu_m_find_best(parent_rate, rate, 1 << cm->m.width, &m);

Use divider_get_val() helper.

> +
> +       spin_lock_irqsave(cm->common.lock, flags);
> +
> +       reg = readl(cm->common.base + cm->common.reg);
> +       reg &= ((1 << cm->m.width) - 1) << cm->m.shift;
> +
> +       writel(reg | ((m - 1) << cm->m.shift),
> +              cm->common.base + cm->common.reg);
> +
> +       spin_unlock_irqrestore(cm->common.lock, flags);
> +
> +       return 0;
> +}
> +
> +static u8 ccu_m_get_parent(struct clk_hw *hw)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +
> +       return ccu_mux_helper_get_parent(&cm->common, &cm->mux);
> +}
> +
> +static int ccu_m_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct ccu_m *cm = hw_to_ccu_m(hw);
> +
> +       return ccu_mux_helper_set_parent(&cm->common, &cm->mux, index);
> +}
> +
> +const struct clk_ops ccu_m_ops = {
> +       .disable        = ccu_m_disable,
> +       .enable         = ccu_m_enable,
> +       .is_enabled     = ccu_m_is_enabled,
> +
> +       .get_parent     = ccu_m_get_parent,
> +       .set_parent     = ccu_m_set_parent,
> +
> +       .determine_rate = ccu_m_determine_rate,
> +       .recalc_rate    = ccu_m_recalc_rate,
> +       .set_rate       = ccu_m_set_rate,
> +};
> diff --git a/drivers/clk/sunxi-ng/ccu_m.h b/drivers/clk/sunxi-ng/ccu_m.h
> new file mode 100644
> index 000000000000..625c0a7cef43
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_m.h
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright (c) 2016 Maxime Ripard. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _CCU_M_H_
> +#define _CCU_M_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_factor.h"
> +#include "ccu_mux.h"
> +
> +struct ccu_m {
> +       u32                     enable;

Add a field for divider flags, such as CLK_DIVIDER_ONE_BASED and
CLK_DIVIDER_POWER_OF_TWO. With these we can merge P & M factor clocks,
and also be able to handle M factors starting from both 1 and 0.

Also add a field for divider tables to merge the divider table clock.

> +
> +       struct ccu_factor       m;
> +       struct ccu_mux_internal mux;
> +       struct ccu_common       common;
> +};
> +
> +#define SUNXI_CCU_M(_struct, _name, _parent, _reg, _mshift, _mwidth,   \
> +                   _flags)                                             \
> +       struct ccu_m _struct = {                                        \
> +               .m      = SUNXI_CLK_FACTOR(_mshift, _mwidth),           \
> +               .common = {                                             \
> +                       .reg            = _reg,                         \
> +                       .hw.init        = SUNXI_HW_INIT(_name,          \
> +                                                       _parent,        \
> +                                                       &ccu_m_ops,     \
> +                                                       _flags),        \
> +               },                                                      \
> +       }
> +
> +#define SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,           \
> +                             _mshift, _mwidth, _gate,                  \
> +                             _flags)                                   \
> +       struct ccu_m _struct = {                                        \
> +               .enable = _gate,                                        \
> +               .m      = SUNXI_CLK_FACTOR(_mshift, _mwidth),           \
> +               .common = {                                             \
> +                       .reg            = _reg,                         \
> +                       .features       = CCU_FEATURE_GATE,             \
> +                       .hw.init        = SUNXI_HW_INIT(_name,          \
> +                                                       _parent,        \
> +                                                       &ccu_m_ops,     \
> +                                                       _flags),        \
> +               },                                                      \
> +       }
> +
> +#define SUNXI_CCU_M_WITH_MUX(_struct, _name, _parents, _reg,           \
> +                            _mshift, _mwidth, _muxshift, _muxwidth,    \
> +                            _flags)                                    \
> +       struct ccu_m _struct = {                                        \
> +               .m      = SUNXI_CLK_FACTOR(_mshift, _mwidth),           \
> +               .mux    = SUNXI_CLK_MUX(_muxshift, _muxwidth),          \
> +               .common = {                                             \
> +                       .reg            = _reg,                         \
> +                       .hw.init        = SUNXI_HW_INIT_PARENTS(_name,  \
> +                                                               _parents, \
> +                                                               &ccu_m_ops, \
> +                                                               _flags), \
> +               },                                                      \
> +       }

Maybe you could use the full macro below to simplify the above 3, with
the unused fields set to 0?


Regards
ChenYu

> +
> +#define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,      \
> +                                 _mshift, _mwidth, _muxshift, _muxwidth, \
> +                                 _gate, _flags)                        \
> +       struct ccu_m _struct = {                                        \
> +               .enable = _gate,                                        \
> +               .m      = SUNXI_CLK_FACTOR(_mshift, _mwidth),           \
> +               .mux    = SUNXI_CLK_MUX(_muxshift, _muxwidth),          \
> +               .common = {                                             \
> +                       .reg            = _reg,                         \
> +                       .features       = CCU_FEATURE_GATE,             \
> +                       .hw.init        = SUNXI_HW_INIT_PARENTS(_name,  \
> +                                                               _parents, \
> +                                                               &ccu_m_ops, \
> +                                                               _flags), \
> +               },                                                      \
> +       }
> +
> +static inline struct ccu_m *hw_to_ccu_m(struct clk_hw *hw)
> +{
> +       struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +       return container_of(common, struct ccu_m, common);
> +}
> +
> +extern const struct clk_ops ccu_m_ops;
> +
> +#endif /* _CCU_M_H_ */
> --
> 2.8.2
>
