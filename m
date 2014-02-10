From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 17:00:02 -0300
Subject: [PATCH 2/2] irqchip: armada-370-xp: Setup a chained handler for the
 MPIC
In-Reply-To: <1392062402-27357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392062402-27357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392062402-27357-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new Armada 375 and Armada 38x Marvell SoCs are based on Cortex-A9
CPU cores and use the ARM GIC as their main interrupt controller.
However, for various purposes (wake-up from suspend, MSI interrupts),
they have kept a separate MPIC interrupt controller, acting as a slave
to the GIC. This MPIC was already used as the primary controller on
previous Marvell SoCs, so this commit extends the existing driver to
allow the MPIC to be used as a GIC slave.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |  8 +++-
 drivers/irqchip/irq-armada-370-xp.c                | 50 +++++++++++++++++++---
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
index d74091a..5fc0313 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
@@ -1,4 +1,4 @@
-Marvell Armada 370 and Armada XP Interrupt Controller
+Marvell Armada 370, 375, 38x, XP Interrupt Controller
 -----------------------------------------------------
 
 Required properties:
@@ -16,7 +16,13 @@ Required properties:
   automatically map to the interrupt controller registers of the
   current CPU)
 
+Optional properties:
 
+- interrupts: If defined, then it indicates that this MPIC is
+  connected as a slave to another interrupt controller. This is
+  typically the case on Armada 375 and Armada 38x, where the MPIC is
+  connected as a slave to the Cortex-A9 GIC. The provided interrupt
+  indicate to which GIC interrupt the MPIC output is connected.
 
 Example:
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 2ba5761..cd79503 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -42,6 +43,7 @@
 #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
 
 #define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
+#define ARMADA_375_PPI_CAUSE			(0x10)
 
 #define ARMADA_370_XP_SW_TRIG_INT_OFFS           (0x4)
 #define ARMADA_370_XP_IN_DRBEL_MSK_OFFS          (0xc)
@@ -353,7 +355,7 @@ static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 };
 
 #ifdef CONFIG_PCI_MSI
-static void armada_370_xp_handle_msi_irq(struct pt_regs *regs)
+static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 {
 	u32 msimask, msinr;
 
@@ -373,13 +375,41 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs)
 
 		irq = irq_find_mapping(armada_370_xp_msi_domain,
 				       msinr - 16);
-		handle_IRQ(irq, regs);
+
+		if (is_chained)
+			generic_handle_irq(irq);
+		else
+			handle_IRQ(irq, regs);
 	}
 }
 #else
-static void armada_370_xp_handle_msi_irq(struct pt_regs *r) {}
+static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
 #endif
 
+static void armada_370_xp_mpic_handle_cascade_irq(unsigned int irq,
+						  struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_get_chip(irq);
+	unsigned long irqmap, irqn;
+	unsigned int cascade_irq;
+
+	chained_irq_enter(chip, desc);
+
+	irqmap = readl_relaxed(per_cpu_int_base + ARMADA_375_PPI_CAUSE);
+
+	if (irqmap & BIT(0)) {
+		armada_370_xp_handle_msi_irq(NULL, true);
+		irqmap &= ~BIT(0);
+	}
+
+	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
+		cascade_irq = irq_find_mapping(armada_370_xp_mpic_domain, irqn);
+		generic_handle_irq(cascade_irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 static asmlinkage void __exception_irq_entry
 armada_370_xp_handle_irq(struct pt_regs *regs)
 {
@@ -402,7 +432,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 
 		/* MSI handling */
 		if (irqnr == 1)
-			armada_370_xp_handle_msi_irq(regs);
+			armada_370_xp_handle_msi_irq(regs, false);
 
 #ifdef CONFIG_SMP
 		/* IPI Handling */
@@ -433,6 +463,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
+	int parent_irq;
 	u32 control;
 
 	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
@@ -461,8 +492,6 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 
 	BUG_ON(!armada_370_xp_mpic_domain);
 
-	irq_set_default_host(armada_370_xp_mpic_domain);
-
 #ifdef CONFIG_SMP
 	armada_xp_mpic_smp_cpu_init();
 
@@ -478,7 +507,14 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 
 	armada_370_xp_msi_init(node, main_int_res.start);
 
-	set_handle_irq(armada_370_xp_handle_irq);
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (parent_irq <= 0) {
+		irq_set_default_host(armada_370_xp_mpic_domain);
+		set_handle_irq(armada_370_xp_handle_irq);
+	} else {
+		irq_set_chained_handler(parent_irq,
+					armada_370_xp_mpic_handle_cascade_irq);
+	}
 
 	return 0;
 }
-- 
1.8.1.5
