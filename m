From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Nov 2015 15:37:08 -0600
Subject: [PATCH v2 2/5] clk: sunxi: Add driver for the H3 THS clock
In-Reply-To: <077fddc9c8d41d4cf55b1dd1c7180c4adee0fce4.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
 <077fddc9c8d41d4cf55b1dd1c7180c4adee0fce4.1448263428.git.atx@atx.name>
Message-ID: <20151123213708.GA12308@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 09:02:49AM +0100, Josef Gajdusek wrote:
> This patch adds a driver for the THS clock which is present on the
> Allwinner H3.
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/Makefile                        |  1 +
>  drivers/clk/sunxi/clk-h3-ths.c                    | 98 +++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-h3-ths.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 23e7bce..6d63b35 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -73,6 +73,7 @@ Required properties:
>  	"allwinner,sun8i-h3-usb-clk" - for usb gates + resets on H3
>  	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
>  	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
> +	"allwinner,sun8i-h3-ths-clk" - for THS on H3
>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index f520af6..1bf8e1c 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -8,6 +8,7 @@ obj-y += clk-a10-hosc.o
>  obj-y += clk-a10-mod1.o
>  obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
> +obj-y += clk-h3-ths.o
>  obj-y += clk-mod0.o
>  obj-y += clk-simple-gates.o
>  obj-y += clk-sun8i-bus-gates.o
> diff --git a/drivers/clk/sunxi/clk-h3-ths.c b/drivers/clk/sunxi/clk-h3-ths.c
> new file mode 100644
> index 0000000..663afc0
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-h3-ths.c
> @@ -0,0 +1,98 @@
> +/*
> + * Sunxi THS clock driver
> + *
> + * Copyright (C) 2015 Josef Gajdusek
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define SUN8I_H3_THS_CLK_ENABLE				31
> +#define SUN8I_H3_THS_CLK_DIVIDER_SHIFT		0
> +#define SUN8I_H3_THS_CLK_DIVIDER_WIDTH		2
> +
> +static DEFINE_SPINLOCK(sun8i_h3_ths_clk_lock);
> +
> +static const struct clk_div_table sun8i_h3_ths_clk_table[] __initconst = {
> +	{ .val = 0, .div = 1 },
> +	{ .val = 1, .div = 2 },
> +	{ .val = 2, .div = 4 },
> +	{ .val = 3, .div = 6 },
> +	{ } /* sentinel */
> +};
> +
> +static void __init sun8i_h3_ths_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	struct clk_gate *gate;
> +	struct clk_divider *div;
> +	const char *parent;
> +	const char *clk_name = node->name;
> +	void __iomem *reg;
> +	int err;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +
> +	if (IS_ERR(reg))
> +		return;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		goto err_unmap;
> +
> +	div = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!div)
> +		goto err_gate_free;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +	parent = of_clk_get_parent_name(node, 0);
> +
> +	gate->reg = reg;
> +	gate->bit_idx = SUN8I_H3_THS_CLK_ENABLE;
> +	gate->lock = &sun8i_h3_ths_clk_lock;
> +
> +	div->reg = reg;
> +	div->shift = SUN8I_H3_THS_CLK_DIVIDER_SHIFT;
> +	div->width = SUN8I_H3_THS_CLK_DIVIDER_WIDTH;
> +	div->table = sun8i_h3_ths_clk_table;
> +	div->lock = &sun8i_h3_ths_clk_lock;
> +
> +	clk = clk_register_composite(NULL, clk_name, &parent, 1,
> +				     NULL, NULL,
> +				     &div->hw, &clk_divider_ops,
> +				     &gate->hw, &clk_gate_ops,
> +				     CLK_SET_RATE_PARENT);
> +
> +	if (IS_ERR(clk))
> +		goto err_div_free;
> +
> +	err = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	if (err)
> +		goto err_unregister_clk;
> +
> +	return;
> +
> +err_unregister_clk:
> +	clk_unregister(clk);
> +err_gate_free:
> +	kfree(gate);
> +err_div_free:
> +	kfree(div);
> +err_unmap:
> +	iounmap(reg);
> +}
> +
> +CLK_OF_DECLARE(sun8i_h3_ths_clk, "allwinner,sun8i-h3-ths-clk",
> +	       sun8i_h3_ths_clk_setup);
> -- 
> 2.4.10
> 
