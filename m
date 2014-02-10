From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 17:00:01 -0300
Subject: [PATCH 1/2] irqchip: armada-370-xp: Add helper for the MSI IRQ
 handling
In-Reply-To: <1392062402-27357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392062402-27357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392062402-27357-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a helper function to handle the MSI interrupts. This makes
the code more readable. In addition, this will allow to introduce a
chained IRQ handler mechanism, which is needed in situations where the
MPIC is used as a slave to another interrupt controller.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 54 ++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5409564..2ba5761 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -352,6 +352,34 @@ static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+#ifdef CONFIG_PCI_MSI
+static void armada_370_xp_handle_msi_irq(struct pt_regs *regs)
+{
+	u32 msimask, msinr;
+
+	msimask = readl_relaxed(per_cpu_int_base +
+				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
+		& PCI_MSI_DOORBELL_MASK;
+
+	writel(~msimask, per_cpu_int_base +
+	       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+
+	for (msinr = PCI_MSI_DOORBELL_START;
+	     msinr < PCI_MSI_DOORBELL_END; msinr++) {
+		int irq;
+
+		if (!(msimask & BIT(msinr)))
+			continue;
+
+		irq = irq_find_mapping(armada_370_xp_msi_domain,
+				       msinr - 16);
+		handle_IRQ(irq, regs);
+	}
+}
+#else
+static void armada_370_xp_handle_msi_irq(struct pt_regs *r) {}
+#endif
+
 static asmlinkage void __exception_irq_entry
 armada_370_xp_handle_irq(struct pt_regs *regs)
 {
@@ -372,31 +400,9 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			continue;
 		}
 
-#ifdef CONFIG_PCI_MSI
 		/* MSI handling */
-		if (irqnr == 1) {
-			u32 msimask, msinr;
-
-			msimask = readl_relaxed(per_cpu_int_base +
-						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
-				& PCI_MSI_DOORBELL_MASK;
-
-			writel(~msimask, per_cpu_int_base +
-			       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
-
-			for (msinr = PCI_MSI_DOORBELL_START;
-			     msinr < PCI_MSI_DOORBELL_END; msinr++) {
-				int irq;
-
-				if (!(msimask & BIT(msinr)))
-					continue;
-
-				irq = irq_find_mapping(armada_370_xp_msi_domain,
-						       msinr - 16);
-				handle_IRQ(irq, regs);
-			}
-		}
-#endif
+		if (irqnr == 1)
+			armada_370_xp_handle_msi_irq(regs);
 
 #ifdef CONFIG_SMP
 		/* IPI Handling */
-- 
1.8.1.5
