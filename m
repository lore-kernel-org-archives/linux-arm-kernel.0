From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 6 Nov 2018 14:10:58 +0530
Subject: [PATCH v3 06/13] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
Message-ID: <20181106084105.32483-7-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT binding documentation for Interrupt router driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- Dropped interrupt-parent from reqired properties description
- Updated the interrupt cells to 4.

 .../interrupt-controller/ti,sci-intr.txt      | 84 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
new file mode 100644
index 000000000000..06e69f8c812c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -0,0 +1,84 @@
+Texas Instruments K3 Interrupt Router
+=====================================
+
+The Interrupt Router (INTR) module provides a mechanism to mux M
+interrupt inputs to N interrupt outputs, where all M inputs are selectable
+to be driven per N output. There is one register per output (MUXCNTL_N) that
+controls the selection.
+
+
+                                 Interrupt Router
+                             +----------------------+
+                             |  Inputs     Outputs  |
+        +-------+            | +------+             |
+        | GPIO  |----------->| | irq0 |             |       Host IRQ
+        +-------+            | +------+             |      controller
+                             |    .        +-----+  |      +-------+
+        +-------+            |    .        |  0  |  |----->|  IRQ  |
+        | INTA  |----------->|    .        +-----+  |      +-------+
+        +-------+            |    .          .      |
+                             | +------+      .      |
+                             | | irqM |    +-----+  |
+                             | +------+    |  N  |  |
+                             |             +-----+  |
+                             +----------------------+
+
+Configuration of these MUXCNTL_N registers is done by a system controller
+(like the Device Memory and Security Controller on K3 AM654 SoC). System
+controller will keep track of the used and unused registers within the Router.
+Driver should request the system controller to get the range of GIC IRQs
+assigned to the requesting hosts. It is the drivers responsibility to keep
+track of Host IRQs.
+
+Communication between the host processor running an OS and the system
+controller happens through a protocol called TI System Control Interface
+(TISCI protocol). For more details refer:
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TISCI Interrupt Router Node:
+----------------------------
+- compatible:		Must be "ti,sci-intr".
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Specifies the number of cells needed to encode an
+			interrupt source. The value should be 4.
+			First cell should contain the TISCI device ID of source
+			Second cell should contain the interrupt source offset
+			within the device
+			Third cell specifies the trigger type as defined
+			in interrupts.txt in this directory.
+			Fourth cell should be 1 if the irq is coming from
+			interrupt aggregator else 0.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
+- ti,sci-rm-range-girq:	TISCI subtype id representing the host irqs assigned
+			to this interrupt router.
+
+For more details on TISCI IRQ resource management refer:
+http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
+
+Example:
+--------
+The following example demonstrates both interrupt router node and the consumer
+node(main gpio) on the AM654 SoC:
+
+main_intr: interrupt-controller at 1 {
+	compatible = "ti,sci-intr";
+	interrupt-controller;
+	interrupt-parent = <&gic>;
+	#interrupt-cells = <4>;
+	ti,sci = <&dmsc>;
+	ti,sci-dst-id = <56>;
+	ti,sci-rm-range-girq = <0x1>;
+};
+
+main_gpio0: gpio at 600000 {
+	...
+	interrupt-parent = <&main_intr>;
+	interrupts = <57 256 IRQ_TYPE_EDGE_RISING 0>,
+			<57 257 IRQ_TYPE_EDGE_RISING 0>,
+			<57 258 IRQ_TYPE_EDGE_RISING 0>,
+			<57 259 IRQ_TYPE_EDGE_RISING 0>,
+			<57 260 IRQ_TYPE_EDGE_RISING 0>,
+			<57 261 IRQ_TYPE_EDGE_RISING 0>;
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 88b28f6dec45..0e3aa3386287 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14739,6 +14739,7 @@ F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.19.1
