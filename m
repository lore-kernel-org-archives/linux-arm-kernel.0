From: b35083@freescale.com (Jingchang Lu)
Date: Fri, 12 Apr 2013 14:57:04 +0800
Subject: [PATCH 2/3] ARM:DTS:MVF600: add basic device tree source
In-Reply-To: <1365749825-20601-1-git-send-email-b35083@freescale.com>
References: <1365749825-20601-1-git-send-email-b35083@freescale.com>
Message-ID: <1365749825-20601-3-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree source for Freescale
Vybrid Family platform and Tower development board.

Signed-off-by: Xiaochun Li <b41219@freescale.com>
Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/boot/dts/imx-mvf600.dtsi   | 442 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx-mvf600twr.dts |  82 +++++++
 2 files changed, 524 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx-mvf600.dtsi
 create mode 100644 arch/arm/boot/dts/imx-mvf600twr.dts

diff --git a/arch/arm/boot/dts/imx-mvf600.dtsi b/arch/arm/boot/dts/imx-mvf600.dtsi
new file mode 100644
index 0000000..3a534c6
--- /dev/null
+++ b/arch/arm/boot/dts/imx-mvf600.dtsi
@@ -0,0 +1,442 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+	};
+
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ckil {
+			compatible = "fsl,mvf-ckil", "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		ckih1 {
+			compatible = "fsl,mvf-ckih1", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		osc {
+			compatible = "fsl,mvf-osc", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		aips0: aips-bus at 40000000 { /* AIPS0 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-parent = <&intc>;
+			reg = <0x40000000 0x70000>;
+			ranges;
+
+			mscm: mscm at 40001000 {
+				compatible = "fsl,mvf-mscm";
+				reg = <0x40001000 0x1000>;
+			};
+
+			intc: interrupt-controller at 40002000 {
+				compatible = "arm,cortex-a9-gic";
+				#interrupt-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupt-controller;
+				reg = <0x40003000 0x1000>,
+				      <0x40002100 0x100>;
+			};
+
+			L2: l2-cache at 40006000 {
+				compatible = "arm,pl310-cache";
+				reg = <0x40006000 0x1000>;
+				interrupts = <0 6 0x04>;
+				cache-unified;
+				cache-level = <2>;
+			};
+
+			uart1: serial at 40027000 { /* UART0 */
+				compatible = "fsl,mvf-uart";
+				reg = <0x40027000 0x1000>;
+				interrupts = <0 61 0x00>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			uart2: serial at 40028000 { /* UART1 */
+				compatible = "fsl,mvf-uart";
+				reg = <0x40028000 0x1000>;
+				interrupts = <0 62 0x04>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			uart3: serial at 40029000 { /* UART2 */
+				compatible = "fsl,mvf-uart";
+				reg = <0x40029000 0x1000>;
+				interrupts = <0 63 0x04>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			uart4: serial at 4002a000 { /* UART3 */
+				compatible = "fsl,mvf-uart";
+				reg = <0x4002a000 0x1000>;
+				interrupts = <0 64 0x04>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			pit:pit at 40037000 {
+				compatible = "fsl,mvf-pit";
+				reg = <0x40037000 0x1000>;
+				interrupts = <0 39 0x04>;
+			};
+
+			wdog at 4003e000 {
+				compatible = "fsl,mvf-wdt";
+				reg = <0x4003e000 0x1000>;
+			};
+
+			qspi0: quadspi at 40044000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,mvf-qspi";
+				reg = <0x40044000 0x1000>;
+				interrupts = <0 24 0x04>;
+				status = "disabled";
+			};
+
+			pinctrl1: iomuxc at 40047000 {
+				compatible = "fsl,mvf-iomuxc";
+				reg = <0x40047000 0x2000>;
+				#gpio-range-cells = <2>;
+
+				/* iomux setting */
+				esdhc1 {
+					pinctrl_esdhc1_1: esdhc1grp_1 {
+						fsl,pins = <
+						85 0x5031ef /* PTA24__SDHC1_CLK */
+						91 0x5031ef /* PTA25__SDHC1_CMD */
+						96 0x5031ef /* PTA26__SDHC1_DAT0 */
+						101 0x5031ef /* PTA27__SDHC1_DAT1 */
+						108 0x5031ef /* PTA28__SDHC1_DAT2 */
+						115 0x5031ef /* PTA29__SDHC1_DAT3 */
+						776 0x219d /* PTA7__SDHC1_SW_CD */
+					>;
+					};
+				};
+				i2c0 {
+					pinctrl_i2c0_1: i2c0grp_1 {
+						fsl,pins = <
+						226 0x2030d3 /* PTB14__I2C0_SCL */
+						231 0x2030d3 /* PTB15__I2C0_SDA */
+						>;
+					};
+				};
+				dspi0 {
+					pinctrl_dspi0_1: dspi0grp_1 {
+						fsl,pins = <
+						247 0x101182 /* PTB19__DSPI0_PCS0 */
+						250 0x101181 /* PTB20__DSPI0_SIN */
+						254 0x101182 /* PTB21__DSPI0_SOUT */
+						259 0x101182 /* PTB22__DSPI0_SCK */
+						>;
+					};
+				};
+				fec0 {
+					pinctrl_fec0_1: fec0grp_1 {
+						fsl,pins = <
+						2 0x2030d1 /* PTA6__RMII_CLKIN */
+						262 0x1030d2 /* PTC0__RMII0_MDC */
+						270 0x1030d3 /* PTC1__RMII0_MDIO */
+						278 0x1030d1 /* PTC2__RMII0_CRS_DV */
+						285 0x1030d1 /* PTC3__RMII0_RXD1 */
+						292 0x1030d1 /* PTC4__RMII0_RXD0 */
+						300 0x1030d1 /* PTC5__RMII0_RXER */
+						308 0x1030d2 /* PTC6__RMII0_TXD1 */
+						315 0x1030d2 /* PTC7__RMII0_TXD0 */
+						321 0x1030d2 /* PTC8__RMII0_TXEN */
+						>;
+					};
+				};
+				fec1 {
+					pinctrl_fec1_1: fec1grp_1 {
+						fsl,pins = <
+						326 0x1030d2 /* PTC9__RMII1_MDC */
+						331 0x1030d3 /* PTC10__RMII1_MDIO */
+						336 0x1030d1 /* PTC11__RMII1_CRS_DV */
+						341 0x1030d1 /* PTC12__RMII1_RXD1 */
+						346 0x1030d1 /* PTC13__RMII1_RXD0 */
+						351 0x1030d1 /* PTC14__RMII1_RXER */
+						358 0x1030d2 /* PTC15__RMII1_TXD1 */
+						365 0x1030d2/* PTC16__RMII1_TXD0 */
+						372 0x1030d2/* PTC17__RMII1_TXEN */
+						>;
+					};
+				};
+				sai2 {
+					pinctrl_sai2_1: sai2grp_1 {
+						fsl,pins = <
+						35 0x5002ed /* PTA16_SAI2_TX_BCLK */
+						51 0x5002ee /* PTA18_SAI2_TX_DATA */
+						59 0x5002ed /* PTA19_SAI2_TX_SYNC */
+						69 0x5002ed /* PTA21_SAI2_RX_BCLK */
+						74 0x5002ed /* PTA22_SAI2_RX_DATA */
+						79 0x5002ed /* PTA23_SAI2_RX_SYNC */
+						244 0x2002ed /* PTB18_EXT_AUDIO_MCLK */
+						>;
+					};
+				};
+				dcu0 {
+					pinctrl_dcu0_1: dcu0grp_1 {
+						fsl,pins = <
+						191 0x42 /* PTB8_LCD_ENABLE */
+						647 0x100042 /* PTE0_DCU0_HSYNC */
+						652 0x100042 /* PTE1_DCU0_VSYNC */
+						657 0x100042 /* PTE2_DCU0_PCLK */
+						665 0x100042 /* PTE4_DCU0_DE */
+						669 0x100042 /* PTE5_DCU0_R0 */
+						673 0x100042 /* PTE6_DCU0_R1 */
+						677 0x100042 /* PTE7_DCU0_R2 */
+						682 0x100042 /* PTE8_DCU0_R3 */
+						687 0x100042 /* PTE9_DCU0_R4 */
+						692 0x100042 /* PTE10_DCU0_R5 */
+						697 0x100042 /* PTE11_DCU0_R6 */
+						702 0x100042 /* PTE12_DCU0_R7 */
+						708 0x100042 /* PTE13_DCU0_G0 */
+						712 0x100042 /* PTE14_DCU0_G1 */
+						716 0x100042 /* PTE15_DCU0_G2 */
+						721 0x100042 /* PTE16_DCU0_G3 */
+						725 0x100042 /* PTE17_DCU0_G4 */
+						729 0x100042 /* PTE18_DCU0_G5 */
+						733 0x100042 /* PTE19_DCU0_G6 */
+						738 0x100042 /* PTE20_DCU0_G7 */
+						744 0x100042 /* PTE21_DCU0_B0 */
+						747 0x100042 /* PTE22_DCU0_B1 */
+						750 0x100042 /* PTE23_DCU0_B2 */
+						754 0x100042 /* PTE24_DCU0_B3 */
+						758 0x100042 /* PTE25_DCU0_B4 */
+						762 0x100042 /* PTE26_DCU0_B5 */
+						766 0x100042 /* PTE27_DCU0_B6 */
+						771 0x100042 /* PTE28_DCU0_B7 */
+						>;
+					};
+				};
+				uart1 {
+					pinctrl_uart1_1: uart1grp_1 {
+						fsl,pins = <
+						163 0x2021a2 /* PTB4_UART1_TX */
+						171 0x2021a1 /* PTB5_UART1_RX */
+						>;
+					};
+				};
+				usbvbus {
+					pinctrl_usbvbus_1: usbvbusgrp_1 {
+						fsl,pins = <
+						32 0x20219c /* PTA24__USB0_VBUS_EN */
+						84 0x20219c /* PTA17__USB1_VBUS_EN */
+						>;
+					};
+				};
+				pwm0 {
+					pinctrl_pwm0_1: pwm0grp_1 {
+						fsl,pins = <
+						131 0x101582 /* PTB0_FTM0CH0 */
+						139 0x101582 /* PTB1_FTM0CH1 */
+						147 0x101582 /* PTB2_FTM0CH2 */
+						155 0x101582 /* PTB3_FTM0CH3 */
+						177 0x101582 /* PTB6_FTM0CH6 */
+						185 0x101582 /* PTB7_FTM0CH7 */
+						>;
+					};
+				};
+				pwm1 {
+					pinctrl_pwm1_1: pwm1grp_1 {
+						fsl,pins = <
+						197 0x101182 /* PTB9_FTM1CH1 */
+						>;
+					};
+				};
+				touchscreen0 {
+					pinctrl_ts0_1: ts0grp_1 {
+						fsl,pins = <
+						124 0x219d /* PTA31_TS_IRQ */
+						>;
+					};
+				};
+				qspi0 {
+					pinctrl_qspi0_1: qspi0grp_1 {
+						fsl,pins = <
+						483 0x10307b /* PTD0_QSPI0_A_SCK */
+						489 0x10307f /* PTD1_QSPI0_A_CS0 */
+						495 0x103073 /* PTD2_QSPI0_A_D3 */
+						502 0x103073 /* PTD3_QSPI0_A_D2 */
+						509 0x103073 /* PTD4_QSPI0_A_D1 */
+						515 0x10307b /* PTD5_QSPI0_A_D0 */
+						525 0x10307b /* PTD7_QSPI0_B_SCK */
+						530 0x10307f /* PTD8_QSPI0_B_CS0 */
+						536 0x103073 /* PTD9_QSPI0_B_D3 */
+						542 0x103073 /* PTD10_QSPI0_B_D2 */
+						547 0x103073 /* PTD11_QSPI0_B_D1 */
+						552 0x10307b /* PTD12_QSPI0_B_D0 */
+						>;
+					};
+				};
+
+			};
+
+			gpio1: gpio at 40049000 {
+				compatible = "fsl,mvf-gpio";
+				reg = <0x40049000 0x1000 0x400ff000 0x40>;
+				interrupts = <0 107 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&pinctrl1 0 32>;
+			};
+
+			gpio2: gpio at 4004a000 {
+				compatible = "fsl,mvf-gpio";
+				reg = <0x4004a000 0x1000 0x400ff040 0x40>;
+				interrupts = <0 108 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&pinctrl1 32 32>;
+			};
+
+			gpio3: gpio at 4004b000 {
+				compatible = "fsl,mvf-gpio";
+				reg = <0x4004b000 0x1000 0x400ff080 0x40>;
+				interrupts = <0 109 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&pinctrl1 64 32>;
+			};
+
+			gpio4: gpio at 4004c000 {
+				compatible = "fsl,mvf-gpio";
+				reg = <0x4004c000 0x1000 0x400ff0c0 0x40>;
+				interrupts = <0 110 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&pinctrl1 96 32>;
+			};
+
+			gpio5: gpio at 4004d000 {
+				compatible = "fsl,mvf-gpio";
+				reg = <0x4004d000 0x1000 0x400ff100 0x40>;
+				interrupts = <0 111 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&pinctrl1 128 7>;
+			};
+
+			anatop at 40050000 {
+				compatible = "fsl,mvf-anatop";
+				reg = <0x40050000 0x1000>;
+			};
+
+			clks: ccm at 4006b000 {
+				compatible = "fsl,mvf-ccm";
+				reg = <0x4006b000 0x1000>;
+				#clock-cells = <1>;
+			};
+
+		};
+
+		aips1: aips-bus at 40080000 { /* AIPS1 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x40080000 0x80000>;
+			ranges;
+
+			uart5: serial at 400a9000 { /* UART4 */
+				compatible = "fsl,mvf-uart";
+				reg = <0x400a9000 0x1000>;
+				interrupts = <0 65 0x04>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			uart6: serial at 400aa000 { /* UART5 */
+				compatible = "fsl,mvf-uart";
+				reg = <0x400aa000 0x1000>;
+				interrupts = <0 66 0x04>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			fec0: ethernet at 400d0000 {
+				compatible = "fsl,mvf-fec";
+				reg = <0x400d0000 0x1000>;
+				interrupts = <0 78 0x04>;
+				clocks = <&clks 52>, <&clks 52>, <&clks 52>;
+				clock-names = "ipg", "ahb", "ptp";
+			};
+
+			fec1: ethernet at 400d1000 {
+				compatible = "fsl,mvf-fec";
+				reg = <0x400d1000 0x1000>;
+				interrupts = <0 79 0x04>;
+				clocks = <&clks 52>, <&clks 52>, <&clks 52>;
+				clock-names = "ipg", "ahb", "ptp";
+			};
+
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx-mvf600twr.dts b/arch/arm/boot/dts/imx-mvf600twr.dts
new file mode 100644
index 0000000..1a6b4a9
--- /dev/null
+++ b/arch/arm/boot/dts/imx-mvf600twr.dts
@@ -0,0 +1,82 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/dts-v1/;
+/include/ "imx-mvf600.dtsi"
+
+/ {
+	model = "MVF600 Tower Board";
+	compatible = "fsl,imx-mvf600-twr", "fsl,imx-mvf600";
+
+	chosen {
+		bootargs = "console=ttymxc1,115200";
+	};
+
+	memory {
+		reg = <0x80000000 0x8000000>;
+	};
+
+	clocks {
+		audio_clk {
+			compatible = "fsl,mvf-audio-ext-clk", "fixed-clock";
+			clock-frequency = <24576000>;
+		};
+		enet_clk {
+			compatible = "fsl,mvf-enet-ext-clk", "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+};
+
+&uart2 { /* UART1 */
+	fsl,uart-fifo-mode;
+	status = "okay";
+};
+
+&fec0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec0_1>;
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1_1>;
+};
+
+
+&qspi0 { /* QuadSPI0 */
+	fsl,spi-num-chipselects = <1>;
+	fsl,spi-flash-chipselects = <0>;
+	status = "okay";
+
+	flash: s25fl128s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		linux,modalias = "m25p80";
+		modal = "s25fl128s";
+		partition at 0 {
+			label = "s25fl128s";
+			reg = <0x0 0x1000000>;
+		};
+	};
+};
-- 
1.8.0
