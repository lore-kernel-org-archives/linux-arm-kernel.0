From: eric.auger@redhat.com (Eric Auger)
Date: Tue, 19 Jul 2016 13:02:45 +0000
Subject: [PATCH v11 08/10] irqchip/gicv3-its: register the MSI global doorbell
In-Reply-To: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1468933367-23159-9-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the registration of the MSI global doorbell in
gicv3-its driver plus the implementation for irq_chip
msi_doorbell_info ops.

This will allow the msi layer to iommu_map this doorbell when
requested.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v10 -> v11:
- adapt to new doorbell registration API and implement msi_doorbell_info
---
 drivers/irqchip/irq-gic-v3-its.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5eb1f9e..23102e3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -29,6 +29,8 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/msi-doorbell.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -84,6 +86,7 @@ struct its_node {
 	u32			ite_size;
 	u32			device_ids;
 	int			numa_node;
+	struct irq_chip_msi_doorbell_info *doorbell_info;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -656,6 +659,16 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->data		= its_get_event_id(d);
 }
 
+static struct irq_chip_msi_doorbell_info *
+its_msi_doorbell_info(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_node *its = its_dev->its;
+
+	return its->doorbell_info;
+}
+
+
 static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
@@ -663,6 +676,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
+	.msi_doorbell_info	= its_msi_doorbell_info,
 };
 
 /*
@@ -1607,6 +1621,7 @@ static int __init its_probe(struct device_node *node,
 
 	if (of_property_read_bool(node, "msi-controller")) {
 		struct msi_domain_info *info;
+		phys_addr_t translater;
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
@@ -1614,10 +1629,23 @@ static int __init its_probe(struct device_node *node,
 			goto out_free_tables;
 		}
 
+		translater = its->phys_base + GITS_TRANSLATER;
+		its->doorbell_info =
+			msi_doorbell_register_global(translater, sizeof(u32),
+						     IOMMU_WRITE | IOMMU_MMIO,
+						     true);
+
+		if (IS_ERR_OR_NULL(its->doorbell_info))  {
+			kfree(info);
+			goto out_free_tables;
+		}
+
+
 		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
 		if (!inner_domain) {
 			err = -ENOMEM;
 			kfree(info);
+			msi_doorbell_unregister_global(its->doorbell_info);
 			goto out_free_tables;
 		}
 
-- 
1.9.1
