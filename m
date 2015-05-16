From: stefan@agner.ch (Stefan Agner)
Date: Sat, 16 May 2015 11:44:15 +0200
Subject: [PATCH v7 03/13] genirq: generic chip: support hierarchy domain
In-Reply-To: <1431769465-26867-1-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
Message-ID: <1431769465-26867-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new helper function irq_domain_set_info to make sure the
function irq_domain_set_hwirq_and_chip is being called, which is
crucial to save irqdomain specific data to irq_data.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 kernel/irq/generic-chip.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 61024e8..15b370d 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -360,7 +360,7 @@ static struct lock_class_key irq_nested_lock_class;
 int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 			 irq_hw_number_t hw_irq)
 {
-	struct irq_data *data = irq_get_irq_data(virq);
+	struct irq_data *data = irq_domain_get_irq_data(d, virq);
 	struct irq_domain_chip_generic *dgc = d->gc;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
@@ -405,8 +405,7 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 	else
 		data->mask = 1 << idx;
 
-	irq_set_chip_and_handler(virq, chip, ct->handler);
-	irq_set_chip_data(virq, gc);
+	irq_domain_set_info(d, virq, hw_irq, chip, gc, ct->handler, NULL, NULL);
 	irq_modify_status(virq, dgc->irq_flags_to_clear, dgc->irq_flags_to_set);
 	return 0;
 }
-- 
2.4.1
