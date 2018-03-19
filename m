From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 22:26:38 +0100
Subject: [PATCH 1/2] clk: sunxi-ng: add missing hdmi-slow clock for H6 CCU
In-Reply-To: <20180319081108.23496-1-icenowy@aosc.io>
References: <20180319081108.23496-1-icenowy@aosc.io>
Message-ID: <20180319212638.4zi2wk76kusemqkh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 04:11:07PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 CCU has a "HDMI Slow Clock", which is currently missing
> in the ccu-sun50i-h6 driver.
> 
> Add this missing clock to the driver.
> 
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c      | 4 ++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.h      | 2 +-
>  include/dt-bindings/clock/sun50i-h6-ccu.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> index d5eab49e6350..bdbfe78fe133 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -643,6 +643,8 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents, 0xb00,
>  				 BIT(31),	/* gate */
>  				 0);
>  
> +static SUNXI_CCU_GATE(hdmi_slow_clk, "hdmi-slow", "osc24M", 0xb04, BIT(31), 0);
> +
>  static const char * const hdmi_cec_parents[] = { "osc32k", "pll-periph0-2x" };
>  static const struct ccu_mux_fixed_prediv hdmi_cec_predivs[] = {
>  	{ .index = 1, .div = 36621 },
> @@ -876,6 +878,7 @@ static struct ccu_common *sun50i_h6_ccu_clks[] = {
>  	&pcie_aux_clk.common,
>  	&bus_pcie_clk.common,
>  	&hdmi_clk.common,
> +	&hdmi_slow_clk.common,
>  	&hdmi_cec_clk.common,
>  	&bus_hdmi_clk.common,
>  	&bus_tcon_top_clk.common,
> @@ -1017,6 +1020,7 @@ static struct clk_hw_onecell_data sun50i_h6_hw_clks = {
>  		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
>  		[CLK_BUS_PCIE]		= &bus_pcie_clk.common.hw,
>  		[CLK_HDMI]		= &hdmi_clk.common.hw,
> +		[CLK_HDMI_SLOW]		= &hdmi_slow_clk.common.hw,
>  		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
>  		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
>  		[CLK_BUS_TCON_TOP]	= &bus_tcon_top_clk.common.hw,
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
> index ad6da4aa733c..ef499a7d45f2 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
> @@ -51,6 +51,6 @@
>  
>  #define CLK_BUS_DRAM		60
>  
> -#define CLK_NUMBER		137
> +#define CLK_NUMBER		(CLK_HDMI_SLOW + 1)
>  
>  #endif /* _CCU_SUN50I_H6_H_ */
> diff --git a/include/dt-bindings/clock/sun50i-h6-ccu.h b/include/dt-bindings/clock/sun50i-h6-ccu.h
> index 6045735a2821..205d09d3dc72 100644
> --- a/include/dt-bindings/clock/sun50i-h6-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-h6-ccu.h
> @@ -107,6 +107,7 @@
>  #define CLK_PCIE_AUX		121
>  #define CLK_BUS_PCIE		122
>  #define CLK_HDMI		123
> +#define CLK_HDMI_SLOW		137

It's not been in a release yet, so we can just change the other IDs.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/a3cac8c9/attachment.sig>
