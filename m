From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Sep 2013 17:10:03 +0100
Subject: [PATCH v6 15/19] swiotlb-xen: call dma_capable only if dev->dma_mask
 is allocated
In-Reply-To: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
Message-ID: <1380298207-29151-15-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/swiotlb-xen.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 790c2eb..3011736 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -512,7 +512,7 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 * buffering it.
 	 */
 	if (!xen_feature(XENFEAT_auto_translated_physmap) &&
-	    dma_capable(dev, dev_addr, size) &&
+	    dev->dma_mask && dma_capable(dev, dev_addr, size) &&
 	    !range_straddles_page_boundary(phys, size) && !swiotlb_force)
 		return dev_addr;
 
@@ -532,7 +532,7 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	/*
 	 * Ensure that the address returned is DMA'ble
 	 */
-	if (!dma_capable(dev, dev_addr, size)) {
+	if (dev->dma_mask && !dma_capable(dev, dev_addr, size)) {
 		swiotlb_tbl_unmap_single(dev, map, size, dir);
 		dev_addr = 0;
 	}
@@ -660,7 +660,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 
 		if (swiotlb_force ||
 		    xen_feature(XENFEAT_auto_translated_physmap) ||
-		    !dma_capable(hwdev, dev_addr, sg->length) ||
+		    (hwdev->dma_mask && !dma_capable(hwdev, dev_addr, sg->length)) ||
 		    range_straddles_page_boundary(paddr, sg->length)) {
 			/*
 			 * Pass the dma_addr of the first slab in the iotlb buffer as
-- 
1.7.2.5
