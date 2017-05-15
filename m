From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 May 2017 11:24:00 +0200
Subject: [PATCH v7 11/13] ARM: sun8i: v3s: add device nodes for DE2
 display pipeline
In-Reply-To: <20170514163045.40366-12-icenowy@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
 <20170514163045.40366-12-icenowy@aosc.io>
Message-ID: <20170515092400.nzxmocrdqgt4u476@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 12:30:43AM +0800, Icenowy Zheng wrote:
> +		de2_clocks: clock at 1000000 {

display_clocks would be better there, we don't have to dissociate de1
with de2

> +			compatible = "allwinner,sun8i-v3s-de2-clk";
> +			reg = <0x01000000 0x100000>;
> +			clocks = <&ccu CLK_DE>,
> +				 <&ccu CLK_BUS_DE>;
> +			clock-names = "mod",
> +				      "bus";
> +			resets = <&ccu RST_BUS_DE>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		de2_mixer0: mixer at 1100000 {

and mixer0 here is enough too.

Is there several of them? Why not just use mixer if there's only one?

> +			compatible = "allwinner,sun8i-v3s-de2-mixer";
> +			reg = <0x01100000 0x100000>;
> +			clocks = <&de2_clocks CLK_MIXER0>,
> +				 <&de2_clocks CLK_BUS_MIXER0>;
> +			clock-names = "mod",
> +				      "bus";
> +			resets = <&de2_clocks RST_MIXER0>;
> +			assigned-clocks = <&de2_clocks CLK_MIXER0>;
> +			assigned-clock-rates = <150000000>;
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
> +				};
> +			};
> +		};
> +
> +		tcon0: lcd-controller at 1c0c000 {
> +			compatible = "allwinner,sun8i-v3s-tcon";
> +			reg = <0x01c0c000 0x1000>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_TCON0>,
> +				 <&ccu CLK_TCON0>;
> +			clock-names = "ahb",
> +				      "tcon-ch0";
> +			clock-output-names = "tcon-pixel-clock";
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
> +				};
> +
> +				tcon0_out: port at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +				};
> +			};
> +		};
> +
> +

You have an extra new line here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/bbbb2b20/attachment.sig>
