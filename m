From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Nov 2013 14:12:00 +0000
Subject: [PATCH 2/2] swiotlb-xen: xen_swiotlb_map_page: do not error out if
 dma_capable fails
In-Reply-To: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
Message-ID: <1384265520-6833-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many ARM devices do not set the dma_mask correctly today.
As a consequence dma_capable fails for them regardless of the address
passed to it.
In xen_swiotlb_map_page we currently use dma_capable to check if the
address returned by the swiotlb is good for dma for the device.
However the check would often fail even if the address is correct.
Considering that we know that the swiotlb buffer has a low address,
skip the check.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/swiotlb-xen.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1eac073..543e30b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -402,13 +402,6 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 					map & ~PAGE_MASK, size, dir, attrs);
 	dev_addr = xen_phys_to_bus(map);
 
-	/*
-	 * Ensure that the address returned is DMA'ble
-	 */
-	if (!dma_capable(dev, dev_addr, size)) {
-		swiotlb_tbl_unmap_single(dev, map, size, dir);
-		dev_addr = 0;
-	}
 	return dev_addr;
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_map_page);
-- 
1.7.2.5
