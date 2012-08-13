From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:36 +0800
Subject: [PATCH 16/17] ARM: dts: imx51-babbage: add pinctrl settings
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-17-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for the exsiting devices in imx51-babbage.dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx51-babbage.dts |   36 ++++++++++-
 arch/arm/boot/dts/imx51.dtsi        |  116 +++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index b2de32b..e010ae4 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -25,23 +25,31 @@
 		aips at 70000000 { /* aips-1 */
 			spba at 70000000 {
 				esdhc at 70004000 { /* ESDHC1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc1_1>;
 					fsl,cd-internal;
 					fsl,wp-internal;
 					status = "okay";
 				};
 
 				esdhc at 70008000 { /* ESDHC2 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc2_1>;
 					cd-gpios = <&gpio1 6 0>;
 					wp-gpios = <&gpio1 5 0>;
 					status = "okay";
 				};
 
 				uart3: serial at 7000c000 {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_uart3_1>;
 					fsl,uart-has-rtscts;
 					status = "okay";
 				};
 
 				ecspi at 70010000 { /* ECSPI1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_ecspi1_1>;
 					fsl,spi-num-chipselects = <2>;
 					cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
 					status = "okay";
@@ -170,22 +178,42 @@
 			};
 
 			iomuxc at 73fa8000 {
-				compatible = "fsl,imx51-iomuxc-babbage";
-				reg = <0x73fa8000 0x4000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							694 0x85	/* MX51_PAD_GPIO1_0__SD1_CD */
+							697 0x85	/* MX51_PAD_GPIO1_1__SD1_WP */
+							737 0x85	/* MX51_PAD_GPIO1_5__GPIO1_5 */
+							740 0x85	/* MX51_PAD_GPIO1_6__GPIO1_6 */
+							121 0x5		/* MX51_PAD_EIM_A27__GPIO2_21 */
+							402 0x85	/* MX51_PAD_CSPI1_SS0__GPIO4_24 */
+							405 0x85	/* MX51_PAD_CSPI1_SS1__GPIO4_25 */
+						>;
+					};
+				};
 			};
 
 			uart1: serial at 73fbc000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_1>;
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
 			uart2: serial at 73fc0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart2_1>;
 				status = "okay";
 			};
 		};
 
 		aips at 80000000 {	/* aips-2 */
 			i2c at 83fc4000 { /* I2C2 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c2_1>;
 				status = "okay";
 
 				sgtl5000: codec at 0a {
@@ -198,10 +226,14 @@
 			};
 
 			audmux at 83fd0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_audmux_1>;
 				status = "okay";
 			};
 
 			ethernet at 83fec000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_fec_1>;
 				phy-mode = "mii";
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 86ca287..58b0c05 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -179,6 +179,122 @@
 				status = "disabled";
 			};
 
+			iomuxc at 73fa8000 {
+				compatible = "fsl,imx51-iomuxc";
+				reg = <0x73fa8000 0x4000>;
+
+				audmux {
+					pinctrl_audmux_1: audmuxgrp-1 {
+						fsl,pins = <
+							384 0x80000000	/* MX51_PAD_AUD3_BB_TXD__AUD3_TXD */
+							386 0x80000000	/* MX51_PAD_AUD3_BB_RXD__AUD3_RXD */
+							389 0x80000000	/* MX51_PAD_AUD3_BB_CK__AUD3_TXC */
+							391 0x80000000	/* MX51_PAD_AUD3_BB_FS__AUD3_TXFS */
+						>;
+					};
+				};
+
+				fec {
+					pinctrl_fec_1: fecgrp-1 {
+						fsl,pins = <
+							128 0x80000000	/* MX51_PAD_EIM_EB2__FEC_MDIO */
+							134 0x80000000	/* MX51_PAD_EIM_EB3__FEC_RDATA1 */
+							146 0x80000000	/* MX51_PAD_EIM_CS2__FEC_RDATA2 */
+							152 0x80000000	/* MX51_PAD_EIM_CS3__FEC_RDATA3 */
+							158 0x80000000	/* MX51_PAD_EIM_CS4__FEC_RX_ER */
+							165 0x80000000	/* MX51_PAD_EIM_CS5__FEC_CRS */
+							206 0x80000000	/* MX51_PAD_NANDF_RB2__FEC_COL */
+							213 0x80000000	/* MX51_PAD_NANDF_RB3__FEC_RX_CLK */
+							293 0x80000000	/* MX51_PAD_NANDF_D9__FEC_RDATA0 */
+							298 0x80000000	/* MX51_PAD_NANDF_D8__FEC_TDATA0 */
+							225 0x80000000	/* MX51_PAD_NANDF_CS2__FEC_TX_ER */
+							231 0x80000000	/* MX51_PAD_NANDF_CS3__FEC_MDC */
+							237 0x80000000	/* MX51_PAD_NANDF_CS4__FEC_TDATA1 */
+							243 0x80000000	/* MX51_PAD_NANDF_CS5__FEC_TDATA2 */
+							250 0x80000000	/* MX51_PAD_NANDF_CS6__FEC_TDATA3 */
+							255 0x80000000	/* MX51_PAD_NANDF_CS7__FEC_TX_EN */
+							260 0x80000000	/* MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK */
+						>;
+					};
+				};
+
+				ecspi1 {
+					pinctrl_ecspi1_1: ecspi1grp-1 {
+						fsl,pins = <
+							398 0x185	/* MX51_PAD_CSPI1_MISO__ECSPI1_MISO */
+							394 0x185	/* MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI */
+							409 0x185	/* MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK */
+						>;
+					};
+				};
+
+				esdhc1 {
+					pinctrl_esdhc1_1: esdhc1grp-1 {
+						fsl,pins = <
+							666 0x400020d5	/* MX51_PAD_SD1_CMD__SD1_CMD */
+							669 0x20d5	/* MX51_PAD_SD1_CLK__SD1_CLK */
+							672 0x20d5	/* MX51_PAD_SD1_DATA0__SD1_DATA0 */
+							678 0x20d5	/* MX51_PAD_SD1_DATA1__SD1_DATA1 */
+							684 0x20d5	/* MX51_PAD_SD1_DATA2__SD1_DATA2 */
+							691 0x20d5	/* MX51_PAD_SD1_DATA3__SD1_DATA3 */
+						>;
+					};
+				};
+
+				esdhc2 {
+					pinctrl_esdhc2_1: esdhc2grp-1 {
+						fsl,pins = <
+							704 0x400020d5	/* MX51_PAD_SD2_CMD__SD2_CMD */
+							707 0x20d5	/* MX51_PAD_SD2_CLK__SD2_CLK */
+							710 0x20d5	/* MX51_PAD_SD2_DATA0__SD2_DATA0 */
+							712 0x20d5	/* MX51_PAD_SD2_DATA1__SD2_DATA1 */
+							715 0x20d5	/* MX51_PAD_SD2_DATA2__SD2_DATA2 */
+							719 0x20d5	/* MX51_PAD_SD2_DATA3__SD2_DATA3 */
+						>;
+					};
+				};
+
+				i2c2 {
+					pinctrl_i2c2_1: i2c2grp-1 {
+						fsl,pins = <
+							449 0x400001ed	/* MX51_PAD_KEY_COL4__I2C2_SCL */
+							454 0x400001ed	/* MX51_PAD_KEY_COL5__I2C2_SDA */
+						>;
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <
+							413 0x1c5	/* MX51_PAD_UART1_RXD__UART1_RXD */
+							416 0x1c5	/* MX51_PAD_UART1_TXD__UART1_TXD */
+							418 0x1c5	/* MX51_PAD_UART1_RTS__UART1_RTS */
+							420 0x1c5	/* MX51_PAD_UART1_CTS__UART1_CTS */
+						>;
+					};
+				};
+
+				uart2 {
+					pinctrl_uart2_1: uart2grp-1 {
+						fsl,pins = <
+							423 0x1c5	/* MX51_PAD_UART2_RXD__UART2_RXD */
+							426 0x1c5	/* MX51_PAD_UART2_TXD__UART2_TXD */
+						>;
+					};
+				};
+
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <
+							54 0x1c5	/* MX51_PAD_EIM_D25__UART3_RXD */
+							59 0x1c5	/* MX51_PAD_EIM_D26__UART3_TXD */
+							65 0x1c5	/* MX51_PAD_EIM_D27__UART3_RTS */
+							49 0x1c5	/* MX51_PAD_EIM_D24__UART3_CTS */
+						>;
+					};
+				};
+			};
+
 			uart1: serial at 73fbc000 {
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fbc000 0x4000>;
-- 
1.7.5.4
