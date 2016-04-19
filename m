From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 19 Apr 2016 17:24:43 +0000
Subject: [PATCH v7 3/7] vfio/type1: specialize remove_dma and replay according
 to type
In-Reply-To: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
References: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461086687-2658-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
let's implement the expected behavior for removal and replay. As opposed
to user dma slots, the physical pages bound to reserved IOVA do not need
to be pinned/unpinned. Also we currently handle a single reserved iova
domain. Any attempt to remove the single reserved dma slot ends up
deleting the underlying iova domain for each iommu domain.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/vfio_iommu_type1.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2d769d4..93c17d9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
+#include <linux/dma-reserved-iommu.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -445,9 +446,20 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	vfio_lock_acct(-unlocked);
 }
 
+static void vfio_destroy_reserved(struct vfio_iommu *iommu)
+{
+	struct vfio_domain *d;
+
+	list_for_each_entry(d, &iommu->domain_list, next)
+		iommu_free_reserved_iova_domain(d->domain);
+}
+
 static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 {
-	vfio_unmap_unpin(iommu, dma);
+	if (likely(dma->type == VFIO_IOVA_USER))
+		vfio_unmap_unpin(iommu, dma);
+	else
+		vfio_destroy_reserved(iommu);
 	vfio_unlink_dma(iommu, dma);
 	kfree(dma);
 }
@@ -727,6 +739,9 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 		dma = rb_entry(n, struct vfio_dma, node);
 		iova = dma->iova;
 
+		if (dma->type == VFIO_IOVA_RESERVED)
+			continue;
+
 		while (iova < dma->iova + dma->size) {
 			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
 			size_t size;
-- 
1.9.1
