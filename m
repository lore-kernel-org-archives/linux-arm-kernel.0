From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:10 +0000
Subject: [PATCH v14 02/16] iommu: Introduce DOMAIN_ATTR_MSI_RESV
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-3-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new DOMAIN_ATTR_MSI_RESV domain attribute and associated
iommu_domain msi_resv field. It comprises the size and alignment
of the IOVA reserved window dedicated to MSI mapping. This attribute
only is supported when MSI must be IOMMU mapped.

This is the case on ARM.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>

---
v13 -> v14:
- new msi_resv type and name

v12 -> v13:
- reword the commit message

v8 -> v9:
- rename programmable into iommu_msi_supported
- add iommu_domain_msi_aperture_valid

v8: creation
- deprecates DOMAIN_ATTR_MSI_MAPPING flag
---
 include/linux/iommu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..aaeb598 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -52,6 +52,12 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+/* MSI reserved IOVA window requirements */
+struct iommu_domain_msi_resv {
+	size_t size;		/* size in bytes	*/
+	size_t alignment;	/* byte alignment	*/
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -83,6 +89,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	struct iommu_domain_msi_resv msi_resv;
 	void *iova_cookie;
 };
 
@@ -108,6 +115,7 @@ enum iommu_cap {
 
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
+	DOMAIN_ATTR_MSI_RESV,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
 	DOMAIN_ATTR_FSL_PAMU_STASH,
-- 
1.9.1
