From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 25 Apr 2014 22:00:21 +0200
Subject: [RFC 2/5] clk: berlin: add berlin clock groups DT bindings
 documentation
In-Reply-To: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1398456024-27876-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree for the clocks sharing a common set of registers

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: devicetree at vger.kernel.org
 .../devicetree/bindings/clock/berlin-clock.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/berlin-clock.txt b/Documentation/devicetree/bindings/clock/berlin-clock.txt
index 49bc229827a0..6d374066d6b9 100644
--- a/Documentation/devicetree/bindings/clock/berlin-clock.txt
+++ b/Documentation/devicetree/bindings/clock/berlin-clock.txt
@@ -11,10 +11,18 @@ Required properties:
 		CPU PLL and System PLL
 	"marvell,berlin2-clk":
 		simple clocks
+	"marvell,berlin2-clkgrp":
+		clocks sharing a common set of registers
 - reg: Address and length of the clock register set.
 - #clock-cells: from common clock binding; shall be set to 0.
 - clocks: from common clock binding
 
+For the clock groups:
+- marvell,clk-switch-offset: offset in bits to the first bit related to the
+  clock in the switch registers
+- marvell,clk-select-offset: offset in bits to the first bit related to the
+  clock in the selection registers.
+
 smclk: sysmgr-clock {
 	compatible = "fixed-clock";
 	#clock-cells = <0>;
@@ -34,3 +42,24 @@ sdio0xinclk: sdio0xinclk at ea023c {
 	#clock-cells = <0>;
 	reg = <0xea023c 0x4>;
 };
+
+
+grpclk: grpclk at ea00ec {
+	compatible = "marvell,berlin-clkgrp";
+	clocks = <&syspll>;
+	reg = <0xea00f8 0x4>, <0xea00ec 0xc>;
+
+	cfgclk: cfgclk {
+		#clock-cells = <0>;
+		marvell,clk-switch-offset = <9>;
+		marvell,clk-select-offset = <12>;
+	};
+
+	nfcecccclk: nfcecccclk {
+		#clock-cells = <0>;
+		marvell,clk-switch-offset = <27>;
+		marvell,clk-select-offset = <50>;
+	};
+};
+
+
-- 
1.9.1
