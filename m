From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Feb 2016 15:47:00 +0100
Subject: [PATCH v3 5/6] irqchip: irq-armada-370-xp: allow allocation of
 multiple MSIs
In-Reply-To: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455115621-22846-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for allocating multiple MSIs at the same time, so that the
MSI_FLAG_MULTI_PCI_MSI flag can be added to the msi_domain_info
structure.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index c99ae5f..e7dc6cb 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -123,7 +123,8 @@ static struct irq_chip armada_370_xp_msi_irq_chip = {
 };
 
 static struct msi_domain_info armada_370_xp_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_MULTI_PCI_MSI),
 	.chip	= &armada_370_xp_msi_irq_chip,
 };
 
@@ -149,21 +150,26 @@ static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
 static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
-	int hwirq;
+	int hwirq, i;
 
 	mutex_lock(&msi_used_lock);
-	hwirq = find_first_zero_bit(&msi_used, PCI_MSI_DOORBELL_NR);
+
+	hwirq = bitmap_find_next_zero_area(msi_used, PCI_MSI_DOORBELL_NR,
+					   0, nr_irqs, 0);
 	if (hwirq >= PCI_MSI_DOORBELL_NR) {
 		mutex_unlock(&msi_used_lock);
 		return -ENOSPC;
 	}
 
-	set_bit(hwirq, msi_used);
+	bitmap_set(msi_used, hwirq, nr_irqs);
 	mutex_unlock(&msi_used_lock);
 
-	irq_domain_set_info(domain, virq, hwirq, &armada_370_xp_msi_bottom_irq_chip,
-			    domain->host_data, handle_simple_irq,
-			    NULL, NULL);
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &armada_370_xp_msi_bottom_irq_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+	}
 
 	return hwirq;
 }
@@ -174,10 +180,7 @@ static void armada_370_xp_msi_free(struct irq_domain *domain,
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 
 	mutex_lock(&msi_used_lock);
-	if (!test_bit(d->hwirq, msi_used))
-		pr_err("trying to free unused MSI#%lu\n", d->hwirq);
-	else
-		clear_bit(d->hwirq, msi_used);
+	bitmap_clear(msi_used, d->hwirq, nr_irqs);
 	mutex_unlock(&msi_used_lock);
 }
 
-- 
2.6.4
