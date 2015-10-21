From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 21 Oct 2015 11:47:29 -0700
Subject: [PATCH V3 6/6] gicv2m: acpi: Introducing GICv2m ACPI support
In-Reply-To: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1445453249-32557-7-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces gicv2m_acpi_init(), which uses information
in MADT GIC MSI frames structure to initialize GICv2m driver.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v2m.c   | 95 +++++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c       |  3 ++
 include/linux/irqchip/arm-gic.h |  4 ++
 3 files changed, 102 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 7e60f7e..4f52e9a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -15,9 +15,11 @@
 
 #define pr_fmt(fmt) "GICv2m: " fmt
 
+#include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
@@ -138,6 +140,11 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 		fwspec.param[0] = 0;
 		fwspec.param[1] = hwirq - 32;
 		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else if (is_fwnode_irqchip(domain->parent->fwnode)) {
+		fwspec.fwnode = domain->parent->fwnode;
+		fwspec.param_count = 2;
+		fwspec.param[0] = hwirq;
+		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
 	} else {
 		return -EINVAL;
 	}
@@ -255,6 +262,8 @@ static void gicv2m_teardown(void)
 		kfree(v2m->bm);
 		iounmap(v2m->base);
 		of_node_put(to_of_node(v2m->fwnode));
+		if (is_fwnode_irqchip(v2m->fwnode))
+			irq_domain_free_fwnode(v2m->fwnode);
 		kfree(v2m);
 	}
 }
@@ -359,6 +368,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 
 	if (to_of_node(fwnode))
 		name = to_of_node(fwnode)->name;
+	else
+		name = irq_domain_get_irqchip_fwnode_name(fwnode);
 
 	pr_info("Frame %s: range[%#lx:%#lx], SPI[%d:%d]\n", name,
 		(unsigned long)res->start, (unsigned long)res->end,
@@ -415,3 +426,87 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 		gicv2m_teardown();
 	return ret;
 }
+
+#ifdef CONFIG_ACPI
+static int acpi_num_msi;
+
+static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+{
+	struct v2m_data *data;
+
+	if (WARN_ON(acpi_num_msi <= 0))
+		return NULL;
+
+	/* We only return the fwnode of the first MSI frame. */
+	data = list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
+	if (!data)
+		return NULL;
+
+	return data->fwnode;
+}
+
+static int __init
+acpi_parse_madt_msi(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	int ret;
+	struct resource res;
+	u32 spi_start = 0, nr_spis = 0;
+	struct acpi_madt_generic_msi_frame *m;
+	struct fwnode_handle *fwnode = NULL;
+
+	m = (struct acpi_madt_generic_msi_frame *)header;
+	if (BAD_MADT_ENTRY(m, end))
+		return -EINVAL;
+
+	res.start = m->base_address;
+	res.end = m->base_address + 0x1000;
+
+	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
+		spi_start = m->spi_base;
+		nr_spis = m->spi_count;
+
+		pr_info("ACPI overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+			spi_start, nr_spis);
+	}
+
+	fwnode = irq_domain_alloc_fwnode((void *)m->base_address);
+	if (!fwnode) {
+		pr_err("Unable to allocate GICv2m domain token\n");
+		return -EINVAL;
+	}
+
+	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
+	if (ret)
+		irq_domain_free_fwnode(fwnode);
+
+	return ret;
+}
+
+int __init gicv2m_acpi_init(struct irq_domain *parent)
+{
+	int ret;
+
+	if (acpi_num_msi > 0)
+		return 0;
+
+	acpi_num_msi = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_MSI_FRAME,
+				      acpi_parse_madt_msi, 0);
+
+	if (acpi_num_msi <= 0)
+		goto err_out;
+
+	ret = gicv2m_allocate_domains(parent);
+	if (ret)
+		goto err_out;
+
+	pci_msi_register_fwnode_provider(&gicv2m_get_fwnode);
+
+	return 0;
+
+err_out:
+	gicv2m_teardown();
+	return -EINVAL;
+}
+
+#endif /* CONFIG_ACPI */
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6685b33..bb3e1f2 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1329,6 +1329,9 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 
 	__gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
 
+	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+		gicv2m_acpi_init(gic_data[0].domain);
+
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 	return 0;
 }
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index bae69e5..30b2ccb 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -108,6 +108,10 @@ void gic_init(unsigned int nr, int start,
 
 int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
 
+#ifdef CONFIG_ACPI
+int gicv2m_acpi_init(struct irq_domain *parent);
+#endif
+
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
-- 
2.1.0
