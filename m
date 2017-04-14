From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri, 14 Apr 2017 23:42:28 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Add CPU thermal sensor and zone
Message-ID: <20170414214228.32521-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This uses CPU thermal sensor available on every Northstar chipset to
monitor temperature. We don't have any cooling or throttling so only a
critical trip was added.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 6a2afe7880ae..bbf39deb89f3 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -356,6 +356,12 @@
 				     "sata2";
 	};
 
+	thermal: thermal at 1800c2c0 {
+		compatible = "brcm,ns-thermal";
+		reg = <0x1800c2c0 0x10>;
+		#thermal-sensor-cells = <0>;
+	};
+
 	srab: srab at 18007000 {
 		compatible = "brcm,bcm5301x-srab";
 		reg = <0x18007000 0x1000>;
@@ -419,4 +425,24 @@
 			status = "disabled";
 		};
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			coefficients = <(-556) 418000>;
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature	= <125000>;
+					hysteresis	= <0>;
+					type		= "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
 };
-- 
2.11.0
