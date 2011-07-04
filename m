From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:48:56 +0100
Subject: [PATCH 04/10] ARM: dmabounce: separate out decision to bounce
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qdeps-0000ZH-IE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the decision to perform DMA bouncing out of map_single() into its
own stand-alone function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |   46 ++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 3e0fa15..643e1d6 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -219,36 +219,46 @@ static struct safe_buffer *find_safe_buffer_dev(struct device *dev,
 	return find_safe_buffer(dev->archdata.dmabounce, dma_addr);
 }
 
-static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
-		enum dma_data_direction dir)
+static int needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
-	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
-	dma_addr_t dma_addr;
-	int needs_bounce = 0;
-
-	if (device_info)
-		DO_STATS ( device_info->map_op_count++ );
-
-	dma_addr = virt_to_dma(dev, ptr);
+	if (!dev || !dev->archdata.dmabounce)
+		return 0;
 
 	if (dev->dma_mask) {
-		unsigned long mask = *dev->dma_mask;
-		unsigned long limit;
+		unsigned long limit, mask = *dev->dma_mask;
 
 		limit = (mask + 1) & ~mask;
 		if (limit && size > limit) {
 			dev_err(dev, "DMA mapping too big (requested %#x "
 				"mask %#Lx)\n", size, *dev->dma_mask);
-			return ~0;
+			return -E2BIG;
 		}
 
-		/*
-		 * Figure out if we need to bounce from the DMA mask.
-		 */
-		needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;
+		/* Figure out if we need to bounce from the DMA mask. */
+		if ((dma_addr | (dma_addr + size - 1)) & ~mask)
+			return 1;
 	}
 
-	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
+	return dma_needs_bounce(dev, dma_addr, size) ? 1 : 0;
+}
+
+static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
+		enum dma_data_direction dir)
+{
+	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
+	dma_addr_t dma_addr;
+	int ret;
+
+	if (device_info)
+		DO_STATS ( device_info->map_op_count++ );
+
+	dma_addr = virt_to_dma(dev, ptr);
+
+	ret = needs_bounce(dev, dma_addr, size);
+	if (ret < 0)
+		return ~0;
+
+	if (ret > 0) {
 		struct safe_buffer *buf;
 
 		buf = alloc_safe_buffer(device_info, ptr, size, dir);
-- 
1.7.4.4
