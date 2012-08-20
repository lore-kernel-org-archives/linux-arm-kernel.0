From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Aug 2012 11:53:36 +0100
Subject: [PATCH] mfd: ab8500: Make ab8500_irq_get_virq() static
Message-ID: <1345460017-404-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MFD core now takes care of  HWIRQ <-> VIRQ mapping, so the helper
ab8500_irq_get_virq() is no longer used by ab8500 subordinate devices
to obtain a Linux wide Virtual IRQ. The AB8500 IRQ controller still
uses it internally though, so we'll just hide it from the rest of the
world by making it static instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c         |   33 ++++++++++++++++-----------------
 include/linux/mfd/abx500/ab8500.h |    2 --
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 71a7757..020c1a8 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -472,6 +472,22 @@ static irqreturn_t ab8500_hierarchical_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+/**
+ * ab8500_irq_get_virq(): Map an interrupt on a chip to a virtual IRQ
+ *
+ * @ab8500: ab8500_irq controller to operate on.
+ * @irq: index of the interrupt requested in the chip IRQs
+ *
+ * Useful for drivers to request their own IRQs.
+ */
+static int ab8500_irq_get_virq(struct ab8500 *ab8500, int irq)
+{
+	if (!ab8500)
+		return -EINVAL;
+
+	return irq_create_mapping(ab8500->domain, irq);
+}
+
 static irqreturn_t ab8500_irq(int irq, void *dev)
 {
 	struct ab8500 *ab8500 = dev;
@@ -512,23 +528,6 @@ static irqreturn_t ab8500_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-/**
- * ab8500_irq_get_virq(): Map an interrupt on a chip to a virtual IRQ
- *
- * @ab8500: ab8500_irq controller to operate on.
- * @irq: index of the interrupt requested in the chip IRQs
- *
- * Useful for drivers to request their own IRQs.
- */
-int ab8500_irq_get_virq(struct ab8500 *ab8500, int irq)
-{
-	if (!ab8500)
-		return -EINVAL;
-
-	return irq_create_mapping(ab8500->domain, irq);
-}
-EXPORT_SYMBOL_GPL(ab8500_irq_get_virq);
-
 static int ab8500_irq_map(struct irq_domain *d, unsigned int virq,
 				irq_hw_number_t hwirq)
 {
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 3764cb6..1491044 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -341,6 +341,4 @@ static inline int is_ab8500_2p0(struct ab8500 *ab)
 	return (is_ab8500(ab) && (ab->chip_id == AB8500_CUT2P0));
 }
 
-int ab8500_irq_get_virq(struct ab8500 *ab8500, int irq);
-
 #endif /* MFD_AB8500_H */
-- 
1.7.9.5
