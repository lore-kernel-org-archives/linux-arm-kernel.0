From: b20788@freescale.com (Anson Huang)
Date: Thu, 19 Dec 2013 16:07:24 -0500
Subject: [PATCH V2] ARM: dts: imx6qdl-sabresd: Add power key support
Message-ID: <1387487244-2749-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for imx6qdl-sabresd board's power
key, the key is named "SW1" on board, press it can wake up
system from suspend.

Add a new pinctrl entry for gpio keys and move all gpio
keys pin to this entry.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b..b545895 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/input/input.h>
 / {
 	memory {
 		reg = <0x10000000 0x40000000>;
@@ -46,19 +47,28 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio3 29 0>;
+			gpio-key,wakeup;
+			linux,code = <KEY_POWER>;
+		};
 
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 4 0>;
 			gpio-key,wakeup;
-			linux,code = <115>; /* KEY_VOLUMEUP */
+			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 5 0>;
 			gpio-key,wakeup;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
+			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
 
@@ -171,8 +181,6 @@
 	hog {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
 				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
 				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
 				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
@@ -185,6 +193,16 @@
 			>;
 		};
 	};
+
+	gpio-keys {
+		pinctrl_gpio_keys: gpio_keysgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x80000000
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
+			>;
+		};
+	};
 };
 
 &ldb {
-- 
1.7.9.5
