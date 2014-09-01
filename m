From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 01 Sep 2014 16:06:32 +0530
Subject: [PATCH V3 2/2] ARM: dts: Add DT changes for display on peach_pit
In-Reply-To: <1409567792-8281-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1409567792-8281-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1409567792-8281-2-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for ps8622 bridge chip and panel.
Add backlight power supply for pwm-backlight.
Also add bridge phandle needed by dp to enable display on peach_pit.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
Changes since V1:
	-- Remove "simple-panel" compatible string.
	-- Use GPIO_ACTIVE_HIGH instead of 0.
	-- Change panel node naming from "panel-simple" to "panel".

Changes since V2:
	-- Use proper compatible string: "auo,b116xw03"

 arch/arm/boot/dts/exynos5420-peach-pit.dts |   36 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 228a6b1..1070a31 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -30,11 +30,12 @@
 		i2c20 = "/spi at 12d40000/cros-ec at 0/i2c-tunnel";
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 1000000 0>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
+		power-supply = <&tps65090_fet1>;
 		pinctrl-0 = <&pwm0_out>;
 		pinctrl-names = "default";
 	};
@@ -100,6 +101,12 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	panel: panel {
+		compatible = "auo,b116xw03";
+		power-supply = <&tps65090_fet6>;
+		backlight = <&backlight>;
+	};
 };
 
 &dp {
@@ -113,22 +120,7 @@
 	samsung,link-rate = <0x06>;
 	samsung,lane-count = <2>;
 	samsung,hpd-gpio = <&gpx2 6 0>;
-
-	display-timings {
-		native-mode = <&timing1>;
-
-		timing1: timing at 1 {
-			clock-frequency = <70589280>;
-			hactive = <1366>;
-			vactive = <768>;
-			hfront-porch = <40>;
-			hback-porch = <40>;
-			hsync-len = <32>;
-			vback-porch = <10>;
-			vfront-porch = <12>;
-			vsync-len = <6>;
-		};
-	};
+	bridge = <&ps8625>;
 };
 
 &fimd {
@@ -155,6 +147,16 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98090_irq>;
 	};
+
+	ps8625: lvds-bridge at 48 {
+		compatible = "parade,ps8625";
+		reg = <0x48>;
+		sleep-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpy7 7 GPIO_ACTIVE_HIGH>;
+		lane-count = <2>;
+		panel = <&panel>;
+		use-external-pwm;
+	};
 };
 
 &hsi2c_9 {
-- 
1.7.9.5
