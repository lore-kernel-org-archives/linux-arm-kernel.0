From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 12 Mar 2014 09:55:52 -0300
Subject: [PATCH 1/2] ARM: dts: imx25-pdk: Add keypad support
Message-ID: <1394628953-26788-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested with evtest.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx25.dtsi    |  3 ++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 71743a3..9507365 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -10,6 +10,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "imx25.dtsi"
 
 / {
@@ -153,6 +154,20 @@
 			>;
 		};
 
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX25_PAD_KPP_ROW0__KPP_ROW0	0x80000000
+				MX25_PAD_KPP_ROW1__KPP_ROW1	0x80000000
+				MX25_PAD_KPP_ROW2__KPP_ROW2	0x80000000
+				MX25_PAD_KPP_ROW3__KPP_ROW3	0x80000000
+				MX25_PAD_KPP_COL0__KPP_COL0	0x80000000
+				MX25_PAD_KPP_COL1__KPP_COL1	0x80000000
+				MX25_PAD_KPP_COL2__KPP_COL2	0x80000000
+				MX25_PAD_KPP_COL3__KPP_COL3	0x80000000	
+			>;
+		};
+
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX25_PAD_UART1_RTS__UART1_RTS		0xe0
@@ -169,6 +184,30 @@
 	status = "okay";
 };
 
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	linux,keymap = <
+			MATRIX_KEY(0x0, 0x0, KEY_UP)
+			MATRIX_KEY(0x0, 0x1, KEY_DOWN)
+			MATRIX_KEY(0x0, 0x2, KEY_VOLUMEDOWN)
+			MATRIX_KEY(0x0, 0x3, KEY_HOME)
+			MATRIX_KEY(0x1, 0x0, KEY_RIGHT)
+			MATRIX_KEY(0x1, 0x1, KEY_LEFT)
+			MATRIX_KEY(0x1, 0x2, KEY_ENTER)
+			MATRIX_KEY(0x1, 0x3, KEY_VOLUMEUP)
+			MATRIX_KEY(0x2, 0x0, KEY_F6)
+			MATRIX_KEY(0x2, 0x1, KEY_F8)
+			MATRIX_KEY(0x2, 0x2, KEY_F9)
+			MATRIX_KEY(0x2, 0x3, KEY_F10)
+			MATRIX_KEY(0x3, 0x0, KEY_F1)
+			MATRIX_KEY(0x3, 0x1, KEY_F2)
+			MATRIX_KEY(0x3, 0x2, KEY_F3)
+			MATRIX_KEY(0x3, 0x2, KEY_POWER)
+	>;
+	status = "okay";
+};
+
 &ssi1 {
 	codec-handle = <&codec>;
 	fsl,mode = "i2s-slave";
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 77bb743..7b68b75 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -165,9 +165,10 @@
 				status = "disabled";
 			};
 
-			kpp at 43fa8000 {
+			kpp: kpp at 43fa8000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
+				compatible = "fsl,imx25-kpp", "fsl,imx21-kpp";
 				reg = <0x43fa8000 0x4000>;
 				clocks = <&clks 102>;
 				clock-names = "";
-- 
1.8.1.2
