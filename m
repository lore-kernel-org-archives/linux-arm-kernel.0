From: stefan@agner.ch (Stefan Agner)
Date: Sat, 16 May 2015 11:44:13 +0200
Subject: [PATCH v7 01/13] irqdomain: Add non-hierarchy helper
 irq_domain_set_info
In-Reply-To: <1431769465-26867-1-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
Message-ID: <1431769465-26867-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the helper irq_domain_set_info() in a non-domain hierarchy
variant. This allows to use the helper for generic chip since not
all chips using generic chip support domain hierarchy.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 include/linux/irqdomain.h |  8 ++++----
 kernel/irq/irqdomain.c    | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 676d730..744ac0e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -258,6 +258,10 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
+extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
+				irq_hw_number_t hwirq, struct irq_chip *chip,
+				void *chip_data, irq_flow_handler_t handler,
+				void *handler_data, const char *handler_name);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
@@ -281,10 +285,6 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
-extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-				irq_hw_number_t hwirq, struct irq_chip *chip,
-				void *chip_data, irq_flow_handler_t handler,
-				void *handler_data, const char *handler_name);
 extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7fac311..41bf6dc 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1232,6 +1232,27 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 	return (irq_data && irq_data->domain == domain) ? irq_data : NULL;
 }
 
+/**
+ * irq_domain_set_info - Set the complete data for a @virq in @domain
+ * @domain:		Interrupt domain to match
+ * @virq:		IRQ number
+ * @hwirq:		The hardware interrupt number
+ * @chip:		The associated interrupt chip
+ * @chip_data:		The associated interrupt chip data
+ * @handler:		The interrupt flow handler
+ * @handler_data:	The interrupt flow handler data
+ * @handler_name:	The interrupt handler name
+ */
+void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq, struct irq_chip *chip,
+			 void *chip_data, irq_flow_handler_t handler,
+			 void *handler_data, const char *handler_name)
+{
+	irq_set_chip_and_handler_name(virq, chip, handler, handler_name);
+	irq_set_chip_data(virq, chip_data);
+	irq_set_handler_data(virq, handler_data);
+}
+
 static void irq_domain_check_hierarchy(struct irq_domain *domain)
 {
 }
-- 
2.4.1
