From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:28 +0800
Subject: [PATCH 08/17] ARM: dts: imx53-qsb: add pinctrl settings
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for existing devices in imx53-qsb.dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-qsb.dts |   34 ++++++++++++++-
 arch/arm/boot/dts/imx53.dtsi    |   90 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index a0e816f..08948af 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -25,6 +25,8 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc1_1>;
 					cd-gpios = <&gpio3 13 0>;
 					status = "okay";
 				};
@@ -35,6 +37,8 @@
 				};
 
 				esdhc at 50020000 { /* ESDHC3 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc3_1>;
 					cd-gpios = <&gpio3 11 0>;
 					wp-gpios = <&gpio3 12 0>;
 					status = "okay";
@@ -42,17 +46,37 @@
 			};
 
 			iomuxc at 53fa8000 {
-				compatible = "fsl,imx53-iomuxc-qsb";
-				reg = <0x53fa8000 0x4000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							1071 0x80000000	/* MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK */
+							1141 0x80000000	/* MX53_PAD_GPIO_8__GPIO1_8 */
+							982  0x80000000	/* MX53_PAD_PATA_DATA14__GPIO2_14 */
+							989  0x80000000	/* MX53_PAD_PATA_DATA15__GPIO2_15 */
+							693  0x80000000	/* MX53_PAD_EIM_DA11__GPIO3_11 */
+							697  0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
+							701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
+							868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+							873  0x80000000	/* MX53_PAD_PATA_DA_1__GPIO7_7 */
+						>;
+					};
+				};
 			};
 
 			uart1: serial at 53fbc000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_1>;
 				status = "okay";
 			};
 		};
 
 		aips at 60000000 {	/* AIPS2 */
 			i2c at 63fc4000 { /* I2C2 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c2_1>;
 				status = "okay";
 
 				sgtl5000: codec at 0a {
@@ -64,6 +88,8 @@
 			};
 
 			i2c at 63fc8000 { /* I2C1 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_1>;
 				status = "okay";
 
 				accelerometer: mma8450 at 1c {
@@ -150,10 +176,14 @@
 			};
 
 			audmux at 63fd0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_audmux_1>;
 				status = "okay";
 			};
 
 			ethernet at 63fec000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_fec_1>;
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 0b928fe..35d102d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -181,6 +181,96 @@
 				status = "disabled";
 			};
 
+			iomuxc at 53fa8000 {
+				compatible = "fsl,imx53-iomuxc";
+				reg = <0x53fa8000 0x4000>;
+
+				audmux {
+					pinctrl_audmux_1: audmuxgrp-1 {
+						fsl,pins = <
+							10 0x80000000	/* MX53_PAD_KEY_COL0__AUDMUX_AUD5_TXC */
+							17 0x80000000	/* MX53_PAD_KEY_ROW0__AUDMUX_AUD5_TXD */
+							23 0x80000000	/* MX53_PAD_KEY_COL1__AUDMUX_AUD5_TXFS */
+							30 0x80000000	/* MX53_PAD_KEY_ROW1__AUDMUX_AUD5_RXD */
+						>;
+					};
+				};
+
+				fec {
+					pinctrl_fec_1: fecgrp-1 {
+						fsl,pins = <
+							820 0x80000000	/* MX53_PAD_FEC_MDC__FEC_MDC */
+							779 0x80000000	/* MX53_PAD_FEC_MDIO__FEC_MDIO */
+							786 0x80000000	/* MX53_PAD_FEC_REF_CLK__FEC_TX_CLK */
+							791 0x80000000	/* MX53_PAD_FEC_RX_ER__FEC_RX_ER */
+							796 0x80000000	/* MX53_PAD_FEC_CRS_DV__FEC_RX_DV */
+							799 0x80000000	/* MX53_PAD_FEC_RXD1__FEC_RDATA_1 */
+							804 0x80000000	/* MX53_PAD_FEC_RXD0__FEC_RDATA_0 */
+							808 0x80000000	/* MX53_PAD_FEC_TX_EN__FEC_TX_EN */
+							811 0x80000000	/* MX53_PAD_FEC_TXD1__FEC_TDATA_1 */
+							816 0x80000000	/* MX53_PAD_FEC_TXD0__FEC_TDATA_0 */
+						>;
+					};
+				};
+
+				esdhc1 {
+					pinctrl_esdhc1_1: esdhc1grp-1 {
+						fsl,pins = <
+							995  0x1d5	/* MX53_PAD_SD1_DATA0__ESDHC1_DAT0 */
+							1000 0x1d5	/* MX53_PAD_SD1_DATA1__ESDHC1_DAT1 */
+							1010 0x1d5	/* MX53_PAD_SD1_DATA2__ESDHC1_DAT2 */
+							1024 0x1d5	/* MX53_PAD_SD1_DATA3__ESDHC1_DAT3 */
+							1005 0x1d5	/* MX53_PAD_SD1_CMD__ESDHC1_CMD */
+							1018 0x1d5	/* MX53_PAD_SD1_CLK__ESDHC1_CLK */
+						>;
+					};
+				};
+
+				esdhc3 {
+					pinctrl_esdhc3_1: esdhc3grp-1 {
+						fsl,pins = <
+							943 0x1d5	/* MX53_PAD_PATA_DATA8__ESDHC3_DAT0 */
+							950 0x1d5	/* MX53_PAD_PATA_DATA9__ESDHC3_DAT1 */
+							957 0x1d5	/* MX53_PAD_PATA_DATA10__ESDHC3_DAT2 */
+							964 0x1d5	/* MX53_PAD_PATA_DATA11__ESDHC3_DAT3 */
+							893 0x1d5	/* MX53_PAD_PATA_DATA0__ESDHC3_DAT4 */
+							900 0x1d5	/* MX53_PAD_PATA_DATA1__ESDHC3_DAT5 */
+							906 0x1d5	/* MX53_PAD_PATA_DATA2__ESDHC3_DAT6 */
+							912 0x1d5	/* MX53_PAD_PATA_DATA3__ESDHC3_DAT7 */
+							857 0x1d5	/* MX53_PAD_PATA_RESET_B__ESDHC3_CMD */
+							863 0x1d5	/* MX53_PAD_PATA_IORDY__ESDHC3_CLK */
+						>;
+					};
+				};
+
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <
+							333 0xc0000000	/* MX53_PAD_CSI0_DAT8__I2C1_SDA */
+							341 0xc0000000	/* MX53_PAD_CSI0_DAT9__I2C1_SCL */
+						>;
+					};
+				};
+
+				i2c2 {
+					pinctrl_i2c2_1: i2c2grp-1 {
+						fsl,pins = <
+							61 0xc0000000	/* MX53_PAD_KEY_ROW3__I2C2_SDA */
+							53 0xc0000000	/* MX53_PAD_KEY_COL3__I2C2_SCL */
+						>;
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <
+							346 0x1c5	/* MX53_PAD_CSI0_DAT10__UART1_TXD_MUX */
+							354 0x1c5	/* MX53_PAD_CSI0_DAT11__UART1_RXD_MUX */
+						>;
+					};
+				};
+			};
+
 			uart1: serial at 53fbc000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fbc000 0x4000>;
-- 
1.7.5.4
