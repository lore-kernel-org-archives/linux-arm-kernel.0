From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 28 Jan 2014 16:38:46 -0300
Subject: [linux-sunxi] [PATCH v2 1/5] clk: sunxi: Add support for USB
 clock-register reset bits
In-Reply-To: <1390426587-16287-2-git-send-email-hdegoede@redhat.com>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
 <1390426587-16287-2-git-send-email-hdegoede@redhat.com>
Message-ID: <52E80746.9020500@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

El 22/01/14 18:36, Hans de Goede escribi?:
> The usb-clk register is special in that it not only contains clk gate bits,
> but also has a few reset bits. This commit adds support for this by allowing
> gates type sunxi clks to also register a reset controller.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
(snip)
>   static const struct gates_data sun4i_axi_gates_data __initconst = {
> @@ -818,6 +873,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>   					 struct gates_data *data)
>   {
>   	struct clk_onecell_data *clk_data;
> +	struct gates_reset_data *reset_data;
>   	const char *clk_parent;
>   	const char *clk_name;
>   	void *reg;
> @@ -861,6 +917,21 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>   	clk_data->clk_num = i;
>
>   	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +
> +	/* Register a reset controler for gates with reset bits */
> +	if (data->reset_mask == 0)
> +		return;
> +
> +	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
> +	if (!reset_data)
> +		return;
> +
> +	reset_data->reg = reg;
> +	reset_data->lock = &clk_lock;
> +	reset_data->rcdev.nr_resets = hweight32(data->reset_mask);

I know I made you change this, but after having a second look into 
nr_resets, I think your original implementation makes more sense. This 
will break if you use a mask with holes on it. Sorry :(

> +	reset_data->rcdev.ops = &sunxi_gates_reset_ops;
> +	reset_data->rcdev.of_node = node;
> +	reset_controller_register(&reset_data->rcdev);
>   }

Emilio
