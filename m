From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jun 2016 09:39:49 +0200
Subject: [PATCH v2 05/15] clk: sunxi-ng: Add gate clock support
In-Reply-To: <20160607204154.31967-6-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-6-maxime.ripard@free-electrons.com>
Message-ID: <20160609093949.b1a7a89aa1448226113b8b1d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 22:41:44 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Some clocks in the Allwinner SoCs clocks unit are just simple gates. Add
> support for those clocks.
> 
> Since it's a feature that can also be found in more complex clocks, provide
> a bunch of helpers that can be reused later on.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile   |  1 +
>  drivers/clk/sunxi-ng/ccu_gate.c | 82 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_gate.h | 53 ++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_gate.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_gate.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index c59cf2ea509b..608b332e0b1f 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -4,3 +4,4 @@ obj-y += ccu_reset.o
>  obj-y += ccu_frac.o
>  
>  obj-y += ccu_fixed_factor.o
> +obj-y += ccu_gate.o
> diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
> new file mode 100644
> index 000000000000..1e98f8a33ac3
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_gate.c
> @@ -0,0 +1,82 @@
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
> +
> +void ccu_gate_helper_disable(struct ccu_common *common, u32 gate)
> +{
> +	unsigned long flags;
> +	u32 reg;
> +
> +	if (!(common->features & CCU_FEATURE_GATE))
> +		return;

	if (!gate)
		return;

seems simpler and permits to remove the feature flag.

> +
> +	spin_lock_irqsave(common->lock, flags);
> +
> +	reg = readl(common->base + common->reg);
> +	writel(reg & ~gate, common->base + common->reg);
> +
> +	spin_unlock_irqrestore(common->lock, flags);
> +}
> +
> +static void ccu_gate_disable(struct clk_hw *hw)
> +{
> +	struct ccu_gate *cg = hw_to_ccu_gate(hw);
> +
> +	return ccu_gate_helper_disable(&cg->common, cg->enable);
> +}
> +
> +int ccu_gate_helper_enable(struct ccu_common *common, u32 gate)
> +{
> +	unsigned long flags;
> +	u32 reg;
> +
> +	if (!(common->features & CCU_FEATURE_GATE))
> +		return 0;

Same as above.

> +
> +	spin_lock_irqsave(common->lock, flags);
> +
> +	reg = readl(common->base + common->reg);
> +	writel(reg | gate, common->base + common->reg);
> +
> +	spin_unlock_irqrestore(common->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ccu_gate_enable(struct clk_hw *hw)
> +{
> +	struct ccu_gate *cg = hw_to_ccu_gate(hw);
> +
> +	return ccu_gate_helper_enable(&cg->common, cg->enable);
> +}
> +
> +int ccu_gate_helper_is_enabled(struct ccu_common *common, u32 gate)
> +{
> +	if (!(common->features & CCU_FEATURE_GATE))
> +		return 1;

Same.

> +
> +	return readl(common->base + common->reg) & gate;
> +}
> +
> +static int ccu_gate_is_enabled(struct clk_hw *hw)
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
