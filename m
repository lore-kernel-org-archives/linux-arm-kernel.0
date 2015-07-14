From: eric@anholt.net (Eric Anholt)
Date: Mon, 13 Jul 2015 18:35:16 -0700
Subject: [PATCH v2 2/4] irqchip: bcm2835: If a parent interrupt is registered,
 chain from it.
In-Reply-To: <1436837718-956-1-git-send-email-eric@anholt.net>
References: <1436837718-956-1-git-send-email-eric@anholt.net>
Message-ID: <1436837718-956-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2836 (Raspberry Pi 2) uses two levels of interrupt handling
with the CPU-local interrupts being the root, so we need to register
ours as chained off of the CPU's local interrupt.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../brcm,bcm2835-armctrl-ic.txt                    | 22 ++++++++++++++++++++++
 drivers/irqchip/irq-bcm2835.c                      | 20 ++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
index 7da578d..8363bc4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
@@ -5,6 +5,10 @@ The BCM2835 contains a custom top-level interrupt controller, which supports
 controller, or the HW block containing it, is referred to occasionally
 as "armctrl" in the SoC documentation, hence naming of this binding.
 
+The BCM2836 contains the same interrupt controller with the same
+interrupts, but the per-CPU interrupt controller is the root, and an
+interrupt there indicates that the ARMCTRL has an interrupt to handle.
+
 Required properties:
 
 - compatible : should be "brcm,bcm2835-armctrl-ic"
@@ -20,6 +24,12 @@ Required properties:
   The 2nd cell contains the interrupt number within the bank. Valid values
   are 0..7 for bank 0, and 0..31 for bank 1.
 
+Optional properties:
+- interrupt-parent : Specifies the parent interrupt controller when this
+  controller is the second level.
+- interrupts : Specifies the interrupt on the parent for this interrupt
+  controller to handle.
+
 The interrupt sources are as follows:
 
 Bank 0:
@@ -102,9 +112,21 @@ Bank 2:
 
 Example:
 
+/* BCM2835, first level */
+intc: interrupt-controller {
+	compatible = "brcm,bcm2835-armctrl-ic";
+	reg = <0x7e00b200 0x200>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
+/* BCM2836, second level */
 intc: interrupt-controller {
 	compatible = "brcm,bcm2835-armctrl-ic";
 	reg = <0x7e00b200 0x200>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
+
+	interrupt-parent = <&local_intc>;
+	interrupts = <8>;
 };
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 382450a..dc6b159 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -97,6 +97,7 @@ struct armctrl_ic {
 static struct armctrl_ic intc __read_mostly;
 static void __exception_irq_entry bcm2835_handle_irq(
 	struct pt_regs *regs);
+static void bcm2835_chained_handle_irq(unsigned int irq, struct irq_desc *desc);
 
 static void armctrl_mask_irq(struct irq_data *d)
 {
@@ -143,7 +144,7 @@ static int __init armctrl_of_init(struct device_node *node,
 	struct device_node *parent)
 {
 	void __iomem *base;
-	int irq, b, i;
+	int irq, parent_irq, b, i;
 
 	base = of_iomap(node, 0);
 	if (!base)
@@ -169,7 +170,14 @@ static int __init armctrl_of_init(struct device_node *node,
 		}
 	}
 
-	set_handle_irq(bcm2835_handle_irq);
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		/* No parent IRQ, so we're the root interrupt controller */
+		set_handle_irq(bcm2835_handle_irq);
+	} else {
+		irq_set_chained_handler(parent_irq, bcm2835_chained_handle_irq);
+	}
+
 	return 0;
 }
 
@@ -220,4 +228,12 @@ static void __exception_irq_entry bcm2835_handle_irq(
 		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
 }
 
+static void bcm2835_chained_handle_irq(unsigned int irq, struct irq_desc *desc)
+{
+	u32 hwirq;
+
+	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
+		generic_handle_irq(irq_linear_revmap(intc.domain, hwirq));
+}
+
 IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic", armctrl_of_init);
-- 
2.1.4
