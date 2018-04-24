From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 24 Apr 2018 17:27:36 +0200
Subject: [RFC 09/13] arm64: dts: allwinner: a64: Add HDMI support
In-Reply-To: <20180424133425.24291-10-jagan@amarulasolutions.com>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
 <20180424133425.24291-10-jagan@amarulasolutions.com>
Message-ID: <16951864.vHPjqCA7g4@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne torek, 24. april 2018 ob 15:34:21 CEST je Jagan Teki napisal(a):
> HDMI on Allwinner A64 has similar behavior like H3/H5, so
> reuse the same dts node details for A64.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28
> +++++++++++++++++++++++++++ include/dt-bindings/clock/sun50i-a64-ccu.h    |
>  2 ++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> b8734319dc77..aa73f1ce1ab2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -705,6 +705,34 @@
>  			#interrupt-cells = <3>;
>  		};
> 
> +		hdmi: hdmi at 1ee0000 {
> +			compatible = "allwinner,sun50i-a64-dw-hdmi",
> +				     "allwinner,sun8i-a83t-dw-hdmi";
> +			reg = <0x01ee0000 0x10000>;
> +			reg-io-width = <1>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu CLK_HDMI>;
> +			clock-names = "iahb", "isfr", "tmds";
> +			resets = <&ccu RST_BUS_HDMI1>;
> +			reset-names = "ctrl";
> +			phys = <&hdmi_phy>;
> +			phy-names = "hdmi-phy";
> +			status = "disabled";
> +		};
> +
> +		hdmi_phy: hdmi-phy at 1ef0000 {
> +			compatible = "allwinner,sun50i-a64-hdmi-phy",
> +				     "allwinner,sun8i-h3-hdmi-phy";
> +			reg = <0x01ef0000 0x10000>;
> +			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu CLK_PLL_VIDEO0>;
> +			clock-names = "bus", "mod", "pll-0";

Unfortunately, that won't work in all cases. HDMI has two possible clock 
parents and only one can be selected. If HDMI controller clock has PLL_VIDEO1 
as a source, you will calculate wrong divider in HDMI PHY, since you will base 
calculations on PLL_VIDEO0. I think driver needs an expansion.

That is also one of the reasons why I didn't yet send A64 HDMI patch series (I 
didn't figure out this part yet). The other reason is that I'm waiting on SRAM 
C claiming code.

Best regards,
Jernej

> +			resets = <&ccu RST_BUS_HDMI0>;
> +			reset-names = "phy";
> +			#phy-cells = <0>;
> +		};
> +
>  		rtc: rtc at 1f00000 {
>  			compatible = "allwinner,sun6i-a31-rtc";
>  			reg = <0x01f00000 0x54>;
> diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h
> b/include/dt-bindings/clock/sun50i-a64-ccu.h index
> d66432c6e675..a054ff665d6e 100644
> --- a/include/dt-bindings/clock/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
> @@ -43,6 +43,8 @@
>  #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
>  #define _DT_BINDINGS_CLK_SUN50I_A64_H_
> 
> +#define CLK_PLL_VIDEO0		7
> +
>  #define CLK_PLL_PERIPH0		11
> 
>  #define CLK_BUS_MIPI_DSI	28
> --
> 2.14.3
