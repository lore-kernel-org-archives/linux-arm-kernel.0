From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 15:32:44 +0200
Subject: [PATCH 1/3] arm64: dts: mt8173: Add clock controller device nodes
In-Reply-To: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
References: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432128766-4445-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device nodes providing clocks on the Mediatek MT8173.
These are: topckgen, infracfg, pericfg and apmixedsys. These are
fed by two oscillators also added by this patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 4595196..ef1d92f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "mt8173-pinfunc.h"
@@ -87,6 +88,20 @@
 		#clock-cells = <0>;
 	};
 
+	clk26m: oscillator at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	clk32k: oscillator at 1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "clk32k";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -106,6 +121,26 @@
 		compatible = "simple-bus";
 		ranges;
 
+		topckgen: clock-controller at 10000000 {
+			compatible = "mediatek,mt8173-topckgen";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: power-controller at 10001000 {
+			compatible = "mediatek,mt8173-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		pericfg: power-controller at 10003000 {
+			compatible = "mediatek,mt8173-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		/*
 		 * Pinctrl access register at 0x10005000 through regmap.
 		 * Register 0x1000b000 is used by EINT.
@@ -138,6 +173,12 @@
 			reg = <0 0x10200620 0 0x20>;
 		};
 
+		apmixedsys: clock-controller at 10209000 {
+			compatible = "mediatek,mt8173-apmixedsys";
+			reg = <0 0x10209000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		gic: interrupt-controller at 10220000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.1.4
