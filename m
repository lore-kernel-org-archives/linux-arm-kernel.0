From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 27 Jan 2015 00:51:31 +0100
Subject: [PATCH 01/15] iommu: Introduce domain_alloc and domain_free iommu_ops
In-Reply-To: <1422316305-19216-1-git-send-email-joro@8bytes.org>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Message-ID: <1422316305-19216-2-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

These new call-backs defer the allocation and destruction of
'struct iommu_domain' to the iommu driver. This allows
drivers to embed this struct into their private domain
structures and to get rid of the domain_init and
domain_destroy call-backs when all drivers have been
converted.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 29 +++++++++++++++++++++--------
 include/linux/iommu.h |  5 +++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7718d7..684efc0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -900,26 +900,34 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
 struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
+	const struct iommu_ops *ops;
 	struct iommu_domain *domain;
-	int ret;
 
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	ops = bus->iommu_ops;
+
+	if (ops->domain_alloc)
+		domain = ops->domain_alloc();
+	else
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+
 	if (!domain)
 		return NULL;
 
 	domain->ops = bus->iommu_ops;
 
-	ret = domain->ops->domain_init(domain);
-	if (ret)
+	if (ops->domain_init && domain->ops->domain_init(domain))
 		goto out_free;
 
 	return domain;
 
 out_free:
-	kfree(domain);
+	if (ops->domain_free)
+		ops->domain_free(domain);
+	else
+		kfree(domain);
 
 	return NULL;
 }
@@ -927,10 +935,15 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
-	if (likely(domain->ops->domain_destroy != NULL))
-		domain->ops->domain_destroy(domain);
+	const struct iommu_ops *ops = domain->ops;
 
-	kfree(domain);
+	if (likely(ops->domain_destroy != NULL))
+		ops->domain_destroy(domain);
+
+	if (ops->domain_free)
+		ops->domain_free(domain);
+	else
+		kfree(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38daa45..69d1d12 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -115,6 +115,11 @@ struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
 	int (*domain_init)(struct iommu_domain *domain);
 	void (*domain_destroy)(struct iommu_domain *domain);
+
+	/* Domain allocation and freeing by the iommu driver */
+	struct iommu_domain *(*domain_alloc)(void);
+	void (*domain_free)(struct iommu_domain *);
+
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
-- 
1.8.4.5
