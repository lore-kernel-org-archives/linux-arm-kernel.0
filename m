From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 19 Feb 2016 16:12:19 +0200
Subject: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
Message-ID: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 8e6ebfaa9b384088002baa10f7534efa73a0794e.

Without the patch reverted regulators will not work. This prevents
MMC to be working for example so the boards can not boot to
MMC rootfs.

Tested it on beaglebone white and bisect also points to the
reverted commit.
The issue can be also fixed by adding "regulator-compatible =" to all board
dts file for the regulators.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

I have noticed that bbw did not find the MMC with linux-next, but it turns out
that even 4.5-rc4 is behaving the same way.
I have run bisect and with this revert patch I can boot up fine.
To be honest I don't know why the tps65217.dtsi has been deleted in the first
place. 


 .../devicetree/bindings/regulator/tps65217.txt     | 10 ----
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 14 ++----
 arch/arm/boot/dts/am335x-chilisom.dtsi             | 14 +-----
 arch/arm/boot/dts/am335x-nano.dts                  | 14 +-----
 arch/arm/boot/dts/am335x-pepper.dts                | 14 +-----
 arch/arm/boot/dts/am335x-sl50.dts                  | 13 +----
 arch/arm/boot/dts/tps65217.dtsi                    | 56 ++++++++++++++++++++++
 7 files changed, 67 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi

diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
index d18109657da6..4f05d208c95c 100644
--- a/Documentation/devicetree/bindings/regulator/tps65217.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
@@ -26,11 +26,7 @@ Example:
 		ti,pmic-shutdown-controller;
 
 		regulators {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
 			dcdc1_reg: dcdc1 {
-				reg = <0>;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -38,7 +34,6 @@ Example:
 			};
 
 			dcdc2_reg: dcdc2 {
-				reg = <1>;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -46,7 +41,6 @@ Example:
 			};
 
 			dcdc3_reg: dcc3 {
-				reg = <2>;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-boot-on;
@@ -54,7 +48,6 @@ Example:
 			};
 
 			ldo1_reg: ldo1 {
-				reg = <3>;
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -62,7 +55,6 @@ Example:
 			};
 
 			ldo2_reg: ldo2 {
-				reg = <4>;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -70,7 +62,6 @@ Example:
 			};
 
 			ldo3_reg: ldo3 {
-				reg = <5>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -78,7 +69,6 @@ Example:
 			};
 
 			ldo4_reg: ldo4 {
-				reg = <6>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index f3db13d2d90e..0cc150b87b86 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -285,8 +285,10 @@
 	};
 };
 
+
+/include/ "tps65217.dtsi"
+
 &tps {
-	compatible = "ti,tps65217";
 	/*
 	 * Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-only
 	 * mode") at poweroff.  Most BeagleBone versions do not support RTC-only
@@ -307,17 +309,12 @@
 	ti,pmic-shutdown-controller;
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		dcdc1_reg: regulator at 0 {
-			reg = <0>;
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
 		dcdc2_reg: regulator at 1 {
-			reg = <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -327,7 +324,6 @@
 		};
 
 		dcdc3_reg: regulator at 2 {
-			reg = <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -337,25 +333,21 @@
 		};
 
 		ldo1_reg: regulator at 3 {
-			reg = <3>;
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator at 4 {
-			reg = <4>;
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
 		ldo3_reg: regulator at 5 {
-			reg = <5>;
 			regulator-name = "vdd_1v8";
 			regulator-always-on;
 		};
 
 		ldo4_reg: regulator at 6 {
-			reg = <6>;
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index fda457b07e15..857d9894103a 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -128,21 +128,16 @@
 
 };
 
-&tps {
-	compatible = "ti,tps65217";
+/include/ "tps65217.dtsi"
 
+&tps {
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		dcdc1_reg: regulator at 0 {
-			reg = <0>;
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
 		dcdc2_reg: regulator at 1 {
-			reg = <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -152,7 +147,6 @@
 		};
 
 		dcdc3_reg: regulator at 2 {
-			reg = <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -162,28 +156,24 @@
 		};
 
 		ldo1_reg: regulator at 3 {
-			reg = <3>;
 			regulator-name = "vio,vrtc,vdds";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator at 4 {
-			reg = <4>;
 			regulator-name = "vdd_3v3aux";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
 		ldo3_reg: regulator at 5 {
-			reg = <5>;
 			regulator-name = "vdd_1v8";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
 		ldo4_reg: regulator at 6 {
-			reg = <6>;
 			regulator-name = "vdd_3v3d";
 			regulator-boot-on;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 77559a1ded60..f313999c503e 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -375,15 +375,11 @@
 	wp-gpios = <&gpio3 18 0>;
 };
 
-&tps {
-	compatible = "ti,tps65217";
+#include "tps65217.dtsi"
 
+&tps {
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		dcdc1_reg: regulator at 0 {
-			reg = <0>;
 			/* +1.5V voltage with ?4% tolerance */
 			regulator-min-microvolt = <1450000>;
 			regulator-max-microvolt = <1550000>;
@@ -392,7 +388,6 @@
 		};
 
 		dcdc2_reg: regulator at 1 {
-			reg = <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.1V with ?4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <915000>;
@@ -402,7 +397,6 @@
 		};
 
 		dcdc3_reg: regulator at 2 {
-			reg = <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with ?4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <915000>;
@@ -412,7 +406,6 @@
 		};
 
 		ldo1_reg: regulator at 3 {
-			reg = <3>;
 			/* +1.8V voltage with ?4% tolerance */
 			regulator-min-microvolt = <1750000>;
 			regulator-max-microvolt = <1870000>;
@@ -421,7 +414,6 @@
 		};
 
 		ldo2_reg: regulator at 4 {
-			reg = <4>;
 			/* +3.3V voltage with ?4% tolerance */
 			regulator-min-microvolt = <3175000>;
 			regulator-max-microvolt = <3430000>;
@@ -430,7 +422,6 @@
 		};
 
 		ldo3_reg: regulator at 5 {
-			reg = <5>;
 			/* +1.8V voltage with ?4% tolerance */
 			regulator-min-microvolt = <1750000>;
 			regulator-max-microvolt = <1870000>;
@@ -439,7 +430,6 @@
 		};
 
 		ldo4_reg: regulator at 6 {
-			reg = <6>;
 			/* +3.3V voltage with ?4% tolerance */
 			regulator-min-microvolt = <3175000>;
 			regulator-max-microvolt = <3430000>;
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 471a3a70ea1f..8867aaaec54d 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -420,9 +420,9 @@
 	vin-supply = <&vbat>;
 };
 
