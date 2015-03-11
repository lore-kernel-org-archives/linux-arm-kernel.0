From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:43:48 +0000
Subject: [PATCH v6 6/7] DT: omap4/5: add binding for the wake-up generator
In-Reply-To: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
References: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088629-15377-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for the OMAP4/5 wake-up generator, which acts as
an interrupt controller feeding into the GIC.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../interrupt-controller/ti,omap4-wugen-mpu        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
new file mode 100644
index 0000000..43effa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
@@ -0,0 +1,33 @@
+TI OMAP4 Wake-up Generator
+
+All TI OMAP4/5 (and their derivatives) an interrupt controller that
+routes interrupts to the GIC, and also serves as a wakeup source. It
+is also referred to as "WUGEN-MPU", hence the name of the binding.
+
+Reguired properties:
+
+- compatible : should contain at least "ti,omap4-wugen-mpu" or
+  "ti,omap5-wugen-mpu"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value must be 3.
+- interrupt-parent : a phandle to the GIC these interrupts are routed
+  to.
+
+Notes:
+
+- Because this HW ultimately routes interrupts to the GIC, the
+  interrupt specifier must be that of the GIC.
+- Only SPIs can use the WUGEN as an interrupt parent. SGIs and PPIs
+  are explicitly forbiden.
+
+Example:
+
+       wakeupgen: interrupt-controller at 48281000 {
+               compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
+               interrupt-controller;
+               #interrupt-cells = <3>;
+               reg = <0x48281000 0x1000>;
+               interrupt-parent = <&gic>;
+       };
-- 
2.1.4
