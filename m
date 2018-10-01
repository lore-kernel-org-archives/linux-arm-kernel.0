From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:54 +0200
Subject: [PATCH v6 10/14] dt-bindings/interrupt-controller: update Marvell ICU
 bindings
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-11-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the documentation to reflect the new bindings used for Marvell
ICU. This involves describing each interrupt group as a subnode of the
ICU node. Each of them having their own compatible.

The DT binding documentation still documents the legacy binding, where
there was a single node with no subnode.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/marvell,icu.txt      | 85 ++++++++++++++++---
 1 file changed, 73 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
index 649b7ec9d9b1..1c94a57a661e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
@@ -5,6 +5,8 @@ The Marvell ICU (Interrupt Consolidation Unit) controller is
 responsible for collecting all wired-interrupt sources in the CP and
 communicating them to the GIC in the AP, the unit translates interrupt
 requests on input wires to MSG memory mapped transactions to the GIC.
+These messages will access a different GIC memory area depending on
+their type (NSR, SR, SEI, REI, etc).
 
 Required properties:
 
@@ -12,20 +14,23 @@ Required properties:
 
 - reg: Should contain ICU registers location and length.
 
+Subnodes: Each group of interrupt is declared as a subnode of the ICU,
+with their own compatible.
+
+Required properties for the icu_nsr/icu_sei subnodes:
+
+- compatible: Should be one of:
+              * "marvell,cp110-icu-nsr"
+	      * "marvell,cp110-icu-sr"
+	      * "marvell,cp110-icu-sei"
+	      * "marvell,cp110-icu-rei"
+
 - #interrupt-cells: Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 3.
+  interrupt source. The value shall be 2.
 
-  The 1st cell is the group type of the ICU interrupt. Possible group
-  types are:
+  The 1st cell is the index of the interrupt in the ICU unit.
 
-   ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
-   ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
-   ICU_GRP_SEI (0x4) : System error interrupt
-   ICU_GRP_REI (0x5) : RAM error interrupt
-
-  The 2nd cell is the index of the interrupt in the ICU unit.
-
-  The 3rd cell is the type of the interrupt. See arm,gic.txt for
+  The 2nd cell is the type of the interrupt. See arm,gic.txt for
   details.
 
 - interrupt-controller: Identifies the node as an interrupt
@@ -35,17 +40,73 @@ Required properties:
   that allows to trigger interrupts using MSG memory mapped
   transactions.
 
+Note: each 'interrupts' property referring to any 'icu_xxx' node shall
+      have a different number within [0:206].
+
 Example:
 
 icu: interrupt-controller at 1e0000 {
 	compatible = "marvell,cp110-icu";
 	reg = <0x1e0000 0x440>;
+
+	CP110_LABEL(icu_nsr): interrupt-controller at 10 {
+		compatible = "marvell,cp110-icu-nsr";
+		reg = <0x10 0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		msi-parent = <&gicp>;
+	};
+
+	CP110_LABEL(icu_sei): interrupt-controller at 50 {
+		compatible = "marvell,cp110-icu-sei";
+		reg = <0x50 0x10>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		msi-parent = <&sei>;
+	};
+};
+
+node1 {
+	interrupt-parent = <&icu_nsr>;
+	interrupts = <106 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+node2 {
+	interrupt-parent = <&icu_sei>;
+	interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+/* Would not work with the above nodes */
+node3 {
+	interrupt-parent = <&icu_nsr>;
+	interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+The legacy bindings were different in this way:
+
+- #interrupt-cells: The value was 3.
+	The 1st cell was the group type of the ICU interrupt. Possible
+	group types were:
+	ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
+	ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
+	ICU_GRP_SEI (0x4) : System error interrupt
+	ICU_GRP_REI (0x5) : RAM error interrupt
+	The 2nd cell was the index of the interrupt in the ICU unit.
+	The 3rd cell was the type of the interrupt. See arm,gic.txt for
+	details.
+
+Example:
+
+icu: interrupt-controller at 1e0000 {
+	compatible = "marvell,cp110-icu";
+	reg = <0x1e0000 0x440>;
+
 	#interrupt-cells = <3>;
 	interrupt-controller;
 	msi-parent = <&gicp>;
 };
 
-usb3h0: usb3 at 500000 {
+node1 {
 	interrupt-parent = <&icu>;
 	interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
2.17.1
