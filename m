From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 28 Apr 2016 08:15:16 +0000
Subject: [PATCH v8 1/8] iommu: Add iommu_domain_msi_geometry and
 DOMAIN_ATTR_MSI_GEOMETRY
In-Reply-To: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
References: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461831323-5480-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new DOMAIN_ATTR_MSI_GEOMETRY domain attribute. It enables
to query the IOVA window dedicated to MSIs and whether this window is
programmable or fixed/reserved.

x86 IOMMUs will typically expose an MSI aperture matching the 1MB
region [FEE0_0000h - FEF0_000h] corresponding to the the APIC
configuration space and not programmable. On ARM we will report a
programmable region and start/end will be set to 0.

In case the MSI IOVA aperture is programmable, the msi-iommu API needs
to be used to set it.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>

---

v8: creation
- deprecates DOMAIN_ATTR_MSI_MAPPING flag
---
 drivers/iommu/iommu.c | 5 +++++
 include/linux/iommu.h | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b9df141..71ed58f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1498,6 +1498,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	struct iommu_domain_geometry *geometry;
+	struct iommu_domain_msi_geometry *msi_geometry;
 	bool *paging;
 	int ret = 0;
 	u32 *count;
@@ -1508,6 +1509,10 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		*geometry = domain->geometry;
 
 		break;
+	case DOMAIN_ATTR_MSI_GEOMETRY:
+		msi_geometry  = data;
+		*msi_geometry = domain->msi_geometry;
+		break;
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
 		*paging = (domain->ops->pgsize_bitmap != 0UL);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 62a5eae..ea5d288 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -52,6 +52,13 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+struct iommu_domain_msi_geometry {
+	dma_addr_t aperture_start; /* First address used for MSI IOVA    */
+	dma_addr_t aperture_end;   /* Last address used for MSI IOVA     */
+	bool programmable;         /* Is the aperture programmable?	 */
+	/* In case the aperture is programmable, start/end are set to 0 */
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -82,6 +89,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	struct iommu_domain_msi_geometry msi_geometry;
 	void *iova_cookie;
 };
 
@@ -107,6 +115,7 @@ enum iommu_cap {
 
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
+	DOMAIN_ATTR_MSI_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
 	DOMAIN_ATTR_FSL_PAMU_STASH,
-- 
1.9.1
