From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:40 +0100
Subject: [PATCH v2 12/17] irqchip/gic: Switch ACPI support to stacked domains
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the basic ACPI GSI code is irq domain aware, make sure
that the ACPI support in the GIC doesn't pointlessly deviate from
the DT path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 12b2973..491eacb 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -963,6 +963,15 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		return 0;
 	}
 
+	if (fwspec->fwnode->type == FWNODE_IRQCHIP) {
+		if(fwspec->param_count != 2)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+		return 0;
+	}
+
 	return -EINVAL;
 }
 
@@ -1017,7 +1026,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 
 static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct device_node *node)
+			   u32 percpu_offset, struct fwnode_handle *handle)
 {
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
@@ -1071,11 +1080,11 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (node) {		/* DT case */
-		gic->domain = irq_domain_add_linear(node, gic_irqs,
-						    &gic_irq_domain_hierarchy_ops,
-						    gic);
-	} else {		/* Non-DT case */
+	if (handle) {		/* DT/ACPI */
+		gic->domain = irq_domain_create_linear(handle, gic_irqs,
+						       &gic_irq_domain_hierarchy_ops,
+						       gic);
+	} else {		/* Legacy support */
 		/*
 		 * For primary GICs, skip over SGIs.
 		 * For secondary GICs, skip over PPIs, too.
@@ -1098,7 +1107,7 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			irq_base = irq_start;
 		}
 
-		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
+		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
 					hwirq_base, &gic_irq_domain_ops, gic);
 	}
 
@@ -1206,7 +1215,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
 		percpu_offset = 0;
 
-	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
+	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
+			 &node->fwnode);
 	if (!gic_cnt)
 		gic_init_physaddr(node);
 
@@ -1281,6 +1291,7 @@ int __init
 gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
+	struct fwnode_handle *domain_handle;
 	int count;
 
 	/* Collect CPU base addresses */
@@ -1331,14 +1342,19 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 		static_key_slow_dec(&supports_deactivate);
 
 	/*
-	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
-	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
-	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
+	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	__gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	irq_set_default_host(gic_data[0].domain);
+	domain_handle = irq_domain_alloc_fwnode(dist_base);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		iounmap(cpu_base);
+		iounmap(dist_base);
+		return -ENOMEM;
+	}
+
+	__gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
 
-	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 	return 0;
 }
 #endif
-- 
2.1.4
