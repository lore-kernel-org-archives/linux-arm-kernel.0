From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Apr 2016 16:11:54 +0800
Subject: [PATCH v7 9/9] arm: dts: mt2701: Add clock controller device nodes
In-Reply-To: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1460621514-65191-10-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock controller nodes for MT2701, include topckgen, infracfg,
pericfg, apmixedsys, mmsys, imgsys, vdecsys, hifsys, ethsys and
bdpsys. This patch also add two oscillators that provide clocks for
MT2701.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 8343768..171d4da 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt2701-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
@@ -76,6 +77,20 @@
 		#clock-cells = <0>;
 	};
 
+	clk26m: oscillator at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	rtc32k: oscillator at 1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "rtc32k";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&gic>;
@@ -85,6 +100,26 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	topckgen: syscon at 10000000 {
+		compatible = "mediatek,mt2701-topckgen", "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	infracfg: syscon at 10001000 {
+		compatible = "mediatek,mt2701-infracfg", "syscon";
+		reg = <0 0x10001000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pericfg: syscon at 10003000 {
+		compatible = "mediatek,mt2701-pericfg", "syscon";
+		reg = <0 0x10003000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
 	watchdog: watchdog at 10007000 {
 		compatible = "mediatek,mt2701-wdt",
 			     "mediatek,mt6589-wdt";
@@ -109,6 +144,13 @@
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
+	apmixedsys: syscon at 10209000 {
+		compatible = "mediatek,mt2701-apmixedsys", "syscon";
+		reg = <0 0x10209000 0 0x1000>;
+		mediatek,hdmi-ibias = <0xa>;
+		#clock-cells = <1>;
+	};
+
 	gic: interrupt-controller at 10211000 {
 		compatible = "arm,cortex-a7-gic";
 		interrupt-controller;
-- 
1.9.1
