From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Sep 2015 09:47:49 +0900
Subject: [PATCH v3 2/2] ARM: dts: Add exynos5422-odroidxu4 board
In-Reply-To: <1442191669-3366-1-git-send-email-k.kozlowski@samsung.com>
References: <1442191669-3366-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1442191669-3366-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Hardkernel Odroid XU4 board Device Tree sources. The board differs
from Odroid XU3 and XU3-Lite by:
1. No green and red LEDs (except standard red power LED).
2. Only two PWM outputs are used (fan and blue LED)
3. No audio codec.
4. Two USB3 ports in host mode (no micro USB3 connector for OTG).
5. Realtek RTL8153-CG gigabit network adapter (instead of SMSC9514).
6. Additional connector with IO ports (I2S_0, I2C_5).
7. No DisplayPort (like XU3-Lite).
8. No TI INA231 power measurement sensors (like XU3-Lite).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v2:
1. Rebase on top v2 "ARM: dts: Fix LEDs on exynos5422-odroidxu3"
   https://lkml.org/lkml/2015/9/13/18
   This means that on new Odroid XU4 DTS the PWM outputs are
   already fixed.
2. Add Javier's reviewed-by.

Changes since v1:
1. hsi2c_5 and is20 are disabled on Odroid XU4 (after moving these nodes
   to the audio DTSI).
2. Update Samsung's copyright date for XU4 DTS.
---
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 50 +---------------------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    | 50 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 50 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 48 +++++++++++++++++++++
 5 files changed, 150 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 233159d2eaab..3d27fe34647f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -123,6 +123,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5420-smdk5420.dtb \
 	exynos5422-odroidxu3.dtb \
 	exynos5422-odroidxu3-lite.dtb \
+	exynos5422-odroidxu4.dtb \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 2f0fb8678e9f..a83d569baea8 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -46,40 +46,6 @@
 		reset-gpios = <&gpd1 0 1>;
 	};
 
-	pwmleds {
-		compatible = "pwm-leds";
-
-		greenled {
-			label = "green:mmc0";
-			pwms = <&pwm 1 2000000 0>;
-			pwm-names = "pwm1";
-			/*
-			 * Green LED is much brighter than the others
-			 * so limit its max brightness
-			 */
-			max_brightness = <127>;
-			linux,default-trigger = "mmc0";
-		};
-
-		blueled {
-			label = "blue:heartbeat";
-			pwms = <&pwm 2 2000000 0>;
-			pwm-names = "pwm2";
-			max_brightness = <255>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	gpioleds {
-		compatible = "gpio-leds";
-		redled {
-			label = "red:microSD";
-			gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "mmc1";
-		};
-	};
-
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm 0 20972 0>;
@@ -417,18 +383,6 @@
 	};
 };
 
-&pwm {
-	/*
-	 * PWM 0 -- fan
-	 * PWM 1 -- Green LED
-	 * PWM 2 -- Blue LED
-	 * PWM 3 -- on MIPI connector for backlight
-	 */
-	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
 	status = "okay";
@@ -464,9 +418,7 @@
 	dr_mode = "host";
 };
 
-&usbdrd_dwc3_1 {
-	dr_mode = "otg";
-};
+/* usbdrd_dwc3_1 mode customized in each board */
 
 &usbdrd3_0 {
 	vdd33-supply = <&ldo9_reg>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index 9c0cea99c996..b1b36081f343 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -18,4 +18,54 @@
 / {
 	model = "Hardkernel Odroid XU3 Lite";
 	compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
+
+	pwmleds {
+		compatible = "pwm-leds";
+
+		greenled {
+			label = "green:mmc0";
+			pwms = <&pwm 1 2000000 0>;
+			pwm-names = "pwm1";
+			/*
+			 * Green LED is much brighter than the others
+			 * so limit its max brightness
+			 */
+			max_brightness = <127>;
+			linux,default-trigger = "mmc0";
+		};
+
+		blueled {
+			label = "blue:heartbeat";
+			pwms = <&pwm 2 2000000 0>;
+			pwm-names = "pwm2";
+			max_brightness = <255>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpioleds {
+		compatible = "gpio-leds";
+		redled {
+			label = "red:microSD";
+			gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc1";
+		};
+	};
+};
+
+&pwm {
+	/*
+	 * PWM 0 -- fan
+	 * PWM 1 -- Green LED
+	 * PWM 2 -- Blue LED
+	 * PWM 3 -- on MIPI connector for backlight
+	 */
+	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "otg";
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index d8647a469a86..0c0bbdbfd85f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -17,6 +17,40 @@
 / {
 	model = "Hardkernel Odroid XU3";
 	compatible = "hardkernel,odroid-xu3", "samsung,exynos5800", "samsung,exynos5";
+
+	pwmleds {
+		compatible = "pwm-leds";
+
+		greenled {
+			label = "green:mmc0";
+			pwms = <&pwm 1 2000000 0>;
+			pwm-names = "pwm1";
+			/*
+			 * Green LED is much brighter than the others
+			 * so limit its max brightness
+			 */
+			max_brightness = <127>;
+			linux,default-trigger = "mmc0";
+		};
+
+		blueled {
+			label = "blue:heartbeat";
+			pwms = <&pwm 2 2000000 0>;
+			pwm-names = "pwm2";
+			max_brightness = <255>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpioleds {
+		compatible = "gpio-leds";
+		redled {
+			label = "red:microSD";
+			gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc1";
+		};
+	};
 };
 
 &i2c_0 {
@@ -50,3 +84,19 @@
 		shunt-resistor = <10000>;
 	};
 };
+
+&pwm {
+	/*
+	 * PWM 0 -- fan
+	 * PWM 1 -- Green LED
+	 * PWM 2 -- Blue LED
+	 * PWM 3 -- on MIPI connector for backlight
+	 */
+	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "otg";
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
new file mode 100644
index 000000000000..2faf88627a48
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -0,0 +1,48 @@
+/*
+ * Hardkernel Odroid XU4 board device tree source
+ *
+ * Copyright (c) 2015 Krzysztof Kozlowski
+ * Copyright (c) 2014 Collabora Ltd.
+ * Copyright (c) 2013-2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+#include "exynos5422-odroidxu3-common.dtsi"
+
+/ {
+	model = "Hardkernel Odroid XU4";
+	compatible = "hardkernel,odroid-xu4", "samsung,exynos5800", \
+		     "samsung,exynos5";
+
+	pwmleds {
+		compatible = "pwm-leds";
+
+		blueled {
+			label = "blue:heartbeat";
+			pwms = <&pwm 2 2000000 0>;
+			pwm-names = "pwm2";
+			max_brightness = <255>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&pwm {
+	/*
+	 * PWM 0 -- fan
+	 * PWM 2 -- Blue LED
+	 */
+	pinctrl-0 = <&pwm0_out &pwm2_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>, <2>;
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
-- 
1.9.1
