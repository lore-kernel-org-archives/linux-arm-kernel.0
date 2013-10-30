From: denis@eukrea.com (Denis Carikli)
Date: Wed, 30 Oct 2013 17:51:13 +0100
Subject: [PATCHv6][ 1/3] DT: Add basic support for imx35-based devices.
Message-ID: <1383151875-7708-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- The dependency on pdata clocks has been removed,
  and the dtsi adapted accordinly.
- Adaptation to the for-next branch of Shawn Guo at
  git://git.linaro.org/people/shawnguo/linux-2.6.git for-next
- imx35-dt.c: very small whitespace cleanup.
- Kconfig: The selection of IMX_HAVE_PLATFORM_* has been removed.
- dtsi: The nodes were reordered alphabetically.
- dtsi: The aliases have been reordered alphabetically.
- Shawn Guo was added in the Cc.
---
 .../devicetree/bindings/clock/imx35-clock.txt      |  115 +++++
 arch/arm/boot/dts/imx35.dtsi                       |  451 ++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |    9 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx35.c                      |   18 +
 arch/arm/mach-imx/common.h                         |    1 +
 arch/arm/mach-imx/imx35-dt.c                       |   48 +++
 7 files changed, 643 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
 create mode 100644 arch/arm/boot/dts/imx35.dtsi
 create mode 100644 arch/arm/mach-imx/imx35-dt.c

