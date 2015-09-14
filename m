From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 17:44:06 +0100
Subject: [PATCH v3 7/8] irqchip: GIC: Switch ACPI support to stacked domains
In-Reply-To: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442249047-21182-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the basic ACPI GSI code is irq domain aware, make sure
that the ACPI support in the GIC doesn't pointlessly deviate from
the DT path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 54 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ecf72cf..bc6353a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -926,8 +926,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret = 0;
 
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
 
@@ -995,7 +993,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 
 static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct device_node *node)
+			   u32 percpu_offset, void *domain_token)
 {
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
@@ -1047,8 +1045,8 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (node) {		/* DT case */
-		gic->domain = irq_domain_add_linear(node, gic_irqs,
+	if (domain_token) {		/* DT/ACPI case */
+		gic->domain = irq_domain_add_linear(domain_token, gic_irqs,
 						    &gic_irq_domain_hierarchy_ops,
 						    gic);
 	} else {		/* Non-DT case */
@@ -1074,7 +1072,7 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			irq_base = irq_start;
 		}
 
-		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
+		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
 					hwirq_base, &gic_irq_domain_ops, gic);
 	}
 
@@ -1220,10 +1218,36 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
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
+	void *domain_token;
 	int count;
 
 	/* Collect CPU base addresses */
@@ -1274,14 +1298,20 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 		static_key_slow_dec(&supports_deactivate);
 
 	/*
-	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
-	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
-	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
+	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	__gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	irq_set_default_host(gic_data[0].domain);
+	domain_token = irq_domain_alloc_domain_token(NULL);
+	if (!domain_token) {
+		pr_err("Unable to allocate domain token\n");
+		iounmap(cpu_base);
+		iounmap(dist_base);
+		return -ENOMEM;
+	}
+
+	__gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_token);
 
-	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_token,
+			   gic_acpi_gsi_desc_populate);
 	return 0;
 }
 #endif
-- 
2.1.4
