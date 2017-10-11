From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Oct 2017 16:01:31 +0200
Subject: [PATCH] dmaengine: stm32-mdma: avoid 64-bit division
Message-ID: <20171011140144.3746128-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with a 64-bit dma_addr_t, we run into a link
error:

drivers/dma/stm32-mdma.o: In function `stm32_mdma_prep_dma_memcpy':
stm32-mdma.c:(.text+0x16a3): undefined reference to `__umoddi3'

Using a 64-bit division here is way too expensive, since the
divisor is a known power-of-two value in reality. This moves
the modulo operation into stm32_mdma_get_max_width(), where
the compiler can optimize out that code, and we can use a 32-bit
division to be on the safe side.

Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/stm32-mdma.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 0db59a7e80e0..55151c2c9fae 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -387,7 +387,9 @@ static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
 	}
 }
 
-static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
+static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len,
+							u32 addr,
+							u32 tlen)
 {
 	enum dma_slave_buswidth max_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
 
@@ -398,6 +400,9 @@ static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
 			break;
 	}
 
+	if (addr % max_width)
+		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	return max_width;
 }
 
@@ -567,7 +572,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		ctcr |= STM32_MDMA_CTCR_DBURST((ilog2(dst_best_burst)));
 
 		/* Set memory data size */
-		src_addr_width = stm32_mdma_get_max_width(buf_len, tlen);
+		src_addr_width = stm32_mdma_get_max_width(buf_len, 0, tlen);
 		chan->mem_width = src_addr_width;
 		src_bus_width = stm32_mdma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
@@ -611,7 +616,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		ctcr |= STM32_MDMA_CTCR_SBURST((ilog2(src_best_burst)));
 
 		/* Set memory data size */
-		dst_addr_width = stm32_mdma_get_max_width(buf_len, tlen);
+		dst_addr_width = stm32_mdma_get_max_width(buf_len, 0, tlen);
 		chan->mem_width = dst_addr_width;
 		dst_bus_width = stm32_mdma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
@@ -956,9 +961,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 		ctcr |= STM32_MDMA_CTCR_TLEN((tlen - 1));
 
 		/* Set source best burst size */
-		max_width = stm32_mdma_get_max_width(len, tlen);
-		if (src % max_width)
-			max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		max_width = stm32_mdma_get_max_width(len, src, tlen);
 		src_bus_width = stm32_mdma_get_width(chan, max_width);
 
 		max_burst = tlen / max_width;
@@ -971,9 +974,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 			STM32_MDMA_CTCR_SINCOS(src_bus_width);
 
 		/* Set destination best burst size */
-		max_width = stm32_mdma_get_max_width(len, tlen);
-		if (dest % max_width)
-			max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		max_width = stm32_mdma_get_max_width(len, dest, tlen);
 		dst_bus_width = stm32_mdma_get_width(chan, max_width);
 
 		max_burst = tlen / max_width;
@@ -1014,9 +1015,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 					   STM32_MDMA_MAX_BLOCK_LEN);
 
 			/* Set source best burst size */
-			max_width = stm32_mdma_get_max_width(len, tlen);
-			if (src % max_width)
-				max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+			max_width = stm32_mdma_get_max_width(len, src, tlen);
 			src_bus_width = stm32_mdma_get_width(chan, max_width);
 
 			max_burst = tlen / max_width;
@@ -1030,9 +1029,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 				STM32_MDMA_CTCR_SINCOS(src_bus_width);
 
 			/* Set destination best burst size */
-			max_width = stm32_mdma_get_max_width(len, tlen);
-			if (dest % max_width)
-				max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+			max_width = stm32_mdma_get_max_width(len, dest, tlen);
 			dst_bus_width = stm32_mdma_get_width(chan, max_width);
 
 			max_burst = tlen / max_width;
-- 
2.9.0
