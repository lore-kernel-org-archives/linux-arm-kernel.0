From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:40:52 +0800
Subject: [PATCH 02/12] arm64: dts: mt7622: add clock controller device nodes
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <b0ba541de4018f4f832267a94c1ab30a0e0cd8d8.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add clock controller nodes for MT7622 and include header for topckgen,
infracfg, pericfg, apmixedsys, ethsys, sgmiisys, pciesys and ssusbsys
for those devices nodes to be added afterwards.

In addition, provides an oscillator node for the source of PLLs and dummy
clock for PWARP to complement missing support of clock gate for the
wrapper circuit in the driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index b111fec..9730f0e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -8,6 +8,8 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mt7622-clk.h>
+#include <dt-bindings/reset/mt7622-reset.h>
 
 / {
 	compatible = "mediatek,mt7622";
@@ -48,6 +50,19 @@
 		clock-frequency = <280000000>;
 	};
 
+	pwrap_clk: dummy40m {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		#clock-cells = <0>;
+	};
+
+	clk25m: oscillator at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
 	psci {
 		compatible  = "arm,psci-0.2";
 		method      = "smc";
@@ -78,6 +93,22 @@
 			      IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	infracfg: infracfg at 10000000 {
+		compatible = "mediatek,mt7622-infracfg",
+			     "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pericfg: pericfg at 10002000 {
+		compatible = "mediatek,mt7622-pericfg",
+			     "syscon";
+		reg = <0 0x10002000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
 	sysirq: interrupt-controller at 10200620 {
 		compatible = "mediatek,mt7622-sysirq",
 			     "mediatek,mt6577-sysirq";
@@ -87,6 +118,20 @@
 		reg = <0 0x10200620 0 0x20>;
 	};
 
+	apmixedsys: apmixedsys at 10209000 {
+		compatible = "mediatek,mt7622-apmixedsys",
+			     "syscon";
+		reg = <0 0x10209000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	topckgen: topckgen at 10210000 {
+		compatible = "mediatek,mt7622-topckgen",
+			     "syscon";
+		reg = <0 0x10210000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	gic: interrupt-controller at 10300000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -107,4 +152,35 @@
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
+
+	ssusbsys: ssusbsys at 1a000000 {
+		compatible = "mediatek,mt7622-ssusbsys",
+			     "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pciesys: pciesys at 1a100800 {
+		compatible = "mediatek,mt7622-pciesys",
+			     "syscon";
+		reg = <0 0x1a100800 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	ethsys: syscon at 1b000000 {
+		compatible = "mediatek,mt7622-ethsys",
+			     "syscon";
+		reg = <0 0x1b000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	sgmiisys: sgmiisys at 1b128000 {
+		compatible = "mediatek,mt7622-sgmiisys",
+			     "syscon";
+		reg = <0 0x1b128000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
2.7.4
