From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 10:51:23 +0000
Subject: [PATCH 2/3] irqchip: gicv3-its: Move some alloc/free code to
 activate/deactivate
In-Reply-To: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
References: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1418381484-4394-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ITS code could do a bit less in the alloc/free paths, and a bit
more in the activate/deactivate methods, giving a better separation
between software allocation and HW programing.

Suggested-by: Wuyun Wu (Abel) <wuyun.wu@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ab01852..98144fd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1102,9 +1102,6 @@ static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
 	*hwirq = dev->lpi_base + idx;
 	set_bit(idx, dev->lpi_map);
 
-	/* Map the GIC irq ID to the device */
-	its_send_mapvi(dev, *hwirq, idx);
-
 	return 0;
 }
 
@@ -1191,6 +1188,26 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
+static void its_irq_domain_activate(struct irq_domain *domain,
+				    struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	u32 event = its_get_event_id(d);
+
+	/* Map the GIC IRQ and event to the device */
+	its_send_mapvi(its_dev, d->hwirq, event);
+}
+
+static void its_irq_domain_deactivate(struct irq_domain *domain,
+				      struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	u32 event = its_get_event_id(d);
+
+	/* Stop the delivery of interrupts */
+	its_send_discard(its_dev, event);
+}
+
 static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs)
 {
@@ -1201,10 +1218,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	for (i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(domain,
 								virq + i);
-		int event = its_get_event_id(data);
-
-		/* Stop the delivery of interrupts */
-		its_send_discard(its_dev, event);
+		u32 event = its_get_event_id(data);
 
 		/* Mark interrupt index as unused */
 		clear_bit(event, its_dev->lpi_map);
@@ -1230,6 +1244,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 static const struct irq_domain_ops its_domain_ops = {
 	.alloc			= its_irq_domain_alloc,
 	.free			= its_irq_domain_free,
+	.activate		= its_irq_domain_activate,
+	.deactivate		= its_irq_domain_deactivate,
 };
 
 static int its_probe(struct device_node *node, struct irq_domain *parent)
-- 
2.1.3