-&tps {
-	compatible = "ti,tps65217";
+/include/ "tps65217.dtsi"
 
+&tps {
 	backlight {
 		isel = <1>; /* ISET1 */
 		fdim = <200>; /* TPS65217_BL_FDIM_200HZ */
@@ -430,17 +430,12 @@
 	};
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		dcdc1_reg: regulator at 0 {
-			reg = <0>;
 			/* VDD_1V8 system supply */
 			regulator-always-on;
 		};
 
 		dcdc2_reg: regulator at 1 {
-			reg = <1>;
 			/* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -450,7 +445,6 @@
 		};
 
 		dcdc3_reg: regulator at 2 {
-			reg = <2>;
 			/* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -460,21 +454,18 @@
 		};
 
 		ldo1_reg: regulator at 3 {
-			reg = <3>;
 			/* VRTC 1.8V always-on supply */
 			regulator-name = "vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator at 4 {
-			reg = <4>;
 			/* 3.3V rail */
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
 		ldo3_reg: regulator at 5 {
-			reg = <5>;
 			/* VDD_3V3A 3.3V rail */
 			regulator-name = "vdd_3v3a";
 			regulator-min-microvolt = <3300000>;
@@ -482,7 +473,6 @@
 		};
 
 		ldo4_reg: regulator at 6 {
-			reg = <6>;
 			/* VDD_3V3B 3.3V rail */
 			regulator-name = "vdd_3v3b";
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index a676869536bc..a6efbe6eda3b 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -395,19 +395,16 @@
 	pinctrl-0 = <&uart4_pins>;
 };
 
+#include "tps65217.dtsi"
+
 &tps {
-	compatible = "ti,tps65217";
 	ti,pmic-shutdown-controller;
 
 	interrupt-parent = <&intc>;
 	interrupts = <7>;	/* NNMI */
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		dcdc1_reg: regulator at 0 {
-			reg = <0>;
 			/* VDDS_DDR */
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
@@ -415,7 +412,6 @@
 		};
 
 		dcdc2_reg: regulator at 1 {
-			reg = <1>;
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -425,7 +421,6 @@
 		};
 
 		dcdc3_reg: regulator at 2 {
-			reg = <2>;
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -435,7 +430,6 @@
 		};
 
 		ldo1_reg: regulator at 3 {
-			reg = <3>;
 			/* VRTC / VIO / VDDS*/
 			regulator-always-on;
 			regulator-min-microvolt = <1800000>;
@@ -443,7 +437,6 @@
 		};
 
 		ldo2_reg: regulator at 4 {
-			reg = <4>;
 			/* VDD_3V3AUX */
 			regulator-always-on;
 			regulator-min-microvolt = <3300000>;
@@ -451,7 +444,6 @@
 		};
 
 		ldo3_reg: regulator at 5 {
-			reg = <5>;
 			/* VDD_1V8 */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -459,7 +451,6 @@
 		};
 
 		ldo4_reg: regulator at 6 {
-			reg = <6>;
 			/* VDD_3V3A */
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
new file mode 100644
index 000000000000..a63272422d76
--- /dev/null
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/tps65217.pdf
+ */
+
+&tps {
+	compatible = "ti,tps65217";
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dcdc1_reg: regulator at 0 {
+			reg = <0>;
+			regulator-compatible = "dcdc1";
+		};
+
+		dcdc2_reg: regulator at 1 {
+			reg = <1>;
+			regulator-compatible = "dcdc2";
+		};
+
+		dcdc3_reg: regulator at 2 {
+			reg = <2>;
+			regulator-compatible = "dcdc3";
+		};
+
+		ldo1_reg: regulator at 3 {
+			reg = <3>;
+			regulator-compatible = "ldo1";
+		};
+
+		ldo2_reg: regulator at 4 {
+			reg = <4>;
+			regulator-compatible = "ldo2";
+		};
+
+		ldo3_reg: regulator at 5 {
+			reg = <5>;
+			regulator-compatible = "ldo3";
+		};
+
+		ldo4_reg: regulator at 6 {
+			reg = <6>;
+			regulator-compatible = "ldo4";
+		};
+	};
+};
-- 
2.7.1
