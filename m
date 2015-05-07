From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 May 2015 21:53:34 +0800
Subject: [PATCH V7 04/10] ARM: dts: add imx7d soc dtsi file
In-Reply-To: <1430317210-18333-5-git-send-email-Frank.Li@freescale.com>
References: <1430317210-18333-1-git-send-email-Frank.Li@freescale.com>
 <1430317210-18333-5-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150507135332.GN3162@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 10:20:04PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Add i.mx7d support:
> 	imx7d dtsi part
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx7d.dtsi | 497 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 497 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> new file mode 100644
> index 0000000..8e1790e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -0,0 +1,497 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/clock/imx7d-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "imx7d-pinfunc.h"
> +#include "skeleton.dtsi"
> +
> +/ {
> +	aliases {
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +		gpio5 = &gpio6;
> +		gpio6 = &gpio7;
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
> +		i2c3 = &i2c4;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc3;
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +		serial4 = &uart5;
> +		serial5 = &uart6;
> +		serial6 = &uart7;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0>;
> +			operating-points = <
> +				/* KHz	uV */
> +				996000	1075000
> +				792000	975000
> +			>;
> +			clock-latency = <61036>; /* two CLK32 periods */
> +			clocks = <&clks IMX7D_ARM_A7_ROOT_CLK>, <&clks IMX7D_ARM_A7_ROOT_SRC>,
> +				 <&clks IMX7D_PLL_ARM_MAIN_CLK>, <&clks IMX7D_PLL_SYS_MAIN_CLK>;
> +			clock-names = "arm", "arm_root_src", "pll_arm", "pll_sys_main";
> +		};
> +	};
> +
> +	intc: interrupt-controller at 31001000 {
> +		compatible = "arm,cortex-a7-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x31001000 0x1000>,
> +		      <0x31002000 0x1000>,
> +		      <0x31004000 0x2000>,
> +		      <0x31006000 0x2000>;
> +	};
> +
> +	ckil: clock-cki {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "ckil";
> +	};
> +
> +	osc: clock-osc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc";
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&intc>;
> +		ranges;
> +
> +		aips1: aips-bus at 30000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x30000000 0x400000>;
> +			ranges;
> +
> +			gpio1: gpio at 30200000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30200000 0x10000>;
> +				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>, /* GPIO1_INT15_0 */
> +					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>; /* GPIO1_INT31_16 */
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio2: gpio at 30210000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30210000 0x10000>;
> +				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio3: gpio at 30220000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30220000 0x10000>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio4: gpio at 30230000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30230000 0x10000>;
> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio5: gpio at 30240000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30240000 0x10000>;
> +				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;

Please make the indentation consistent with gpio1 ~ gpio4:

				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;

> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio6: gpio at 30250000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30250000 0x10000>;
> +				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio7: gpio at 30260000 {
> +				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
> +				reg = <0x30260000 0x10000>;
> +				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpt1: gpt at 302d0000 {
> +				compatible = "fsl,imx7d-gpt", "fsl,imx31-gpt";
> +				reg = <0x302d0000 0x10000>;
> +				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_GPT1_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +			};
> +
> +			gpt2: gpt at 302e0000 {
> +				compatible = "fsl,imx7d-gpt", "fsl,imx31-gpt";
> +				reg = <0x302e0000 0x10000>;
> +				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_GPT2_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			gpt3: gpt at 302f0000 {
> +				compatible = "fsl,imx7d-gpt", "fsl,imx31-gpt";
> +				reg = <0x302f0000 0x10000>;
> +				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_GPT3_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			gpt4: gpt at 30300000 {
> +				compatible = "fsl,imx7d-gpt", "fsl,imx31-gpt";
> +				reg = <0x30300000 0x10000>;
> +				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_GPT4_ROOT_CLK>;

Ditto

> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			iomuxc: iomuxc at 30330000 {
> +				compatible = "fsl,imx7d-iomuxc";
> +				reg = <0x30330000 0x10000>;
> +			};
> +
> +			gpr: iomuxc-gpr at 30340000 {
> +				compatible = "fsl,imx7d-iomuxc-gpr", "syscon";
> +				reg = <0x30340000 0x10000>;
> +			};
> +
> +			ocotp: ocotp-ctrl at 30350000 {
> +				compatible = "syscon";
> +				reg = <0x30350000 0x10000>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>;
> +				status = "disabled";
> +			};
> +
> +			anatop: anatop at 30360000 {
> +				compatible = "fsl,imx7d-anatop", "fsl,imx6q-anatop",
> +					"syscon", "simple-bus";
> +				reg = <0x30360000 0x10000>;
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				reg_1p0d: regulator-vdd1p0d at 210 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "vdd1p0d";
> +					regulator-min-microvolt = <800000>;
> +					regulator-max-microvolt = <1200000>;
> +					anatop-reg-offset = <0x210>;
> +					anatop-vol-bit-shift = <8>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <8>;
> +					anatop-min-voltage = <800000>;
> +					anatop-max-voltage = <1200000>;
> +					anatop-enable-bit = <31>;
> +				};
> +			};
> +
> +			snvs: snvs at 30370000 {
> +				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x30370000 0x10000>;
> +
> +				snvs-rtc-lp at 34 {
> +					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> +					reg = <0x34 0x58>;
> +					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +
> +			snvs-pwrkey at 0x30370000 {
> +				compatible = "fsl, imx7d-snvs-pwrkey", "fsl,imx6sx-snvs-pwrkey";
> +				reg = <0x30370000 0x10000>;
> +				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +				fsl,keycode = <116>; /* KEY_POWER */
> +				fsl,wakeup;
> +			};

Is this supported by mainline kernel and device tree?

> +
> +			clks: ccm at 30380000 {
> +				compatible = "fsl,imx7d-ccm";
> +				reg = <0x30380000 0x10000>;
> +				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				#clock-cells = <1>;
> +				clocks = <&ckil>, <&osc>;
> +				clock-names = "ckil", "osc";

This does not match device tree binding doc, which says:

 - clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"

> +			};
> +
> +			src: src at 30390000 {
> +				compatible = "fsl,imx7d-src", "fsl,imx51-src", "syscon";
> +				reg = <0x30390000 0x10000>;
> +				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +				#reset-cells = <1>;
> +			};
> +
> +			gpc: gpc at 303a0000 {
> +				compatible = "fsl,imx7d-gpc";
> +				reg = <0x303a0000 0x10000>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +				fsl,mf-mix-wakeup-irq = <0x4000000 0xc00 0x0 0x0>;

What is this?

> +				#power-domain-cells = <1>;
> +				pcie-phy-supply = <&reg_1p0d>;
> +			};
> +		};
> +
> +		aips3: aips-bus at 30800000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x30800000 0x400000>;
> +			ranges;
> +
> +			uart1: serial at 30860000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";

If it's compatible with "fsl,imx6q-uart", putting "fsl,imx21-uart" in
there is not going to help anything.

> +				reg = <0x30860000 0x10000>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART1_ROOT_CLK>,
> +					<&clks IMX7D_UART1_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart2: serial at 30870000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30870000 0x10000>;
> +				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART2_ROOT_CLK>,
> +					<&clks IMX7D_UART2_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart3: serial at 30880000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30880000 0x10000>;
> +				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART3_ROOT_CLK>,
> +					<&clks IMX7D_UART3_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c at 30a20000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a20000 0x10000>;
> +				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_I2C1_ROOT_CLK>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c at 30a30000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a30000 0x10000>;
> +				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_I2C2_ROOT_CLK>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c at 30a40000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a40000 0x10000>;
> +				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_I2C3_ROOT_CLK>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c at 30a50000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a50000 0x10000>;
> +				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_I2C4_ROOT_CLK>;
> +				status = "disabled";
> +			};
> +
> +			uart4: serial at 30a60000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30a60000 0x10000>;
> +				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART4_ROOT_CLK>,
> +					<&clks IMX7D_UART4_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart5: serial at 30a70000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30a70000 0x10000>;
> +				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART5_ROOT_CLK>,
> +					<&clks IMX7D_UART5_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart6: serial at 30a80000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30a80000 0x10000>;
> +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART6_ROOT_CLK>,
> +					<&clks IMX7D_UART6_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart7: serial at 30a90000 {
> +				compatible = "fsl,imx7d-uart",
> +					     "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30a90000 0x10000>;
> +				interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_UART7_ROOT_CLK>,
> +					<&clks IMX7D_UART7_ROOT_CLK>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			usdhc1: usdhc at 30b40000 {
> +				compatible = "fsl,imx7d-usdhc", "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";

It's not helpful to have "fsl,imx6sx-usdhc" in there.

Shawn

> +				reg = <0x30b40000 0x10000>;
> +				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_USDHC1_ROOT_CLK>;
> +				clock-names = "ipg", "ahb", "per";
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			usdhc2: usdhc at 30b50000 {
> +				compatible = "fsl,imx7d-usdhc", "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";
> +				reg = <0x30b50000 0x10000>;
> +				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_USDHC2_ROOT_CLK>;
> +				clock-names = "ipg", "ahb", "per";
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			usdhc3: usdhc at 30b60000 {
> +				compatible = "fsl,imx7d-usdhc", "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";
> +				reg = <0x30b60000 0x10000>;
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_USDHC3_ROOT_CLK>;
> +				clock-names = "ipg", "ahb", "per";
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
