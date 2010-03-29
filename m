From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Mon, 29 Mar 2010 15:14:29 -0700
Subject: [PATCH 2/2] bcmring: fix missing down on semaphore in dma.c
Message-ID: <20100329221429.GC24565@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added missing down on the memMap->lock semaphore. Also fixed a return
statement so that we always exit with an up (i.e. early exit via return
is not allowed)

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/mach-bcmring/dma.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index 7b20fcc..bbcda5e 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -2220,11 +2220,15 @@ EXPORT_SYMBOL(dma_map_create_descriptor_ring);
 int dma_unmap(DMA_MemMap_t *memMap,	/* Stores state information about the map */
 	      int dirtied	/* non-zero if any of the pages were modified */
     ) {
+
+	int rc = 0;
 	int regionIdx;
 	int segmentIdx;
 	DMA_Region_t *region;
 	DMA_Segment_t *segment;
 
+	down(&memMap->lock);
+
 	for (regionIdx = 0; regionIdx < memMap->numRegionsUsed; regionIdx++) {
 		region = &memMap->region[regionIdx];
 
@@ -2238,7 +2242,8 @@ int dma_unmap(DMA_MemMap_t *memMap,	/* Stores state information about the map */
 					printk(KERN_ERR
 					       "%s: vmalloc'd pages are not yet supported\n",
 					       __func__);
-					return -EINVAL;
+					rc = -EINVAL;
+					goto out;
 				}
 
 			case DMA_MEM_TYPE_KMALLOC:
@@ -2275,7 +2280,8 @@ int dma_unmap(DMA_MemMap_t *memMap,	/* Stores state information about the map */
 					printk(KERN_ERR
 					       "%s: Unsupported memory type: %d\n",
 					       __func__, region->memType);
-					return -EINVAL;
+					rc = -EINVAL;
+					goto out;
 				}
 			}
 
@@ -2313,9 +2319,10 @@ int dma_unmap(DMA_MemMap_t *memMap,	/* Stores state information about the map */
 	memMap->numRegionsUsed = 0;
 	memMap->inUse = 0;
 
+out:
 	up(&memMap->lock);
 
-	return 0;
+	return rc;
 }
 
 EXPORT_SYMBOL(dma_unmap);
-- 
1.6.6.1

-- 

Leo Hao Chen

------------------------
Broadcom Canada
