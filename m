From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 17:43:01 +0100
Subject: [PATCH v4 8/9] irqchip/GIC: Switch ACPI support to stacked domains
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443458582-7497-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the basic ACPI GSI code is irq domain aware, make sure
that the ACPI support in the GIC doesn't pointlessly deviate from
the DT path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 58 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 0e4142d..4f5772d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -910,8 +910,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret = 0;
 
-	if (d->of_node != controller)
-		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
 
@@ -979,7 +977,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 
 static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct device_node *node)
+			   u32 percpu_offset, struct fwnode_handle *handle)
 {
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
@@ -1031,11 +1029,12 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (node) {		/* DT case */
+	if (handle) {		/* DT/ACPI */
+		struct device_node *node = to_of_node(handle);
 		gic->domain = irq_domain_add_linear(node, gic_irqs,
 						    &gic_irq_domain_hierarchy_ops,
 						    gic);
-	} else {		/* Non-DT case */
+	} else {		/* Legacy support */
 		/*
 		 * For primary GICs, skip over SGIs.
 		 * For secondary GICs, skip over PPIs, too.
@@ -1058,7 +1057,7 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			irq_base = irq_start;
 		}
 
-		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
+		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
 					hwirq_base, &gic_irq_domain_ops, gic);
 	}
 
@@ -1166,7 +1165,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
 		percpu_offset = 0;
 
-	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
+	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
+			 &node->fwnode);
 	if (!gic_cnt)
 		gic_init_physaddr(node);
 
@@ -1236,10 +1236,36 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
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
 	void __iomem *cpu_base, *dist_base;
+	struct fwnode_handle *domain_handle;
 	int count;
 
 	/* Collect CPU base addresses */
@@ -1290,14 +1316,20 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 		static_key_slow_dec(&supports_deactivate);
 
 	/*
-	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
-	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
-	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
+	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	__gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	irq_set_default_host(gic_data[0].domain);
+	domain_handle = irq_domain_alloc_fwnode(NULL);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		iounmap(cpu_base);
+		iounmap(dist_base);
+		return -ENOMEM;
+	}
+
+	__gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
 
-	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle,
+			   gic_acpi_gsi_desc_populate);
 	return 0;
 }
 #endif
-- 
2.1.4
