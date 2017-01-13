From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jan 2017 16:11:29 +0100
Subject: [PATCH 3/3] ARM: dts: add the AB8500 clocks to the device tree
Message-ID: <20170113151129.31713-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the AB8500 clocks to the device tree using the new
bindings from the clk subsystem, making audio work again.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi  | 19 +++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi    |  9 ---------
 arch/arm/boot/dts/ste-snowball.dts |  9 ---------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 82d8c4771293..084fb4f13a7b 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/mfd/dbx500-prcmu.h>
 #include <dt-bindings/arm/ux500_pm_domains.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/ste-ab8500.h>
 #include "skeleton.dtsi"
 
 / {
@@ -603,6 +604,11 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 
+				ab8500_clock: ab8500-clock {
+					compatible = "stericsson,ab8500-clk";
+					#clock-cells = <1>;
+				};
+
 				ab8500_gpio: ab8500-gpio {
 					compatible = "stericsson,ab8500-gpio";
 					gpio-controller;
@@ -686,6 +692,8 @@
 
 				ab8500-pwm {
 					compatible = "stericsson,ab8500-pwm";
+					clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
+					clock-names = "intclk";
 				};
 
 				ab8500-debugfs {
@@ -700,6 +708,9 @@
 					V-AMIC2-supply = <&ab8500_ldo_anamic2_reg>;
 					V-DMIC-supply = <&ab8500_ldo_dmic_reg>;
 
+					clocks = <&ab8500_clock AB8500_SYSCLK_AUDIO>;
+					clock-names = "audioclk";
+
 					stericsson,earpeice-cmv = <950>; /* Units in mV. */
 				};
 
@@ -1095,6 +1106,14 @@
 			status = "disabled";
 		};
 
+		sound {
+			compatible = "stericsson,snd-soc-mop500";
+			stericsson,cpu-dai = <&msp1 &msp3>;
+			stericsson,audio-codec = <&codec>;
+			clocks = <&prcmu_clk PRCMU_SYSCLK>, <&ab8500_clock AB8500_SYSCLK_ULP>, <&ab8500_clock AB8500_SYSCLK_INT>;
+			clock-names = "sysclk", "ulpclk", "intclk";
+		};
+
 		msp0: msp at 80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 4f70088d3c8a..a10369ed36e0 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -186,15 +186,6 @@
 			status = "okay";
 		};
 
-		sound {
-			compatible = "stericsson,snd-soc-mop500";
-
-			stericsson,cpu-dai = <&msp1 &msp3>;
-			stericsson,audio-codec = <&codec>;
-			clocks = <&prcmu_clk PRCMU_SYSCLK>;
-			clock-names = "sysclk";
-		};
-
 		msp0: msp at 80123000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&msp0_default_mode>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index c6bcc8e2f29a..d1be40f96154 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -159,15 +159,6 @@
 				     "", "", "", "", "", "", "", "";
 		};
 
-		sound {
-			compatible = "stericsson,snd-soc-mop500";
-
-			stericsson,cpu-dai = <&msp1 &msp3>;
-			stericsson,audio-codec = <&codec>;
-			clocks = <&prcmu_clk PRCMU_SYSCLK>;
-			clock-names = "sysclk";
-		};
-
 		msp0: msp at 80123000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&msp0_default_mode>;
-- 
2.9.3
