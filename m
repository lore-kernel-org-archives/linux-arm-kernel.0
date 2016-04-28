From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 28 Apr 2016 08:28:38 +0000
Subject: [PATCH v8 7/7] vfio/type1: return MSI mapping requirements with
 VFIO_IOMMU_GET_INFO
In-Reply-To: <1461832118-5668-1-git-send-email-eric.auger@linaro.org>
References: <1461832118-5668-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461832118-5668-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the user-space to know whether MSI addresses need to
be mapped in the IOMMU. The user-space uses VFIO_IOMMU_GET_INFO ioctl and
IOMMU_INFO_REQUIRE_MSI_MAP gets set if they need to.

The computation of the number of IOVA pages to be provided by the user
space will be implemented in a separate patch using capability chains.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v6 -> v7:
- remove the computation of the number of IOVA pages to be provisionned.
  This number depends on the domain/group/device topology which can
  dynamically change. Let's rely instead rely on an arbitrary max depending
  on the system

v4 -> v5:
- move msi_info and ret declaration within the conditional code

v3 -> v4:
- replace former vfio_domains_require_msi_mapping by
  more complex computation of MSI mapping requirements, especially the
  number of pages to be provided by the user-space.
- reword patch title

RFC v1 -> v1:
- derived from
  [RFC PATCH 3/6] vfio: Extend iommu-info to return MSIs automap state
- renamed allow_msi_reconfig into require_msi_mapping
- fixed VFIO_IOMMU_GET_INFO
---
 drivers/vfio/vfio_iommu_type1.c | 26 ++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2fc8197..86d97d9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -310,6 +310,29 @@ static int vaddr_get_pfn(unsigned long vaddr, int prot, unsigned long *pfn)
 }
 
 /*
+ * vfio_domains_require_msi_mapping: return whether MSI doorbells must be
+ * iommu mapped
+ *
+ * returns true if msi mapping is requested
+ */
+static bool vfio_domains_require_msi_mapping(struct vfio_iommu *iommu)
+{
+	struct iommu_domain_msi_geometry msi_geometry;
+	struct vfio_domain *d;
+	bool flag;
+
+	mutex_lock(&iommu->lock);
+	/* All domains have same require_msi_map property, pick first */
+	d = list_first_entry(&iommu->domain_list, struct vfio_domain, next);
+	iommu_domain_get_attr(d->domain, DOMAIN_ATTR_MSI_GEOMETRY,
+			      &msi_geometry);
+	flag = msi_geometry.programmable;
+
+	mutex_unlock(&iommu->lock);
+
+	return flag;
+}
+/*
  * Attempt to pin pages.  We really don't want to track all the pfns and
  * the iommu can only map chunks of consecutive pfns anyway, so get the
  * first page and all consecutive pages with the same locking.
@@ -1166,6 +1189,9 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		info.flags = VFIO_IOMMU_INFO_PGSIZES;
 
+		if (vfio_domains_require_msi_mapping(iommu))
+			info.flags |= VFIO_IOMMU_INFO_REQUIRE_MSI_MAP;
+
 		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
 		return copy_to_user((void __user *)arg, &info, minsz) ?
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 4a9dbc2..3e27263 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -488,6 +488,7 @@ struct vfio_iommu_type1_info {
 	__u32	argsz;
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
+#define VFIO_IOMMU_INFO_REQUIRE_MSI_MAP (1 << 1)/* MSI must be mapped */
 	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
 };
 
@@ -503,6 +504,9 @@ struct vfio_iommu_type1_info {
  * IOVA region that will be used on some platforms to map the host MSI frames.
  * In that specific case, vaddr is ignored. Once registered, an MSI reserved
  * IOVA region stays until the container is closed.
+ * The requirement for provisioning such reserved IOVA range can be checked by
+ * calling VFIO_IOMMU_GET_INFO and testing the VFIO_IOMMU_INFO_REQUIRE_MSI_MAP
+ * flag.
  */
 struct vfio_iommu_type1_dma_map {
 	__u32	argsz;
-- 
1.9.1
