From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:25 +0100
Subject: [PATCH 01/45] ARM: at91: Document new TCB bindings
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current binding for the TCB is not flexible enough for some use cases
and prevents proper utilization of all the channels.

Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         | 32 -------------
 .../devicetree/bindings/mfd/atmel-tcb.txt          | 56 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 91cb8e4f2a4f..31220b54d85d 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -90,38 +90,6 @@ System Timer (ST) required properties:
 Its subnodes can be:
 - watchdog: compatible should be "atmel,at91rm9200-wdt"
 
-TC/TCLIB Timer required properties:
-- compatible: Should be "atmel,<chip>-tcb".
-  <chip> can be "at91rm9200" or "at91sam9x5"
-- reg: Should contain registers location and length
-- interrupts: Should contain all interrupts for the TC block
-  Note that you can specify several interrupt cells if the TC
-  block has one interrupt per channel.
-- clock-names: tuple listing input clock names.
-	Required elements: "t0_clk", "slow_clk"
-	Optional elements: "t1_clk", "t2_clk"
-- clocks: phandles to input clocks.
-
-Examples:
-
-One interrupt per TC block:
-	tcb0: timer at fff7c000 {
-		compatible = "atmel,at91rm9200-tcb";
-		reg = <0xfff7c000 0x100>;
-		interrupts = <18 4>;
-		clocks = <&tcb0_clk>;
-		clock-names = "t0_clk";
-	};
-
-One interrupt per TC channel in a TC block:
-	tcb1: timer at fffdc000 {
-		compatible = "atmel,at91rm9200-tcb";
-		reg = <0xfffdc000 0x100>;
-		interrupts = <26 4 27 4 28 4>;
-		clocks = <&tcb1_clk>;
-		clock-names = "t0_clk";
-	};
-
 RSTC Reset Controller required properties:
 - compatible: Should be "atmel,<chip>-rstc".
   <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
new file mode 100644
index 000000000000..c4a83e364cb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
@@ -0,0 +1,56 @@
+* Device tree bindings for Atmel Timer Counter Blocks
+- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
+  <chip> can be "at91rm9200" or "at91sam9x5"
+- reg: Should contain registers location and length
+- #address-cells: has to be 1
+- #size-cells: has to be 0
+- interrupts: Should contain all interrupts for the TC block
+  Note that you can specify several interrupt cells if the TC
+  block has one interrupt per channel.
+- clock-names: tuple listing input clock names.
+	Required elements: "t0_clk", "slow_clk"
+	Optional elements: "t1_clk", "t2_clk"
+- clocks: phandles to input clocks.
+
+The TCB can expose multiple subdevices:
+ * a timer
+   - compatible: Should be "atmel,tcb-timer"
+   - reg: Should contain the TCB channels to be used. If the
+     counter width is 16 bits (at91rm9200-tcb), two consecutive
+     channels are needed. Else, only one channel will be used.
+
+Examples:
+
+One interrupt per TC block:
+	tcb0: timer at fff7c000 {
+		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0xfff7c000 0x100>;
+		interrupts = <18 4>;
+		clocks = <&tcb0_clk>, <&clk32k>;
+		clock-names = "t0_clk", "slow_clk";
+
+		timer at 0 {
+			compatible = "atmel,tcb-timer";
+			reg = <0>, <1>;
+		};
+
+		timer at 2 {
+			compatible = "atmel,tcb-timer";
+			reg = <2>;
+		};
+	};
+
+One interrupt per TC channel in a TC block:
+	tcb1: timer at fffdc000 {
+		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0xfffdc000 0x100>;
+		interrupts = <26 4>, <27 4>, <28 4>;
+		clocks = <&tcb1_clk>, <&clk32k>;
+		clock-names = "t0_clk", "slow_clk";
+	};
+
+
-- 
2.15.1
