From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 May 2016 22:13:48 +0200
Subject: [PATCH v4 07/22] ARM: dts: exynos: Split Odroid XU3 LEDs to separate
 DTSI
In-Reply-To: <1463343243-26429-1-git-send-email-krzk@kernel.org>
References: <1463343243-26429-1-git-send-email-krzk@kernel.org>
Message-ID: <1463343243-26429-8-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LED nodes can be shared between Odroid XU3, XU3-Lite and XU (not yet
added) thus removing duplication.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 35 +----------------
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      | 35 +----------------
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi | 50 +++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index 2ae1cf41dcb6..03fa88c45426 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -14,44 +14,11 @@
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
 #include "exynos5422-odroidxu3-audio.dtsi"
+#include "exynos54xx-odroidxu-leds.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU3 Lite";
 	compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
-
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
 };
 
 &pwm {
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 432406db85de..9ed6564acfb0 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -13,44 +13,11 @@
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
 #include "exynos5422-odroidxu3-audio.dtsi"
+#include "exynos54xx-odroidxu-leds.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU3";
 	compatible = "hardkernel,odroid-xu3", "samsung,exynos5800", "samsung,exynos5";
-
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
 };
 
 &i2c_0 {
diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
new file mode 100644
index 000000000000..0ed30206625c
--- /dev/null
+++ b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Hardkernel Odroid XU/XU3 LED device tree source
+ *
+ * Copyright (c) 2015,2016 Krzysztof Kozlowski
+ * Copyright (c) 2014 Collabora Ltd.
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
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
-- 
2.5.0
