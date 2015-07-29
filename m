From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 29 Jul 2015 18:08:59 +0800
Subject: [PATCH v4 10/10] irqchip / gicv2m: Introducing gicv2m_acpi_init()
In-Reply-To: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1438164539-29256-11-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch introduces gicv2m_acpi_init(), which uses information
in MADT GIC MSI frames structure to initialize GICv2m driver.
It also refactors gicv2m_init_one() to handle both DT and ACPI
initialization path.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v2m.c   | 111 +++++++++++++++++++++++++++++++---------
 drivers/irqchip/irq-gic.c       |   3 ++
 include/linux/irqchip/arm-gic.h |   7 +++
 3 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index d0fcbf8..c491a08 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) "GICv2m: " fmt
 
+#include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -211,6 +212,10 @@ static bool is_msi_spi_valid(u32 base, u32 num)
 	return true;
 }
 
+char gicv2m_domain_name[] = "GICV2M";
+char gicv2m_pci_msi_domain_name[] = "GICV2M-PCI-MSI";
+char gicv2m_plat_msi_domain_name[] = "GICV2M-PLAT-MSI";
+
 static struct irq_chip gicv2m_pmsi_irq_chip = {
 	.name			= "pMSI",
 };
@@ -224,8 +229,9 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
-static int __init gicv2m_init_one(struct device_node *node,
-				  struct irq_domain *parent)
+static int __init gicv2m_init_one(struct irq_domain *parent,
+				  u32 *spi_start, u32 *nr_spis,
+				  struct resource *res, void *token)
 {
 	int ret;
 	struct v2m_data *v2m;
@@ -237,28 +243,22 @@ static int __init gicv2m_init_one(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	ret = of_address_to_resource(node, 0, &v2m->res);
-	if (ret) {
-		pr_err("Failed to allocate v2m resource.\n");
-		goto err_free_v2m;
-	}
-
-	v2m->base = ioremap(v2m->res.start, resource_size(&v2m->res));
+	v2m->base = ioremap(res->start, resource_size(res));
 	if (!v2m->base) {
 		pr_err("Failed to map GICv2m resource\n");
 		ret = -ENOMEM;
 		goto err_free_v2m;
 	}
+	memcpy(&v2m->res, res, sizeof(struct resource));
 
-	if (!of_property_read_u32(node, "arm,msi-base-spi", &v2m->spi_start) &&
-	    !of_property_read_u32(node, "arm,msi-num-spis", &v2m->nr_spis)) {
-		pr_info("Overriding V2M MSI_TYPER (base:%u, num:%u)\n",
-			v2m->spi_start, v2m->nr_spis);
+	if (*spi_start && *nr_spis) {
+		v2m->spi_start = *spi_start;
+		v2m->nr_spis = *nr_spis;
 	} else {
 		u32 typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
 
-		v2m->spi_start = V2M_MSI_TYPER_BASE_SPI(typer);
-		v2m->nr_spis = V2M_MSI_TYPER_NUM_SPI(typer);
+		v2m->spi_start = *spi_start = V2M_MSI_TYPER_BASE_SPI(typer);
+		v2m->nr_spis = *nr_spis = V2M_MSI_TYPER_NUM_SPI(typer);
 	}
 
 	if (!is_msi_spi_valid(v2m->spi_start, v2m->nr_spis)) {
@@ -273,7 +273,7 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	inner_domain = irq_domain_add_tree(node, &gicv2m_domain_ops, v2m);
+	inner_domain = irq_domain_add_tree(token, &gicv2m_domain_ops, v2m);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		ret = -ENOMEM;
@@ -282,9 +282,11 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
 	inner_domain->parent = parent;
-	pci_domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
+	inner_domain->name = gicv2m_domain_name;
+
+	pci_domain = pci_msi_create_irq_domain(token, &gicv2m_msi_domain_info,
 					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(node,
+	plat_domain = platform_msi_create_irq_domain(token,
 						     &gicv2m_pmsi_domain_info,
 						     inner_domain);
 	if (!pci_domain || !plat_domain) {
@@ -293,11 +295,10 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_free_domains;
 	}
 
-	spin_lock_init(&v2m->msi_cnt_lock);
+	pci_domain->name = gicv2m_pci_msi_domain_name;
+	plat_domain->name = gicv2m_plat_msi_domain_name;
 
-	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
-		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
-		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
+	spin_lock_init(&v2m->msi_cnt_lock);
 
 	return 0;
 
@@ -329,15 +330,79 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 
 	for (child = of_find_matching_node(node, gicv2m_device_id); child;
 	     child = of_find_matching_node(child, gicv2m_device_id)) {
+		u32 spi_start = 0, nr_spis = 0;
+		struct resource res;
+
 		if (!of_find_property(child, "msi-controller", NULL))
 			continue;
 
-		ret = gicv2m_init_one(child, parent);
+		ret = of_address_to_resource(child, 0, &res);
+		if (ret) {
+			pr_err("Failed to allocate v2m resource.\n");
+			break;
+		}
+
+		if (!of_property_read_u32(child, "arm,msi-base-spi", &spi_start) &&
+		    !of_property_read_u32(child, "arm,msi-num-spis", &nr_spis))
+			pr_info("Overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+				spi_start, nr_spis);
+
+		ret = gicv2m_init_one(parent, &spi_start, &nr_spis, &res,
+				      child);
 		if (ret) {
 			of_node_put(node);
 			break;
 		}
+
+		pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", child->name,
+			(unsigned long)res.start, (unsigned long)res.end,
+			spi_start, (spi_start + nr_spis));
 	}
 
 	return ret;
 }
+
+#ifdef CONFIG_ACPI
+int __init gicv2m_acpi_init(struct acpi_table_header *table,
+			    struct irq_domain *parent)
+{
+	int i, ret;
+
+	ret = acpi_gic_msi_init(table);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < acpi_gic_get_num_msi_frame(); i++) {
+		struct resource res;
+		u32 spi_start = 0, nr_spis = 0;
+		struct acpi_madt_generic_msi_frame *m;
+
+		ret = acpi_gic_get_msi_frame(i, &m);
+		if (ret)
+			return ret;
+
+		res.start = m->base_address;
+		res.end = m->base_address + 0x1000;
+
+		if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
+			spi_start = m->spi_base;
+			nr_spis = m->spi_count;
+
+			pr_info("ACPI overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+				spi_start, nr_spis);
+		}
+
+		ret = gicv2m_init_one(parent, &spi_start, &nr_spis, &res,
+				      (void *)(m->base_address));
+		if (ret)
+			break;
+
+		pr_info("MSI frame ID %u: range[%#lx:%#lx], SPI[%d:%d]\n",
+			m->msi_frame_id,
+			(unsigned long)res.start, (unsigned long)res.end,
+			spi_start, (spi_start + nr_spis));
+	}
+	return ret;
+}
+
+#endif /* CONFIG_ACPI */
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index bec6b00..531ebbc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1159,6 +1159,9 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	 */
 	gic_init_bases(0, -1, dist_base, cpu_base, 0, (void *)ACPI_IRQ_MODEL_GIC);
 
+	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+		gicv2m_acpi_init(table, gic_data[0].domain);
+
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, ACPI_IRQ_MODEL_GIC,
 			   gic_acpi_gsi_desc_populate);
 	return 0;
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 97799b7..27d8196 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -109,6 +109,13 @@ static inline void gic_init(unsigned int nr, int start,
 
 int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
 
+#ifdef CONFIG_ACPI
+struct acpi_table_header;
+
+int gicv2m_acpi_init(struct acpi_table_header *table,
+		     struct irq_domain *parent);
+#endif
+
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
-- 
1.9.1
