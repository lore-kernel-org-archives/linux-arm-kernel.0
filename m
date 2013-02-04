From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Feb 2013 23:27:26 +0800
Subject: [PATCH 2/2] ARM: dts: add dtsi for imx6q and imx6dl
In-Reply-To: <1359991646-7803-1-git-send-email-shawn.guo@linaro.org>
References: <1359991646-7803-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1359991646-7803-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dtsi for imx6q and imx6dl with non-common blocks moved into there.
Major differences between imx6dl and imx6q:

 * Dual vs. Quad cores
 * single vs. dual IPU
 * 128 vs. 256 KB OCRAM
 * imx6q: ECSPI5, OpenVG (GC355), SATA
 * imx6dl: I2C4, PXP, EPDC, LCDIF
 * iomuxc/pads definition

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6dl.dtsi         |   59 +++++++
 arch/arm/boot/dts/imx6q-arm2.dts      |    2 +-
 arch/arm/boot/dts/imx6q-sabreauto.dts |    2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 +-
 arch/arm/boot/dts/imx6q-sabresd.dts   |    2 +-
 arch/arm/boot/dts/imx6q.dtsi          |  296 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi        |  277 ------------------------------
 7 files changed, 359 insertions(+), 281 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q.dtsi

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
new file mode 100644
index 0000000..63fafe2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/include/ "imx6qdl.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	soc {
+		aips1: aips-bus at 02000000 {
+			pxp: pxp at 020f0000 {
+				reg = <0x020f0000 0x4000>;
+				interrupts = <0 98 0x04>;
+			};
+
+			epdc: epdc at 020f4000 {
+				reg = <0x020f4000 0x4000>;
+				interrupts = <0 97 0x04>;
+			};
+
+			lcdif: lcdif at 020f8000 {
+				reg = <0x020f8000 0x4000>;
+				interrupts = <0 39 0x04>;
+			};
+		};
+
+		aips2: aips-bus at 02100000 {
+			i2c4: i2c at 021f8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx1-i2c";
+				reg = <0x021f8000 0x4000>;
+				interrupts = <0 35 0x04>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index cd5813d..53eb241 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6qdl.dtsi"
+/include/ "imx6q.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad Armadillo2 Board";
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 5baa824..656d489 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6qdl.dtsi"
+/include/ "imx6q.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Automotive Board";
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 6aaaf69..2ce355c 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6qdl.dtsi"
+/include/ "imx6q.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Lite Board";
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index a48528f..2dea304 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6qdl.dtsi"
+/include/ "imx6q.dtsi"
 
 / {
 	model = "Freescale i.MX6Q SABRE Smart Device Board";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
new file mode 100644
index 0000000..cba021e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -0,0 +1,296 @@
+
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/include/ "imx6qdl.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			operating-points = <
+				/* kHz    uV */
+				1200000 1275000
+				996000  1250000
+				792000  1150000
+				396000  950000
+			>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
+				 <&clks 17>, <&clks 170>;
+			clock-names = "arm", "pll2_pfd2_396m", "step",
+				      "pll1_sw", "pll1_sys";
+			arm-supply = <&reg_arm>;
+			pu-supply = <&reg_pu>;
+			soc-supply = <&reg_soc>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a9";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	soc {
+		aips-bus at 02000000 { /* AIPS1 */
+			spba-bus at 02000000 {
+				ecspi5: ecspi at 02018000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02018000 0x4000>;
+					interrupts = <0 35 0x04>;
+					clocks = <&clks 116>, <&clks 116>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+			};
+
+			iomuxc: iomuxc at 020e0000 {
+				compatible = "fsl,imx6q-iomuxc";
+				reg = <0x020e0000 0x4000>;
+
+				/* shared pinctrl settings */
+				audmux {
+					pinctrl_audmux_1: audmux-1 {
+						fsl,pins = <
+							18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
+							1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
+							11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
+							3    0x80000000	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
+						>;
+					};
+				};
+
+				ecspi1 {
+					pinctrl_ecspi1_1: ecspi1grp-1 {
+						fsl,pins = <
+							101 0x100b1	/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
+							109 0x100b1	/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
+							94  0x100b1	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
+						>;
+					};
+				};
+
+				enet {
+					pinctrl_enet_1: enetgrp-1 {
+						fsl,pins = <
+							695 0x1b0b0	/* MX6Q_PAD_ENET_MDIO__ENET_MDIO */
+							756 0x1b0b0	/* MX6Q_PAD_ENET_MDC__ENET_MDC */
+							24  0x1b0b0	/* MX6Q_PAD_RGMII_TXC__ENET_RGMII_TXC */
+							30  0x1b0b0	/* MX6Q_PAD_RGMII_TD0__ENET_RGMII_TD0 */
+							34  0x1b0b0	/* MX6Q_PAD_RGMII_TD1__ENET_RGMII_TD1 */
+							39  0x1b0b0	/* MX6Q_PAD_RGMII_TD2__ENET_RGMII_TD2 */
+							44  0x1b0b0	/* MX6Q_PAD_RGMII_TD3__ENET_RGMII_TD3 */
+							56  0x1b0b0	/* MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL */
+							702 0x1b0b0	/* MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK */
+							74  0x1b0b0	/* MX6Q_PAD_RGMII_RXC__ENET_RGMII_RXC */
+							52  0x1b0b0	/* MX6Q_PAD_RGMII_RD0__ENET_RGMII_RD0 */
+							61  0x1b0b0	/* MX6Q_PAD_RGMII_RD1__ENET_RGMII_RD1 */
+							66  0x1b0b0	/* MX6Q_PAD_RGMII_RD2__ENET_RGMII_RD2 */
+							70  0x1b0b0	/* MX6Q_PAD_RGMII_RD3__ENET_RGMII_RD3 */
+							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
+							1033 0x4001b0a8	/* MX6Q_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT*/
+						>;
+					};
+
+					pinctrl_enet_2: enetgrp-2 {
+						fsl,pins = <
+							890 0x1b0b0	/* MX6Q_PAD_KEY_COL1__ENET_MDIO */
+							909 0x1b0b0	/* MX6Q_PAD_KEY_COL2__ENET_MDC */
+							24  0x1b0b0	/* MX6Q_PAD_RGMII_TXC__ENET_RGMII_TXC */
+							30  0x1b0b0	/* MX6Q_PAD_RGMII_TD0__ENET_RGMII_TD0 */
+							34  0x1b0b0	/* MX6Q_PAD_RGMII_TD1__ENET_RGMII_TD1 */
+							39  0x1b0b0	/* MX6Q_PAD_RGMII_TD2__ENET_RGMII_TD2 */
+							44  0x1b0b0	/* MX6Q_PAD_RGMII_TD3__ENET_RGMII_TD3 */
+							56  0x1b0b0	/* MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL */
+							702 0x1b0b0	/* MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK */
+							74  0x1b0b0	/* MX6Q_PAD_RGMII_RXC__ENET_RGMII_RXC */
+							52  0x1b0b0	/* MX6Q_PAD_RGMII_RD0__ENET_RGMII_RD0 */
+							61  0x1b0b0	/* MX6Q_PAD_RGMII_RD1__ENET_RGMII_RD1 */
+							66  0x1b0b0	/* MX6Q_PAD_RGMII_RD2__ENET_RGMII_RD2 */
+							70  0x1b0b0	/* MX6Q_PAD_RGMII_RD3__ENET_RGMII_RD3 */
+							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
+						>;
+					};
+				};
+
+				gpmi-nand {
+					pinctrl_gpmi_nand_1: gpmi-nand-1 {
+						fsl,pins = <
+							1328 0xb0b1	/* MX6Q_PAD_NANDF_CLE__RAWNAND_CLE */
+							1336 0xb0b1	/* MX6Q_PAD_NANDF_ALE__RAWNAND_ALE */
+							1344 0xb0b1	/* MX6Q_PAD_NANDF_WP_B__RAWNAND_RESETN */
+							1352 0xb000	/* MX6Q_PAD_NANDF_RB0__RAWNAND_READY0 */
+							1360 0xb0b1	/* MX6Q_PAD_NANDF_CS0__RAWNAND_CE0N */
+							1365 0xb0b1	/* MX6Q_PAD_NANDF_CS1__RAWNAND_CE1N */
+							1371 0xb0b1	/* MX6Q_PAD_NANDF_CS2__RAWNAND_CE2N */
+							1378 0xb0b1	/* MX6Q_PAD_NANDF_CS3__RAWNAND_CE3N */
+							1387 0xb0b1	/* MX6Q_PAD_SD4_CMD__RAWNAND_RDN */
+							1393 0xb0b1	/* MX6Q_PAD_SD4_CLK__RAWNAND_WRN */
+							1397 0xb0b1	/* MX6Q_PAD_NANDF_D0__RAWNAND_D0 */
+							1405 0xb0b1	/* MX6Q_PAD_NANDF_D1__RAWNAND_D1 */
+							1413 0xb0b1	/* MX6Q_PAD_NANDF_D2__RAWNAND_D2 */
+							1421 0xb0b1	/* MX6Q_PAD_NANDF_D3__RAWNAND_D3 */
+							1429 0xb0b1	/* MX6Q_PAD_NANDF_D4__RAWNAND_D4 */
+							1437 0xb0b1	/* MX6Q_PAD_NANDF_D5__RAWNAND_D5 */
+							1445 0xb0b1	/* MX6Q_PAD_NANDF_D6__RAWNAND_D6 */
+							1453 0xb0b1	/* MX6Q_PAD_NANDF_D7__RAWNAND_D7 */
+							1463 0x00b1	/* MX6Q_PAD_SD4_DAT0__RAWNAND_DQS */
+						>;
+					};
+				};
+
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <
+							137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
+							196 0x4001b8b1	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
+						>;
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <
+							1140 0x1b0b1	/* MX6Q_PAD_CSI0_DAT10__UART1_TXD */
+							1148 0x1b0b1	/* MX6Q_PAD_CSI0_DAT11__UART1_RXD */
+						>;
+					};
+				};
+
+				uart2 {
+					pinctrl_uart2_1: uart2grp-1 {
+						fsl,pins = <
+							183 0x1b0b1	/* MX6Q_PAD_EIM_D26__UART2_TXD */
+							191 0x1b0b1	/* MX6Q_PAD_EIM_D27__UART2_RXD */
+						>;
+					};
+				};
+
+				uart4 {
+					pinctrl_uart4_1: uart4grp-1 {
+						fsl,pins = <
+							877 0x1b0b1	/* MX6Q_PAD_KEY_COL0__UART4_TXD */
+							885 0x1b0b1	/* MX6Q_PAD_KEY_ROW0__UART4_RXD */
+						>;
+					};
+				};
+
+				usbotg {
+					pinctrl_usbotg_1: usbotggrp-1 {
+						fsl,pins = <
+							1592 0x17059	/* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
+						>;
+					};
+				};
+
+				usdhc2 {
+					pinctrl_usdhc2_1: usdhc2grp-1 {
+						fsl,pins = <
+							1577 0x17059	/* MX6Q_PAD_SD2_CMD__USDHC2_CMD */
+							1569 0x10059	/* MX6Q_PAD_SD2_CLK__USDHC2_CLK */
+							16   0x17059	/* MX6Q_PAD_SD2_DAT0__USDHC2_DAT0 */
+							0    0x17059	/* MX6Q_PAD_SD2_DAT1__USDHC2_DAT1 */
+							8    0x17059	/* MX6Q_PAD_SD2_DAT2__USDHC2_DAT2 */
+							1583 0x17059	/* MX6Q_PAD_SD2_DAT3__USDHC2_DAT3 */
+							1430 0x17059	/* MX6Q_PAD_NANDF_D4__USDHC2_DAT4 */
+							1438 0x17059	/* MX6Q_PAD_NANDF_D5__USDHC2_DAT5 */
+							1446 0x17059	/* MX6Q_PAD_NANDF_D6__USDHC2_DAT6 */
+							1454 0x17059	/* MX6Q_PAD_NANDF_D7__USDHC2_DAT7 */
+						>;
+					};
+				};
+
+				usdhc3 {
+					pinctrl_usdhc3_1: usdhc3grp-1 {
+						fsl,pins = <
+							1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
+							1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
+							1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
+							1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
+							1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
+							1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
+							1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
+							1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
+							1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
+							1241 0x17059	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
+						>;
+					};
+
+					pinctrl_usdhc3_2: usdhc3grp-2 {
+						fsl,pins = <
+							1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
+							1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
+							1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
+							1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
+							1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
+							1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
+						>;
+					};
+				};
+
+				usdhc4 {
+					pinctrl_usdhc4_1: usdhc4grp-1 {
+						fsl,pins = <
+							1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+							1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
+							1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+							1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+							1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+							1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+							1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
+							1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
+							1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
+							1517 0x17059	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
+						>;
+					};
+
+					pinctrl_usdhc4_2: usdhc4grp-2 {
+						fsl,pins = <
+							1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+							1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
+							1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+							1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+							1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+							1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+						>;
+					};
+				};
+			};
+		};
+
+		ipu2: ipu at 02800000 {
+			#crtc-cells = <1>;
+			compatible = "fsl,imx6q-ipu";
+			reg = <0x02800000 0x400000>;
+			interrupts = <0 8 0x4 0 7 0x4>;
+			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
+			clock-names = "bus", "di0", "di1";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index de0d5c9..5a0d996 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -28,50 +28,6 @@
 		gpio6 = &gpio7;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu at 0 {
-			compatible = "arm,cortex-a9";
-			reg = <0>;
-			next-level-cache = <&L2>;
-			operating-points = <
-				/* kHz    uV */
-				1200000 1275000
-				996000  1250000
-				792000  1150000
-				396000  950000
-			>;
-			clock-latency = <61036>; /* two CLK32 periods */
-			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
-				 <&clks 17>, <&clks 170>;
-			clock-names = "arm", "pll2_pfd2_396m", "step",
-				      "pll1_sw", "pll1_sys";
-			arm-supply = <&reg_arm>;
-			pu-supply = <&reg_pu>;
-			soc-supply = <&reg_soc>;
-		};
-
-		cpu at 1 {
-			compatible = "arm,cortex-a9";
-			reg = <1>;
-			next-level-cache = <&L2>;
-		};
-
-		cpu at 2 {
-			compatible = "arm,cortex-a9";
-			reg = <2>;
-			next-level-cache = <&L2>;
-		};
-
-		cpu at 3 {
-			compatible = "arm,cortex-a9";
-			reg = <3>;
-			next-level-cache = <&L2>;
-		};
-	};
-
 	intc: interrupt-controller at 00a01000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -208,17 +164,6 @@
 					status = "disabled";
 				};
 
