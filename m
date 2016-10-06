From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:27 +0000
Subject: [PATCH v13 11/15] vfio/type1: Handle unmap/unpin and replay for
 VFIO_IOVA_RESERVED slots
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1475743531-4780-12-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
let's implement the expected behavior for removal and replay.

As opposed to user dma slots, reserved IOVAs are not systematically bound
to PAs and PAs are not pinned. VFIO just initializes the IOVA "aperture".
IOVAs are allocated outside of the VFIO framework, by the MSI layer which
is responsible to free and unmap them. The MSI mapping resources are freeed
by the IOMMU driver on domain destruction.

On the creation of a new domain, the "replay" of a reserved slot simply
needs to set the MSI aperture on the new domain.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v12 -> v13:
- use dma-iommu iommu_get_dma_msi_region_cookie

v9 -> v10:
- replay of a reserved slot sets the MSI aperture on the new domain
- use VFIO_IOVA_RESERVED_MSI enum value instead of VFIO_IOVA_RESERVED

v7 -> v8:
- do no destroy anything anymore, just bypass unmap/unpin and iommu_map
  on replay
---
 drivers/vfio/Kconfig            |  1 +
 drivers/vfio/vfio_iommu_type1.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index da6e2ce..673ec79 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -1,6 +1,7 @@
 config VFIO_IOMMU_TYPE1
 	tristate
 	depends on VFIO
+	select IOMMU_DMA
 	default n
 
 config VFIO_IOMMU_SPAPR_TCE
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 65a4038..5bc5fc9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
+#include <linux/dma-iommu.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -387,7 +388,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	struct vfio_domain *domain, *d;
 	long unlocked = 0;
 
-	if (!dma->size)
+	if (!dma->size || dma->type != VFIO_IOVA_USER)
 		return;
 	/*
 	 * We use the IOMMU to track the physical addresses, otherwise we'd
@@ -724,6 +725,13 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 		dma = rb_entry(n, struct vfio_dma, node);
 		iova = dma->iova;
 
+		if (dma->type == VFIO_IOVA_RESERVED_MSI) {
+			ret = iommu_get_dma_msi_region_cookie(domain->domain,
+						     dma->iova, dma->size);
+			WARN_ON(ret);
+			continue;
+		}
+
 		while (iova < dma->iova + dma->size) {
 			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
 			size_t size;
-- 
1.9.1
