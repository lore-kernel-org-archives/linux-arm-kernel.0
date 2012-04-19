From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:32 +0100
Subject: [PATCH 03/15] ARM: ux500: Use correct format for dynamic IRQ
 assignment
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch applies the correct format requested by the irq
domain. For chained IRQs which use GPIO lines as IRQs, we
stipulate that a two cell request is required. The first cell
contains the requested IRQ and the second can contain flags
pertaining to edge detection and level sensitive values. The
zeroth cell specifies the GPIO controller by use of a phandle.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi  |   22 ++++++++++++++++++++--
 arch/arm/boot/dts/snowball.dts |   20 +++++++++-----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 57d3d35..9e8ff2c 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -24,7 +24,6 @@
 			#interrupt-cells = <3>;
 			#address-cells = <1>;
 			interrupt-controller;
-			interrupt-parent;
 			reg = <0xa0411000 0x1000>,
 			      <0xa0410100 0x100>;
 		};
@@ -59,6 +58,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8012e000 0x80>;
 			interrupts = <0 119 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -70,6 +71,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8012e080 0x80>;
 			interrupts = <0 120 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -81,6 +84,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e000 0x80>;
 			interrupts = <0 121 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -92,6 +97,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e080 0x80>;
 			interrupts = <0 122 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -103,6 +110,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e100 0x80>;
 			interrupts = <0 123 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -114,6 +123,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e180 0x80>;
 			interrupts = <0 124 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -125,6 +136,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8011e000 0x80>;
 			interrupts = <0 125 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -136,6 +149,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8011e080 0x80>;
 			interrupts = <0 126 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -147,6 +162,8 @@
 				"st,nomadik-gpio";
 			reg =  <0xa03fe000 0x80>;
 			interrupts = <0 127 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -230,7 +247,8 @@
 			status = "disabled";
 
 			// Add one of these for each child device
-			cs-gpios = <&gpio0 31 &gpio4 14 &gpio4 16 &gpio6 22 &gpio7 0>;
+			cs-gpios = <&gpio0 31 0x4 &gpio4 14 0x4 &gpio4 16 0x4
+				    &gpio6 22 0x4 &gpio7 0 0x4>;
 
 		};
 
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index fb2a037..0ba0955 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -30,35 +30,35 @@
 			wakeup = <1>;
 			linux,code = <2>;
 			label = "userpb";
-			gpios = <&gpio1 0 0>;
+			gpios = <&gpio1 0 0x4>;
 		};
 		button at 2 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <3>;
 			label = "extkb1";
-			gpios = <&gpio4 23 0>;
+			gpios = <&gpio4 23 0x4>;
 		};
 		button at 3 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <4>;
 			label = "extkb2";
-			gpios = <&gpio4 24 0>;
+			gpios = <&gpio4 24 0x4>;
 		};
 		button at 4 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <5>;
 			label = "extkb3";
-			gpios = <&gpio5 1 0>;
+			gpios = <&gpio5 1 0x4>;
 		};
 		button at 5 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <6>;
 			label = "extkb4";
-			gpios = <&gpio5 2 0>;
+			gpios = <&gpio5 2 0x4>;
 		};
 	};
 
@@ -66,12 +66,11 @@
 		compatible = "gpio-leds";
 		used-led {
 			label = "user_led";
-			gpios = <&gpio4 14>;
+			gpios = <&gpio4 14 0x4>;
 		};
 	};
 
 	soc-u9500 {
-
 		external-bus at 50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x10000000>;
@@ -82,7 +81,7 @@
 			ethernet at 50000000 {
 				compatible = "smsc,9111";
 				reg = <0x50000000 0x10000>;
-				interrupts = <12>;
+				interrupts = <12 0x4>;
 				interrupt-parent = <&gpio4>;
 			};
 		};
@@ -94,8 +93,7 @@
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 
-			#gpio-cells = <1>;
-			cd-gpios  = <&gpio6 26>; // 218
+			cd-gpios  = <&gpio6 26 0x4>; // 218
 			cd-inverted;
 
 			status = "okay";
@@ -127,7 +125,7 @@
 			tc3589x at 42 {
 				//compatible = "tc3589x";
 				reg = <0x42>;
-				interrupts = <25>;
+				gpios = <&gpio6 25 0x4>;
 				interrupt-parent = <&gpio6>;
 			};
 			tps61052 at 33 {
-- 
1.7.9.1
