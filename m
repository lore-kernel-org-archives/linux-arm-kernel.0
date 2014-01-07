From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  7 Jan 2014 16:47:17 -0700
Subject: [PATCH 2/2] ARM: tegra: enable LCD panel on Ventana
In-Reply-To: <1389138437-4686-1-git-send-email-swarren@wwwdotorg.org>
References: <1389138437-4686-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1389138437-4686-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Ventana uses a CLAA101WA01A LCD panel. Enable the relevant display
controller, backlight, and regulators.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 571d12e6ac2d..93cbb9928e1d 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -17,6 +17,14 @@
 	};
 
 	host1x at 50000000 {
+		dc at 54200000 {
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&panel>;
+			};
+		};
+
 		hdmi at 54280000 {
 			status = "okay";
 
@@ -309,6 +317,10 @@
 		status = "okay";
 	};
 
+	pwm: pwm at 7000a000 {
+		status = "okay";
+	};
+
 	i2c at 7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
@@ -359,7 +371,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c at 1 {
+		lvds_ddc: i2c at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -557,6 +569,17 @@
 		non-removable;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_bl_reg>;
+		pwms = <&pwm 0 5000000>;
+
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -581,6 +604,16 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "chungwa,claa101wa01a", "simple-panel";
+
+		power-supply = <&vdd_pnl_reg>;
+		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+		ddc-i2c-bus = <&lvds_ddc>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -614,7 +647,7 @@
 			enable-active-high;
 		};
 
-		regulator at 3 {
+		vdd_pnl_reg: regulator at 3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
 			regulator-name = "vdd_pnl";
@@ -624,7 +657,7 @@
 			enable-active-high;
 		};
 
-		regulator at 4 {
+		vdd_bl_reg: regulator at 4 {
 			compatible = "regulator-fixed";
 			reg = <4>;
 			regulator-name = "vdd_bl";
-- 
1.8.1.5
