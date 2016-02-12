From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 12 Feb 2016 08:13:06 +0000
Subject: [RFC v3 04/15] iommu: add alloc/free_reserved_iova_domain
In-Reply-To: <1455264797-2334-1-git-send-email-eric.auger@linaro.org>
References: <1455264797-2334-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1455264797-2334-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce alloc/free_reserved_iova_domain in the IOMMU API.
alloc_reserved_iova_domain initializes an iova domain at a given
iova base address and with a given size. This iova domain will
be used to allocate iova within that window. Those IOVAs will be reserved
for special purpose, typically MSI frame binding. Allocation function
within the reserved iova domain will be introduced in subsequent patches.

This is the responsability of the API user to make sure any IOVA
belonging to that domain are allocated with those allocation functions.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v2 -> v3:
- remove iommu_alloc_reserved_iova_domain & iommu_free_reserved_iova_domain
  static implementation in case CONFIG_IOMMU_API is not set

v1 -> v2:
- moved from vfio API to IOMMU API
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..a994f34 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1557,6 +1557,28 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
+				     dma_addr_t iova, size_t size,
+				     unsigned long order)
+{
+	int ret;
+
+	if (!domain->ops->alloc_reserved_iova_domain)
+		return -EINVAL;
+	ret = domain->ops->alloc_reserved_iova_domain(domain, iova,
+						      size, order);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_alloc_reserved_iova_domain);
+
+void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
+{
+	if (!domain->ops->free_reserved_iova_domain)
+		return;
+	domain->ops->free_reserved_iova_domain(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_free_reserved_iova_domain);
+
 void iommu_get_dm_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a4fe04a..2d1f155 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -195,6 +195,12 @@ struct iommu_ops {
 	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
 	/* Get the number of windows per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
+	/* allocates the reserved iova domain */
+	int (*alloc_reserved_iova_domain)(struct iommu_domain *domain,
+					  dma_addr_t iova, size_t size,
+					  unsigned long order);
+	/* frees the reserved iova domain */
+	void (*free_reserved_iova_domain)(struct iommu_domain *domain);
 
 #ifdef CONFIG_OF_IOMMU
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
@@ -266,6 +272,10 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern int iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
+					    dma_addr_t iova, size_t size,
+					    unsigned long order);
+extern void iommu_free_reserved_iova_domain(struct iommu_domain *domain);
 struct device *iommu_device_create(struct device *parent, void *drvdata,
 				   const struct attribute_group **groups,
 				   const char *fmt, ...) __printf(4, 5);
-- 
1.9.1
