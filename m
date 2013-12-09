From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 9 Dec 2013 16:06:00 +0000
Subject: [PATCH] xen/arm64: do not call the swiotlb functions twice
Message-ID: <1386605160-3185-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64 the dma_map_ops implementation is based on the swiotlb.
swiotlb-xen, used by default in dom0 on Xen, is also based on the
swiotlb.

Avoid calling into the default arm64 dma_map_ops functions from
xen_dma_map_page, xen_dma_unmap_page, xen_dma_sync_single_for_cpu, and
xen_dma_sync_single_for_device otherwise we end up calling into the
swiotlb twice.

When arm64 gets a non-swiotlb based implementation of dma_map_ops, we'll
probably have to reintroduce dma_map_ops calls in page-coherent.h.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: catalin.marinas at arm.com
CC: Will.Deacon at arm.com
CC: Ian.Campbell at citrix.com
---
 arch/arm64/include/asm/xen/page-coherent.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
index 2820f1a..dde3fc9 100644
--- a/arch/arm64/include/asm/xen/page-coherent.h
+++ b/arch/arm64/include/asm/xen/page-coherent.h
@@ -23,25 +23,21 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
-	__generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
 }
 
 static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
 }
 
 static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
 }
 
 static inline void xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
 }
 #endif /* _ASM_ARM64_XEN_PAGE_COHERENT_H */
-- 
1.7.10.4
