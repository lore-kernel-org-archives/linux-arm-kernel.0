From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 19 Apr 2016 17:13:09 +0000
Subject: [PATCH v7 7/8] genirq/msi: map/unmap the MSI doorbells on
 msi_domain_alloc/free_irqs
In-Reply-To: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461085990-2547-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch handles the iommu mapping of MSI doorbells that require to
be mapped in an iommu domain. This happens on msi_domain_alloc/free_irqs
since this is called in code that can sleep (pci_enable/disable_msi):
iommu_map/unmap is not stated as atomic. On msi_domain_(de)activate and
msi_domain_set_affinity, which must be atomic, we just lookup for this
pre-allocated/mapped IOVA.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v7: creation
---
 kernel/irq/msi.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 72bf4d6..e45907e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,6 +14,8 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/dma-reserved-iommu.h>
+#include <linux/iommu.h>
 
 /* Temparory solution for building, will be removed later */
 #include <linux/pci.h>
@@ -322,6 +324,59 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 }
 
 /**
+ * msi_handle_doorbell_mapping: in case the irq data corresponds to an
+ * MSI that requires iommu mapping, traverse the irq domain hierarchy
+ * to retrieve the doorbells to handle and iommu_map/unmap them according
+ * to @map boolean.
+ *
+ * @data: irq data handle
+ * @map: mapping if true, unmapping if false
+ */
+static int msi_handle_doorbell_mappings(struct irq_data *data, bool map)
+{
+
+	for (; data; data = data->parent_data) {
+		const struct irq_chip_msi_doorbell_info *dbinfo;
+		struct iommu_domain *domain;
+		struct msi_desc *desc;
+		struct irq_chip *chip;
+		dma_addr_t iova;
+		int ret = 0, i;
+
+		chip = irq_data_get_irq_chip(data);
+		desc = irq_data_get_msi_desc(data);
+
+		domain = iommu_msi_mapping_desc_to_domain(desc);
+		if (!domain)
+			continue;
+
+		if (!chip->msi_doorbell_info)
+			continue;
+
+		dbinfo = chip->msi_doorbell_info(data);
+		if (!dbinfo)
+			return -EINVAL;
+
+		for (i = 0; i < dbinfo->nb_doorbells; i++) {
+			struct irq_chip_msi_doorbell __percpu *db;
+
+			db = per_cpu_ptr(dbinfo->percpu_doorbells, i);
+			if (map) {
+				ret = iommu_get_reserved_iova(domain,
+							      db->base,
+							      db->size,
+							      db->prot,
+							      &iova);
+				if (ret)
+					return ret;
+			} else
+				iommu_put_reserved_iova(domain, db->base);
+		}
+	}
+	return 0;
+}
+
+/**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
@@ -352,17 +407,25 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
 					       dev_to_node(dev), &arg, false);
-		if (virq < 0) {
-			ret = -ENOSPC;
-			if (ops->handle_error)
-				ret = ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
-			return ret;
-		}
+		if (virq < 0)
+			goto error;
 
-		for (i = 0; i < desc->nvec_used; i++)
+		for (i = 0; i < desc->nvec_used; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
+			ret = msi_handle_doorbell_mappings(
+				irq_get_irq_data(virq + i), true);
+			if (ret)
+				break;
+		}
+
+		if (ret) {
+			for (; i >= 0; i--) {
+				ret = msi_handle_doorbell_mappings(
+					irq_get_irq_data(virq + i), false);
+				irq_set_msi_desc_off(virq, i, NULL);
+			}
+			goto error;
+		}
 	}
 
 	if (ops->msi_finish)
@@ -377,6 +440,13 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	}
 
 	return 0;
+error:
+	ret = -ENOSPC;
+	if (ops->handle_error)
+		ret = ops->handle_error(domain, desc, ret);
+	if (ops->msi_finish)
+		ops->msi_finish(&arg, ret);
+	return ret;
 }
 
 /**
@@ -396,6 +466,12 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 		 * entry. If that's the case, don't do anything.
 		 */
 		if (desc->irq) {
+			int ret;
+
+			ret = msi_handle_doorbell_mappings(
+				irq_get_irq_data(desc->irq),
+				false);
+			WARN_ON(ret);
 			irq_domain_free_irqs(desc->irq, desc->nvec_used);
 			desc->irq = 0;
 		}
-- 
1.9.1
