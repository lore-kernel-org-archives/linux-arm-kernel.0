From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:52 +0100
Subject: [PATCH 48/67] swiotlb: rely on dev->coherent_dma_mask
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-49-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These days the coherent DMA mask is always set, so don't work around the
lack of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index e0b8980334c3..a14fff30ee9d 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -716,15 +716,11 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
-	u64 dma_mask = DMA_BIT_MASK(32);
-
-	if (hwdev && hwdev->coherent_dma_mask)
-		dma_mask = hwdev->coherent_dma_mask;
 
 	ret = (void *)__get_free_pages(flags, order);
 	if (ret) {
 		dev_addr = swiotlb_virt_to_bus(hwdev, ret);
-		if (dev_addr + size - 1 > dma_mask) {
+		if (dev_addr + size - 1 > hwdev->coherent_dma_mask) {
 			/*
 			 * The allocated memory isn't reachable by the device.
 			 */
@@ -747,9 +743,9 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
 
 		/* Confirm address can be DMA'd by device */
-		if (dev_addr + size - 1 > dma_mask) {
+		if (dev_addr + size - 1 > hwdev->coherent_dma_mask) {
 			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
-			       (unsigned long long)dma_mask,
+			       (unsigned long long)hwdev->coherent_dma_mask,
 			       (unsigned long long)dev_addr);
 
 			/*
-- 
2.14.2
