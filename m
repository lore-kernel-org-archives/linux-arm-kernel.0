From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 11 May 2016 10:45:56 +0200
Subject: [PATCH 13/16] clk: sunxi-ng: Add N-K-M Factor clock
In-Reply-To: <1462737711-10017-14-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-14-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160511104556.037a2c17e3a6a0503a26fbf0@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  8 May 2016 22:01:48 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Introduce support for clocks that multiply and divide using two linear
> multipliers and one linear divider.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile  |   1 +
>  drivers/clk/sunxi-ng/ccu_nkm.c | 144 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  42 ++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nkm.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nkm.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index fba64c7f4fcd..2bb8bc22e907 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -8,6 +8,7 @@ obj-y += ccu_m.o
>  obj-y += ccu_mp.o
>  obj-y += ccu_mux.o
>  obj-y += ccu_nk.o
> +obj-y += ccu_nkm.o
>  obj-y += ccu_nm.o
>  obj-y += ccu_p.o
>  obj-y += ccu_phase.o
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> new file mode 100644
> index 000000000000..9019c7f6988c
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
	[snip]
> @@ -0,0 +1,144 @@
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
> +#include "ccu_nkm.h"
> +
> +void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
> +		       unsigned long max_n, unsigned long max_k, unsigned long max_m,
> +		       unsigned long *n, unsigned long *k, unsigned long *m)

Should be static

	[snip]

> +static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
> +			   unsigned long parent_rate)
> +{
> +	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
> +	unsigned long n, k, m;
> +	unsigned long flags;
> +	u32 reg;
> +
> +	ccu_nkm_find_best(parent_rate, rate, 1 << nkm->n.width,
> +			  1 << nkm->k.width, 1 << nkm->m.width,
> +			  &n, &k, &m);
> +
> +	spin_lock_irqsave(nkm->common.lock, flags);
> +
> +	reg = readl(nkm->common.base + nkm->common.reg);
> +	reg &= ~GENMASK(nkm->n.width + nkm->n.shift, nkm->n.shift);
> +	reg &= ~GENMASK(nkm->k.width + nkm->k.shift, nkm->k.shift);
> +	reg &= ~GENMASK(nkm->m.width + nkm->m.shift, nkm->m.shift);
> +
> +	reg |= (n - 1) << nkm->m.shift;
> +	reg |= (k - 1) << nkm->m.shift;
> +	reg |= (m - 1) << nkm->m.shift;

	reg |= (n - 1) << nkm->n.shift;
	reg |= (k - 1) << nkm->k.shift;

> +
> +	writel(reg, nkm->common.base + nkm->common.reg);
> +
> +	spin_unlock_irqrestore(nkm->common.lock, flags);
> +
> +	ccu_helper_wait_for_lock(&nkm->common, nkm->lock);
> +
> +	return 0;
> +}
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
