From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:31:31 +0200
Subject: [PATCH 10/10] ARM: ux500: move BU21013 touchpad GPIOs into top-level
 DTS
Message-ID: <1380799891-26087-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BU21013 touchscreen GPIOs have been pretty confused, correct
them per board, and move the GPIO assignments up to the top
level DTS file so we can control it from there, and avoid defining
the GPIO assignments for non-ST UIB equipped boards.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-stuib.dtsi       |  2 --
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts  |  6 ++++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi       |  6 ------
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts | 10 ++++++++--
 arch/arm/boot/dts/ste-hrefv60plus.dtsi      |  6 ------
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
index 524e332..76704ec 100644
--- a/arch/arm/boot/dts/ste-href-stuib.dtsi
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -57,7 +57,6 @@
 			bu21013_tp at 5c {
 				compatible = "rohm,bu21013_tp";
 				reg = <0x5c>;
-				touch-gpio = <&gpio2 20 0x4>;
 				avdd-supply = <&ab8500_ldo_aux1_reg>;
 
 				rohm,touch-max-x = <384>;
@@ -68,7 +67,6 @@
 			bu21013_tp at 5d {
 				compatible = "rohm,bu21013_tp";
 				reg = <0x5d>;
-				touch-gpio = <&gpio2 20 0x4>;
 				avdd-supply = <&ab8500_ldo_aux1_reg>;
 
 				rohm,touch-max-x = <384>;
diff --git a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
index 3e1b974..2b1cb5b 100644
--- a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
@@ -20,7 +20,13 @@
 	soc {
 		/* Reset line for the BU21013 touchscreen */
 		i2c at 80110000 {
+			/* Only one of these will be used */
 			bu21013_tp at 5c {
+				touch-gpio = <&gpio2 12 0x4>;
+				reset-gpio = <&tc3589x_gpio 13 0x4>;
+			};
+			bu21013_tp at 5d {
+				touch-gpio = <&gpio2 12 0x4>;
 				reset-gpio = <&tc3589x_gpio 13 0x4>;
 			};
 		};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index de6b0a0..b2cd7bc 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -49,12 +49,6 @@
 			};
 		};
 
-		i2c at 80110000 {
-			bu21013_tp at 5c {
-				reset-gpio = <&tc3589x_gpio 13 0x4>;
-			};
-		};
-
 		vmmci: regulator-gpio {
 			gpios = <&tc3589x_gpio 18 0x4>;
 			enable-gpio = <&tc3589x_gpio 17 0x4>;
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
index 4da49e7..8c6a2de 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
@@ -22,8 +22,14 @@
 	soc {
 		/* Reset line for the BU21013 touchscreen */
 		i2c at 80110000 {
-			bu21013_tp at 0x5c {
-				reset-gpio = <&gpio4 15 0x4>;
+			/* Only one of these will be used */
+			bu21013_tp at 5c {
+				touch-gpio = <&gpio2 20 0x4>;
+				reset-gpio = <&gpio4 17 0x4>;
+			};
+			bu21013_tp at 5d {
+				touch-gpio = <&gpio2 20 0x4>;
+				reset-gpio = <&gpio4 17 0x4>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index d0f1165..aed511b 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -23,12 +23,6 @@
 	};
 
 	soc {
-		i2c at 80110000 {
-			bu21013_tp at 0x5c {
-				reset-gpio = <&gpio4 15 0x4>;
-			};
-		};
-
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
-- 
1.8.3.1
