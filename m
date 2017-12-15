From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 15 Dec 2017 11:29:31 -0800
Subject: [PATCH v3 1/2] ARM64: dts: meson-axg: add ethernet mac controller
In-Reply-To: <20171215021014.231308-2-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Fri, 15 Dec 2017 10:10:13 +0800")
References: <20171215021014.231308-1-yixun.lan@amlogic.com>
 <20171215021014.231308-2-yixun.lan@amlogic.com>
Message-ID: <7ho9mz94dg.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> Add DT info for the stmmac ethernet MAC which found in
> the Amlogic's Meson-AXG SoC, also describe the ethernet
> pinctrl & clock information here.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

This patch does not apply, and dependencies are not described.

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 54 ++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index d356ce74ad89..94c4972222b7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/axg-clkc.h>
>  
>  / {
>  	compatible = "amlogic,meson-axg";
> @@ -148,6 +149,19 @@
>  			#address-cells = <0>;
>  		};
>  
> +		ethmac: ethernet at ff3f0000 {
> +			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
> +			reg = <0x0 0xff3f0000 0x0 0x10000
> +				0x0 0xff634540 0x0 0x8>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "macirq";
> +			clocks = <&clkc CLKID_ETH>,
> +				 <&clkc CLKID_FCLK_DIV2>,
> +				 <&clkc CLKID_MPLL2>;
> +			clock-names = "stmmaceth", "clkin0", "clkin1";
> +			status = "disabled";
> +		};
> +
>  		hiubus: bus at ff63c000 {
>  			compatible = "simple-bus";
>  			reg = <0x0 0xff63c000 0x0 0x1c00>;

Based on the hiubus node, presumably this depends on the patch from the
clock series.

> @@ -194,6 +208,46 @@
>  					#gpio-cells = <2>;
>  					gpio-ranges = <&pinctrl_periphs 0 0 86>;
>  				};

I'm not sure where this part is coming from, but it causes the rest of
it to not apply.

Please be sure to describe all dependencies.

Kevin

> +
> +				eth_rgmii_x_pins: eth-x-rgmii {
> +					mux {
> +						groups = "eth_mdio_x",
> +						       "eth_mdc_x",
> +						       "eth_rgmii_rx_clk_x",
> +						       "eth_rx_dv_x",
> +						       "eth_rxd0_x",
> +						       "eth_rxd1_x",
> +						       "eth_rxd2_rgmii",
> +						       "eth_rxd3_rgmii",
> +						       "eth_rgmii_tx_clk",
> +						       "eth_txen_x",
> +						       "eth_txd0_x",
> +						       "eth_txd1_x",
> +						       "eth_txd2_rgmii",
> +						       "eth_txd3_rgmii";
> +						function = "eth";
> +					};
> +				};
> +
> +				eth_rgmii_y_pins: eth-y-rgmii {
> +					mux {
> +						groups = "eth_mdio_y",
> +						       "eth_mdc_y",
> +						       "eth_rgmii_rx_clk_y",
> +						       "eth_rx_dv_y",
> +						       "eth_rxd0_y",
> +						       "eth_rxd1_y",
> +						       "eth_rxd2_rgmii",
> +						       "eth_rxd3_rgmii",
> +						       "eth_rgmii_tx_clk",
> +						       "eth_txen_y",
> +						       "eth_txd0_y",
> +						       "eth_txd1_y",
> +						       "eth_txd2_rgmii",
> +						       "eth_txd3_rgmii";
> +						function = "eth";
> +					};
> +				};
>  			};
>  		};
