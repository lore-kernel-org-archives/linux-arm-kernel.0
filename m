From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 15:34:10 -0700
Subject: [PATCH v3 02/19] clk: sunxi: Add display and TCON0 clocks driver
In-Reply-To: <1458751122-23976-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160415223410.GS14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23, Maxime Ripard wrote:
> diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
> new file mode 100644
> index 000000000000..af7d1faebdec
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> @@ -0,0 +1,262 @@
> +#include <linux/clk-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +struct sun4i_a10_display_clk_data {
> +	bool	has_div;
> +	u8	has_rst;

Can this be num_resets? It's not a bool but name starts with
"has".

> +	u8	parents;
> +
> +	u8	offset_en;
> +	u8	offset_div;
> +	u8	offset_mux;
> +	u8	offset_rst;
> +
> +	u8	width_div;
> +	u8	width_mux;
> +};
> +
> +
> +static int sun4i_a10_display_reset_xlate(struct reset_controller_dev *rcdev,
> +					 const struct of_phandle_args *spec)
> +{
> +	/* We only have a single reset signal */
> +	return 0;
> +}

Is there a default function for this case in the reset framework?

> +
> +static void __init sun4i_a10_display_init(struct device_node *node,
> +					  struct sun4i_a10_display_clk_data *data)

const?

> +{
> +	const char *parents[data->parents];
> +	const char *clk_name = node->name;
> +	struct reset_data *reset_data;
> +	struct clk_divider *div = NULL;
> +	struct clk_gate *gate;
> +	struct resource res;
> +	struct clk_mux *mux;
> +	void __iomem *reg;
> +	struct clk *clk;
> +	int ret;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n", clk_name);
> +		return;
> +	}
> +
> +	ret = of_clk_parent_fill(node, parents, data->parents);
> +	if (ret != data->parents) {
> +		pr_err("%s Could not retrieve the parents\n", clk_name);

Missing ':'?

> +		goto unmap;
> +	}
> +
[..]
> +
> +	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	if (ret) {
> +		pr_err("%s: Couldn't register DT provider\n", clk_name);
> +		goto free_clk;
> +	}
> +
> +	if (!data->has_rst)
> +		return;
> +
> +	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
> +	if (!reset_data)
> +		goto free_of_clk;
> +
> +	reset_data->reg = reg;
> +	reset_data->offset = data->offset_rst;
> +	reset_data->lock = &sun4i_a10_display_lock;
> +	reset_data->rcdev.nr_resets = data->has_rst;
> +	reset_data->rcdev.ops = &sun4i_a10_display_reset_ops;
> +	reset_data->rcdev.of_node = node;
> +
> +	if (data->has_rst == 1) {
> +		reset_data->rcdev.of_reset_n_cells = 0;
> +		reset_data->rcdev.of_xlate = &sun4i_a10_display_reset_xlate;
> +	} else {
> +		reset_data->rcdev.of_reset_n_cells = 1;
> +	}
> +
> +	if (reset_controller_register(&reset_data->rcdev)) {
> +		pr_err("%s: Couldn't register the reset controller\n",
> +		       clk_name);
> +		goto free_reset;
> +	}
> +
> +	return;
> +
> +free_reset:
> +	kfree(reset_data);
> +free_of_clk:
> +	of_clk_del_provider(node);
> +free_clk:
> +	clk_unregister_composite(clk);
> +free_div:
> +	if (data->has_div)

Do you need this check? div is NULL so I think no.

> +		kfree(div);
> +free_gate:
> +	kfree(gate);
> +free_mux:
> +	kfree(mux);
> +unmap:
> +	iounmap(reg);
> +	of_address_to_resource(node, 0, &res);
> +	release_mem_region(res.start, resource_size(&res));
> +}
> +
> +static struct sun4i_a10_display_clk_data sun4i_a10_tcon_ch0_data = {

const?

> +	.has_rst	= 2,
> +	.parents	= 4,
> +	.offset_en	= 31,
> +	.offset_rst	= 29,
> +	.offset_mux	= 24,
> +	.width_mux	= 2,
> +};
> +
> +static void __init sun4i_a10_tcon_ch0_setup(struct device_node *node)
> +{
> +	sun4i_a10_display_init(node, &sun4i_a10_tcon_ch0_data);
> +}
> +CLK_OF_DECLARE(sun4i_a10_tcon_ch0, "allwinner,sun4i-a10-tcon-ch0-clk",
> +	       sun4i_a10_tcon_ch0_setup);
> +
> +static struct sun4i_a10_display_clk_data sun4i_a10_display_data = {

const?

> +	.has_div	= true,
> +	.has_rst	= 1,
> +	.parents	= 3,
> +	.offset_en	= 31,
> +	.offset_rst	= 30,
> +	.offset_mux	= 24,
> +	.offset_div	= 0,
> +	.width_mux	= 2,
> +	.width_div	= 4,
> +};
> +
> +static void __init sun4i_a10_display_setup(struct device_node *node)
> +{
> +	sun4i_a10_display_init(node, &sun4i_a10_display_data);
> +}
> +CLK_OF_DECLARE(sun4i_a10_display, "allwinner,sun4i-a10-display-clk",
> +	       sun4i_a10_display_setup);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
