From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 9 Sep 2011 13:59:35 +0530
Subject: [PATCH] irq: Add IRQCHIP_SKIP_SET_WAKE flag to avoid need of dummy set_wake() handler.
Message-ID: <mailman.124.1315559161.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain IRQCHIP's may not need to install the irq_set_wake() handler if
the IRQCHIP_MASK_ON_SUSPEND flag is set. But but if it's not implemented,
enable_irq_wake() will return an error.  That needs the IRQCHIP to install
an empty set_wake handler.

Add an 'IRQCHIP_SKIP_SET_WAKE' flag so that IRQCHIP can inform the core
irq code that irq_set_wake() handler is not necessary.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    2 ++
 kernel/irq/manage.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5951730..4b0d842 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -336,12 +336,14 @@ struct irq_chip {
  * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path
  * IRQCHIP_ONOFFLINE_ENABLED:	Only call irq_on/off_line callbacks
  *				when irq enabled
+ * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this IRQCHIP
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
 	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
 	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
 	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
+	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
 };
 
 /* This include will go away once we isolated irq_desc usage to core code */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9b956fa..7e1a3ed 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -467,6 +467,9 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
 	struct irq_desc *desc = irq_to_desc(irq);
 	int ret = -ENXIO;
 
+	if (irq_desc_get_chip(desc)->flags &  IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (desc->irq_data.chip->irq_set_wake)
 		ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);
 
-- 
1.7.4.1


--------------010300060004050802040203--
