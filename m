From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 May 2013 22:14:27 +0800
Subject: [PATCH v3 3/4] ARM: dts: add SoC level device tree source for
 MVF600
In-Reply-To: <1368684648-20826-4-git-send-email-b35083@freescale.com>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-4-git-send-email-b35083@freescale.com>
Message-ID: <20130519141409.GB18553@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:10:47PM +0800, Jingchang Lu wrote:
> diff --git a/arch/arm/boot/dts/mvf600.dtsi b/arch/arm/boot/dts/mvf600.dtsi
> new file mode 100644
> index 0000000..a3c3353
> --- /dev/null
> +++ b/arch/arm/boot/dts/mvf600.dtsi
> @@ -0,0 +1,475 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include "skeleton.dtsi"
> +#include "mvf600-pinfunc.h"
> +#include <dt-bindings/clock/mvf600-clock.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a5";
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sxosc {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		fxosc {
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&intc>;
> +		ranges;
> +
> +		aips0: aips-bus at 40000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-parent = <&intc>;
> +			reg = <0x40000000 0x70000>;
> +			ranges;
> +
> +			mscm: mscm at 40001000 {
> +				compatible = "fsl,mvf600-mscm";
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
> +				cache-unified;
> +				cache-level = <2>;
> +				arm,data-latency = <1 1 1>;
> +				arm,tag-latency = <2 2 2>;
> +			};
> +
> +			uart0: serial at 40027000 {
> +				compatible = "fsl,mvf600-uart","fsl,lpuart";

We generally avoid using generic compatible string for IP block but
prefer to encode SoC name in the string to define the version/revision
using SoC part name.  That said, "fsl,mvf600-uart" is good enough to
specify the IP block.  More on this later.

> +				reg = <0x40027000 0x1000>;
> +				interrupts = <0 61 0x00>;
> +				clocks = <&clks MVF600_CLK_UART0>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			uart1: serial at 40028000 {
> +				compatible = "fsl,mvf600-uart","fsl,lpuart";
> +				reg = <0x40028000 0x1000>;
> +				interrupts = <0 62 0x04>;
> +				clocks = <&clks MVF600_CLK_UART1>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			uart2: serial at 40029000 {
> +				compatible = "fsl,mvf600-uart","fsl,lpuart";
> +				reg = <0x40029000 0x1000>;
> +				interrupts = <0 63 0x04>;
> +				clocks = <&clks MVF600_CLK_UART2>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			uart3: serial at 4002a000 {
> +				compatible = "fsl,mvf600-uart","fsl,lpuart";
> +				reg = <0x4002a000 0x1000>;
> +				interrupts = <0 64 0x04>;
> +				clocks = <&clks MVF600_CLK_UART3>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			sai2: sai at 40031000 {
> +				compatible = "fsl,mvf600-sai";
> +				reg = <0x40031000 0x1000>;
> +				interrupts = <0 86 0x04>;
> +				clocks = <&clks MVF600_CLK_SAI2>;
> +				clock-names = "sai";
> +				status = "disabled";
> +			};
> +
> +			pit:pit at 40037000 {

Nit: put a space after "pit:".

> +				compatible = "fsl,mvf600-pit";
> +				reg = <0x40037000 0x1000>;
> +				interrupts = <0 39 0x04>;
> +				clock-names = "pit";
> +				clocks = <&clks MVF600_CLK_PIT>;

Nit: I've seen some nodes have "clock-names" before "clocks" and others
have it after "clocks".  Please be consistent.

> +			};
> +
> +			wdog at 4003e000 {
> +				compatible = "fsl,mvf600-wdt","fsl,imx21-wdt";

Nit: please have a space between two strings (after comma).

> +				reg = <0x4003e000 0x1000>;
> +				clock-names = "wdog";
> +				clocks = <&clks MVF600_CLK_WDT>;
> +			};
> +
> +			qspi0: quadspi at 40044000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,mvf600-qspi";
> +				reg = <0x40044000 0x1000>;
> +				interrupts = <0 24 0x04>;
> +				clocks = <&clks MVF600_CLK_QSPI0_EN>,
> +					<&clks MVF600_CLK_QSPI0>;
> +				clock-names = "qspi0_en", "qspi0";
> +				status = "disabled";
> +			};
> +
> +			iomuxc: iomuxc at 40048000 {
> +				compatible = "fsl,mvf600-iomuxc";
> +				reg = <0x40048000 0x1000>;
> +				#gpio-range-cells = <2>;
> +
> +				/* functions and groups pins */
> +
> +				dcu0 {
> +					pinctrl_dcu0_1: dcu0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTB8__GPIO_30	0x42
> +						MVF600_PAD_PTE0__DCU0_HSYNC	0x42
> +						MVF600_PAD_PTE1__DCU0_VSYNC	0x42
> +						MVF600_PAD_PTE2__DCU0_PCLK	0x42
> +						MVF600_PAD_PTE4__DCU0_DE	0x42
> +						MVF600_PAD_PTE5__DCU0_R0	0x42
> +						MVF600_PAD_PTE6__DCU0_R1	0x42
> +						MVF600_PAD_PTE7__DCU0_R2	0x42
> +						MVF600_PAD_PTE8__DCU0_R3	0x42
> +						MVF600_PAD_PTE9__DCU0_R4	0x42
> +						MVF600_PAD_PTE10__DCU0_R5	0x42
> +						MVF600_PAD_PTE11__DCU0_R6	0x42
> +						MVF600_PAD_PTE12__DCU0_R7	0x42
> +						MVF600_PAD_PTE13__DCU0_G0	0x42
> +						MVF600_PAD_PTE14__DCU0_G1	0x42
> +						MVF600_PAD_PTE15__DCU0_G2	0x42
> +						MVF600_PAD_PTE16__DCU0_G3	0x42
> +						MVF600_PAD_PTE17__DCU0_G4	0x42
> +						MVF600_PAD_PTE18__DCU0_G5	0x42
> +						MVF600_PAD_PTE19__DCU0_G6	0x42
> +						MVF600_PAD_PTE20__DCU0_G7	0x42
> +						MVF600_PAD_PTE21__DCU0_B0	0x42
> +						MVF600_PAD_PTE22__DCU0_B1	0x42
> +						MVF600_PAD_PTE23__DCU0_B2	0x42
> +						MVF600_PAD_PTE24__DCU0_B3	0x42
> +						MVF600_PAD_PTE25__DCU0_B4	0x42
> +						MVF600_PAD_PTE26__DCU0_B5	0x42
> +						MVF600_PAD_PTE27__DCU0_B6	0x42
> +						MVF600_PAD_PTE28__DCU0_B7	0x42
> +						>;
> +					};
> +				};
> +
> +				dspi0 {
> +					pinctrl_dspi0_1: dspi0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTB19__DSPI0_CS0	0x1182
> +						MVF600_PAD_PTB20__DSPI0_SIN	0x1181
> +						MVF600_PAD_PTB21__DSPI0_SOUT	0x1182
> +						MVF600_PAD_PTB22__DSPI0_SCK	0x1182
> +						>;
> +					};
> +				};
> +
> +				esdhc1 {
> +					pinctrl_esdhc1_1: esdhc1grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTA24__ESDHC1_CLK	0x31ef
> +						MVF600_PAD_PTA25__ESDHC1_CMD	0x31ef
> +						MVF600_PAD_PTA26__ESDHC1_DAT0	0x31ef
> +						MVF600_PAD_PTA27__ESDHC1_DAT1	0x31ef
> +						MVF600_PAD_PTA28__ESDHC1_DATA2	0x31ef
> +						MVF600_PAD_PTA29__ESDHC1_DAT3	0x31ef
> +						MVF600_PAD_PTA7__GPIO_134	0x219d
> +						>;
> +					};
> +				};
> +
> +				fec0 {
> +					pinctrl_fec0_1: fec0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTA6__RMII_CLKIN		0x30d1
> +						MVF600_PAD_PTC0__ENET_RMII0_MDC		0x30d3
> +						MVF600_PAD_PTC1__ENET_RMII0_MDIO	0x30d1
> +						MVF600_PAD_PTC2__ENET_RMII0_CRS		0x30d1
> +						MVF600_PAD_PTC3__ENET_RMII0_RXD1	0x30d1
> +						MVF600_PAD_PTC4__ENET_RMII0_RXD0	0x30d1
> +						MVF600_PAD_PTC5__ENET_RMII0_RXER	0x30d1
> +						MVF600_PAD_PTC6__ENET_RMII0_TXD1	0x30d2
> +						MVF600_PAD_PTC7__ENET_RMII0_TXD0	0x30d2
> +						MVF600_PAD_PTC8__ENET_RMII0_TXEN	0x30d2
> +						>;
> +					};
> +				};
> +
> +				fec1 {
> +					pinctrl_fec1_1: fec1grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTC9__ENET_RMII1_MDC		0x30d2
> +						MVF600_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
> +						MVF600_PAD_PTC11__ENET_RMII1_CRS	0x30d1
> +						MVF600_PAD_PTC12__ENET_RMII_RXD1	0x30d1
> +						MVF600_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
> +						MVF600_PAD_PTC14__ENET_RMII1_RXER	0x30d1
> +						MVF600_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
> +						MVF600_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
> +						MVF600_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
> +						>;
> +					};
> +				};
> +
> +				i2c0 {
> +					pinctrl_i2c0_1: i2c0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTB14__I2C0_SCL	0x30d3
> +						MVF600_PAD_PTB15__I2C0_SDA	0x30d3
> +						>;
> +					};
> +				};
> +
> +				pwm0 {
> +					pinctrl_pwm0_1: pwm0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTB0__FTM0_CH0	0x1582
> +						MVF600_PAD_PTB1__FTM0_CH1	0x1582
> +						MVF600_PAD_PTB2__FTM0_CH2	0x1582
> +						MVF600_PAD_PTB3__FTM0_CH3	0x1582
> +						MVF600_PAD_PTB6__FTM0_CH6	0x1582
> +						MVF600_PAD_PTB7__FTM0_CH7	0x1582
> +						>;
> +					};
> +				};
> +
> +				qspi0 {
> +					pinctrl_qspi0_1: qspi0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTD0__QSPI0_A_QSCK	0x307b
> +						MVF600_PAD_PTD1__QSPI0_A_CS0	0x307f
> +						MVF600_PAD_PTD2__QSPI0_A_DATA3	0x3073
> +						MVF600_PAD_PTD3__QSPI0_A_DATA2	0x3073
> +						MVF600_PAD_PTD4__QSPI0_A_DATA1	0x3073
> +						MVF600_PAD_PTD5__QSPI0_A_DATA0	0x307b
> +						MVF600_PAD_PTD7__QSPI0_B_QSCK	0x307b
> +						MVF600_PAD_PTD8__QSPI0_B_CS0	0x307f
> +						MVF600_PAD_PTD9__QSPI0_B_DATA3	0x3073
> +						MVF600_PAD_PTD10__QSPI0_B_DATA2	0x3073
> +						MVF600_PAD_PTD11__QSPI0_B_DATA1	0x3073
> +						MVF600_PAD_PTD12__QSPI0_B_DATA0	0x307b
> +						>;
> +					};
> +				};
> +
> +				sai2 {
> +					pinctrl_sai2_1: sai2grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTA16__SAI2_TX_BCLK		0x02ed
> +						MVF600_PAD_PTA18__SAI2_TX_DATA		0x02ee
> +						MVF600_PAD_PTA19__SAI2_TX_SYNC		0x02ed
> +						MVF600_PAD_PTA21__SAI2_RX_BCLK		0x02ed
> +						MVF600_PAD_PTA22__SAI2_RX_DATA		0x02ed
> +						MVF600_PAD_PTA23__SAI2_RX_SYNC		0x02ed
> +						MVF600_PAD_PTB18__EXT_AUDIO_MCLK	0x02ed
> +						>;
> +					};
> +				};
> +
> +				touchscreen0 {
> +					pinctrl_ts0_1: ts0grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTA31__GPIO_21	0x219d
> +						>;
> +					};
> +				};

