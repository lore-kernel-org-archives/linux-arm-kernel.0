From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 25 Apr 2016 04:00:23 +0300
Subject: [PATCH v2 1/4] dt-bindings: interrupt-controllers: add description of
 SIC1 and SIC2
In-Reply-To: <1461545990-25560-1-git-send-email-vz@mleia.com>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
Message-ID: <1461546023-25614-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx has three interrupt controllers, namely root Main
Interrupt Controller (MIC) and two supplementary Sub Interrupt
Controllers (SIC1 and SIC2), four interrupt outputs from SIC1 and SIC2
are connected to MIC.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* removed introduced optional "interrupt-controller-name" property,
  for users the name of a controller will be constructed from mic/sic
  and controller physical address,
* removed introduced optional "wakeup-sources" property, a list of
  mappings between a hardware interrupt and its correspondent wakeup source
  to exit CPU STOP mode will be discussed later on,
* other negligible changes (rewording, small letters in unit address etc.)

 .../interrupt-controller/nxp,lpc3220-mic.txt       | 70 ++++++++++++++--------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
index 539adca..38211f3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
@@ -1,38 +1,60 @@
-* NXP LPC32xx Main Interrupt Controller
-  (MIC, including SIC1 and SIC2 secondary controllers)
+* NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
 
 Required properties:
-- compatible: Should be "nxp,lpc3220-mic"
-- interrupt-controller: Identifies the node as an interrupt controller.
-- interrupt-parent: Empty for the interrupt controller itself
-- #interrupt-cells: The number of cells to define the interrupts. Should be 2.
-  The first cell is the IRQ number
-  The second cell is used to specify mode:
-      1 = low-to-high edge triggered
-      2 = high-to-low edge triggered
-      4 = active high level-sensitive
-      8 = active low level-sensitive
-      Default for internal sources should be set to 4 (active high).
-- reg: Should contain MIC registers location and length
+- compatible: "nxp,lpc3220-mic" or "nxp,lpc3220-sic".
+- reg: should contain IC registers location and length.
+- interrupt-controller: identifies the node as an interrupt controller.
+- #interrupt-cells: the number of cells to define an interrupt, should be 2.
+  The first cell is the IRQ number, the second cell is used to specify
+  one of the supported IRQ types:
+      IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
+      IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
+      IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
+      IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
+  Reset value is IRQ_TYPE_LEVEL_LOW.
+
+Optional properties:
+- interrupt-parent: empty for MIC interrupt controller, link to parent
+  MIC interrupt controller for SIC1 and SIC2
+- interrupts: empty for MIC interrupt controller, cascaded MIC
+  hardware interrupts for SIC1 and SIC2
 
 Examples:
-	/*
-	 * MIC
-	 */
+
+	/* LPC32xx MIC, SIC1 and SIC2 interrupt controllers */
 	mic: interrupt-controller at 40008000 {
 		compatible = "nxp,lpc3220-mic";
+		reg = <0x40008000 0x4000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sic1: interrupt-controller at 4000c000 {
+		compatible = "nxp,lpc3220-sic";
+		reg = <0x4000c000 0x4000>;
 		interrupt-controller;
-		interrupt-parent;
 		#interrupt-cells = <2>;
-		reg = <0x40008000 0xC000>;
+
+		interrupt-parent = <&mic>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
+			     <30 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	/*
-	 * ADC
-	 */
+	sic2: interrupt-controller at 40010000 {
+		compatible = "nxp,lpc3220-sic";
+		reg = <0x40010000 0x4000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&mic>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
+			     <31 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	/* ADC */
 	adc at 40048000 {
 		compatible = "nxp,lpc3220-adc";
 		reg = <0x40048000 0x1000>;
-		interrupt-parent = <&mic>;
-		interrupts = <39 4>;
+		interrupt-parent = <&sic1>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
2.1.4
