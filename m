From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Jun 2017 16:19:19 +0200
Subject: [PATCH v3 2/6] dt-bindings: interrupt-controller: add DT binding for
 the Marvell ICU
In-Reply-To: <20170616141923.31226-1-thomas.petazzoni@free-electrons.com>
References: <20170616141923.31226-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170616141923.31226-3-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree binding documentation for the Marvell
ICU interrupt controller, which collects wired interrupts from the
devices located into the CP110 hardware block of Marvell Armada 7K/8K,
and converts them into SPI interrupts in the GIC located in the AP
hardware block, using the GICP extension.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/interrupt-controller/marvell,icu.txt  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
new file mode 100644
index 0000000..aa8bf2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
@@ -0,0 +1,51 @@
+Marvell ICU Interrupt Controller
+--------------------------------
+
+The Marvell ICU (Interrupt Consolidation Unit) controller is
+responsible for collecting all wired-interrupt sources in the CP and
+communicating them to the GIC in the AP, the unit translates interrupt
+requests on input wires to MSG memory mapped transactions to the GIC.
+
+Required properties:
+
+- compatible: Should be "marvell,cp110-icu"
+
+- reg: Should contain ICU registers location and length.
+
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 3.
+
+  The 1st cell is the group type of the ICU interrupt. Possible group
+  types are:
+
+   ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
+   ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
+   ICU_GRP_SEI (0x4) : System error interrupt
+   ICU_GRP_REI (0x5) : RAM error interrupt
+
+  The 2nd cell is the index of the interrupt in the ICU unit.
+
+  The 3rd cell is the type of the interrupt. See arm,gic.txt for
+  details.
+
+- interrupt-controller: Identifies the node as an interrupt
+  controller.
+
+- msi-parent: Should point to the GICP controller, the GIC extension
+  that allows to trigger interrupts using MSG memory mapped
+  transactions.
+
+Example:
+
+icu: interrupt-controller at 1e0000 {
+	compatible = "marvell,cp110-icu";
+	reg = <0x1e0000 0x10>;
+	#interrupt-cells = <3>;
+	interrupt-controller;
+	msi-parent = <&gicp>;
+};
+
+usb3h0: usb3 at 500000 {
+	interrupt-parent = <&icu>;
+	interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.9.4