The pin group represented in <soc>.dtsi should be those defined by SoC
design.  This group does not look like the case.

> +
> +				uart1 {
> +					pinctrl_uart1_1: uart1grp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTB4__UART1_TX(0x21a2)
> +						MVF600_PAD_PTB5__UART1_RX(0x21a1)

Something forgot to change from last version.

> +						>;
> +					};
> +				};
> +
> +				usbvbus {
> +					pinctrl_usbvbus_1: usbvbusgrp_1 {
> +						fsl,pins = <
> +						MVF600_PAD_PTA24__USB1_VBUS_EN(0x219c)
> +						MVF600_PAD_PTA16__USB0_VBUS_EN(0x219c)

Ditto

> +						>;
> +					};
> +				};
> +
> +			};
> +
> +			gpio1: gpio at 40049000 {
> +				compatible = "fsl,mvf600-gpio";
> +				reg = <0x40049000 0x1000 0x400ff000 0x40>;
> +				interrupts = <0 107 0x04>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				gpio-ranges = <&iomuxc 0 32>;
> +			};
> +
> +			gpio2: gpio at 4004a000 {
> +				compatible = "fsl,mvf600-gpio";
> +				reg = <0x4004a000 0x1000 0x400ff040 0x40>;
> +				interrupts = <0 108 0x04>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				gpio-ranges = <&iomuxc 32 32>;
> +			};
> +
> +			gpio3: gpio at 4004b000 {
> +				compatible = "fsl,mvf600-gpio";
> +				reg = <0x4004b000 0x1000 0x400ff080 0x40>;
> +				interrupts = <0 109 0x04>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				gpio-ranges = <&iomuxc 64 32>;
> +			};
> +
> +			gpio4: gpio at 4004c000 {
> +				compatible = "fsl,mvf600-gpio";
> +				reg = <0x4004c000 0x1000 0x400ff0c0 0x40>;
> +				interrupts = <0 110 0x04>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				gpio-ranges = <&iomuxc 96 32>;
> +			};
> +
> +			gpio5: gpio at 4004d000 {
> +				compatible = "fsl,mvf600-gpio";
> +				reg = <0x4004d000 0x1000 0x400ff100 0x40>;
> +				interrupts = <0 111 0x04>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				gpio-ranges = <&iomuxc 128 7>;
> +			};
> +
> +			anatop at 40050000 {
> +				compatible = "fsl,mvf600-anatop";
> +				reg = <0x40050000 0x1000>;
> +			};
> +
> +			i2c0: i2c at 40066000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,mvf600-i2c";
> +				reg = <0x40066000 0x1000>;
> +				interrupts =<0 71 0x04>;
> +				clocks = <&clks MVF600_CLK_I2C0>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			clks: ccm at 4006b000 {
> +				compatible = "fsl,mvf600-ccm";
> +				reg = <0x4006b000 0x1000>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		aips1: aips-bus at 40080000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x40080000 0x80000>;
> +			ranges;
> +
> +			uart4: serial at 400a9000 {
> +				compatible = "fsl,mvf600-uart","fsl,lpuart";
> +				reg = <0x400a9000 0x1000>;
> +				interrupts = <0 65 0x04>;
> +				clocks = <&clks MVF600_CLK_UART4>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			uart5: serial at 400aa000 {
> +				compatible = "fsl,mvf600-uart","fsl,lpuart";
> +				reg = <0x400aa000 0x1000>;
> +				interrupts = <0 66 0x04>;
> +				clocks = <&clks MVF600_CLK_UART5>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			fec0: ethernet at 400d0000 {
> +				compatible = "fsl,mvf600-fec","fsl,mvf-fec";

"fsl,mvf-fec" is not a good compatible string.  I will try to send a
patch to change fec driver on this.

Shawn

> +				reg = <0x400d0000 0x1000>;
> +				interrupts = <0 78 0x04>;
> +				clocks = <&clks MVF600_CLK_ENET>,
> +					<&clks MVF600_CLK_ENET>,
> +					<&clks MVF600_CLK_ENET>;
> +				clock-names = "ipg", "ahb", "ptp";
> +			};
> +
> +			fec1: ethernet at 400d1000 {
> +				compatible = "fsl,mvf600-fec","fsl,mvf-fec";
> +				reg = <0x400d1000 0x1000>;
> +				interrupts = <0 79 0x04>;
> +				clocks = <&clks MVF600_CLK_ENET>,
> +					<&clks MVF600_CLK_ENET>,
> +					<&clks MVF600_CLK_ENET>;
> +				clock-names = "ipg", "ahb", "ptp";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.8.0
> 
> 
