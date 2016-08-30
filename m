From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 14:12:35 +0200
Subject: [PATCH 3/4] ARM: dts: Add the core module clocks to Integrator/AP
In-Reply-To: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
References: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1472559156-32148-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clocks on the core module to the Integrator/AP
board: a 24MHz chrystal, and two special-purpose ICST525
dividers, one used to clock the CPU core and another auxilary
oscillator.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 726a3ac486e0..6f16d09dc5a4 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -19,7 +19,7 @@
 		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
 	};
 
-	/* 24 MHz chrystal on the core module */
+	/* 24 MHz chrystal on the Integrator/AP development board */
 	xtal24mhz: xtal24mhz at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -42,6 +42,33 @@
 		clocks = <&xtal24mhz>;
 	};
 
+	core-module at 10000000 {
+		/* 24 MHz chrystal on the core module */
+		cm24mhz: cm24mhz at 24M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		/* Oscillator on the core module, clocks the CPU core */
+		cmosc: cmosc at 24M {
+			compatible = "arm,syscon-icst525-integratorap-cm";
+			#clock-cells = <0>;
+			lock-offset = <0x14>;
+			vco-offset = <0x08>;
+			clocks = <&cm24mhz>;
+		};
+
+		/* Auxilary oscillator on the core module, 32.369MHz at boot */
+		auxosc: auxosc at 24M {
+			compatible = "arm,syscon-icst525";
+			#clock-cells = <0>;
+			lock-offset = <0x14>;
+			vco-offset = <0x1c>;
+			clocks = <&cm24mhz>;
+		};
+	};
+
 	syscon {
 		compatible = "arm,integrator-ap-syscon", "syscon";
 		reg = <0x11000000 0x100>;
-- 
2.7.4
