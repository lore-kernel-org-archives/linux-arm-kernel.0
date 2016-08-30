From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 14:12:36 +0200
Subject: [PATCH 4/4] ARM: dts: add the core module clocks to Integrator/CP
In-Reply-To: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
References: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1472559156-32148-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the core and memory clocks to the Integrator/CP device
tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorcp.dts | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 79430fbfec3b..cf27958fed4c 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -58,20 +58,37 @@
 
 	core-module at 10000000 {
 		/* 24 MHz chrystal on the core module */
-		xtal24mhz: xtal24mhz at 24M {
+		cm24mhz: cm24mhz at 24M {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 		};
 
-		/*
-		 * External oscillator on the core module, usually used
-		 * to drive video circuitry. Driven from the 24MHz clock.
-		 */
-		auxosc: cm_aux_osc at 25M {
+		/* Oscillator on the core module, clocks the CPU core */
+		cmcore: cmosc at 24M {
+			compatible = "arm,syscon-icst525-integratorcp-cm-core";
+			#clock-cells = <0>;
+			lock-offset = <0x14>;
+			vco-offset = <0x08>;
+			clocks = <&cm24mhz>;
+		};
+
+		/* Oscillator on the core module, clocks the memory bus */
+		cmmem: cmosc at 24M {
+			compatible = "arm,syscon-icst525-integratorcp-cm-mem";
+			#clock-cells = <0>;
+			lock-offset = <0x14>;
+			vco-offset = <0x08>;
+			clocks = <&cm24mhz>;
+		};
+
+		/* Auxilary oscillator on the core module, clocks the CLCD */
+		auxosc: auxosc at 24M {
+			compatible = "arm,syscon-icst525";
 			#clock-cells = <0>;
-			compatible = "arm,integrator-cm-auxosc";
-			clocks = <&xtal24mhz>;
+			lock-offset = <0x14>;
+			vco-offset = <0x1c>;
+			clocks = <&cm24mhz>;
 		};
 
 		/* The KMI clock is the 24 MHz oscillator divided to 8MHz */
@@ -80,7 +97,7 @@
 			compatible = "fixed-factor-clock";
 			clock-div = <3>;
 			clock-mult = <1>;
-			clocks = <&xtal24mhz>;
+			clocks = <&cm24mhz>;
 		};
 
 		/* The timer clock is the 24 MHz oscillator divided to 1MHz */
@@ -89,7 +106,7 @@
 			compatible = "fixed-factor-clock";
 			clock-div = <24>;
 			clock-mult = <1>;
-			clocks = <&xtal24mhz>;
+			clocks = <&cm24mhz>;
 		};
 	};
 
-- 
2.7.4
