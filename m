From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jun 2016 09:41:01 +0200
Subject: [PATCH v2 11/15] clk: sunxi-ng: Add N-M-factor clock support
In-Reply-To: <20160607204154.31967-12-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-12-maxime.ripard@free-electrons.com>
Message-ID: <20160609094101.426a13c4c61aa6cb11df16fc@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 22:41:50 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Introduce support for clocks that multiply and divide using linear factors.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> ---
> Changes from v1:
>   - Fixed the maximums for both factors passed to the rational factor
>     computation.
> ---
>  drivers/clk/sunxi-ng/Makefile |   1 +
>  drivers/clk/sunxi-ng/ccu_nm.c | 114 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nm.h |  95 +++++++++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index a201fad6b11d..5c7ae1ad1082 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -9,4 +9,5 @@ obj-y += ccu_gate.o
>  obj-y += ccu_mp.o
>  obj-y += ccu_mux.o
>  obj-y += ccu_nk.o
> +obj-y += ccu_nm.o
>  obj-y += ccu_phase.o
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> new file mode 100644
> index 000000000000..e35ddd8eec8b
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -0,0 +1,114 @@
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
> +#include "ccu_frac.h"
> +#include "ccu_gate.h"
> +#include "ccu_nm.h"
	[snip]
> +static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> +	unsigned long n, m;
> +	u32 reg;
> +
> +	if (ccu_frac_helper_is_enabled(&nm->common, &nm->frac))
> +		return ccu_frac_helper_read_rate(&nm->common, &nm->frac);
> +
> +	reg = readl(nm->common.base + nm->common.reg);
> +
> +	n = reg >> nm->n.shift;
> +	n &= (1 << nm->n.width) - 1;
> +
> +	m = reg >> nm->m.shift;
> +	m &= (1 << nm->m.width) - 1;
> +
> +	return parent_rate * (n + 1) / (m + 1);

In the H3, 'm' is a pre-divider (audio and video PLLs):

	return parent_rate / (m + 1) * (n + 1);

> +}
> +
> +static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
> +			      unsigned long *parent_rate)
> +{
> +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> +	unsigned long n, m;
> +
> +	rational_best_approximation(rate, *parent_rate,
> +				    1 << nm->n.width, 1 << nm->m.width,
> +				    &n, &m);
> +
> +	return *parent_rate * n / m;

Same here.

> +}
> +
> +static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
> +			   unsigned long parent_rate)
> +{
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
