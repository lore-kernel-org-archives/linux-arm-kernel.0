From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 29 Oct 2015 13:59:45 +0000
Subject: [PATCH] vfio/type1: handle case where IOMMU does not support
 PAGE_SIZE size
Message-ID: <1446127185-2096-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current vfio_pgsize_bitmap code hides the supported IOMMU page
sizes smaller than PAGE_SIZE. As a result, in case the IOMMU
does not support PAGE_SIZE page, the alignment check on map/unmap
is done with larger page sizes, if any. This can fail although
mapping could be done with pages smaller than PAGE_SIZE.

This patch modifies vfio_pgsize_bitmap implementation so that,
in case the IOMMU supports page sizes smaller than PAGE_HOST
we pretend PAGE_HOST is supported and hide sub-PAGE_HOST sizes.
That way the user will be able to map/unmap buffers whose size/
start address is aligned with PAGE_HOST. Pinning code uses that
granularity while iommu driver can use the sub-PAGE_HOST size
to map the buffer.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

---

This was tested on AMD Seattle with 64kB page host. ARM MMU 401
currently expose 4kB, 2MB and 1GB page support. With a 64kB page host,
the map/unmap check is done against 2MB. Some alignment check fail
so VFIO_IOMMU_MAP_DMA fail while we could map using 4kB IOMMU page
size.

RFC -> PATCH v1:
- move all modifications in vfio_pgsize_bitmap following Alex'
  suggestion to expose a fake PAGE_HOST support
- restore WARN_ON's
---
 drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 57d8c37..cee504a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -403,13 +403,26 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 {
 	struct vfio_domain *domain;
-	unsigned long bitmap = PAGE_MASK;
+	unsigned long bitmap = ULONG_MAX;
 
 	mutex_lock(&iommu->lock);
 	list_for_each_entry(domain, &iommu->domain_list, next)
 		bitmap &= domain->domain->ops->pgsize_bitmap;
 	mutex_unlock(&iommu->lock);
 
+	/*
+	 * In case the IOMMU supports page sizes smaller than PAGE_HOST
+	 * we pretend PAGE_HOST is supported and hide sub-PAGE_HOST sizes.
+	 * That way the user will be able to map/unmap buffers whose size/
+	 * start address is aligned with PAGE_HOST. Pinning code uses that
+	 * granularity while iommu driver can use the sub-PAGE_HOST size
+	 * to map the buffer.
+	 */
+	if (bitmap & ~PAGE_MASK) {
+		bitmap &= PAGE_MASK;
+		bitmap |= PAGE_SIZE;
+	}
+
 	return bitmap;
 }
 
-- 
1.9.1
