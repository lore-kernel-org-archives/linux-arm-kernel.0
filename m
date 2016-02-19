From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Feb 2016 15:00:29 +0000
Subject: [PATCH] irqchip/gic: Return IRQ_SET_MASK_OK_DONE in the set_affinity
 method
Message-ID: <1455894029-17270-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving an SPI around doesn't require any extra work from the rest
of the stack, and specially not for MSI-generated SPIs.

It is then worth returning IRQ_SET_MASK_OK_DONE instead of
IRQ_SET_MASK_OK, and simplify the other irqchips that rely on
this behaviour (GICv2m and Marvell's ODMI controller).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c    | 14 +-------------
 drivers/irqchip/irq-gic.c        |  2 +-
 drivers/irqchip/irq-mvebu-odmi.c | 14 +-------------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index c779f83..28f047c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -92,18 +92,6 @@ static struct msi_domain_info gicv2m_msi_domain_info = {
 	.chip	= &gicv2m_msi_irq_chip,
 };
 
-static int gicv2m_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
-{
-	int ret;
-
-	ret = irq_chip_set_affinity_parent(irq_data, mask, force);
-	if (ret == IRQ_SET_MASK_OK)
-		ret = IRQ_SET_MASK_OK_DONE;
-
-	return ret;
-}
-
 static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
@@ -122,7 +110,7 @@ static struct irq_chip gicv2m_irq_chip = {
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= gicv2m_set_affinity,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_compose_msi_msg	= gicv2m_compose_msi_msg,
 };
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8f9ebf7..282344b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -319,7 +319,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	writel_relaxed(val | bit, reg);
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
-	return IRQ_SET_MASK_OK;
+	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
 
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 0ae98b2..b4d3678 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -47,18 +47,6 @@ static unsigned int odmis_count;
 /* Protects odmis_bm */
 static DEFINE_SPINLOCK(odmis_bm_lock);
 
-static int odmi_set_affinity(struct irq_data *d,
-			     const struct cpumask *mask, bool force)
-{
-	int ret;
-
-	ret = irq_chip_set_affinity_parent(d, mask, force);
-	if (ret == IRQ_SET_MASK_OK)
-		ret = IRQ_SET_MASK_OK_DONE;
-
-	return ret;
-}
-
 static void odmi_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct odmi_data *odmi;
@@ -83,7 +71,7 @@ static struct irq_chip odmi_irq_chip = {
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= odmi_set_affinity,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_compose_msi_msg	= odmi_compose_msi_msg,
 };
 
-- 
2.1.4
