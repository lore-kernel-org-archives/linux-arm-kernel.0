From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 26 Jul 2014 01:14:24 +0530
Subject: [PATCH 3/3] ARM: dts: Add DT changes for display on peach_pi
In-Reply-To: <1406317464-7525-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1406317464-7525-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1406317464-7525-4-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for panel-simple "auo,b133htn01" panel.
Add backlight enable pin and backlight power supply for pwm-backlight.
Also add panel phandle needed by dp to enable display on peach_pi.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index f3ee48b..5342638 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -28,11 +28,13 @@
 		i2c20 = "/spi at 12d40000/cros-ec at 0/i2c-tunnel";
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 1000000 0>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
+		enable-gpios = <&gpx2 2 0>;
+		power-supply = <&tps65090_fet1>;
 		pinctrl-0 = <&pwm0_out>;
 		pinctrl-names = "default";
 	};
@@ -98,6 +100,12 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	panel: panel-simple {
+		compatible = "auo,b133htn01", "simple-panel";
+		power-supply = <&tps65090_fet6>;
+		backlight = <&backlight>;
+	};
 };
 
 &dp {
@@ -111,22 +119,7 @@
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <2>;
 	samsung,hpd-gpio = <&gpx2 6 0>;
-
-	display-timings {
-		native-mode = <&timing1>;
-
-		timing1: timing at 1 {
-			clock-frequency = <150660000>;
-			hactive = <1920>;
-			vactive = <1080>;
-			hfront-porch = <60>;
-			hback-porch = <172>;
-			hsync-len = <80>;
-			vback-porch = <25>;
-			vfront-porch = <10>;
-			vsync-len = <10>;
-		};
-	};
+	panel = <&panel>;
 };
 
 &fimd {
-- 
1.7.9.5
