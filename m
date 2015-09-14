From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Sep 2015 09:47:48 +0900
Subject: [PATCH v3 1/2] ARM: dts: Split audio configuration to separate
 exynos5422-odroidxu3-audio
Message-ID: <1442191669-3366-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Odroid XU4 board does not have audio codec so before adding DTS for
new board split the audio codec to separate DTSI file. Include the audio codec
DTSI in Odroid XU3 and XU3-Lite boards.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Changes since v2:
1. Add Javier's reviewed-by.

Changes since v1:
1. New patch (refactor).
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  | 61 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 47 -----------------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  1 +
 4 files changed, 63 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
new file mode 100644
index 000000000000..9493923ec652
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -0,0 +1,61 @@
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
+	status = "okay";
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
+
+&i2s0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 90d298dce851..2f0fb8678e9f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -80,36 +80,6 @@
 		};
 	};
 
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
@@ -376,19 +346,6 @@
 	};
 };
 
-&hsi2c_5 {
-	status = "okay";
-	max98090: max98090 at 10 {
-		compatible = "maxim,max98090";
-		reg = <0x10>;
-		interrupt-parent = <&gpx3>;
-		interrupts = <2 0>;
-		clocks = <&i2s0 CLK_I2S_CDCLK>;
-		clock-names = "mclk";
-		#sound-dai-cells = <0>;
-	};
-};
-
 &i2c_2 {
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <66000>;
@@ -400,10 +357,6 @@
 	};
 };
 
-&i2s0 {
-	status = "okay";
-};
-
 &mfc {
 	samsung,mfc-r = <0x43000000 0x800000>;
 	samsung,mfc-l = <0x51000000 0x800000>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index c06882bbb822..9c0cea99c996 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
+#include "exynos5422-odroidxu3-audio.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU3 Lite";
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 78e6a502f320..d8647a469a86 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
+#include "exynos5422-odroidxu3-audio.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU3";
-- 
1.9.1
