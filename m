From: gking@nvidia.com (gking at nvidia.com)
Date: Wed, 28 Jul 2010 17:57:46 -0700
Subject: [PATCH 1/2] [ARM] dmabounce: add support for low bitmasks in dmabounce
In-Reply-To: <1280365067-21102-1-git-send-email-gking@nvidia.com>
References: <1280365067-21102-1-git-send-email-gking@nvidia.com>
Message-ID: <1280365067-21102-2-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gary King <gking@nvidia.com>

some systems have devices which require DMA bounce buffers due to
alignment restrictions rather than address window restrictions.

detect when a device's DMA mask has low bits set to zero and treat
this as an alignment for DMA pool allocations, but ignore the low
bits for DMA valid window comparisons.

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/common/dmabounce.c |   17 +++++++++++++----
 arch/arm/mm/dma-mapping.c   |    1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index cc0a932..e31a333 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -235,7 +235,8 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		unsigned long mask = *dev->dma_mask;
 		unsigned long limit;
 
-		limit = (mask + 1) & ~mask;
+		limit = (mask - 1) | mask;
+		limit = (limit + 1) & ~limit;
 		if (limit && size > limit) {
 			dev_err(dev, "DMA mapping too big (requested %#x "
 				"mask %#Lx)\n", size, *dev->dma_mask);
@@ -245,7 +246,8 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		/*
 		 * Figure out if we need to bounce from the DMA mask.
 		 */
-		needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;
+		needs_bounce = (dma_addr & ~mask) ||
+			(limit && (dma_addr + size > limit));
 	}
 
 	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
@@ -451,10 +453,17 @@ EXPORT_SYMBOL(dmabounce_sync_for_device);
 static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
 		const char *name, unsigned long size)
 {
+	unsigned int align = 0;
+	if (!(*dev->dma_mask & 0x1))
+		align = 1 << ffs(*dev->dma_mask);
+
+	if (align & (align-1)) {
+		dev_warn(dev, "invalid DMA mask %#llx\n", *dev->dma_mask);
+		return -ENOMEM;
+	}
 	pool->size = size;
 	DO_STATS(pool->allocs = 0);
-	pool->pool = dma_pool_create(name, dev, size,
-				     0 /* byte alignment */,
+	pool->pool = dma_pool_create(name, dev, size, align,
 				     0 /* no page-crossing issues */);
 
 	return pool->pool ? 0 : -ENOMEM;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9e7742f..e257943 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -30,6 +30,7 @@ static u64 get_coherent_dma_mask(struct device *dev)
 
 	if (dev) {
 		mask = dev->coherent_dma_mask;
+		mask = (mask - 1) | mask;
 
 		/*
 		 * Sanity check the DMA mask - it must be non-zero, and
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
