From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 22 May 2018 11:40:39 +0200
Subject: [PATCH v2 13/16] dt-bindings/interrupt-controller: add documentation
 for Marvell SEI controller
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Message-ID: <20180522094042.24770-14-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the System Error Interrupt (SEI) controller. It aggregates two
types of interrupts, wired and MSIs from respectively the AP and the
CPs, into a single SPI interrupt.

Suggested-by: Haim Boot <hayim@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/interrupt-controller/marvell,sei.txt  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
new file mode 100644
index 000000000000..689981036c30
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
@@ -0,0 +1,50 @@
+Marvell SEI (System Error Interrupt) Controller
+-----------------------------------------------
+
+Marvell SEI (System Error Interrupt) controller is an interrupt
+aggregator. It receives interrupts from several sources and aggregates
+them to a single interrupt line (an SPI) on the parent interrupt
+controller.
+
+This interrupt controller can handle up to 64 SEIs, a set comes from the
+AP and is wired while a second set comes from the CPs by the mean of
+MSIs. Each 'domain' is represented as a subnode.
+
+Required properties:
+
+- compatible: should be "marvell,armada-8k-sei".
+- reg: SEI registers location and length.
+- interrupts: identifies the parent IRQ that will be triggered.
+
+Child node 'sei-wired-controller' required properties:
+
+- marvell,sei-ranges: ranges of wired interrupts.
+- #interrupt-cells: number of cells to define an SEI wired interrupt
+                    coming from the AP, should be 1. The cell is the IRQ
+                    number.
+- interrupt-controller: identifies the node as an interrupt controller.
+
+Child node 'sei-msi-controller' required properties:
+
+- marvell,sei-ranges: ranges of non-wired interrupts triggered by way of
+                      MSIs.
+- msi-controller: identifies the node as an MSI controller.
+
+Example:
+
+        sei: sei at 3f0200 {
+               compatible = "marvell,armada-8k-sei";
+               reg = <0x3f0200 0x40>;
+               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+
+               sei_wired_controller: sei-wired-controller at 0 {
+                       marvell,sei-ranges = <0 21>;
+                       #interrupt-cells = <1>;
+                       interrupt-controller;
+               };
+
+               sei_msi_controller: sei-msi-controller at 21 {
+                       marvell,sei-ranges = <21 43>;
+                       msi-controller;
+               };
+       };
-- 
2.14.1
