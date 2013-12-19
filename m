From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:32 +0100
Subject: [PATCH 08/10] ARM: tegra: Enable DSI support on Dalmore
In-Reply-To: <1387468774-14216-1-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
Message-ID: <1387468774-14216-9-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dalmore has a 10.1" WUXGA panel connected to one of the DSI outputs of
the Tegra114.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- make panel a peripheral on the DSI bus

Changes in v2:
- remove backlight-boot-off property for now
- don't renumber all regulators

 arch/arm/boot/dts/tegra114-dalmore.dts | 44 ++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index ca4485903b9d..512922f049c3 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -16,6 +16,21 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
+	host1x at 50000000 {
+		dsi at 54300000 {
+			status = "okay";
+
+			panel at 0 {
+				compatible = "panasonic,vvx10f004b00",
+					     "simple-panel";
+				reg = <0>;
+
+				power-supply = <&avdd_lcd_reg>;
+				backlight = <&backlight>;
+			};
+		};
+	};
+
 	pinmux at 70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -723,6 +738,10 @@
 		status = "okay";
 	};
 
+	pwm at 7000a000 {
+		status = "okay";
+	};
+
 	i2c at 7000c000 {
 		status = "okay";
 		clock-frequency = <100000>;
@@ -811,7 +830,7 @@
 					regulator-boot-on;
 				};
 
-				fet1 {
+				vdd_bl_reg: fet1 {
 					regulator-name = "vdd-lcd-bl";
 				};
 
@@ -819,7 +838,7 @@
 					regulator-name = "vdd-modem-3v3";
 				};
 
-				fet4 {
+				avdd_lcd_reg: fet4 {
 					regulator-name = "avdd-lcd";
 				};
 
@@ -1089,6 +1108,17 @@
 		vbus-supply = <&usb3_vbus_reg>;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_bl_reg>;
+		pwms = <&pwm 1 1000000>;
+
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1155,16 +1185,6 @@
 			gpio = <&gpio TEGRA_GPIO(H, 5) GPIO_ACTIVE_HIGH>;
 		};
 
-		lcd_bl_en_reg: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "lcd_bl_en";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			gpio = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
-		};
-
 		usb1_vbus_reg: regulator at 3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
-- 
1.8.4.2
