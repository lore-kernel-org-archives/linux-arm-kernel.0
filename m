From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 20:06:16 +0200
Subject: [RFC PATCH 10/11] ARM: sun8i: h3: add display engine pipeline
 for TVE
In-Reply-To: <20170517164354.16399-11-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-11-icenowy@aosc.io>
Message-ID: <20170519180616.vzrlu2avuucsjkiu@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 12:43:53AM +0800, Icenowy Zheng wrote:
> As we have already the support for the TV encoder on Allwinner H3, add
> the display engine pipeline device tree nodes to its DTSI file.
> 
> The H5 pipeline has some differences and will be enabled later.
> 
> The currently-unused mixer0 and tcon0 are also needed, for the
> completement of the pipeline.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 189 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index b36f9f423c39..20172ef92415 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -41,6 +41,8 @@
>   */
>  
>  #include "sunxi-h3-h5.dtsi"
> +#include <dt-bindings/clock/sun8i-de2.h>
> +#include <dt-bindings/reset/sun8i-de2.h>
>  
>  / {
>  	cpus {
> @@ -72,6 +74,193 @@
>  		};
>  	};
>  
> +	de: display-engine {
> +		compatible = "allwinner,sun8i-h3-display-engine";
> +		allwinner,pipelines = <&mixer0>,
> +				      <&mixer1>;
> +		status = "disabled";
> +	};
> +
> +	soc {
> +		display_clocks: clock at 1000000 {
> +			compatible = "allwinner,sun8i-a83t-de2-clk";
> +			reg = <0x01000000 0x100000>;
> +			clocks = <&ccu CLK_BUS_DE>,
> +				 <&ccu CLK_DE>;
> +			clock-names = "bus",
> +				      "mod";
> +			resets = <&ccu RST_BUS_DE>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			assigned-clocks = <&ccu CLK_DE>;
> +			assigned-clock-parents = <&ccu CLK_PLL_DE>;
> +			assigned-clock-rates = <432000000>;

This shouldn't be set in the DT, but evaluated at runtime when calling
clk_set_rate.

> +		tve0: tv-encoder at 1e00000 {
> +			compatible = "allwinner,sun8i-h3-tv-encoder";
> +			reg = <0x01e00000 0x1000>;
> +			clocks = <&ccu CLK_BUS_TVE>, <&ccu CLK_TVE>;
> +			clock-names = "bus", "mod";
> +			resets = <&ccu RST_BUS_TVE>;
> +			status = "disabled";
> +
> +			assigned-clocks = <&ccu CLK_TVE>;
> +			assigned-clock-parents = <&ccu CLK_PLL_DE>;

Same thing here. clk_set_rate should just do the right thing.

> +			assigned-clock-rates = <216000000>;

And why are you setting it in the driver and in the DT?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/c57dec29/attachment.sig>
