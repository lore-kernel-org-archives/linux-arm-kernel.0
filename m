From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Feb 2015 11:47:21 +0100
Subject: [PATCH 09/13] ARM: dts: mediatek: Enable clock support for Mediatek
 MT8135.
In-Reply-To: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1423478845-2835-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch adds MT8135 clock controllers into device tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/mt8135.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 7d56a98..7cb5e84 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt8135-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
@@ -86,6 +87,18 @@
 			clock-frequency = <32000>;
 			#clock-cells = <0>;
 		};
+
+		clk_null: clk_null {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		clk26m: clk26m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
 	};
 
 	soc {
@@ -94,6 +107,26 @@
 		compatible = "simple-bus";
 		ranges;
 
+		topckgen: topckgen at 10000000 {
+			compatible = "mediatek,mt8135-topckgen";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: infracfg at 10001000 {
+			#reset-cells = <1>;
+			#clock-cells = <1>;
+			compatible = "mediatek,mt8135-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+		};
+
+		pericfg: pericfg at 10003000 {
+			#reset-cells = <1>;
+			#clock-cells = <1>;
+			compatible = "mediatek,mt8135-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+		};
+
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8135-timer",
 					"mediatek,mt6577-timer";
@@ -103,6 +136,12 @@
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		apmixedsys: apmixedsys at 10209000 {
+			compatible = "mediatek,mt8135-apmixedsys";
+			reg = <0 0x10209000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
-- 
2.1.4
