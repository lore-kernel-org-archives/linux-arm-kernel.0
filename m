From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:19 +0000
Subject: [PATCH v13 03/15] iommu/dma: Allow MSI-only cookies
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1475743531-4780-4-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

IOMMU domain users such as VFIO face a similar problem to DMA API ops
with regard to mapping MSI messages in systems where the MSI write is
subject to IOMMU translation. With the relevant infrastructure now in
place for managed DMA domains, it's actually really simple for other
users to piggyback off that and reap the benefits without giving up
their own IOVA management, and without having to reinvent their own
wheel in the MSI layer.

Allow such users to opt into automatic MSI remapping by dedicating a
region of their IOVA space to a managed cookie.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- compared to Robin's version
- add NULL last param to iommu_dma_init_domain
- set the msi_geometry aperture
- I removed
  if (base < U64_MAX - size)
     reserve_iova(iovad, iova_pfn(iovad, base + size), ULONG_MAX);
  don't get why we would reserve something out of the scope of the iova domain?
  what do I miss?
---
 drivers/iommu/dma-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  9 +++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c5ab866..11da1a0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -716,3 +716,43 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo += lower_32_bits(msi_page->iova);
 	}
 }
+
+/**
+ * iommu_get_dma_msi_region_cookie - Configure a domain for MSI remapping only
+ * @domain: IOMMU domain to prepare
+ * @base: Base address of IOVA region to use as the MSI remapping aperture
+ * @size: Size of the desired MSI aperture
+ *
+ * Users who manage their own IOVA allocation and do not want DMA API support,
+ * but would still like to take advantage of automatic MSI remapping, can use
+ * this to initialise their own domain appropriately.
+ */
+int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
+		dma_addr_t base, u64 size)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iova_domain *iovad;
+	int ret;
+
+	if (domain->type == IOMMU_DOMAIN_DMA)
+		return -EINVAL;
+
+	ret = iommu_get_dma_cookie(domain);
+	if (ret)
+		return ret;
+
+	ret = iommu_dma_init_domain(domain, base, size, NULL);
+	if (ret) {
+		iommu_put_dma_cookie(domain);
+		return ret;
+	}
+
+	domain->msi_geometry.aperture_start = base;
+	domain->msi_geometry.aperture_end = base + size - 1;
+
+	cookie = domain->iova_cookie;
+	iovad = &cookie->iovad;
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 32c5890..1c55413 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -67,6 +67,9 @@ int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 /* The DMA API isn't _quite_ the whole story, though... */
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 
+int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
+		dma_addr_t base, u64 size);
+
 #else
 
 struct iommu_domain;
@@ -90,6 +93,12 @@ static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
 
+static inline int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
+		dma_addr_t base, u64 size)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.1
