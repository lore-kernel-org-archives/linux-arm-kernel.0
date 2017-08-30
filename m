From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Aug 2017 16:44:09 +0200
Subject: [RESEND PATCH 1/2] arm64: allwinner: a64: add SPI nodes
In-Reply-To: <20170829202652.5476-2-stefan.bruens@rwth-aachen.de>
References: <20170829202652.5476-1-stefan.bruens@rwth-aachen.de>
 <20170829202652.5476-2-stefan.bruens@rwth-aachen.de>
Message-ID: <20170830144409.qtewwaffwof34hai@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Aug 29, 2017 at 10:26:51PM +0200, Stefan Br?ns wrote:
> The A64 SPI controllers are register compatible to the h3/h5 SPI
> controllers.
> 
> The A64 has two SPI controllers, each with a single chip select.
> The handles for the DMA channels (23/24 for SPI0/SPI1) are omitted,
> as the A64 DMA controller node is currently missing.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index bd0f33b77f57..373cd14f0206 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -325,6 +325,16 @@
>  				drive-strength = <40>;
>  			};
>  
> +			spi0_pins: spi0 {
> +				pins = "PC0", "PC1", "PC2", "PC3";
> +				function = "spi0";
> +			};
> +
> +			spi1_pins: spi1 {
> +				pins = "PD0", "PD1", "PD2", "PD3";
> +				function = "spi1";
> +			};
> +
>  			uart0_pins_a: uart0 at 0 {
>  				pins = "PB8", "PB9";
>  				function = "uart0";
> @@ -527,5 +537,35 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		spi0: spi at 01c68000 {
> +			compatible = "allwinner,sun8i-h3-spi";
> +			reg = <0x01c68000 0x1000>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +			clock-names = "ahb", "mod";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi0_pins>;
> +			resets = <&ccu RST_BUS_SPI0>;
> +			status = "disabled";
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		spi1: spi at 01c69000 {
> +			compatible = "allwinner,sun8i-h3-spi";
> +			reg = <0x01c69000 0x1000>;
> +			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> +			clock-names = "ahb", "mod";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi1_pins>;
> +			resets = <&ccu RST_BUS_SPI1>;
> +			status = "disabled";
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};

Those nodes are ordered by ascending physical base address, so they
belong a bit above were you placed them.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/535300e6/attachment.sig>