diff --git a/Documentation/devicetree/bindings/clock/imx35-clock.txt b/Documentation/devicetree/bindings/clock/imx35-clock.txt
new file mode 100644
index 0000000..9f9a60d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx35-clock.txt
@@ -0,0 +1,115 @@
+* Clock bindings for Freescale i.MX35
+
+Required properties:
+- compatible: Should be "fsl,imx35-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX35
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	ckih			0
+	mpll			1
+	ppll			2
+	mpll_075		3
+	arm			4
+	hsp			5
+	hsp_div			6
+	hsp_sel			7
+	ahb			8
+	ipg			9
+	arm_per_div		10
+	ahb_per_div		11
+	ipg_per			12
+	uart_sel		13
+	uart_div		14
+	esdhc_sel		15
+	esdhc1_div		16
+	esdhc2_div		17
+	esdhc3_div		18
+	spdif_sel		19
+	spdif_div_pre		20
+	spdif_div_post		21
+	ssi_sel			22
+	ssi1_div_pre		23
+	ssi1_div_post		24
+	ssi2_div_pre		25
+	ssi2_div_post		26
+	usb_sel			27
+	usb_div			28
+	nfc_div			29
+	asrc_gate		30
+	pata_gate		31
+	audmux_gate		32
+	can1_gate		33
+	can2_gate		34
+	cspi1_gate		35
+	cspi2_gate		36
+	ect_gate		37
+	edio_gate		38
+	emi_gate		39
+	epit1_gate		40
+	epit2_gate		41
+	esai_gate		42
+	esdhc1_gate		43
+	esdhc2_gate		44
+	esdhc3_gate		45
+	fec_gate		46
+	gpio1_gate		47
+	gpio2_gate		48
+	gpio3_gate		49
+	gpt_gate		50
+	i2c1_gate		51
+	i2c2_gate		52
+	i2c3_gate		53
+	iomuxc_gate		54
+	ipu_gate		55
+	kpp_gate		56
+	mlb_gate		57
+	mshc_gate		58
+	owire_gate		59
+	pwm_gate		60
+	rngc_gate		61
+	rtc_gate		62
+	rtic_gate		63
+	scc_gate		64
+	sdma_gate		65
+	spba_gate		66
+	spdif_gate		67
+	ssi1_gate		68
+	ssi2_gate		69
+	uart1_gate		70
+	uart2_gate		71
+	uart3_gate		72
+	usbotg_gate		73
+	wdog_gate		74
+	max_gate		75
+	admux_gate		76
+	csi_gate		77
+	csi_div			78
+	csi_sel			79
+	iim_gate		80
+	gpu2d_gate		81
+	clk_max			82
+
+Examples:
+
+clks: ccm at 53f80000 {
+	compatible = "fsl,imx35-ccm";
+	reg = <0x53f80000 0x4000>;
+	interrupts = <31>;
+	#clock-cells = <1>;
+};
+
+esdhc1: esdhc at 53fb4000 {
+	compatible = "fsl,imx35-esdhc";
+	reg = <0x53fb4000 0x4000>;
+	interrupts = <7>;
+	clocks = <&clks 9>, <&clks 8>, <&clks 43>;
+	clock-names = "ipg", "ahb", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
new file mode 100644
index 0000000..0f67f22
--- /dev/null
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -0,0 +1,451 @@
+/*
+ * Copyright 2012 Steffen Trumtrar, Pengutronix
+ *
+ * based on imx27.dtsi
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include "skeleton.dtsi"
+#include "imx35-pinfunc.h"
+
+/ {
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+	};
+
+	avic: avic-interrupt-controller at 68000000 {
+		compatible = "fsl,imx35-avic", "fsl,avic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x68000000 0x10000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ckil {
+			compatible = "fsl,imx-ckil", "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		osc {
+			compatible = "fsl,imx-osc", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&avic>;
+		ranges;
+
+		L2: l2-cache at 30000000 {
+			compatible = "arm,l210-cache";
+			reg = <0x30000000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		aips1: aips at 43f00000 {
+			compatible = "fsl,aips", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x43f00000 0x100000>;
+			ranges;
+
+			i2c1: i2c at 43f80000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
+				reg = <0x43f80000 0x4000>;
+				clocks = <&clks 51>;
+				clock-names = "ipg_per";
+				interrupts = <10>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 43f84000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
+				reg = <0x43f84000 0x4000>;
+				clocks = <&clks 53>;
+				clock-names = "ipg_per";
+				interrupts = <3>;
+				status = "disabled";
+			};
+
+			uart1: serial at 43f90000 {
+				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
+				reg = <0x43f90000 0x4000>;
+				clocks = <&clks 9>, <&clks 70>;
+				clock-names = "ipg", "per";
+				interrupts = <45>;
+				status = "disabled";
+			};
+
+			uart2: serial at 43f94000 {
+				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
+				reg = <0x43f94000 0x4000>;
+				clocks = <&clks 9>, <&clks 71>;
+				clock-names = "ipg", "per";
+				interrupts = <32>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 43f98000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
+				reg = <0x43f98000 0x4000>;
+				clocks = <&clks 52>;
+				clock-names = "ipg_per";
+				interrupts = <4>;
+				status = "disabled";
+			};
+
+			ssi1: ssi at 43fa0000 {
+				compatible = "fsl,imx35-ssi", "fsl,imx21-ssi";
+				reg = <0x43fa0000 0x4000>;
+				interrupts = <11>;
+				clocks = <&clks 68>;
+				dmas = <&sdma 28 0 0>,
+				       <&sdma 29 0 0>;
+				dma-names = "rx", "tx";
+				fsl,fifo-depth = <15>;
+				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
+				status = "disabled";
+			};
+
+			iomuxc: iomuxc at 43fac000 {
+				compatible = "fsl,imx35-iomuxc";
+				reg = <0x43fac000 0x4000>;
+
+				audmux {
+					pinctrl_audmux_1: audmuxgrp-1 {
+						fsl,pins = <
+							MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS 0x80000000
+							MX35_PAD_STXD4__AUDMUX_AUD4_TXD   0x80000000
+							MX35_PAD_SRXD4__AUDMUX_AUD4_RXD	  0x80000000
+							MX35_PAD_SCK4__AUDMUX_AUD4_TXC	  0x80000000
+						>;
+					};
+
+				};
+
+				can1 {
+					pinctrl_can1_1: can1grp-1 {
+						fsl,pins = <
+							MX35_PAD_I2C2_CLK__CAN1_TXCAN 0x1c0
+							MX35_PAD_I2C2_DAT__CAN1_RXCAN 0x1c0
+						>;
+					};
+				};
+
+				can2 {
+					pinctrl_can2_1: can2grp-1 {
+						fsl,pins = <
+							MX35_PAD_TX5_RX0__CAN2_TXCAN 0x1c0
+							MX35_PAD_TX4_RX1__CAN2_RXCAN 0x1c0
+						>;
+					};
+				};
+
+				esdhc1 {
+					pinctrl_esdhc1_1: esdhc1grp-1 {
+						fsl,pins = <
+							MX35_PAD_SD1_CMD__ESDHC1_CMD    0x80000000
+							MX35_PAD_SD1_CLK__ESDHC1_CLK    0x80000000
+							MX35_PAD_SD1_DATA0__ESDHC1_DAT0 0x80000000
+							MX35_PAD_SD1_DATA1__ESDHC1_DAT1 0x80000000
+							MX35_PAD_SD1_DATA2__ESDHC1_DAT2 0x80000000
+							MX35_PAD_SD1_DATA3__ESDHC1_DAT3 0x80000000
+						>;
+					};
+				};
+
+				fec {
+					pinctrl_fec_1: fecgrp-1 {
+						fsl,pins = <
+							MX35_PAD_FEC_TX_CLK__FEC_TX_CLK  0x80000000
+							MX35_PAD_FEC_RX_CLK__FEC_RX_CLK  0x80000000
+							MX35_PAD_FEC_RX_DV__FEC_RX_DV    0x80000000
+							MX35_PAD_FEC_COL__FEC_COL        0x80000000
+							MX35_PAD_FEC_RDATA0__FEC_RDATA_0 0x80000000
+							MX35_PAD_FEC_TDATA0__FEC_TDATA_0 0x80000000
+							MX35_PAD_FEC_TX_EN__FEC_TX_EN    0x80000000
+							MX35_PAD_FEC_MDC__FEC_MDC        0x80000000
+							MX35_PAD_FEC_MDIO__FEC_MDIO      0x80000000
+							MX35_PAD_FEC_TX_ERR__FEC_TX_ERR  0x80000000
+							MX35_PAD_FEC_RX_ERR__FEC_RX_ERR  0x80000000
+							MX35_PAD_FEC_CRS__FEC_CRS        0x80000000
+							MX35_PAD_FEC_RDATA1__FEC_RDATA_1 0x80000000
+							MX35_PAD_FEC_TDATA1__FEC_TDATA_1 0x80000000
+							MX35_PAD_FEC_RDATA2__FEC_RDATA_2 0x80000000
+							MX35_PAD_FEC_TDATA2__FEC_TDATA_2 0x80000000
+							MX35_PAD_FEC_RDATA3__FEC_RDATA_3 0x80000000
+							MX35_PAD_FEC_TDATA3__FEC_TDATA_3 0x80000000
+						>;
+					};
+				};
+
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <
+							MX35_PAD_I2C1_CLK__I2C1_SCL 0x80000000
+							MX35_PAD_I2C1_DAT__I2C1_SDA 0x80000000
+						>;
+					};
+				};
+
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <
+							MX35_PAD_ATA_DATA12__I2C3_SCL 0x1c0
+							MX35_PAD_ATA_DATA13__I2C3_SDA 0x1c0
+						>;
+					};
+				};
+				lcdc {
+					pinctrl_lcdc_1: lcdcgp-1 {
+						fsl,pins = <
+							MX35_PAD_LD0__IPU_DISPB_DAT_0         0x80000000
+							MX35_PAD_LD1__IPU_DISPB_DAT_1         0x80000000
+							MX35_PAD_LD2__IPU_DISPB_DAT_2         0x80000000
+							MX35_PAD_LD3__IPU_DISPB_DAT_3         0x80000000
+							MX35_PAD_LD4__IPU_DISPB_DAT_4         0x80000000
+							MX35_PAD_LD5__IPU_DISPB_DAT_5         0x80000000
+							MX35_PAD_LD6__IPU_DISPB_DAT_6         0x80000000
+							MX35_PAD_LD7__IPU_DISPB_DAT_7         0x80000000
+							MX35_PAD_LD8__IPU_DISPB_DAT_8         0x80000000
+							MX35_PAD_LD9__IPU_DISPB_DAT_9         0x80000000
+							MX35_PAD_LD10__IPU_DISPB_DAT_10       0x80000000
+							MX35_PAD_LD11__IPU_DISPB_DAT_11       0x80000000
+							MX35_PAD_LD12__IPU_DISPB_DAT_12	      0x80000000
+							MX35_PAD_LD13__IPU_DISPB_DAT_13       0x80000000
+							MX35_PAD_LD14__IPU_DISPB_DAT_14       0x80000000
+							MX35_PAD_LD15__IPU_DISPB_DAT_15       0x80000000
+							MX35_PAD_LD16__IPU_DISPB_DAT_16       0x80000000
+							MX35_PAD_LD17__IPU_DISPB_DAT_17       0x80000000
+							MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC 0x80000000
+							MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK 0x80000000
+							MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY   0x80000000
+							MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC 0x80000000
+							/* Backlight */
+							MX35_PAD_CONTRAST__IPU_DISPB_CONTR    0x80000000
+						>;
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <
+							MX35_PAD_CTS1__UART1_CTS     0x80000000
+							MX35_PAD_RTS1__UART1_RTS     0x80000000
+							MX35_PAD_TXD1__UART1_TXD_MUX 0x80000000
+							MX35_PAD_RXD1__UART1_RXD_MUX 0x80000000
+						>;
+					};
+				};
+
+				uart2 {
+					pinctrl_uart2_1: uart2grp-1 {
+						fsl,pins = <
+							MX35_PAD_RTS2__UART2_RTS     0x80000000
+							MX35_PAD_CTS2__UART2_CTS     0x80000000
+							MX35_PAD_RXD2__UART2_RXD_MUX 0x80000000
+							MX35_PAD_TXD2__UART2_TXD_MUX 0x80000000
+						>;
+					};
+				};
+			};
+		};
+
+		spba: spba-bus at 50000000 {
+			compatible = "fsl,spba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x50000000 0x100000>;
+			ranges;
+
+			uart3: serial at 5000c000 {
+				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
+				reg = <0x5000c000 0x4000>;
+				clocks = <&clks 9>, <&clks 72>;
+				clock-names = "ipg", "per";
+				interrupts = <18>;
+				status = "disabled";
+			};
+
+			fec: fec at 50038000 {
+				compatible = "fsl,imx35-fec", "fsl,imx27-fec";
+				reg = <0x50038000 0x4000>;
+				clocks = <&clks 46>, <&clks 8>;
+				clock-names = "ipg", "ahb";
+				interrupts = <57>;
+				status = "disabled";
+			};
+		};
+
+		aips2: aips at 53f00000 {
+			compatible = "fsl,aips", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x53f00000 0x100000>;
+			ranges;
+
+			clks: ccm at 53f80000 {
+				compatible = "fsl,imx35-ccm";
+				reg = <0x53f80000 0x4000>;
+				interrupts = <31>;
+				#clock-cells = <1>;
+			};
+
+			gpio3: gpio at 53fa4000 {
+				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <56>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			esdhc1: esdhc at 53fb4000 {
+				compatible = "fsl,imx35-esdhc";
+				reg = <0x53fb4000 0x4000>;
+				interrupts = <7>;
+				clocks = <&clks 9>, <&clks 8>, <&clks 43>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			esdhc2: esdhc at 53fb8000 {
+				compatible = "fsl,imx35-esdhc";
+				reg = <0x53fb8000 0x4000>;
+				interrupts = <8>;
+				clocks = <&clks 9>, <&clks 8>, <&clks 44>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			esdhc3: esdhc at 53fbc000 {
+				compatible = "fsl,imx35-esdhc";
+				reg = <0x53fbc000 0x4000>;
+				interrupts = <9>;
+				clocks = <&clks 9>, <&clks 8>, <&clks 45>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			audmux: audmux at 53fc4000 {
+				compatible = "fsl,imx35-audmux", "fsl,imx31-audmux";
+				reg = <0x53fc4000 0x4000>;
+				status = "disabled";
+			};
+
+			gpio1: gpio at 53fcc000 {
+				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
+				reg = <0x53fcc000 0x4000>;
+				interrupts = <52>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio at 53fd0000 {
+				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
+				reg = <0x53fd0000 0x4000>;
+				interrupts = <51>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			sdma: sdma at 53fd4000 {
+				compatible = "fsl,imx35-sdma";
+				reg = <0x53fd4000 0x4000>;
+				clocks = <&clks 9>, <&clks 65>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				interrupts = <34>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx35.bin";
+			};
+
+			wdog: wdog at 53fdc000 {
+				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
+				reg = <0x53fdc000 0x4000>;
+				clocks = <&clks 74>;
+				clock-names = "";
+				interrupts = <55>;
+			};
+
+			can1: can at 53fe4000 {
+				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fe4000 0x1000>;
+				clocks = <&clks 33>;
+				clock-names = "ipg";
+				interrupts = <43>;
+				status = "disabled";
+			};
+
+			can2: can at 53fe8000 {
+				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fe8000 0x1000>;
+				clocks = <&clks 34>;
+				clock-names = "ipg";
+				interrupts = <44>;
+				status = "disabled";
+			};
+		};
+
+		emi at 80000000 { /* External Memory Interface */
+			compatible = "fsl,emi", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80000000 0x40000000>;
+			ranges;
+
+			nfc: nand at bb000000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				compatible = "fsl,imx35-nand", "fsl,imx25-nand";
+				reg = <0xbb000000 0x2000>;
+				clocks = <&clks 29>;
+				clock-names = "";
+				interrupts = <33>;
+				status = "disabled";
+			};
+
+			weim: weim at b8002000 {
+				#address-cells = <2>;
+				#size-cells = <1>;
+				compatible = "fsl,imx35-weim";
+				reg = <0xb8002000 0x1000>;
+				ranges = <
+					0 0 0xa0000000 0x8000000
+					1 0 0xa8000000 0x8000000
+					2 0 0xb0000000 0x2000000
+					3 0 0xb2000000 0x2000000
+					4 0 0xb4000000 0x2000000
+					5 0 0xb6000000 0x2000000
+				>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 270f786..3a560fa 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -626,6 +626,15 @@ config MACH_IMX31_DT
 
 comment "MX35 platforms:"
 
+config MACH_IMX35_DT
+	bool "Support i.MX35 platforms from device tree"
+	select SOC_IMX35
+	select PINCTRL
+	select PINCTRL_IMX35
+	help
+	  Include support for Freescale i.MX35 based platforms
+	  using the device tree for discovery.
+
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select IMX_HAVE_PLATFORM_FLEXCAN
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bbe1f5b..97d7a1d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
+obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
 
 obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 2193c83..cea861b 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -45,6 +45,8 @@ static struct arm_ahb_div clk_consumer[] = {
 static char hsp_div_532[] = { 4, 8, 3, 0 };
 static char hsp_div_400[] = { 3, 6, 3, 0 };
 
+static struct clk_onecell_data clk_data;
+
 static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
@@ -286,3 +288,19 @@ int __init mx35_clocks_init(void)
 
 	return 0;
 }
+
+int __init mx35_clocks_init_dt(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+	int irq;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-ccm");
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	mx35_clocks_init();
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7cbe22d..e438ca7 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -65,6 +65,7 @@ int mx35_clocks_init(void);
 int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 int mx25_clocks_init_dt(void);
+int mx35_clocks_init_dt(void);
 int mx27_clocks_init_dt(void);
 int mx31_clocks_init_dt(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
new file mode 100644
index 0000000..e3def45
--- /dev/null
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2012 Steffen Trumtrar, Pengutronix
+ *
+ * based on imx27-dt.c
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "common.h"
+#include "mx35.h"
+
+static void __init imx35_dt_init(void)
+{
+	mxc_arch_reset_init_dt();
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     NULL, NULL);
+}
+
+static void __init imx35_timer_init(void)
+{
+	mx35_clocks_init_dt();
+}
+
+static const char *imx35_dt_board_compat[] __initdata = {
+	"fsl,imx35",
+	NULL
+};
+
+DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
+	.map_io		= mx35_map_io,
+	.init_early	= imx35_init_early,
+	.init_irq	= mx35_init_irq,
+	.handle_irq	= imx35_handle_irq,
+	.init_time	= imx35_timer_init,
+	.init_machine	= imx35_dt_init,
+	.dt_compat	= imx35_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
1.7.9.5
