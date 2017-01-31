From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Jan 2017 22:17:41 +0100
Subject: [PATCH 2/4] ARM: dts: Ux500: move USB PHY pins to PHY device
Message-ID: <20170131211741.4608-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The physical pins from the SoC are in a sense belonging to the
PHY device (AB8500 USB) rather than the MUSB USB IP block.
The driver definately assumes so: before this change it
complains that it cannot control the pins it is using:

abx5x0-usb ab8500-usb.0: could not get/set default pinstate

After this patch the warning goes away.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi    | 12 ++++++------
 arch/arm/boot/dts/ste-snowball.dts | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 1b59943ab6ec..865da0259963 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -19,12 +19,6 @@
 	};
 
 	soc {
-		usb_per5 at a03e0000 {
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&musb_default_mode>;
-			pinctrl-1 = <&musb_sleep_mode>;
-		};
-
 		uart at 80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart0_default_mode>;
@@ -225,6 +219,12 @@
 				ab8500-gpio {
 				};
 
+				ab8500_usb {
+					pinctrl-names = "default", "sleep";
+					pinctrl-0 = <&musb_default_mode>;
+					pinctrl-1 = <&musb_sleep_mode>;
+				};
+
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
 						regulator-name = "V-DISPLAY";
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 7900e5d6aa05..d5f61256fe56 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -159,12 +159,6 @@
 				     "", "", "", "", "", "", "", "";
 		};
 
-		usb_per5 at a03e0000 {
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&musb_default_mode>;
-			pinctrl-1 = <&musb_sleep_mode>;
-		};
-
 		sound {
 			compatible = "stericsson,snd-soc-mop500";
 
@@ -451,6 +445,12 @@
 						     "PM_GPIO42"; /* AB8500 GPIO42 */
 				};
 
+				ab8500_usb {
+					pinctrl-names = "default", "sleep";
+					pinctrl-0 = <&musb_default_mode>;
+					pinctrl-1 = <&musb_sleep_mode>;
+				};
+
 				ext_regulators: ab8500-ext-regulators {
 					ab8500_ext1_reg: ab8500_ext1 {
 						regulator-name = "ab8500-ext-supply1";
-- 
2.9.3
