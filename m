From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Feb 2015 18:22:35 +0100
Subject: [PATCH v4 2/5] ARM: dts: pxa: add clocks
In-Reply-To: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
References: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423761758-29159-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks to the IPs already described in the pxa device-tree
files. There are more clocks in the clock tree than IPs described in the
current pxa device-tree.

This patch ensures that :
 - the current description is correct
 - the clocks are actually claimed, so that clock framework doesn't
   disable them automatically (unused clocks shutdown)

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v3: change pxa2xx-clks into clks to accomodate pxa3xx as well
---
 arch/arm/boot/dts/pxa27x.dtsi | 18 ++++++++++++++----
 arch/arm/boot/dts/pxa2xx.dtsi |  7 ++++++-
 arch/arm/boot/dts/pxa3xx.dtsi | 21 ++++++++++++++++++++-
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 98b560e..9696718 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -1,6 +1,6 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
 #include "pxa2xx.dtsi"
-#include "dt-bindings/clock/pxa2xx-clock.h"
+#include "dt-bindings/clock/pxa-clock.h"
 
 / {
 	model = "Marvell PXA27x familiy SoC";
@@ -12,36 +12,47 @@
 			marvell,intc-nr-irqs = <34>;
 		};
 
+		gpio: gpio at 40e00000 {
+			compatible = "intel,pxa27x-gpio";
+			clocks = <&clks CLK_NONE>;
+		};
+
 		pwm0: pwm at 40b00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm1: pwm at 40b00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00010 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM1>;
 		};
 
 		pwm2: pwm at 40c00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00000 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm3: pwm at 40c00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00010 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM1>;
 		};
 
 		pwri2c: i2c at 40f000180 {
 			compatible = "mrvl,pxa-i2c";
 			reg = <0x40f00180 0x24>;
 			interrupts = <6>;
+			clocks = <&clks CLK_PWRI2C>;
 			status = "disabled";
 		};
+
 	};
 
 	clocks {
@@ -53,11 +64,10 @@
 		#size-cells = <1>;
 		ranges;
 
-		pxa2xx_clks: pxa2xx_clks at 41300004 {
-			compatible = "marvell,pxa-clocks";
+		clks: pxa2xx_clks at 41300004 {
+			compatible = "marvell,pxa270-clocks";
 			#clock-cells = <1>;
 			status = "okay";
 		};
 	};
-
 };
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index c08f8462..71a0cd7 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -6,7 +6,8 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
+#include "dt-bindings/clock/pxa-clock.h"
 
 / {
 	model = "Marvell PXA2xx family SoC";
@@ -79,6 +80,7 @@
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40100000 0x30>;
 			interrupts = <22>;
+			clocks = <&clks CLK_FFUART>;
 			status = "disabled";
 		};
 
@@ -86,6 +88,7 @@
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40200000 0x30>;
 			interrupts = <21>;
+			clocks = <&clks CLK_BTUART>;
 			status = "disabled";
 		};
 
@@ -93,6 +96,7 @@
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40700000 0x30>;
 			interrupts = <20>;
+			clocks = <&clks CLK_STUART>;
 			status = "disabled";
 		};
 
@@ -107,6 +111,7 @@
 			compatible = "mrvl,pxa-i2c";
 			reg = <0x40301680 0x30>;
 			interrupts = <18>;
+			clocks = <&clks CLK_I2C>;
 			#address-cells = <0x1>;
 			#size-cells = <0>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 83bb0ef..c7066eb 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -1,5 +1,5 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
-/include/ "pxa2xx.dtsi"
+#include "pxa2xx.dtsi"
 
 / {
 	model = "Marvell PXA3xx familiy SoC";
@@ -10,6 +10,7 @@
 			compatible = "mrvl,pwri2c";
 			reg = <0x40f500c0 0x30>;
 			interrupts = <6>;
+			clocks = <&clks CLK_PWRI2C>;
 			#address-cells = <0x1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -19,6 +20,7 @@
 			compatible = "marvell,pxa3xx-nand";
 			reg = <0x43100000 90>;
 			interrupts = <45>;
+			clocks = <&clks CLK_NAND>;
 			#address-cells = <1>;
 			#size-cells = <1>;	
 			status = "disabled";
@@ -32,6 +34,7 @@
 		gpio: gpio at 40e00000 {
 			compatible = "intel,pxa3xx-gpio";
 			reg = <0x40e00000 0x10000>;
+			clocks = <&clks CLK_GPIO>;
 			interrupt-names = "gpio0", "gpio1", "gpio_mux";
 			interrupts = <8 9 10>;
 			gpio-controller;
@@ -40,4 +43,20 @@
 			#interrupt-cells = <0x2>;
 		};
 	};
+
+	clocks {
+	       /*
+		* The muxing of external clocks/internal dividers for osc* clock
+		* sources has been hidden under the carpet by now.
+		*/
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clks: pxa3xx_clks at 41300004 {
+			compatible = "marvell,pxa300-clocks";
+			#clock-cells = <1>;
+			status = "okay";
+		};
+	};
 };
-- 
2.1.0
