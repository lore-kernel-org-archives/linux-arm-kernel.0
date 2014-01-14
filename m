From: b20788@freescale.com (Anson Huang)
Date: Tue, 14 Jan 2014 17:23:31 +0800
Subject: [PATCH V2] ARM: dts: imx6sl: add keypad support for i.mx6sl-evk board.
Message-ID: <1389691411-25231-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SL EVK board has a 3*3 keypad matrix to support 8 keypads,
enable them, the keymap is as below:

SW6:  MATRIX_KEY(0x0, 0x0, 0x67)  /* ROW0, COL0, KEY_UP */
SW7:  MATRIX_KEY(0x0, 0x1, 0x6c)  /* ROW0, COL1, KEY_DOWN */
SW8:  MATRIX_KEY(0x0, 0x2, 0x1c)  /* ROW0, COL2, KEY_ENTER */
SW9:  MATRIX_KEY(0x1, 0x0, 0x66)  /* ROW1, COL0, KEY_HOME */
SW10: MATRIX_KEY(0x1, 0x1, 0x6a)  /* ROW1, COL1, KEY_RIGHT */
SW11: MATRIX_KEY(0x1, 0x2, 0x69)  /* ROW1, COL2, KEY_LEFT */
SW12: MATRIX_KEY(0x2, 0x0, 0x72)  /* ROW2, COL0, KEY_VOLUMEDOWN */
SW13: MATRIX_KEY(0x2, 0x1, 0x73)  /* ROW2, COL1, KEY_VOLUMEUP */

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts |   28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sl.dtsi    |    2 ++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index f5e4513..a2a0399 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "imx6sl.dtsi"
 
 / {
@@ -93,6 +94,17 @@
 			fsl,pins = <MX6SL_FEC_PINGRP1>;
 		};
 
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX6SL_PAD_KEY_ROW0__KEY_ROW0    0x1b010
+				MX6SL_PAD_KEY_ROW1__KEY_ROW1    0x1b010
+				MX6SL_PAD_KEY_ROW2__KEY_ROW2    0x1b0b0
+				MX6SL_PAD_KEY_COL0__KEY_COL0    0x110b0
+				MX6SL_PAD_KEY_COL1__KEY_COL1    0x110b0
+				MX6SL_PAD_KEY_COL2__KEY_COL2    0x110b0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <MX6SL_UART1_PINGRP1>;
 		};
@@ -139,6 +151,22 @@
 	};
 };
 
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	linux,keymap = <
+			MATRIX_KEY(0x0, 0x0, 0x67)  /* ROW0, COL0, KEY_UP */
+			MATRIX_KEY(0x0, 0x1, 0x6c)  /* ROW0, COL1, KEY_DOWN */
+			MATRIX_KEY(0x0, 0x2, 0x1c)  /* ROW0, COL2, KEY_ENTER */
+			MATRIX_KEY(0x1, 0x0, 0x66)  /* ROW1, COL0, KEY_HOME */
+			MATRIX_KEY(0x1, 0x1, 0x6a)  /* ROW1, COL1, KEY_RIGHT */
+			MATRIX_KEY(0x1, 0x2, 0x69)  /* ROW1, COL2, KEY_LEFT */
+			MATRIX_KEY(0x2, 0x0, 0x72)  /* ROW2, COL0, KEY_VOLUMEDOWN */
+			MATRIX_KEY(0x2, 0x1, 0x73)  /* ROW2, COL1, KEY_VOLUMEUP */
+	>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a5ef3c3..a449c4f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -393,8 +393,10 @@
 			};
 
 			kpp: kpp at 020b8000 {
+				compatible = "fsl,imx6sl-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_DUMMY>;
 			};
 
 			wdog1: wdog at 020bc000 {
-- 
1.7.9.5
