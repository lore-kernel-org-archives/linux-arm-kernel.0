From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 6 Nov 2018 14:11:00 +0530
Subject: [RFC PATCH v3 08/13] genirq/msi: Add support for allocating single
 MSI for a device
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
Message-ID: <20181106084105.32483-9-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously all MSIs for a device are allocated in one go
by calling msi_domain_alloc_irq() from a bus layer. This might
not be the case when a device is trying to allocate interrupts
dynamically based on a request to it.

So introduce msi_domain_alloc/free_irq() apis to allocate a single
msi. prepare and activate operations to be handled by bus layer
calling msi_domain_alloc/free_irq() apis.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- New patch

 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0e9c50052ff3..021f789226b5 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -299,8 +299,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
+int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
+			 struct msi_desc *desc,  msi_alloc_info_t *arg);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
+void msi_domain_free_irq(struct msi_desc *desc);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4ca2fd46645d..e37238317fab 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -387,6 +387,35 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
 }
 
+int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
+			 struct msi_desc *desc,  msi_alloc_info_t *arg)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+	int i, ret, virq;
+
+	ops->set_desc(arg, desc);
+
+	virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
+				       dev_to_node(dev), arg, false,
+				       desc->affinity);
+	if (virq < 0) {
+		ret = -ENOSPC;
+		if (ops->handle_error)
+			ret = ops->handle_error(domain, desc, ret);
+		if (ops->msi_finish)
+			ops->msi_finish(arg, ret);
+		return ret;
+	}
+
+	for (i = 0; i < desc->nvec_used; i++) {
+		irq_set_msi_desc_off(virq, i, desc);
+		irq_debugfs_copy_devname(virq + i, dev);
+	}
+
+	return 0;
+}
+
 /**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
@@ -404,7 +433,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct irq_data *irq_data;
 	struct msi_desc *desc;
 	msi_alloc_info_t arg;
-	int i, ret, virq;
+	int ret, virq;
 	bool can_reserve;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
@@ -412,24 +441,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		return ret;
 
 	for_each_msi_entry(desc, dev) {
-		ops->set_desc(&arg, desc);
-
-		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
-					       dev_to_node(dev), &arg, false,
-					       desc->affinity);
-		if (virq < 0) {
-			ret = -ENOSPC;
-			if (ops->handle_error)
-				ret = ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
+		ret = msi_domain_alloc_irq(domain, dev, desc, &arg);
+		if (ret)
 			return ret;
-		}
-
-		for (i = 0; i < desc->nvec_used; i++) {
-			irq_set_msi_desc_off(virq, i, desc);
-			irq_debugfs_copy_devname(virq + i, dev);
-		}
 	}
 
 	if (ops->msi_finish)
@@ -487,6 +501,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return ret;
 }
 
+void msi_domain_free_irq(struct msi_desc *desc)
+{
+	irq_domain_free_irqs(desc->irq, desc->nvec_used);
+	desc->irq = 0;
+}
+
 /**
  * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
  * @domain:	The domain to managing the interrupts
@@ -503,10 +523,8 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 		 * enough that there is no IRQ associated to this
 		 * entry. If that's the case, don't do anything.
 		 */
-		if (desc->irq) {
-			irq_domain_free_irqs(desc->irq, desc->nvec_used);
-			desc->irq = 0;
-		}
+		if (desc->irq)
+			msi_domain_free_irq(desc);
 	}
 }
 
-- 
2.19.1
