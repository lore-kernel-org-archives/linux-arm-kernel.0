From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 11 May 2016 08:46:33 +0200
Subject: [PATCH 08/16] clk: sunxi-ng: Add M-factor clock support
In-Reply-To: <1462737711-10017-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160511084633.29b56effa514996ffafd56ef@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  8 May 2016 22:01:43 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Introduce support for clocks that divide by a linear factor.
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
	[snip]
> +static int ccu_m_set_rate(struct clk_hw *hw, unsigned long rate,
> +			  unsigned long parent_rate)
> +{
> +	struct ccu_m *cm = hw_to_ccu_m(hw);
> +	unsigned long flags;
> +	unsigned int m;
> +	u32 reg;
> +
> +	ccu_m_find_best(parent_rate, rate, 1 << cm->m.width, &m);
> +
> +	spin_lock_irqsave(cm->common.lock, flags);
> +
> +	reg = readl(cm->common.base + cm->common.reg);
> +	reg &= ((1 << cm->m.width) - 1) << cm->m.shift;

Bug:
	reg &= ~GENMASK(cm->m.width + cm->m.shift, cm->m.shift);

> +
> +	writel(reg | ((m - 1) << cm->m.shift),
> +	       cm->common.base + cm->common.reg);
> +
> +	spin_unlock_irqrestore(cm->common.lock, flags);
> +
> +	return 0;
> +}
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
