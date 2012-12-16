From: laurent.cans@gmail.com (Laurent Cans)
Date: Sun, 16 Dec 2012 22:49:51 +0100
Subject: [PATCH] Add apf51 basic support
Message-ID: <1355694591-7084-1-git-send-email-laurent.cans@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Cans <laurent.cans@gmail.com>
Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/Makefile        |    3 +-
 arch/arm/boot/dts/imx51-apf51.dts |   68 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx51.dtsi      |   30 ++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx51-apf51.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f37cf9f..8600cdf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -45,7 +45,8 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-xp-db.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
+dtb-$(CONFIG_ARCH_MXC) += imx51-apf51.dtb \
+	imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
 	imx53-qsb.dtb \
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
new file mode 100644
index 0000000..c7cdafa
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2012 Laurent Cans <laurent.cans@gmail.com>
+ *
+ * Based on mx51-babbage.dts
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx51.dtsi"
+
+/ {
+	model = "Armadeus Systems APF51 Board";
+	compatible = "fsl,imx51-apf51", "fsl,imx51";
+	memory {
+		reg = <0x90000000 0x20000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ckih1 {
+			compatible = "fsl,imx-ckih1", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		osc {
+			compatible = "fsl,imx-osc", "fixed-clock";
+			clock-frequency = <33554432>;
+		};
+	};
+	soc {
+		aips at 70000000 { /* aips-1 */
+			spba at 70000000 {
+				uart3: serial at 7000c000 {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_uart3_2>;
+					status = "okay";
+				};
+			};
+		};
+		aips at 80000000 {	/* aips-2 */
+			nand0: nand at 83fdb000 {
+				nand-bus-width = <8>;
+				nand-ecc-mode = "hw";
+				nand-on-flash-bbt;
+				status = "okay";
+			};
+
+			ethernet at 83fec000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_fec_2>;
+				phy-mode = "mii";
+				phy-reset-gpios = <&gpio3 0 0>;
+				phy-reset-duration = <1>;
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 75d069f..0de37bd 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -248,6 +248,29 @@
 							260 0x80000000	/* MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK */
 						>;
 					};
+
+					pinctrl_fec_2: fecgrp-2 {
+						fsl,pins = <
+							589 0x80000000 /* MX51_PAD_DI_GP3__FEC_TX_ER */
+							592 0x80000000 /* MX51_PAD_DI2_PIN4__FEC_CRS */
+							594 0x80000000 /* MX51_PAD_DI2_PIN2__FEC_MDC */
+							596 0x80000000 /* MX51_PAD_DI2_PIN3__FEC_MDIO */
+							598 0x80000000 /* MX51_PAD_DI2_DISP_CLK__FEC_RDATA1 */
+							602 0x80000000 /* MX51_PAD_DI_GP4__FEC_RDATA2 */
+							604 0x80000000 /* MX51_PAD_DISP2_DAT0__FEC_RDATA3 */
+							609 0x80000000 /* MX51_PAD_DISP2_DAT1__FEC_RX_ER */
+							618 0x80000000 /* MX51_PAD_DISP2_DAT6__FEC_TDATA1 */
+							623 0x80000000 /* MX51_PAD_DISP2_DAT7__FEC_TDATA2 */
+							628 0x80000000 /* MX51_PAD_DISP2_DAT8__FEC_TDATA3 */
+							634 0x80000000 /* MX51_PAD_DISP2_DAT9__FEC_TX_EN */
+							639 0x80000000 /* MX51_PAD_DISP2_DAT10__FEC_COL */
+							644 0x80000000 /* MX51_PAD_DISP2_DAT11__FEC_RX_CLK */
+							649 0x80000000 /* MX51_PAD_DISP2_DAT12__FEC_RX_DV */
+							653 0x80000000 /* MX51_PAD_DISP2_DAT13__FEC_TX_CLK */
+							657 0x80000000 /* MX51_PAD_DISP2_DAT14__FEC_RDATA0 */
+							662 0x80000000 /* MX51_PAD_DISP2_DAT15__FEC_TDATA0 */
+						>;
+					};
 				};
 
 				ecspi1 {
@@ -324,6 +347,13 @@
 							49 0x1c5	/* MX51_PAD_EIM_D24__UART3_CTS */
 						>;
 					};
+
+					pinctrl_uart3_2: uart3grp-2 {
+						fsl,pins = <
+							434 0x1c5	/* MX51_PAD_UART3_RXD__UART3_RXD */
+							430 0x1c5	/* MX51_PAD_UART3_TXD__UART3_TXD */
+						>;
+					};
 				};
 			};
 
-- 
1.7.10.4
