From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 17 May 2017 22:19:59 +0200
Subject: [linux-sunxi] [RFC PATCH 10/11] ARM: sun8i: h3: add display
 engine pipeline for TVE
In-Reply-To: <20170517164354.16399-11-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-11-icenowy@aosc.io>
Message-ID: <1982631.bJ2xR1JVHY@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne sreda, 17. maj 2017 ob 18:43:53 CEST je Icenowy Zheng napisal(a):
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
>  arch/arm/boot/dts/sun8i-h3.dtsi | 189
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 189 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> b/arch/arm/boot/dts/sun8i-h3.dtsi index b36f9f423c39..20172ef92415 100644
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
> +		};
> +
> +		mixer0: mixer at 1100000 {
> +			compatible = "allwinner,sun8i-h3-de2-mixer0";
> +			reg = <0x01100000 0x100000>;
> +			clocks = <&display_clocks CLK_BUS_MIXER0>,
> +				 <&display_clocks CLK_MIXER0>;
> +			clock-names = "bus",
> +				      "mod";
> +			resets = <&display_clocks RST_MIXER0>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				mixer0_out: port at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +
> +					mixer0_out_tcon0: endpoint at 0 {
> +						reg = <0>;
> +						remote-endpoint = <&tcon0_in_mixer0>;
> +					};
> +
> +					mixer0_out_tcon1: endpoint at 1 {
> +						reg = <1>;
> +						remote-endpoint = <&tcon1_in_mixer0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		mixer1: mixer at 1200000 {
> +			compatible = "allwinner,sun8i-h3-de2-mixer1";
> +			reg = <0x01200000 0x100000>;
> +			clocks = <&display_clocks CLK_BUS_MIXER1>,
> +				 <&display_clocks CLK_MIXER1>;
> +			clock-names = "bus",
> +				      "mod";
> +			resets = <&display_clocks RST_WB>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				mixer1_out: port at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +
> +					mixer1_out_tcon1: endpoint at 0 {
> +						reg = <0>;
> +						remote-endpoint = <&tcon1_in_mixer1>;
> +					};
> +
> +					mixer1_out_tcon0: endpoint at 1 {
> +						reg = <1>;
> +						remote-endpoint = <&tcon0_in_mixer1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tcon0: lcd-controller at 1c0c000 {
> +			compatible = "allwinner,sun8i-h3-tcon0";
> +			reg = <0x01c0c000 0x1000>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_TCON0>,
> +				 <&ccu CLK_TCON0>;
> +			clock-names = "ahb",
> +				      "tcon-ch1";
> +			resets = <&ccu RST_BUS_TCON0>;
> +			reset-names = "lcd";
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				tcon0_in: port at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;
> +
> +					tcon0_in_mixer0: endpoint at 0 {
> +						reg = <0>;
> +						remote-endpoint = <&mixer0_out_tcon0>;
> +					};
> +
> +					tcon0_in_mixer1: endpoint at 1 {
> +						reg = <1>;
> +						remote-endpoint = <&mixer1_out_tcon0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tcon1: lcd-controller at 1c0d000 {
> +			compatible = "allwinner,sun8i-h3-tcon1";
> +			reg = <0x01c0d000 0x1000>;
> +			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_TCON1>;
> +			clock-names = "ahb";
> +			resets = <&ccu RST_BUS_TCON1>;
> +			reset-names = "lcd";
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				tcon1_in: port at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;
> +
> +					tcon1_in_mixer1: endpoint at 0 {
> +						reg = <0>;
> +						remote-endpoint = <&mixer1_out_tcon1>;
> +					};
> +
> +					tcon1_in_mixer0: endpoint at 1 {
> +						reg = <1>;
> +						remote-endpoint = <&mixer0_out_tcon1>;
> +					};
> +				};
> +
> +				tcon1_out: port at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +
> +					tcon1_out_tve0: endpoint at 1 {
> +						reg = <1>;
> +						remote-endpoint = <&tve0_in_tcon1>;
> +					};
> +				};
> +			};
> +		};
> +
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
> +			assigned-clock-rates = <216000000>;
> +
> +			port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				tve0_in_tcon1: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&tcon1_out_tve0>;
> +				};

I think there should be out endpoint to composite connector (compatible: 
"composite-video-connector").

Best regards,
Jernej

> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
IRQ_TYPE_LEVEL_LOW)>,
> --
> 2.12.2
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
