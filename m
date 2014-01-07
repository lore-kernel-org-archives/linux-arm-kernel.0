From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:14:30 +0100
Subject: [PATCH v2 1/8] clk: sunxi: add clock-output-names dt property
 support
In-Reply-To: <1388987892-23733-2-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-2-git-send-email-wens@csie.org>
Message-ID: <20140107221430.GE3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Jan 06, 2014 at 01:58:05PM +0800, Chen-Yu Tsai wrote:
> sunxi clock drivers use dt node name as clock name, but clock
> nodes should be named clk at X, so the names would be the same.
> Let the drivers read clock names from dt clock-output-names
> property.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 19d9e9e..14a3774 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -53,6 +53,8 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
>  	if (of_property_read_u32(node, "clock-frequency", &rate))
>  		return;
>  
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
>  	/* set up gate and fixed rate properties */
>  	gate->reg = of_iomap(node, 0);
>  	gate->bit_idx = SUNXI_OSC24M_GATE;
> @@ -595,6 +597,8 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
>  	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
>  		i++;
>  
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
>  	clk = clk_register_mux(NULL, clk_name, parents, i,
>  			       CLK_SET_RATE_NO_REPARENT, reg,
>  			       data->shift, SUNXI_MUX_GATE_WIDTH,
> @@ -654,6 +658,8 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
>  
>  	clk_parent = of_clk_get_parent_name(node, 0);
>  
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
>  	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
>  				   reg, data->shift, data->width,
>  				   data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
> -- 
> 1.8.5.2
> 

Please document this in Documentation/devicetree/bindings.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/36a0c0f1/attachment.sig>
