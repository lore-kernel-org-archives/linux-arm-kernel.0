From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 28 Nov 2014 19:34:50 +0800
Subject: [PATCH 4/4] dts: Enable clock support for Mediatek MT8135.
In-Reply-To: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1417174490-6845-5-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MT8135 clock controllers into device tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 90a56ad..37d852b 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt8135-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
@@ -86,6 +87,24 @@
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
+
+		rtc32k: rtc32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
 	};
 
 	soc {
@@ -94,6 +113,28 @@
 		compatible = "simple-bus";
 		ranges;
 
+		topckgen: topckgen at 10000000 {
+			compatible = "mediatek,mt8135-topckgen";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: syscon at 10001000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt8135-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: syscon at 10003000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt8135-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8135-timer", "mediatek,mt6577-timer";
 			reg = <0 0x10008000 0 0x80>;
@@ -102,6 +143,12 @@
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
1.8.1.1.dirty
