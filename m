From: ping.bai@nxp.com (Jacky Bai)
Date: Fri, 9 Mar 2018 05:04:40 +0000
Subject: [PATCH v4 1/2] ARM: dts: imx: Add basic dtsi file for imx6sll
In-Reply-To: <20180309031503.GF3217@dragon>
References: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
 <20180309031503.GF3217@dragon>
Message-ID: <HE1PR04MB3113D640770F0407970CFAB187DE0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Mar 08, 2018 at 06:03:43PM +0800, Bai Ping wrote:
> > diff --git a/arch/arm/boot/dts/imx6sll.dtsi
> > b/arch/arm/boot/dts/imx6sll.dtsi new file mode 100644 index
> > 0000000..3fb1156
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6sll.dtsi
> > @@ -0,0 +1,806 @@
> > +//SPDX-License-Identifier: (GPL-2.0 OR MIT)
> 
> There should be space right after //
> 

Thanks for review, will fix all the comment in this patch.

Jacky

> > +/*
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017-2018 NXP.
> > + *
> > + */
> > +
> > +#include <dt-bindings/clock/imx6sll-clock.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include "imx6sll-pinfunc.h"
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	aliases {
> > +		gpio0 = &gpio1;
> > +		gpio1 = &gpio2;
> > +		gpio2 = &gpio3;
> > +		gpio3 = &gpio4;
> > +		gpio4 = &gpio5;
> > +		gpio5 = &gpio6;
> > +		i2c0 = &i2c1;
> > +		i2c1 = &i2c2;
> > +		i2c2 = &i2c3;
> > +		mmc0 = &usdhc1;
> > +		mmc1 = &usdhc2;
> > +		mmc2 = &usdhc3;
> > +		serial0 = &uart1;
> > +		serial1 = &uart2;
> > +		serial2 = &uart3;
> > +		serial3 = &uart4;
> > +		serial4 = &uart5;
> > +		spi0 = &ecspi1;
> > +		spi1 = &ecspi2;
> > +		spi3 = &ecspi3;
> > +		spi4 = &ecspi4;
> > +		usbphy0 = &usbphy1;
> > +		usbphy1 = &usbphy2;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu at 0 {
> > +			compatible = "arm,cortex-a9";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			next-level-cache = <&L2>;
> > +			operating-points = <
> > +				/* kHz    uV */
> > +				996000  1225000
> > +				792000  1175000
> > +				396000  1075000
> > +				198000	975000
> > +			>;
> > +			fsl,soc-operating-points = <
> > +				/* ARM kHz      SOC-PU uV */
> > +				996000          1225000
> > +				792000          1175000
> > +				396000          1175000
> > +				198000		1175000
> > +			>;
> > +			clock-latency = <61036>; /* two CLK32 periods */
> > +			fsl,low-power-run;
> 
> What is this?
> 
> > +			clocks = <&clks IMX6SLL_CLK_ARM>,
> > +				 <&clks IMX6SLL_CLK_PLL2_PFD2>,
> > +				 <&clks IMX6SLL_CLK_STEP>,
> > +				 <&clks IMX6SLL_CLK_PLL1_SW>,
> > +				 <&clks IMX6SLL_CLK_PLL1_SYS>,
> > +				 <&clks IMX6SLL_CLK_PLL1>,
> > +				 <&clks IMX6SLL_PLL1_BYPASS>,
> > +				 <&clks IMX6SLL_PLL1_BYPASS_SRC>;
> > +			clock-names = "arm", "pll2_pfd2_396m", "step",
> > +				      "pll1_sw", "pll1_sys", "pll1", "pll1_bypass",
> > +				      "pll1_bypass_src";
> > +		};
> > +	};
> > +
> > +	intc: interrupt-controller at a01000 {
> > +		compatible = "arm,cortex-a9-gic";
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x00a01000 0x1000>,
> > +		      <0x00a00100 0x100>;
> > +		interrupt-parent = <&intc>;
> > +	};
> > +
> > +	clocks {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> 
> As requested by DT maintainer, please drop this container node and give an
> unique name for each fixed-clock, something like:
> 
> 	clock-xxx {
> 		...
> 	};
> 
> You may want to refer to how Lucas did it for i.MX8QM.
> 
> > +
> > +		ckil: clock at 0 {
> > +			compatible = "fixed-clock";
> > +			reg = <0>;
> > +			#clock-cells = <0>;
> > +			clock-frequency = <32768>;
> > +			clock-output-names = "ckil";
> > +		};
> > +
> > +		osc: clock at 1 {
> > +			compatible = "fixed-clock";
> > +			reg = <1>;
> > +			#clock-cells = <0>;
> > +			clock-frequency = <24000000>;
> > +			clock-output-names = "osc";
> > +		};
> > +
> > +		ipp_di0: clock at 2 {
> > +			compatible = "fixed-clock";
> > +			reg = <2>;
> > +			#clock-cells = <0>;
> > +			clock-frequency = <0>;
> > +			clock-output-names = "ipp_di0";
> > +		};
> > +
> > +		ipp_di1: clock at 3 {
> > +			compatible = "fixed-clock";
> > +			reg = <3>;
> > +			#clock-cells = <0>;
> > +			clock-frequency = <0>;
> > +			clock-output-names = "ipp_di1";
> > +		};
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "simple-bus";
> > +		interrupt-parent = <&gpc>;
> > +		ranges;
> > +
> > +		ocram: sram at 900000 {
> > +			compatible = "mmio-sram";
> > +			reg = <0x00900000 0x20000>;
> > +		};
> > +
> > +		L2: l2-cache at a02000 {
> > +			compatible = "arm,pl310-cache";
> > +			reg = <0x00a02000 0x1000>;
> > +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> > +			cache-unified;
> > +			cache-level = <2>;
> > +			arm,tag-latency = <4 2 3>;
> > +			arm,data-latency = <4 2 3>;
> > +		};
> > +
> > +		aips1: aips-bus at 2000000 {
> > +			compatible = "fsl,aips-bus", "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x02000000 0x100000>;
> > +			ranges;
> > +
> > +			spba: spba-bus at 2000000 {
> > +				compatible = "fsl,spba-bus", "simple-bus";
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				reg = <0x02000000 0x40000>;
> > +				ranges;
> > +
> > +				spdif: spdif at 2004000 {
> > +					compatible = "fsl,imx6sl-spdif", "fsl,imx35-spdif";
> > +					reg = <0x02004000 0x4000>;
> > +					interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 14 18 0>, <&sdma 15 18 0>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_SPDIF_GCLK>,
> > +						 <&clks IMX6SLL_CLK_OSC>,
> > +						 <&clks IMX6SLL_CLK_SPDIF>,
> > +						 <&clks IMX6SLL_CLK_DUMMY>,
> > +						 <&clks IMX6SLL_CLK_DUMMY>,
> > +						 <&clks IMX6SLL_CLK_DUMMY>,
> > +						 <&clks IMX6SLL_CLK_IPG>,
> > +						 <&clks IMX6SLL_CLK_DUMMY>,
> > +						 <&clks IMX6SLL_CLK_DUMMY>,
> > +						 <&clks IMX6SLL_CLK_SPBA>;
> > +					clock-names = "core", "rxtx0",
> > +						      "rxtx1", "rxtx2",
> > +						      "rxtx3", "rxtx4",
> > +						      "rxtx5", "rxtx6",
> > +						      "rxtx7", "dma";
> > +					status = "disabled";
> > +				};
> > +
> > +				ecspi1: ecspi at 2008000 {
> 
> s/ecspi/spi for node name.
> 
> > +					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> > +					reg = <0x02008000 0x4000>;
> > +					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_ECSPI1>,
> > +						 <&clks IMX6SLL_CLK_ECSPI1>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				ecspi2: ecspi at 200c000 {
> > +					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> > +					reg = <0x0200c000 0x4000>;
> > +					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_ECSPI2>,
> > +						 <&clks IMX6SLL_CLK_ECSPI2>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				ecspi3: ecspi at 2010000 {
> > +					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> > +					reg = <0x02010000 0x4000>;
> > +					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_ECSPI3>,
> > +						 <&clks IMX6SLL_CLK_ECSPI3>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				ecspi4: ecspi at 2014000 {
> > +					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> > +					reg = <0x02014000 0x4000>;
> > +					interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_ECSPI4>,
> > +						 <&clks IMX6SLL_CLK_ECSPI4>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				uart4: serial at 2018000 {
> > +					compatible = "fsl,imx6sl-uart", "fsl,imx6q-uart",
> "fsl,imx21-uart";
> > +					reg = <0x02018000 0x4000>;
> > +					interrupts =<GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 31 4 0>, <&sdma 32 4 0>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_UART4_IPG>,
> > +						 <&clks IMX6SLL_CLK_UART4_SERIAL>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				uart1: serial at 2020000 {
> > +					compatible = "fsl,imx6sl-uart", "fsl,imx6q-uart",
> "fsl,imx21-uart";
> > +					reg = <0x02020000 0x4000>;
> > +					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 25 4 0>, <&sdma 26 4 0>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_UART1_IPG>,
> > +						 <&clks IMX6SLL_CLK_UART1_SERIAL>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				uart2: serial at 2024000 {
> > +					compatible = "fsl,imx6sl-uart", "fsl,imx6q-uart",
> "fsl,imx21-uart";
> > +					reg = <0x02024000 0x4000>;
> > +					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
> > +					dma-names = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_UART2_IPG>,
> > +						 <&clks IMX6SLL_CLK_UART2_SERIAL>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +
> > +				ssi1: ssi at 2028000 {
> 
> ssi-controller
> 
> > +					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
> > +					reg = <0x02028000 0x4000>;
> > +					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 37 22 0>, <&sdma 38 22 0>;
> > +					dma-names = "rx", "tx";
> > +					fsl,fifo-depth = <15>;
> > +					clocks = <&clks IMX6SLL_CLK_SSI1_IPG>,
> > +						 <&clks IMX6SLL_CLK_SSI1>;
> > +					clock-names = "ipg", "baud";
> > +					status = "disabled";
> > +				};
> > +
> > +				ssi2: ssi2 at 202c000 {
> 
> Drop 2 from node name.
> 
> > +					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
> > +					reg = <0x0202c000 0x4000>;
> > +					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 41 22 0>, <&sdma 42 22 0>;
> > +					dma-names = "rx", "tx";
> > +					fsl,fifo-depth = <15>;
> > +					clocks = <&clks IMX6SLL_CLK_SSI2_IPG>,
> > +						 <&clks IMX6SLL_CLK_SSI2>;
> > +					clock-names = "ipg", "baud";
> > +					status = "disabled";
> > +				};
> > +
> > +				ssi3: ssi at 2030000 {
> > +					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
> > +					reg = <0x02030000 0x4000>;
> > +					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 45 22 0>, <&sdma 46 22 0>;
> > +					dma-names = "rx", "tx";
> > +					fsl,fifo-depth = <15>;
> > +					clocks = <&clks IMX6SLL_CLK_SSI3_IPG>,
> > +						 <&clks IMX6SLL_CLK_SSI3>;
> > +					clock-names = "ipg", "baud";
> > +					status = "disabled";
> > +				};
> > +
> > +				uart3: serial at 2034000 {
> > +					compatible = "fsl,imx6sl-uart", "fsl,imx6q-uart",
> "fsl,imx21-uart";
> > +					reg = <0x02034000 0x4000>;
> > +					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> > +					dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;
> > +					dma-name = "rx", "tx";
> > +					clocks = <&clks IMX6SLL_CLK_UART3_IPG>,
> > +						 <&clks IMX6SLL_CLK_UART3_SERIAL>;
> > +					clock-names = "ipg", "per";
> > +					status = "disabled";
> > +				};
> > +			};
> > +
> > +			pwm1: pwm at 2080000 {
> > +				compatible = "fsl,imx6sll-pwm", "fsl,imx27-pwm";
> > +				reg = <0x02080000 0x4000>;
> > +				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_PWM1>,
> > +					 <&clks IMX6SLL_CLK_PWM1>;
> > +				clock-names = "ipg", "per";
> > +				#pwm-cells = <2>;
> > +			};
> > +
> > +			pwm2: pwm at 2084000 {
> > +				compatible = "fsl,imx6sll-pwm", "fsl,imx27-pwm";
> > +				reg = <0x02084000 0x4000>;
> > +				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_PWM2>,
> > +					 <&clks IMX6SLL_CLK_PWM2>;
> > +				clock-names = "ipg", "per";
> > +				#pwm-cells = <2>;
> > +			};
> > +
> > +			pwm3: pwm at 2088000 {
> > +				compatible = "fsl,imx6sll-pwm", "fsl,imx27-pwm";
> > +				reg = <0x02088000 0x4000>;
> > +				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_PWM3>,
> > +					 <&clks IMX6SLL_CLK_PWM3>;
> > +				clock-names = "ipg", "per";
> > +				#pwm-cells = <2>;
> > +			};
> > +
> > +			pwm4: pwm at 208c000 {
> > +				compatible = "fsl,imx6sll-pwm", "fsl,imx27-pwm";
> > +				reg = <0x0208c000 0x4000>;
> > +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_PWM4>,
> > +					 <&clks IMX6SLL_CLK_PWM4>;
> > +				clock-names = "ipg", "per";
> > +				#pwm-cells = <2>;
> > +			};
> > +
> > +			gpt1: gpt at 2098000 {
> 
> timer
> 
> > +				compatible = "fsl,imx6sll-gpt";
> > +				reg = <0x02098000 0x4000>;
> > +				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_GPT_BUS>,
> > +					 <&clks IMX6SLL_CLK_GPT_SERIAL>;
> > +				clock-names = "ipg", "per";
> > +			};
> > +
> > +			gpio1: gpio at 209c000 {
> > +				compatible = "fsl,imx6sll-gpio", "fsl,imx35-gpio";
> > +				reg = <0x0209c000 0x4000>;
> > +				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +
> > +			gpio2: gpio at 20a0000 {
> > +				compatible = "fsl,imx6sll-gpio", "fsl,imx35-gpio";
> > +				reg = <0x020a0000 0x4000>;
> > +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +
> > +			gpio3: gpio at 20a4000 {
> > +				compatible = "fsl,imx6sll-gpio", "fsl,imx35-gpio";
> > +				reg = <0x020a4000 0x4000>;
> > +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +
> > +			gpio4: gpio at 20a8000 {
> > +				compatible = "fsl,imx6sll-gpio", "fsl,imx35-gpio";
> > +				reg = <0x020a8000 0x4000>;
> > +				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +
> > +			gpio5: gpio at 20ac000 {
> > +				compatible = "fsl,imx6sll-gpio", "fsl,imx35-gpio";
> > +				reg = <0x020ac000 0x4000>;
> > +				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +
> > +			gpio6: gpio at 20b0000 {
> > +				compatible = "fsl,imx6sll-gpio", "fsl,imx35-gpio";
> > +				reg = <0x020b0000 0x4000>;
> > +				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +
> > +			kpp: kpp at 20b8000 {
> 
> s/kpp/keypad for node name.
> 
> > +				compatible = "fsl,imx6sll-kpp", "fsl,imx21-kpp";
> > +				reg = <0x020b8000 0x4000>;
> > +				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_KPP>;
> > +				status = "disabled";
> > +			};
> > +
> > +			wdog1: wdog at 20bc000 {
> 
> s/wdog/watchdog for node name.
> 
> > +				compatible = "fsl,imx6sll-wdt", "fsl,imx21-wdt";
> > +				reg = <0x020bc000 0x4000>;
> > +				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_WDOG1>;
> > +			};
> > +
> > +			wdog2: wdog at 20c0000 {
> > +				compatible = "fsl,imx6sll-wdt", "fsl,imx21-wdt";
> > +				reg = <0x020c0000 0x4000>;
> > +				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_WDOG2>;
> > +				status = "disabled";
> > +			};
> > +
> > +			clks: clock-controller at 20c4000 {
> > +				compatible = "fsl,imx6sll-ccm";
> > +				reg = <0x020c4000 0x4000>;
> > +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> > +				#clock-cells = <1>;
> > +				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
> > +				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
> > +
> > +				assigned-clocks = <&clks IMX6SLL_CLK_PERCLK_SEL>;
> > +				assigned-clock-parents = <&clks IMX6SLL_CLK_OSC>;
> > +			};
> > +
> > +			anatop: anatop at 20c8000 {
> > +				compatible = "fsl,imx6sll-anatop",
> > +					     "fsl,imx6q-anatop",
> > +					     "syscon", "simple-bus";
> > +				reg = <0x020c8000 0x4000>;
> > +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				reg_3p0: regulator-3p0 at 20c8120 {
> > +					compatible = "fsl,anatop-regulator";
> > +					reg = <0x20c8120>;
> > +					regulator-name = "vdd3p0";
> > +					regulator-min-microvolt = <2625000>;
> > +					regulator-max-microvolt = <3400000>;
> > +					anatop-reg-offset = <0x120>;
> > +					anatop-vol-bit-shift = <8>;
> > +					anatop-vol-bit-width = <5>;
> > +					anatop-min-bit-val = <0>;
> > +					anatop-min-voltage = <2625000>;
> > +					anatop-max-voltage = <3400000>;
> > +					anatop-enable-bit = <0>;
> > +				};
> > +			};
> > +
> > +			tempmon: tempmon {
> 
> s/tempmon/temperature-sensor for node name.
> 
> > +				compatible = "fsl,imx6sll-tempmon", "fsl,imx6sx-tempmon";
> > +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> > +				fsl,tempmon = <&anatop>;
> > +				fsl,tempmon-data = <&ocotp>;
> > +				clocks = <&clks IMX6SLL_CLK_PLL3_USB_OTG>;
> > +				status = "disabled";
> > +			};
> > +
> > +			usbphy1: usbphy at 20c9000 {
> 
> s/usbphy/usb-phy for node name.
> 
> > +				compatible = "fsl,imx6sll-usbphy", "fsl,imx6ul-usbphy",
> > +						"fsl,imx23-usbphy";
> > +				reg = <0x020c9000 0x1000>;
> > +				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USBPHY1>;
> > +				phy-3p0-supply = <&reg_3p0>;
> > +				fsl,anatop = <&anatop>;
> > +			};
> > +
> > +			usbphy2: usbphy at 20ca000 {
> > +				compatible = "fsl,imx6sll-usbphy", "fsl,imx6ul-usbphy",
> > +						"fsl,imx23-usbphy";
> > +				reg = <0x020ca000 0x1000>;
> > +				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
> > +				phy-reg_3p0-supply = <&reg_3p0>;
> > +				fsl,anatop = <&anatop>;
> > +			};
> > +
> > +			snvs: snvs at 20cc000 {
> > +				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> > +				reg = <0x020cc000 0x4000>;
> > +
> > +				snvs_rtc: snvs-rtc-lp {
> > +					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> > +					regmap = <&snvs>;
> > +					offset = <0x34>;
> > +					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> > +				};
> > +
> > +				snvs_poweroff: snvs-poweroff {
> > +					compatible = "syscon-poweroff";
> > +					regmap = <&snvs>;
> > +					offset = <0x38>;
> > +					mask = <0x61>;
> > +				};
> > +
> > +				snvs_pwrkey: snvs-powerkey {
> > +					compatible = "fsl,sec-v4.0-pwrkey";
> > +					regmap = <&snvs>;
> > +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +					linux,keycode = <KEY_POWER>;
> > +					wakeup-source;
> > +				};
> > +			};
> > +
> > +			epit1: epit at 20d0000 {
> > +				reg = <0x020d0000 0x4000>;
> > +				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +			};
> > +
> > +			epit2: epit at 20d4000 {
> > +				reg = <0x020d4000 0x4000>;
> > +				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +			};
> 
> No compatible, so unused?
> 
> > +
> > +			src: src at 20d8000 {
> 
> reset-controller
> 
> > +				compatible = "fsl,imx6sll-src";
> > +				reg = <0x020d8000 0x4000>;
> > +				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> > +				#reset-cells = <1>;
> > +			};
> > +
> > +			gpc: gpc at 20dc000 {
> 
> interrupt-controller
> 
> > +				compatible = "fsl,imx6sll-gpc", "fsl,imx6q-gpc";
> > +				reg = <0x020dc000 0x4000>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <3>;
> > +				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-parent = <&intc>;
> > +				fsl,mf-mix-wakeup-irq = <0x7c00000 0x7d00 0x0
> 0x1400640>;
> 
> What is this?
> 
> > +			};
> > +
> > +			iomuxc: iomuxc at 20e0000 {
> > +				compatible = "fsl,imx6sll-iomuxc";
> > +				reg = <0x020e0000 0x4000>;
> > +			};
> > +
> > +			gpr: iomuxc-gpr at 20e4000 {
> > +				compatible = "fsl,imx6sll-iomuxc-gpr",
> > +					     "fsl,imx6q-iomuxc-gpr", "syscon";
> > +				reg = <0x020e4000 0x4000>;
> > +			};
> > +
> > +			csi: csi at 20e8000 {
> > +				compatible = "fsl,imx6sll-csi", "fsl,imx6s-csi";
> > +				reg = <0x020e8000 0x4000>;
> > +				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_DUMMY>,
> > +					 <&clks IMX6SLL_CLK_CSI>,
> > +					 <&clks IMX6SLL_CLK_DUMMY>;
> > +				clock-names = "disp-axi", "csi_mclk", "disp_dcic";
> > +				status = "disabled";
> > +			};
> > +
> > +			sdma: sdma at 20ec000 {
> 
> dma-controller
> 
> > +				compatible = "fsl,imx6sll-sdma", "fsl,imx35-sdma";
> > +				reg = <0x020ec000 0x4000>;
> > +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_SDMA>,
> > +					 <&clks IMX6SLL_CLK_SDMA>;
> > +				clock-names = "ipg", "ahb";
> > +				#dma-cells = <3>;
> > +				iram = <&ocram>;
> > +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
> > +			};
> > +
> > +			lcdif: lcdif at 20f8000 {
> 
> lcd-controller
> 
> > +				compatible = "fsl,imx6sll-lcdif", "fsl,imx28-lcdif";
> > +				reg = <0x020f8000 0x4000>;
> > +				interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_LCDIF_PIX>,
> > +					 <&clks IMX6SLL_CLK_LCDIF_APB>,
> > +					 <&clks IMX6SLL_CLK_DUMMY>;
> > +				clock-names = "pix", "axi", "disp_axi";
> > +				status = "disabled";
> > +			};
> > +
> > +			dcp: dcp at 20fc000 {
> > +				compatible = "fsl,imx6sl-dcp";
> > +				reg = <0x020fc000 0x4000>;
> > +				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_DCP>;
> > +				clock-names = "dcp";
> > +			};
> > +		};
> > +
> > +		aips2: aips-bus at 2100000 {
> > +			compatible = "fsl,aips-bus", "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x02100000 0x100000>;
> > +			ranges;
> > +
> > +			usbotg1: usb at 2184000 {
> > +				compatible = "fsl,imx6sll-usb", "fsl,imx6ul-usb",
> > +						"fsl,imx27-usb";
> > +				reg = <0x02184000 0x200>;
> > +				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USBOH3>;
> > +				fsl,usbphy = <&usbphy1>;
> > +				fsl,usbmisc = <&usbmisc 0>;
> > +				fsl,anatop = <&anatop>;
> > +				ahb-burst-config = <0x0>;
> > +				tx-burst-size-dword = <0x10>;
> > +				rx-burst-size-dword = <0x10>;
> > +				status = "disabled";
> > +			};
> > +
> > +			usbotg2: usb at 2184200 {
> > +				compatible = "fsl,imx6sll-usb", "fsl,imx6ul-usb",
> > +						"fsl,imx27-usb";
> > +				reg = <0x02184200 0x200>;
> > +				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USBOH3>;
> > +				fsl,usbphy = <&usbphy2>;
> > +				fsl,usbmisc = <&usbmisc 1>;
> > +				ahb-burst-config = <0x0>;
> > +				tx-burst-size-dword = <0x10>;
> > +				rx-burst-size-dword = <0x10>;
> > +				status = "disabled";
> > +			};
> > +
> > +			usbmisc: usbmisc at 2184800 {
> > +				#index-cells = <1>;
> > +				compatible = "fsl,imx6sll-usbmisc", "fsl,imx6ul-usbmisc",
> > +						"fsl,imx6q-usbmisc";
> > +				reg = <0x02184800 0x200>;
> > +			};
> > +
> > +			usdhc1: usdhc at 2190000 {
> 
> s/usdhc/mmc for node name.
> 
> > +				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> > +				reg = <0x02190000 0x4000>;
> > +				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USDHC1>,
> > +					 <&clks IMX6SLL_CLK_USDHC1>,
> > +					 <&clks IMX6SLL_CLK_USDHC1>;
> > +				clock-names = "ipg", "ahb", "per";
> > +				bus-width = <4>;
> > +				fsl,tuning-step = <2>;
> > +				fsl,tuning-start-tap = <20>;
> > +				status = "disabled";
> > +			};
> > +
> > +			usdhc2: usdhc at 2194000 {
> > +				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> > +				reg = <0x02194000 0x4000>;
> > +				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USDHC2>,
> > +					 <&clks IMX6SLL_CLK_USDHC2>,
> > +					 <&clks IMX6SLL_CLK_USDHC2>;
> > +				clock-names = "ipg", "ahb", "per";
> > +				bus-width = <4>;
> > +				fsl,tuning-step = <2>;
> > +				fsl,tuning-start-tap = <20>;
> > +				status = "disabled";
> > +			};
> > +
> > +			usdhc3: usdhc at 2198000 {
> > +				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> > +				reg = <0x02198000 0x4000>;
> > +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_USDHC3>,
> > +					 <&clks IMX6SLL_CLK_USDHC3>,
> > +					 <&clks IMX6SLL_CLK_USDHC3>;
> > +				clock-names = "ipg", "ahb", "per";
> > +				bus-width = <4>;
> > +				fsl,tuning-step = <2>;
> > +				fsl,tuning-start-tap = <20>;
> > +				status = "disabled";
> > +			};
> > +
> > +			i2c1: i2c at 21a0000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "fs,imx6sll-i2c", "fsl,imx21-i2c";
> > +				reg = <0x021a0000 0x4000>;
> > +				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_I2C1>;
> > +				status = "disabled";
> > +			};
> > +
> > +			i2c2: i2c at 21a4000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";
> > +				reg = <0x021a4000 0x4000>;
> > +				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_I2C2>;
> > +				status = "disabled";
> > +			};
> > +
> > +			i2c3: i2c at 21a8000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";
> > +				reg = <0x021a8000 0x4000>;
> > +				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SLL_CLK_I2C3>;
> > +				status = "disabled";
> > +			};
> > +
> > +			romcp at 21ac000 {
> > +				compatible = "fsl,imx6sll-romcp", "syscon";
> > +				reg = <0x021ac000 0x4000>;
> > +			};
> > +
> > +			mmdc: mmdc at 21b0000 {
> 
> memory-controller
> 
> Shawn
> 
> > +				compatible = "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
> > +				reg = <0x021b0000 0x4000>;
> > +			};
> > +
> > +			rngb: rngb at 21b4000 {
> > +				reg = <0x021b4000 0x4000>;
> > +				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =  <&clks IMX6SLL_CLK_DUMMY>;
> > +			};
> > +
> > +			ocotp: ocotp-ctrl at 21bc000 {
> > +				compatible = "fsl,imx6sll-ocotp", "syscon";
> > +				reg = <0x021bc000 0x4000>;
> > +				clocks = <&clks IMX6SLL_CLK_OCOTP>;
> > +			};
> > +
> > +			snvs_gpr: snvs-gpr at 21c4000 {
> > +				reg = <0x021c4000 0x10000>;
> > +			};
> > +
> > +			iomuxc_snvs: iomuxc-snvs at 21c8000 {
> > +				reg = <0x021c8000 0x10000>;
> > +			};
> > +
> > +			audmux: audmux at 21d8000 {
> > +				compatible = "fsl,imx6sll-audmux", "fsl,imx31-audmux";
> > +				reg = <0x021d8000 0x4000>;
> > +				status = "disabled";
> > +			};
> > +
> > +			uart5: serial at 21f4000 {
> > +				compatible = "fsl,imx6sll-uart", "fsl,imx6q-uart",
> "fsl,imx21-uart";
> > +				reg = <0x021f4000 0x4000>;
> > +				interrupts =<GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > +				dmas = <&sdma 33 4 0>, <&sdma 34 4 0>;
> > +				dma-names = "rx", "tx";
> > +				clocks = <&clks IMX6SLL_CLK_UART5_IPG>,
> > +					 <&clks IMX6SLL_CLK_UART5_SERIAL>;
> > +				clock-names = "ipg", "per";
> > +				status = "disabled";
> > +			};
> > +		};
> > +	};
> > +};
> > --
> > 1.9.1
> >
