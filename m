From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 26 Nov 2018 11:03:53 +0100
Subject: [PATCH v3 1/4] dt-bindings: interrupt-controller: Actions external
 interrupt controller
In-Reply-To: <20181126100356.2840578-1-pn@denx.de>
References: <20181126100356.2840578-1-pn@denx.de>
Message-ID: <20181126100356.2840578-2-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actions Semi OWL family SoC's provides support for external interrupt
controller to be connected and controlled using SIRQ pins. S500, S700
and S900 provides 3 SIRQ lines and works independently for 3 external
interrupt controllers.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../interrupt-controller/actions,owl-sirq.txt | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
new file mode 100644
index 000000000000..b3adc4bddf40
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
@@ -0,0 +1,57 @@
+Actions Semi Owl SoCs SIRQ interrupt controller
+
+S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
+in which external interrupt controller can be connected. 3 SPI's
+45, 46, 47 from GIC are directly exposed as SIRQ. It has
+the following properties:
+
+- inputs three interrupt signal from external interrupt controller
+
+Required properties:
+
+- compatible: should be "actions,owl-sirq"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 2.
+- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
+  details are maintained at same offset/register.
+- actions,sirq-reg-offset: register offset for SIRQ interrupts. When registers are
+  shared, all the three offsets will be same (S500 and S700).
+- actions,ext-irq-range: Identifies external irq number range in different SoCs.
+
+Example for S900:
+
+sirq: interrupt-controller at e01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0x0 0xe01b0000 0x0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	actions,sirq-offset = <0x200 0x528 0x52c>;
+	actions,ext-irq-range = <13 15>;
+};
+
+Example for S700:
+
+sirq: interrupt-controller at e01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0x0 0xe01b0000 0x0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	actions,sirq-shared-reg;
+	actions,sirq-reg-offset = <0x200 0x200 0x200>;
+	actions,ext-irq-range = <13 15>;
+};
+
+Example for S500:
+
+sirq: interrupt-controller at b01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0x0 0xb01b0000 0x0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	actions,sirq-shared-reg;
+	actions,sirq-offset = <0x200 0x200 0x200>;
+	actions,ext-irq-range = <13 15>;
+};
-- 
2.17.2
