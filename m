From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Apr 2013 13:39:55 +0200
Subject: [PATCH 2/3] ARM:DTS:MVF600: add basic device tree source
In-Reply-To: <1365749825-20601-3-git-send-email-b35083@freescale.com>
References: <1365749825-20601-1-git-send-email-b35083@freescale.com>
 <1365749825-20601-3-git-send-email-b35083@freescale.com>
Message-ID: <20130412113955.GD10373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:57:04PM +0800, Jingchang Lu wrote:
> This patch adds basic device tree source for Freescale
> Vybrid Family platform and Tower development board.
> 
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  arch/arm/boot/dts/imx-mvf600.dtsi   | 442 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx-mvf600twr.dts |  82 +++++++
>  2 files changed, 524 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx-mvf600.dtsi
>  create mode 100644 arch/arm/boot/dts/imx-mvf600twr.dts
> 
> diff --git a/arch/arm/boot/dts/imx-mvf600.dtsi b/arch/arm/boot/dts/imx-mvf600.dtsi
> new file mode 100644
> index 0000000..3a534c6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx-mvf600.dtsi
> @@ -0,0 +1,442 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +		serial4 = &uart5;
> +		serial5 = &uart6;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +	};
> +
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ckil {
> +			compatible = "fsl,mvf-ckil", "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		ckih1 {
> +			compatible = "fsl,mvf-ckih1", "fixed-clock";
> +			clock-frequency = <0>;
> +		};
> +
> +		osc {
> +			compatible = "fsl,mvf-osc", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&intc>;
> +		ranges;
> +
> +		aips0: aips-bus at 40000000 { /* AIPS0 */
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-parent = <&intc>;
> +			reg = <0x40000000 0x70000>;
> +			ranges;
> +
> +			mscm: mscm at 40001000 {
> +				compatible = "fsl,mvf-mscm";
> +				reg = <0x40001000 0x1000>;
> +			};
> +
> +			intc: interrupt-controller at 40002000 {
> +				compatible = "arm,cortex-a9-gic";
> +				#interrupt-cells = <3>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				interrupt-controller;
> +				reg = <0x40003000 0x1000>,
> +				      <0x40002100 0x100>;
> +			};
> +
> +			L2: l2-cache at 40006000 {
> +				compatible = "arm,pl310-cache";
> +				reg = <0x40006000 0x1000>;
> +				interrupts = <0 6 0x04>;
> +				cache-unified;
> +				cache-level = <2>;
> +			};
> +
> +			uart1: serial at 40027000 { /* UART0 */

That's the first time Freescale actually starts counting at zero. Let's
be grateful for that and just use it instead of renumbering it.

> +
> +			pinctrl1: iomuxc at 40047000 {
> +				compatible = "fsl,mvf-iomuxc";
> +				reg = <0x40047000 0x2000>;
> +				#gpio-range-cells = <2>;
> +
> +				/* iomux setting */
> +				esdhc1 {
> +					pinctrl_esdhc1_1: esdhc1grp_1 {
> +						fsl,pins = <
> +						85 0x5031ef /* PTA24__SDHC1_CLK */
> +						91 0x5031ef /* PTA25__SDHC1_CMD */
> +						96 0x5031ef /* PTA26__SDHC1_DAT0 */
> +						101 0x5031ef /* PTA27__SDHC1_DAT1 */
> +						108 0x5031ef /* PTA28__SDHC1_DAT2 */
> +						115 0x5031ef /* PTA29__SDHC1_DAT3 */
> +						776 0x219d /* PTA7__SDHC1_SW_CD */
> +					>;
> +					};

I have no idea how the iomux works on vybrid, but Shawn just eliminated
the magic numbers for the pins. Let's not reintroduce them for vybrid if
possible.


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
