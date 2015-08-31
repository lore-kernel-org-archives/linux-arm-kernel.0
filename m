From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 31 Aug 2015 12:56:05 +0900
Subject: [PATCH] ARM: dts: Add exynos5422-odroidxu4 board
Message-ID: <1440993365-26896-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Hardkernel Odroid XU4 board Device Tree sources. The board differs
from Odroid XU3 and XU3-Lite by:
1. No green and red leds (except standard red power led).
2. No audio codec.
3. Two USB3 ports in host mode (no micro USB3 connector for OTG).
4. Realtek RTL8153-CG gigabit network adapter (instead of SMSC9514).
5. Additional connector with IO ports (I2S_0, I2C_5).
6. No DisplayPort.
7. No TI INA231 power measurement sensors.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  | 56 ++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 90 +---------------------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    | 52 +++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 52 +++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 48 ++++++++++++
 6 files changed, 210 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
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
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
new file mode 100644
index 000000000000..eee16a820484
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -0,0 +1,56 @@
+/*
+ * Hardkernel Odroid XU3 Audio Codec device tree source
+ *
+ * Copyright (c) 2015 Krzysztof Kozlowski
+ * Copyright (c) 2014 Collabora Ltd.
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/ {
+	sound: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,name = "Odroid-XU3";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Speakers", "Speakers";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Headphone Jack", "MICBIAS",
+			"IN1", "Headphone Jack",
+			"Speakers", "SPKL",
+			"Speakers", "SPKR";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&link0_codec>;
+		simple-audio-card,frame-master = <&link0_codec>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0 0>;
+			system-clock-frequency = <19200000>;
+		};
+
+		link0_codec: simple-audio-card,codec {
+			sound-dai = <&max98090>;
+			clocks = <&i2s0 CLK_I2S_CDCLK>;
+		};
+	};
+};
+
+&hsi2c_5 {
+	max98090: max98090 at 10 {
+		compatible = "maxim,max98090";
+		reg = <0x10>;
+		interrupt-parent = <&gpx3>;
+		interrupts = <2 0>;
+		clocks = <&i2s0 CLK_I2S_CDCLK>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index dd8bc86d9de4..52c34d8e791f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -46,70 +46,6 @@
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
-	sound: sound {
-		compatible = "simple-audio-card";
-
-		simple-audio-card,name = "Odroid-XU3";
-		simple-audio-card,widgets =
-			"Headphone", "Headphone Jack",
-			"Speakers", "Speakers";
-		simple-audio-card,routing =
-			"Headphone Jack", "HPL",
-			"Headphone Jack", "HPR",
-			"Headphone Jack", "MICBIAS",
-			"IN1", "Headphone Jack",
-			"Speakers", "SPKL",
-			"Speakers", "SPKR";
-
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&link0_codec>;
-		simple-audio-card,frame-master = <&link0_codec>;
-
-		simple-audio-card,cpu {
-			sound-dai = <&i2s0 0>;
-			system-clock-frequency = <19200000>;
-		};
-
-		link0_codec: simple-audio-card,codec {
-			sound-dai = <&max98090>;
-			clocks = <&i2s0 CLK_I2S_CDCLK>;
-		};
-	};
-
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm 0 20972 0>;
@@ -378,15 +314,6 @@
 
 &hsi2c_5 {
 	status = "okay";
-	max98090: max98090 at 10 {
-		compatible = "maxim,max98090";
-		reg = <0x10>;
-		interrupt-parent = <&gpx3>;
-		interrupts = <2 0>;
-		clocks = <&i2s0 CLK_I2S_CDCLK>;
-		clock-names = "mclk";
-		#sound-dai-cells = <0>;
-	};
 };
 
 &i2c_2 {
@@ -464,19 +391,6 @@
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
-	samsung,pwm-outputs = <0>;
-	status = "okay";
-};
-
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
 	status = "okay";
@@ -512,9 +426,7 @@
 	dr_mode = "host";
 };
 
-&usbdrd_dwc3_1 {
-	dr_mode = "otg";
-};
+/* usbdrd_dwc3_1 mode customized in each board */
 
 &usbdrd3_0 {
 	vdd33-supply = <&ldo9_reg>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index c06882bbb822..379cd61178ee 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -13,8 +13,60 @@
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
+#include "exynos5422-odroidxu3-audio.dtsi"
 
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
+	samsung,pwm-outputs = <0>;
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "otg";
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 78e6a502f320..c7509690131d 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -12,10 +12,45 @@
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
+#include "exynos5422-odroidxu3-audio.dtsi"
 
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
@@ -49,3 +84,20 @@
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
+	samsung,pwm-outputs = <0>;
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "otg";
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
new file mode 100644
index 000000000000..087c485b6084
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -0,0 +1,48 @@
+/*
+ * Hardkernel Odroid XU4 board device tree source
+ *
+ * Copyright (c) 2015 Krzysztof Kozlowski
+ * Copyright (c) 2014 Collabora Ltd.
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
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
+	samsung,pwm-outputs = <0>;
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
-- 
1.9.1
