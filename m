From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 17:44:42 +0200
Subject: [PATCH] ARM: dts: sun8i: Add SPI controller node in H3
In-Reply-To: <20161019134608.12850-1-woogyom.kim@gmail.com>
References: <20161019134608.12850-1-woogyom.kim@gmail.com>
Message-ID: <20161020154442.m2lphzwfabjacw5t@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milo,

On Wed, Oct 19, 2016 at 10:46:08PM +0900, Milo Kim wrote:
> H3 supports two SPI controllers. Four pins (MOSI, MISO, SCLK, SS) are
> configured through the pinctrl subsystem. It is almost same as A31 SPI
> except buffer size, so those DT properties are reusable.
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>

Ideally, this would be part of your serie to add the H3 support to the
spi driver. This way, you make it explicit that there is a dependency
between the two, and it's easier for us :)

> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 75a8654..c38b028 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -381,6 +381,20 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> +			spi0_pins: spi0 {
> +				allwinner,pins = "PC0", "PC1", "PC2", "PC3";
> +				allwinner,function = "spi0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi1_pins: spi1 {
> +				allwinner,pins = "PA15", "PA16", "PA14", "PA13";
> +				allwinner,function = "spi1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +

This needs to be in a separate patch

>  			uart0_pins_a: uart0 at 0 {
>  				allwinner,pins = "PA4", "PA5";
>  				allwinner,function = "uart0";
> @@ -425,6 +439,38 @@
>  			clocks = <&osc24M>;
>  		};
>  
> +		spi0: spi at 01c68000 {
> +			compatible = "allwinner,sun8i-h3-spi";
> +			reg = <0x01c68000 0x1000>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +			clock-names = "ahb", "mod";
> +			dmas = <&dma 23>, <&dma 23>;
> +			dma-names = "rx", "tx";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi0_pins>;
> +			resets = <&ccu RST_BUS_SPI0>;
> +			status = "disabled";
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
> +			dmas = <&dma 24>, <&dma 24>;
> +			dma-names = "rx", "tx";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi1_pins>;
> +			resets = <&ccu RST_BUS_SPI1>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/83100724/attachment-0001.sig>
