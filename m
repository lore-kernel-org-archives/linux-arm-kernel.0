From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:23 +0700
Subject: [RFCv2 PATCH 7/8] gicv2m: Introducing gicv2m_acpi_init()
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1436778864-17645-8-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces gicv2m_acpi_init(), which parse MADT GIC MSI frames,
and use information to initialize GICv2m. It also refactors
gicv2m_init_one() to handle both DT and ACPI initialization path.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
NOTE:
Now that we are setting v2m->domain->bus_token to DOMAIN_BUS_PCI_MSI,
this limits the scope of this particular domain to just PCI-MSI-related
stuff. I am not sure if it would be acceptable to use MSI frame handle as
a reference to assign to v2m->domain->of_node. This same concern is also
applied to patch 8 where we bind the GIC MSI frame to PCI host bridge.

Any suggestions/feedbacks are welcomed.

Thanks,

Suravee

 drivers/irqchip/irq-gic-v2m.c   | 106 +++++++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c       |   3 ++
 include/linux/irqchip/arm-gic.h |  13 +++++
 3 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index e4e2a92..c0417e1 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) "GICv2m: " fmt
 
+#include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -219,8 +220,14 @@ static bool is_msi_spi_valid(u32 base, u32 num)
 	return true;
 }
 
-static int __init gicv2m_init_one(struct device_node *node,
-				  struct irq_domain *parent)
+char gicv2m_domain_name[] = "GICV2M";
+char gicv2m_msi_domain_name[] = "V2M-MSI";
+
+static int __init gicv2m_init_one(struct irq_domain *parent,
+				  u32 *spi_start, u32 *nr_spis,
+				  struct resource *res,
+				  struct device_node *node,
+				  void *msi_frame)
 {
 	int ret;
 	struct v2m_data *v2m;
@@ -232,23 +239,17 @@ static int __init gicv2m_init_one(struct device_node *node,
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
 
@@ -277,6 +278,8 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	inner_domain->bus_token = DOMAIN_BUS_PLATFORM_MSI;
 	inner_domain->parent = parent;
+	inner_domain->name = gicv2m_domain_name;
+
 	v2m->domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
 						inner_domain);
 	if (!v2m->domain) {
@@ -285,11 +288,11 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_free_domains;
 	}
 
-	spin_lock_init(&v2m->msi_cnt_lock);
+	v2m->domain->name = gicv2m_msi_domain_name;
+	if (!acpi_disabled)
+		v2m->domain->of_node = msi_frame;
 
-	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
-		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
-		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
+	spin_lock_init(&v2m->msi_cnt_lock);
 
 	return 0;
 
@@ -319,15 +322,82 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 
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
+				      child, NULL);
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
+	int ret = 0;
+	int num, i;
+	struct acpi_madt_generic_msi_frame *cur, *msi_frame;
+
+	ret = acpi_madt_msi_frame_init(table);
+	if (ret)
+		return ret;
+
+	ret = acpi_get_msi_frame(0, &msi_frame);
+	if (ret)
+		return ret;
+
+	num = acpi_get_num_msi_frames();
+
+	for (i = 0, cur = msi_frame; i < num; i++, cur++) {
+		struct resource res;
+		u32 spi_start = 0, nr_spis = 0;
+
+		res.start = cur->base_address;
+		res.end = cur->base_address + 0x1000;
+
+		if (cur->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
+			spi_start = cur->spi_base;
+			nr_spis = cur->spi_count;
+
+			pr_info("ACPI overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+				spi_start, nr_spis);
+		}
+
+		ret = gicv2m_init_one(parent, &spi_start, &nr_spis, &res,
+				      NULL, msi_frame);
+		if (ret)
+			break;
+
+		pr_info("MSI frame ID %u: range[%#lx:%#lx], SPI[%d:%d]\n",
+			cur->msi_frame_id,
+			(unsigned long)res.start, (unsigned long)res.end,
+			spi_start, (spi_start + nr_spis));
+	}
+	return ret;
+}
+
+#endif /* CONFIG_ACPI */
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8ac8ec4..5630e16 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1195,6 +1195,9 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
 	set_acpi_irq_domain(gic_data[0].domain);
 
+	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+		gicv2m_acpi_init(table, gic_data[0].domain);
+
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 	return 0;
 }
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 4808514..de1bd1e 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -118,6 +118,19 @@ static inline void gic_init(unsigned int nr, int start,
 	gic_init_bases(nr, start, dist, cpu, 0, NULL);
 }
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+
+int gicv2m_acpi_init(struct acpi_table_header *table,
+		     struct irq_domain *parent);
+#else
+int gicv2m_acpi_init(struct acpi_table_header *table,
+		     struct irq_domain *parent);
+{
+	return 0;
+}
+#endif
+
 int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
 
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
-- 
2.1.0
