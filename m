From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 May 2016 21:58:04 +0800
Subject: [PATCH 11/16] clk: sunxi-ng: Add N-K-factor clock support
In-Reply-To: <1462737711-10017-12-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-12-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65x8nxHzKG2MF8YLm6G1HHtTibxoqsNz_nzhqbzD8S-Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Introduce support for clocks that use a combination of two linear
> multipliers.

Mostly the same comments as the previous patch.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile |   1 +
>  drivers/clk/sunxi-ng/ccu_nk.c | 147 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nk.h |  44 +++++++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nk.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nk.h
>
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 09fce7467784..e29ddae99653 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -7,5 +7,6 @@ obj-y += ccu_gate.o
>  obj-y += ccu_m.o
>  obj-y += ccu_mp.o
>  obj-y += ccu_mux.o
> +obj-y += ccu_nk.o
>  obj-y += ccu_p.o
>  obj-y += ccu_phase.o
> diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
> new file mode 100644
> index 000000000000..46eede3e986e
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nk.c
> @@ -0,0 +1,147 @@
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
> +#include <linux/rational.h>
> +
> +#include "ccu_gate.h"
> +#include "ccu_nk.h"

A formula to check against would be nice.

> +void ccu_nk_find_best(unsigned long parent, unsigned long rate,
> +                     unsigned int max_n, unsigned int max_k,
> +                     unsigned int *n, unsigned int *k)
> +{
> +       unsigned long best_rate = 0;
> +       unsigned int best_k = 0, best_n =0;
> +       unsigned int _k, _n;
> +
> +       for (_k = 0; _k <= max_k; _k++) {
> +               for (_n = 0; _n <= max_n; _n++) {

I don't think 0 is a valid multiplier, regardless whether the N value in
the register starts from 0 or 1.

> +                       unsigned long tmp_rate = parent * _n * _k;
> +
> +                       if (tmp_rate > rate)
> +                               continue;
> +
> +                       if ((rate - tmp_rate) < (rate - best_rate)) {
> +                               best_rate = tmp_rate;
> +                               best_k = _k;
> +                               best_n = _n;
> +                       }
> +               }
> +       }
> +
> +       *k = best_k;
> +       *n = best_n;
> +}
> +
> +static void ccu_nk_disable(struct clk_hw *hw)
> +{
> +       struct ccu_nk *nk = hw_to_ccu_nk(hw);
> +
> +       return ccu_gate_helper_disable(&nk->common, nk->enable);
> +}
> +
> +static int ccu_nk_enable(struct clk_hw *hw)
> +{
> +       struct ccu_nk *nk = hw_to_ccu_nk(hw);
> +
> +       return ccu_gate_helper_enable(&nk->common, nk->enable);
> +}
> +
> +static int ccu_nk_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_nk *nk = hw_to_ccu_nk(hw);
> +
> +       return ccu_gate_helper_is_enabled(&nk->common, nk->enable);
> +}
> +
> +static unsigned long ccu_nk_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct ccu_nk *nk = hw_to_ccu_nk(hw);
> +       unsigned long rate, n, k;
> +       u32 reg;
> +
> +       reg = readl(nk->common.base + nk->common.reg);
> +
> +       n = reg >> nk->n.shift;
> +       n &= (1 << nk->n.width) - 1;
> +
> +       k = reg >> nk->k.shift;
> +       k &= (1 << nk->k.width) - 1;
> +
> +       rate = parent_rate * (n + 1) * (k + 1);
> +
> +       if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate = rate / nk->fixed_post_div;

I would go with "rate /= nk->fixed_post_div", but it's purely aesthetics.

> +
> +       return rate;
> +}
> +
> +static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long *parent_rate)
> +{
> +       struct ccu_nk *nk = hw_to_ccu_nk(hw);
> +       unsigned int n, k;
> +
> +       if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate = rate * nk->fixed_post_div;
> +
> +       ccu_nk_find_best(*parent_rate, rate,
> +                        1 << nk->n.width, 1 << nk->k.width,
> +                        &n, &k);
> +
> +       rate = *parent_rate * n * k;
> +       if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate = rate / nk->fixed_post_div;
> +
> +       return rate;
> +}
> +
> +static int ccu_nk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                          unsigned long parent_rate)
> +{
> +       struct ccu_nk *nk = hw_to_ccu_nk(hw);
> +       unsigned long flags;
> +       unsigned int n, k;
> +       u32 reg;
> +
> +       if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate = rate * nk->fixed_post_div;
> +
> +       ccu_nk_find_best(parent_rate, rate,
> +                        1 << nk->n.width, 1 << nk->k.width,
> +                        &n, &k);
> +
> +       spin_lock_irqsave(nk->common.lock, flags);
> +
> +       reg = readl(nk->common.base + nk->common.reg);
> +       reg &= ~GENMASK(nk->n.width + nk->n.shift, nk->n.shift);
> +       reg &= ~GENMASK(nk->k.width + nk->k.shift, nk->k.shift);

width + shift - 1

> +
> +       writel(reg | ((k - 1) << nk->k.shift) | ((n - 1) << nk->n.shift),
> +              nk->common.base + nk->common.reg);
> +
> +       spin_unlock_irqrestore(nk->common.lock, flags);
> +
> +       ccu_helper_wait_for_lock(&nk->common, nk->lock);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops ccu_nk_ops = {
> +       .disable        = ccu_nk_disable,
> +       .enable         = ccu_nk_enable,
> +       .is_enabled     = ccu_nk_is_enabled,
> +
> +       .recalc_rate    = ccu_nk_recalc_rate,
> +       .round_rate     = ccu_nk_round_rate,
> +       .set_rate       = ccu_nk_set_rate,
> +};
> diff --git a/drivers/clk/sunxi-ng/ccu_nk.h b/drivers/clk/sunxi-ng/ccu_nk.h
> new file mode 100644
> index 000000000000..cdbbd45815c6
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nk.h
> @@ -0,0 +1,44 @@
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
> +#ifndef _CCU_NK_H_
> +#define _CCU_NK_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_factor.h"
> +
> +struct ccu_nk {
> +       u16                     reg;
> +       u32                     enable;
> +       u32                     lock;
> +
> +       struct ccu_factor       n;
> +       struct ccu_factor       k;
> +
> +       unsigned int            fixed_post_div;
> +
> +       struct ccu_common       common;
> +};
> +
> +static inline struct ccu_nk *hw_to_ccu_nk(struct clk_hw *hw)
> +{
> +       struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +       return container_of(common, struct ccu_nk, common);
> +}
> +
> +extern const struct clk_ops ccu_nk_ops;

No macros for this one?


Regards
ChenYu

> +
> +#endif /* _CCU_NK_H_ */
> --
> 2.8.2
>
