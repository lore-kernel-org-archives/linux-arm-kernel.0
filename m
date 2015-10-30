From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Oct 2015 14:29:02 -0700
Subject: [PATCH 01/19] clk: sunxi: Add display clock
In-Reply-To: <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151030212902.GG19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30, Maxime Ripard wrote:
> diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
> new file mode 100644
> index 000000000000..f13b095c6d7a
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright 2015 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
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

#include <linux/kernel.h> for container_of?

> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define SUN4I_A10_DISPLAY_PARENTS	3
> +
> +#define SUN4I_A10_DISPLAY_GATE_BIT	31
> +#define SUN4I_A10_DISPLAY_RESET_BIT	30
> +#define SUN4I_A10_DISPLAY_MUX_MASK	3
> +#define SUN4I_A10_DISPLAY_MUX_SHIFT	24
> +#define SUN4I_A10_DISPLAY_DIV_WIDTH	4
> +#define SUN4I_A10_DISPLAY_DIV_SHIFT	0
> +
> +struct reset_data {
> +	void __iomem			*reg;
> +	spinlock_t			*lock;
> +	struct reset_controller_dev	rcdev;
> +};
> +
> +static DEFINE_SPINLOCK(sun4i_a10_display_lock);
> +
> +static int sun4i_a10_display_assert(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	struct reset_data *data = container_of(rcdev,
> +					       struct reset_data,
> +					       rcdev);

Can this be a macro rcdev_to_reset_data() or something?

> +	unsigned long flags;
[..]
> +
> +static int sun4i_a10_display_status(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	struct reset_data *data = container_of(rcdev,
> +					       struct reset_data,
> +					       rcdev);
> +
> +	return !(readl(data->reg) & BIT(SUN4I_A10_DISPLAY_RESET_BIT));
> +}
> +
> +static struct reset_control_ops sun4i_a10_display_reset_ops = {

Someone should make it so this can be const...

> +	.assert		= sun4i_a10_display_assert,
> +	.deassert	= sun4i_a10_display_deassert,
> +	.status		= sun4i_a10_display_status,
> +};
> +
> +static int sun4i_a10_display_reset_xlate(struct reset_controller_dev *rcdev,
> +					 const struct of_phandle_args *spec)
> +{
> +	if (WARN_ON(spec->args_count != rcdev->of_reset_n_cells))
> +		return -EINVAL;

Do we really need this check? Seems like something the reset core
should handle.

> +
> +	/* We only have a single reset signal */
> +	return 0;
> +}
> +
> +static void __init sun4i_a10_display_setup(struct device_node *node)
> +{
> +	const char *parents[SUN4I_A10_DISPLAY_PARENTS];
> +	const char *clk_name = node->name;
> +	struct reset_data *reset_data;
> +	struct clk_divider *div;
> +	struct clk_gate *gate;
> +	struct clk_mux *mux;
> +	void __iomem *reg;
> +	struct clk *clk;
> +	int i;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n", clk_name);
> +		return;
> +	}
> +
> +	for (i = 0; i < SUN4I_A10_DISPLAY_PARENTS; i++)
> +		parents[i] = of_clk_get_parent_name(node, i);

of_clk_parent_fill()?

> +
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
[..]
> +		goto free_reset;
> +	}
> +
> +	return;
> +
> +free_reset:
> +	kfree(reset_data);
> +free_clk:
> +	clk_unregister(clk);

We really ought to have a clk_composite_unregister() API.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
