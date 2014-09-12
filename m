From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Sep 2014 14:03:06 +0200
Subject: [PATCH] ARM: dts: Add Maxim 77693 PMIC to the Trats2 board
Message-ID: <1410523386-10581-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MAX77693 is a companion power management IC for smart phones and tablets.

The MAX77693 contains input over-voltage protection (OVP),
a fully-integrated 2.5A switching charger for Lithium Ion battery with
integrated battery disconnect, OTG/accessory 5V output power,
a high-current white LED driver for camera flash, two safeout LDOs,
a haptic motor driver, Model Gauge m3 battery fuel gauge and MicroUSB
Interface Controller (MUIC). I2C serial interface is used for
communicating.

Add MAX77693 node to the Trats2 board. This allows using:
 - charger regulator,
 - 2 safeout LDO regulators (for USB OTG),
 - extcon.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 11967f4561e0..0b641513a23d 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -22,6 +22,7 @@
 	aliases {
 		i2c9 = &i2c_ak8975;
 		i2c10 = &i2c_cm36651;
+		i2c11 = &i2c_max77693;
 	};
 
 	memory {
@@ -518,6 +519,39 @@
 		};
 	};
 
+	i2c_max77693: i2c-gpio-1 {
+		compatible = "i2c-gpio";
+		gpios = <&gpm2 0 0>, <&gpm2 1 0 >;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		max77693 at 66 {
+			compatible = "maxim,max77693";
+			interrupt-parent = <&gpx1>;
+			interrupts = <5 2>;
+			reg = <0x66>;
+
+			regulators {
+				esafeout1_reg: esafeout at 1 {
+					regulator-compatible = "ESAFEOUT1";
+					regulator-name = "ESAFEOUT1";
+				};
+				esafeout2_reg: esafeout at 2 {
+					regulator-compatible = "ESAFEOUT2";
+					regulator-name = "ESAFEOUT2";
+				};
+				charger_reg: charger at 0 {
+					regulator-compatible = "CHARGER";
+					regulator-name = "CHARGER";
+					regulator-min-microamp = <60000>;
+					regulator-max-microamp = <2580000>;
+				};
+			};
+		};
+	};
+
 	mmc at 12550000 {
 		num-slots = <1>;
 		supports-highspeed;
-- 
1.9.1
