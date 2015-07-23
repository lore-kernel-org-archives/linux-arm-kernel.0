From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Jul 2015 14:05:12 +0100
Subject: [PATCH v2 6/7] irqchip: GIC: Switch ACPI support to stacked domains
In-Reply-To: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1437656713-9677-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the basic ACPI GSI code is irq domain aware, make sure
that the ACPI support in the GIC doesn't pointlessly deviate from
the DT path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 45 ++++++++++++++++++++++++++++++-----------
 include/linux/irqchip/arm-gic.h |  2 +-
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b41ccf5..ce531e6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -813,8 +813,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret = 0;
 
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
 
@@ -887,7 +885,7 @@ void gic_set_irqchip_flags(unsigned long flags)
 
 void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct device_node *node)
+			   u32 percpu_offset, void *domain_token)
 {
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
@@ -946,8 +944,8 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (node) {		/* DT case */
-		gic->domain = irq_domain_add_linear(node, gic_irqs,
+	if (domain_token) {		/* DT/ACPI case */
+		gic->domain = irq_domain_add_linear(domain_token, gic_irqs,
 						    &gic_irq_domain_hierarchy_ops,
 						    gic);
 	} else {		/* Non-DT case */
@@ -973,7 +971,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			irq_base = irq_start;
 		}
 
-		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
+		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
 					hwirq_base, &gic_irq_domain_ops, gic);
 	}
 
@@ -1086,6 +1084,31 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
 	return 0;
 }
 
+static int gic_acpi_gsi_desc_populate(struct acpi_gsi_descriptor *data,
+				      u32 gsi, unsigned int irq_type)
+{
+	/*
+	 * Encode GSI and triggering information the way the GIC likes
+	 * them.
+	 */
+	if (WARN_ON(gsi < 16))
+		return -EINVAL;
+
+	if (gsi >= 32) {
+		data->param[0] = 0;		/* SPI */
+		data->param[1] = gsi - 32;
+		data->param[2] = irq_type;
+	} else {
+		data->param[0] = 1; 		/* PPI */
+		data->param[1] = gsi - 16;
+		data->param[2] = 0xff << 4 | irq_type;
+	}
+
+	data->param_count = 3;
+
+	return 0;
+}
+
 int __init
 gic_v2_acpi_init(struct acpi_table_header *table)
 {
@@ -1132,14 +1155,12 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	}
 
 	/*
-	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
-	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
-	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
+	 * Initialize zero GIC instance (no multi-GIC support).
 	 */
-	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	irq_set_default_host(gic_data[0].domain);
+	gic_init_bases(0, -1, dist_base, cpu_base, 0, (void *)ACPI_IRQ_MODEL_GIC);
 
-	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, ACPI_IRQ_MODEL_GIC,
+			   gic_acpi_gsi_desc_populate);
 	return 0;
 }
 #endif
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 9de976b..97799b7 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -97,7 +97,7 @@ struct device_node;
 
 void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
-		    u32 offset, struct device_node *);
+		    u32 offset, void *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_cpu_if_down(void);
 
-- 
2.1.4