-				ecspi5: ecspi at 02018000 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02018000 0x4000>;
-					interrupts = <0 35 0x04>;
-					clocks = <&clks 116>, <&clks 116>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
 				uart1: serial at 02020000 {
 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
@@ -584,219 +529,6 @@
 				reg = <0x020e0000 0x38>;
 			};
 
-			iomuxc: iomuxc at 020e0000 {
-				compatible = "fsl,imx6q-iomuxc";
-				reg = <0x020e0000 0x4000>;
-
-				/* shared pinctrl settings */
-				audmux {
-					pinctrl_audmux_1: audmux-1 {
-						fsl,pins = <
-							18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
-							1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
-							11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
-							3    0x80000000	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
-						>;
-					};
-				};
-
-				ecspi1 {
-					pinctrl_ecspi1_1: ecspi1grp-1 {
-						fsl,pins = <
-							101 0x100b1	/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
-							109 0x100b1	/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
-							94  0x100b1	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
-						>;
-					};
-				};
-
-				enet {
-					pinctrl_enet_1: enetgrp-1 {
-						fsl,pins = <
-							695 0x1b0b0	/* MX6Q_PAD_ENET_MDIO__ENET_MDIO */
-							756 0x1b0b0	/* MX6Q_PAD_ENET_MDC__ENET_MDC */
-							24  0x1b0b0	/* MX6Q_PAD_RGMII_TXC__ENET_RGMII_TXC */
-							30  0x1b0b0	/* MX6Q_PAD_RGMII_TD0__ENET_RGMII_TD0 */
-							34  0x1b0b0	/* MX6Q_PAD_RGMII_TD1__ENET_RGMII_TD1 */
-							39  0x1b0b0	/* MX6Q_PAD_RGMII_TD2__ENET_RGMII_TD2 */
-							44  0x1b0b0	/* MX6Q_PAD_RGMII_TD3__ENET_RGMII_TD3 */
-							56  0x1b0b0	/* MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL */
-							702 0x1b0b0	/* MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK */
-							74  0x1b0b0	/* MX6Q_PAD_RGMII_RXC__ENET_RGMII_RXC */
-							52  0x1b0b0	/* MX6Q_PAD_RGMII_RD0__ENET_RGMII_RD0 */
-							61  0x1b0b0	/* MX6Q_PAD_RGMII_RD1__ENET_RGMII_RD1 */
-							66  0x1b0b0	/* MX6Q_PAD_RGMII_RD2__ENET_RGMII_RD2 */
-							70  0x1b0b0	/* MX6Q_PAD_RGMII_RD3__ENET_RGMII_RD3 */
-							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
-							1033 0x4001b0a8	/* MX6Q_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT*/
-						>;
-					};
-
-					pinctrl_enet_2: enetgrp-2 {
-						fsl,pins = <
-							890 0x1b0b0	/* MX6Q_PAD_KEY_COL1__ENET_MDIO */
-							909 0x1b0b0	/* MX6Q_PAD_KEY_COL2__ENET_MDC */
-							24  0x1b0b0	/* MX6Q_PAD_RGMII_TXC__ENET_RGMII_TXC */
-							30  0x1b0b0	/* MX6Q_PAD_RGMII_TD0__ENET_RGMII_TD0 */
-							34  0x1b0b0	/* MX6Q_PAD_RGMII_TD1__ENET_RGMII_TD1 */
-							39  0x1b0b0	/* MX6Q_PAD_RGMII_TD2__ENET_RGMII_TD2 */
-							44  0x1b0b0	/* MX6Q_PAD_RGMII_TD3__ENET_RGMII_TD3 */
-							56  0x1b0b0	/* MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL */
-							702 0x1b0b0	/* MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK */
-							74  0x1b0b0	/* MX6Q_PAD_RGMII_RXC__ENET_RGMII_RXC */
-							52  0x1b0b0	/* MX6Q_PAD_RGMII_RD0__ENET_RGMII_RD0 */
-							61  0x1b0b0	/* MX6Q_PAD_RGMII_RD1__ENET_RGMII_RD1 */
-							66  0x1b0b0	/* MX6Q_PAD_RGMII_RD2__ENET_RGMII_RD2 */
-							70  0x1b0b0	/* MX6Q_PAD_RGMII_RD3__ENET_RGMII_RD3 */
-							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
-						>;
-					};
-				};
-
-				gpmi-nand {
-					pinctrl_gpmi_nand_1: gpmi-nand-1 {
-						fsl,pins = <
-							1328 0xb0b1	/* MX6Q_PAD_NANDF_CLE__RAWNAND_CLE */
-							1336 0xb0b1	/* MX6Q_PAD_NANDF_ALE__RAWNAND_ALE */
-							1344 0xb0b1	/* MX6Q_PAD_NANDF_WP_B__RAWNAND_RESETN */
-							1352 0xb000	/* MX6Q_PAD_NANDF_RB0__RAWNAND_READY0 */
-							1360 0xb0b1	/* MX6Q_PAD_NANDF_CS0__RAWNAND_CE0N */
-							1365 0xb0b1	/* MX6Q_PAD_NANDF_CS1__RAWNAND_CE1N */
-							1371 0xb0b1	/* MX6Q_PAD_NANDF_CS2__RAWNAND_CE2N */
-							1378 0xb0b1	/* MX6Q_PAD_NANDF_CS3__RAWNAND_CE3N */
-							1387 0xb0b1	/* MX6Q_PAD_SD4_CMD__RAWNAND_RDN */
-							1393 0xb0b1	/* MX6Q_PAD_SD4_CLK__RAWNAND_WRN */
-							1397 0xb0b1	/* MX6Q_PAD_NANDF_D0__RAWNAND_D0 */
-							1405 0xb0b1	/* MX6Q_PAD_NANDF_D1__RAWNAND_D1 */
-							1413 0xb0b1	/* MX6Q_PAD_NANDF_D2__RAWNAND_D2 */
-							1421 0xb0b1	/* MX6Q_PAD_NANDF_D3__RAWNAND_D3 */
-							1429 0xb0b1	/* MX6Q_PAD_NANDF_D4__RAWNAND_D4 */
-							1437 0xb0b1	/* MX6Q_PAD_NANDF_D5__RAWNAND_D5 */
-							1445 0xb0b1	/* MX6Q_PAD_NANDF_D6__RAWNAND_D6 */
-							1453 0xb0b1	/* MX6Q_PAD_NANDF_D7__RAWNAND_D7 */
-							1463 0x00b1	/* MX6Q_PAD_SD4_DAT0__RAWNAND_DQS */
-						>;
-					};
-				};
-
-				i2c1 {
-					pinctrl_i2c1_1: i2c1grp-1 {
-						fsl,pins = <
-							137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
-							196 0x4001b8b1	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
-						>;
-					};
-				};
-
-				uart1 {
-					pinctrl_uart1_1: uart1grp-1 {
-						fsl,pins = <
-							1140 0x1b0b1	/* MX6Q_PAD_CSI0_DAT10__UART1_TXD */
-							1148 0x1b0b1	/* MX6Q_PAD_CSI0_DAT11__UART1_RXD */
-						>;
-					};
-				};
-
-				uart2 {
-					pinctrl_uart2_1: uart2grp-1 {
-						fsl,pins = <
-							183 0x1b0b1	/* MX6Q_PAD_EIM_D26__UART2_TXD */
-							191 0x1b0b1	/* MX6Q_PAD_EIM_D27__UART2_RXD */
-						>;
-					};
-				};
-
-				uart4 {
-					pinctrl_uart4_1: uart4grp-1 {
-						fsl,pins = <
-							877 0x1b0b1	/* MX6Q_PAD_KEY_COL0__UART4_TXD */
-							885 0x1b0b1	/* MX6Q_PAD_KEY_ROW0__UART4_RXD */
-						>;
-					};
-				};
-
-				usbotg {
-					pinctrl_usbotg_1: usbotggrp-1 {
-						fsl,pins = <
-							1592 0x17059	/* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
-						>;
-					};
-				};
-
-				usdhc2 {
-					pinctrl_usdhc2_1: usdhc2grp-1 {
-						fsl,pins = <
-							1577 0x17059	/* MX6Q_PAD_SD2_CMD__USDHC2_CMD */
-							1569 0x10059	/* MX6Q_PAD_SD2_CLK__USDHC2_CLK */
-							16   0x17059	/* MX6Q_PAD_SD2_DAT0__USDHC2_DAT0 */
-							0    0x17059	/* MX6Q_PAD_SD2_DAT1__USDHC2_DAT1 */
-							8    0x17059	/* MX6Q_PAD_SD2_DAT2__USDHC2_DAT2 */
-							1583 0x17059	/* MX6Q_PAD_SD2_DAT3__USDHC2_DAT3 */
-							1430 0x17059	/* MX6Q_PAD_NANDF_D4__USDHC2_DAT4 */
-							1438 0x17059	/* MX6Q_PAD_NANDF_D5__USDHC2_DAT5 */
-							1446 0x17059	/* MX6Q_PAD_NANDF_D6__USDHC2_DAT6 */
-							1454 0x17059	/* MX6Q_PAD_NANDF_D7__USDHC2_DAT7 */
-						>;
-					};
-				};
-
-				usdhc3 {
-					pinctrl_usdhc3_1: usdhc3grp-1 {
-						fsl,pins = <
-							1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-							1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
-							1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
-							1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
-							1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
-							1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
-							1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
-							1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
-							1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
-							1241 0x17059	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
-						>;
-					};
-
-					pinctrl_usdhc3_2: usdhc3grp-2 {
-						fsl,pins = <
-							1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-							1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
-							1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
-							1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
-							1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
-							1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
-						>;
-					};
-				};
-
-				usdhc4 {
-					pinctrl_usdhc4_1: usdhc4grp-1 {
-						fsl,pins = <
-							1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
-							1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
-							1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
-							1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
-							1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
-							1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
-							1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
-							1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
-							1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
-							1517 0x17059	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
-						>;
-					};
-
-					pinctrl_usdhc4_2: usdhc4grp-2 {
-						fsl,pins = <
-							1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
-							1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
-							1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
-							1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
-							1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
-							1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
-						>;
-					};
-				};
-			};
-
 			dcic1: dcic at 020e4000 {
 				reg = <0x020e4000 0x4000>;
 				interrupts = <0 124 0x04>;
@@ -1064,14 +796,5 @@
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
 		};
-
-		ipu2: ipu at 02800000 {
-			#crtc-cells = <1>;
-			compatible = "fsl,imx6q-ipu";
-			reg = <0x02800000 0x400000>;
-			interrupts = <0 8 0x4 0 7 0x4>;
-			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
-			clock-names = "bus", "di0", "di1";
-		};
 	};
 };
-- 
1.7.9.5
