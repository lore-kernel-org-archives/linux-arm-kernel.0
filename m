From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  7 Jan 2014 16:47:16 -0700
Subject: [PATCH 1/2] ARM: tegra: enable LCD panel on Seaboard
Message-ID: <1389138437-4686-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Seaboard uses a CLAA101WA01A LCD panel. Enable the relevant display
controller, backlight, and regulators.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts | 55 +++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index a11b6e7b4759..f4443c1eaba7 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
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
 
@@ -312,6 +320,10 @@
 		status = "okay";
 	};
 
+	pwm: pwm at 7000a000 {
+		status = "okay";
+	};
+
 	i2c at 7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
@@ -369,7 +381,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c at 1 {
+		lvds_ddc: i2c at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -762,6 +774,17 @@
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
@@ -795,6 +818,16 @@
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
@@ -839,6 +872,26 @@
 			regulator-always-on;
 			regulator-boot-on;
 		};
+
+		vdd_pnl_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "vdd_pnl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		vdd_bl_reg: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "vdd_bl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
 	};
 
 	sound {
-- 
1.8.1.5
