From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jan 2015 23:48:27 +0100
Subject: [PATCH 2/5] ARM: dts: pxa: add clocks
In-Reply-To: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1422744510-3179-2-git-send-email-robert.jarzmik@free.fr>
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
 arch/arm/boot/dts/pxa27x.dtsi | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 80fc5d7..7cbf36f 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -1,6 +1,6 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
 #include "pxa2xx.dtsi"
-#include "dt-bindings/clock/pxa2xx-clock.h"
+#include "dt-bindings/clock/pxa-clock.h"
 
 / {
 	model = "Marvell PXA27x familiy SoC";
@@ -12,30 +12,58 @@
 			marvell,intc-nr-irqs = <34>;
 		};
 
+		gpio: gpio at 40e00000 {
+			compatible = "intel,pxa27x-gpio";
+			clocks = <&pxa2xx_clks CLK_NONE>;
+		};
+
+		ffuart: uart at 40100000 {
+			clocks = <&pxa2xx_clks CLK_FFUART>;
+		};
+
+		btuart: uart at 40200000 {
+			clocks = <&pxa2xx_clks CLK_BTUART>;
+		};
+
+		stuart: uart at 40700000 {
+			clocks = <&pxa2xx_clks CLK_STUART>;
+		};
+
 		pwm0: pwm at 40b00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&pxa2xx_clks CLK_PWM0>;
 		};
 
 		pwm1: pwm at 40b00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00010 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&pxa2xx_clks CLK_PWM1>;
 		};
 
 		pwm2: pwm at 40c00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00000 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&pxa2xx_clks CLK_PWM0>;
 		};
 
 		pwm3: pwm at 40c00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00010 0x10>;
 			#pwm-cells = <1>;
+			clocks = <&pxa2xx_clks CLK_PWM1>;
+		};
+
+		pwri2c: i2c at 40f000180 {
+			clocks = <&pxa2xx_clks CLK_PWRI2C>;
+		};
+
+		pxai2c1: i2c at 40301680 {
+			clocks = <&pxa2xx_clks CLK_I2C>;
 		};
-	};
 
 	clocks {
 	       /*
@@ -47,10 +75,10 @@
 		ranges;
 
 		pxa2xx_clks: pxa2xx_clks at 41300004 {
-			compatible = "marvell,pxa-clocks";
+			compatible = "marvell,pxa270-clocks";
 			#clock-cells = <1>;
 			status = "okay";
 		};
 	};
-
+	};
 };
-- 
2.1.0
