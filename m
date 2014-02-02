From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:41:47 +0100
Subject: [PATCH 1/2] irqchip: sunxi: Add new compatibles
Message-ID: <1391348508-9908-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Add compatibles
matching the other pattern to the irq controller driver for consistency, and
keep the older one for backward compatibility.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt  | 5 +++--
 drivers/irqchip/irq-sun4i.c                                          | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index 32cec4b..fb38f32 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -2,7 +2,8 @@ Allwinner Sunxi Interrupt Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-ic"
+- compatible : should be "allwinner,sun4i-a10-ic"
+               (Deprecated: "allwinner,sun4i-ic")
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
@@ -11,7 +12,7 @@ Required properties:
 Example:
 
 intc: interrupt-controller {
-	compatible = "allwinner,sun4i-ic";
+	compatible = "allwinner,sun4i-a10-ic";
 	reg = <0x01c20400 0x400>;
 	interrupt-controller;
 	#interrupt-cells = <1>;
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index a5438d8..6ddeb5f 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -134,6 +134,9 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+/* Deprecated */
 IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-ic", sun4i_of_init);
 
 static asmlinkage void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
-- 
1.8.4.2
