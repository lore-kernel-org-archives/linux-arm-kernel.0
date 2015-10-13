From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 13 Oct 2015 13:46:23 -0700
Subject: [PATCH 4/4] gicv2m: acpi: Introducing GICv2m ACPI support
In-Reply-To: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1444769183-12374-5-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces gicv2m_acpi_init(), which uses information
in MADT GIC MSI frames structure to initialize GICv2m driver.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v2m.c   | 106 ++++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c       |   3 ++
 include/linux/irqchip/arm-gic.h |   6 +++
 3 files changed, 115 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 97d1bf4..b52560b 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -15,7 +15,10 @@
 
 #define pr_fmt(fmt) "GICv2m: " fmt
 
+#include <linux/acpi.h>
 #include <linux/irq.h>
+#include <linux/list.h>
+#include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
@@ -51,6 +54,7 @@
 #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
 
 struct v2m_data {
+	struct list_head list;
 	spinlock_t msi_cnt_lock;
 	struct resource res;	/* GICv2m resource */
 	void __iomem *base;	/* GICv2m virt address */
@@ -58,8 +62,11 @@ struct v2m_data {
 	u32 nr_spis;		/* The number of SPIs for MSIs */
 	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
+	struct fwnode_handle *fwnode;
 };
 
+static LIST_HEAD(v2m_data_list);
+
 static void gicv2m_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
@@ -134,6 +141,12 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 		fwspec.param[0] = 0;
 		fwspec.param[1] = hwirq - 32;
 		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else if (domain->parent->fwnode->type == FWNODE_IRQCHIP) {
+		/* Note: This is mainly for GICv2m ACPI. */
+		fwspec.fwnode = domain->parent->fwnode;
+		fwspec.param_count = 2;
+		fwspec.param[0] = hwirq;
+		fwspec.param[1] = IRQ_TYPE_EDGE_RISING & IRQ_TYPE_SENSE_MASK;
 	} else {
 		return -EINVAL;
 	}
@@ -317,6 +330,8 @@ static int __init gicv2m_init_one(struct irq_domain *parent,
 	}
 
 	spin_lock_init(&v2m->msi_cnt_lock);
+	v2m->fwnode = fwnode;
+	list_add(&v2m->list, &v2m_data_list);
 
 	pr_info("range[%#lx:%#lx], SPI[%d:%d]\n",
 		(unsigned long)res->start, (unsigned long)res->end,
@@ -379,3 +394,94 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 
 	return ret;
 }
+
+#ifdef CONFIG_ACPI
+static int acpi_num_msi;
+
+/**
+ * Note:
+ * This is used as a temporary variable since we cannot
+ * pass args into acpi_parse_masdt_msi() when calling
+ * acpi_parse_entries(),
+ */
+struct irq_domain *acpi_parent_domain;
+
+static int __init
+acpi_parse_madt_msi(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	int ret;
+	struct resource res;
+	u32 spi_start = 0, nr_spis = 0;
+	struct acpi_madt_generic_msi_frame *m;
+	struct fwnode_handle *domain_handle = NULL;
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
+	domain_handle = irq_domain_alloc_fwnode((void *)m->base_address);
+	if (!domain_handle) {
+		pr_err("Unable to allocate GICv2m domain token\n");
+		return -EINVAL;
+	}
+
+	if (gicv2m_init_one(acpi_parent_domain, spi_start, nr_spis, &res,
+			    domain_handle)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	return 0;
+err_out:
+	if (domain_handle)
+		irq_domain_free_fwnode(domain_handle);
+	return ret;
+}
+
+static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+{
+	struct v2m_data *data;
+
+	if (!acpi_num_msi)
+		return NULL;
+
+	/* We only support one MSI frame at the moment. */
+	data = list_first_entry_or_null(&v2m_data_list,
+					struct v2m_data, list);
+	if (!data)
+		return NULL;
+
+	return data->fwnode;
+}
+
+int __init gicv2m_acpi_init(struct irq_domain *parent)
+{
+	if (acpi_num_msi > 0)
+		return 0;
+
+	acpi_parent_domain = parent;
+
+	acpi_num_msi = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_MSI_FRAME,
+				      acpi_parse_madt_msi, 0);
+
+	if (acpi_num_msi)
+		pci_msi_register_fwnode_provider(&gicv2m_get_fwnode);
+	else
+		pr_debug("No valid ACPI GIC MSI FRAME exist\n");
+
+	return 0;
+}
+
+#endif /* CONFIG_ACPI */
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1d0e768..adfd1aa 100644
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
index bae69e5..7398538 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -108,6 +108,12 @@ void gic_init(unsigned int nr, int start,
 
 int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+
+int gicv2m_acpi_init(struct irq_domain *parent);
+#endif
+
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
-- 
2.1.0
