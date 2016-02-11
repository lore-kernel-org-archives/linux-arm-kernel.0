From: ashoks@broadcom.com (Ashok Kumar)
Date: Thu, 11 Feb 2016 05:38:53 -0800
Subject: [PATCH] irqchip/gic-v3-its: Fix double EOIR write for LPI in
 EOImode==1
Message-ID: <1455197933-26141-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU receives SError exception EOI1_NO_INTS_ACTIVE when EOIR
is written twice in gic_handle_irq and in its_eoi_irq for a
single LPI in EOImode == 1.

Now irq_eoi of its_irq_chip calls parent irqchip's(gic_eoimode1_chip/gic_chip)
irq_eoi handler which handles EOImode 0 and 1 separately.

This is introduced by
commit 0b996fd35957a ("irqchip/GICv3: Convert to EOImode == 1")

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e23d1d1..a159529f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -597,11 +597,6 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_set_config(d, true);
 }
 
-static void its_eoi_irq(struct irq_data *d)
-{
-	gic_write_eoir(d->hwirq);
-}
-
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
@@ -638,7 +633,7 @@ static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
 	.irq_unmask		= its_unmask_irq,
-	.irq_eoi		= its_eoi_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 };
-- 
2.1.0
