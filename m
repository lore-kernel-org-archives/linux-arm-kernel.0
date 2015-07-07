From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jul 2015 14:45:10 +0200
Subject: [PATCH 1/4] ARM: dts: mediatek: Enable clock support for Mediatek
 MT8135.
In-Reply-To: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
References: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1436273113-25472-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch adds MT8135 clock controllers into device tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/mt8135.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 0aba9eb..b99e488 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt8135-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
@@ -94,6 +95,11 @@
 			#clock-cells = <0>;
 		};
 
+		clk26m: clk26m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
 	};
 
 	soc {
@@ -102,6 +108,26 @@
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
 		/*
 		 * Pinctrl access register at 0x10005000 and 0x1020c000 through
 		 * regmap. Register 0x1000b000 is used by EINT.
@@ -143,6 +169,12 @@
 			reg = <0 0x10200030 0 0x1c>;
 		};
 
+		apmixedsys: apmixedsys at 10209000 {
+			compatible = "mediatek,mt8135-apmixedsys";
+			reg = <0 0x10209000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		syscfg_pctl_b: syscfg_pctl_b at 1020c000 {
 			compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
 			reg = <0 0x1020c000 0 0x1000>;
-- 
2.1.4
