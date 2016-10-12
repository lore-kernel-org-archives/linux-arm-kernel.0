From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:16 +0000
Subject: [PATCH v14 08/16] irqchip/gicv3-its: Register the MSI doorbell
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-9-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the ITS global doorbell. Registered information
are needed to set up the KVM passthrough use case.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v13 -> v14:
- use iommu_msi_doorbell_alloc/free

v12 -> v13:
- use new doorbell registration prototype

v11 -> v12:
- use new irq_get_msi_doorbell_info name
- simplify error handling

v10 -> v11:
- adapt to new doorbell registration API and implement msi_doorbell_info
---
 drivers/irqchip/irq-gic-v3-its.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 98ff669..b42e006 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -86,6 +86,7 @@ struct its_node {
 	u32			ite_size;
 	u32			device_ids;
 	int			numa_node;
+	struct iommu_msi_doorbell_info	*doorbell_info;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -1717,6 +1718,7 @@ static int __init its_probe(struct device_node *node,
 
 	if (of_property_read_bool(node, "msi-controller")) {
 		struct msi_domain_info *info;
+		phys_addr_t translater;
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
@@ -1724,10 +1726,21 @@ static int __init its_probe(struct device_node *node,
 			goto out_free_tables;
 		}
 
+		translater = its->phys_base + GITS_TRANSLATER;
+		its->doorbell_info =
+			iommu_msi_doorbell_alloc(translater, sizeof(u32), true);
+
+		if (IS_ERR(its->doorbell_info))  {
+			kfree(info);
+			goto out_free_tables;
+		}
+
+
 		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
 		if (!inner_domain) {
 			err = -ENOMEM;
 			kfree(info);
+			iommu_msi_doorbell_free(its->doorbell_info);
 			goto out_free_tables;
 		}
 
-- 
1.9.1
