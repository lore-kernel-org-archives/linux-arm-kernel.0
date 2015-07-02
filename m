From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 14:52:03 -0700
Subject: [PATCH v2 5/9] clk: rockchip: add support for phase inverters
In-Reply-To: <1434637116-17124-6-git-send-email-heiko@sntech.de>
References: <1434637116-17124-1-git-send-email-heiko@sntech.de>
 <1434637116-17124-6-git-send-email-heiko@sntech.de>
Message-ID: <20150702215203.GI4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Heiko Stuebner wrote:
> Most Rockchip socs have optional phase inverters connected to some
> clocks that move the clock-phase by 180 degrees.
> While not having any actual influence on the rate, the inverter
> provides its own simple recalc_rate callback as relying on the
> fallback in the framework is for "lazy developers" according

I don't have a problem with being lazy. We should update the
documentation to encourage less code by omitting recalc_rate if
possible instead.

> diff --git a/drivers/clk/rockchip/clk-inverter.c b/drivers/clk/rockchip/clk-inverter.c
> new file mode 100644
> index 0000000..db852cd
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-inverter.c
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright 2015 Heiko Stuebner <heiko@sntech.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>

#include <linux/io.h> ?
#include <linux/spinlock.h> ?
#include <linux/kernel.h> ? // for container_of

> +#include "clk.h"
> +
> +struct rockchip_inv_clock {
> +	struct clk_hw	hw;
> +	void __iomem	*reg;
> +	int		shift;
> +	int		flags;
> +	spinlock_t	*lock;
> +};
> +
> +#define to_inv_clock(_hw) container_of(_hw, struct rockchip_inv_clock, hw)
> +
> +#define INVERTER_MASK 0x1
> +
> +static unsigned long rockchip_inv_recalc(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	return parent_rate;
> +}
> +
> +static int rockchip_inv_get_phase(struct clk_hw *hw)
> +{
> +	struct rockchip_inv_clock *inv_clock = to_inv_clock(hw);
> +	u32 val;
> +
> +	val = readl(inv_clock->reg) >> (inv_clock->shift) & INVERTER_MASK;

What's the parentheses for? Is it supposed to be around the
readl() and the shift?

> +	return val ? 180 : 0;
> +}
> +
> +static int rockchip_inv_set_phase(struct clk_hw *hw, int degrees)
> +{

I'm not too familiar with phase api, but the range of degrees
would be 0 to 360.

> +	struct rockchip_inv_clock *inv_clock = to_inv_clock(hw);
> +	u32 val;
> +
> +	switch (degrees) {
> +	case 0:
> +		val = 0;
> +		break;
> +	case 180:
> +		val = 1;
> +		break;
> +	default:
> +		pr_err("%s: unsupported phase %d for %s\n",
> +		       __func__, degrees, __clk_get_name(hw->clk));
> +		return -EINVAL;
> +	}

So this could be

	if (degrees % 180 == 0) {
		val = !!degrees;
	} else {
		pr_err("%s: unsupported phase %d for %s\n",
		       __func__, degrees, __clk_get_name(hw->clk));
		return -EINVAL;
	}

and save some lines?

> +
> +static const struct clk_ops rockchip_inv_clk_ops = {
> +	.recalc_rate	= rockchip_inv_recalc,
> +	.get_phase	= rockchip_inv_get_phase,
> +	.set_phase	= rockchip_inv_set_phase,
> +};
> +
> +struct clk *rockchip_clk_register_inverter(const char *name,
> +				const char *const *parent_names, u8 num_parents,
> +				void __iomem *reg, int shift, int flags,
> +				spinlock_t *lock)
> +{
> +	struct clk_init_data init;
> +	struct rockchip_inv_clock *inv_clock;
> +	struct clk *clk;
> +
> +	inv_clock = kmalloc(sizeof(*inv_clock), GFP_KERNEL);
> +	if (!inv_clock)
> +		return NULL;
> +
> +	init.num_parents = num_parents;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = parent_names;
> +	init.ops = &rockchip_inv_clk_ops;
> +
> +	inv_clock->hw.init = &init;
> +	inv_clock->reg = reg;
> +	inv_clock->shift = shift;
> +	inv_clock->flags = flags;
> +	inv_clock->lock = lock;
> +
> +	if (name)
> +		init.name = name;

And if name is NULL? init.name is junk?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
