From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu,  2 Jun 2011 21:59:36 +0300
Subject: [PATCH v2 3/5] net: ep93xx_eth: allocate buffers using kmalloc()
In-Reply-To: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
Message-ID: <7b20107efa24e0a0c956663ddc70b2189f64c04b.1307040443.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use simply kmalloc() to allocate the buffers. This also simplifies the
code and allows us to perform DMA sync operations more easily.

Memory is allocated with only GFP_KERNEL since there are no DMA allocation
restrictions on this platform.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/arm/ep93xx_eth.c |   51 ++++++++++++++++-------------------------
 1 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/net/arm/ep93xx_eth.c b/drivers/net/arm/ep93xx_eth.c
index 8779d3b..0c9df11 100644
--- a/drivers/net/arm/ep93xx_eth.c
+++ b/drivers/net/arm/ep93xx_eth.c
@@ -463,36 +463,32 @@ static void ep93xx_free_buffers(struct ep93xx_priv *ep)
 	struct device *dev = ep->dma_dev;
 	int i;
 
-	for (i = 0; i < RX_QUEUE_ENTRIES; i += 2) {
+	for (i = 0; i < RX_QUEUE_ENTRIES; i++) {
 		dma_addr_t d;
 
 		d = ep->descs->rdesc[i].buf_addr;
 		if (d)
-			dma_unmap_single(dev, d, PAGE_SIZE, DMA_FROM_DEVICE);
+			dma_unmap_single(dev, d, PKT_BUF_SIZE, DMA_FROM_DEVICE);
 
 		if (ep->rx_buf[i] != NULL)
-			free_page((unsigned long)ep->rx_buf[i]);
+			kfree(ep->rx_buf[i]);
 	}
 
-	for (i = 0; i < TX_QUEUE_ENTRIES; i += 2) {
+	for (i = 0; i < TX_QUEUE_ENTRIES; i++) {
 		dma_addr_t d;
 
 		d = ep->descs->tdesc[i].buf_addr;
 		if (d)
-			dma_unmap_single(dev, d, PAGE_SIZE, DMA_TO_DEVICE);
+			dma_unmap_single(dev, d, PKT_BUF_SIZE, DMA_TO_DEVICE);
 
 		if (ep->tx_buf[i] != NULL)
-			free_page((unsigned long)ep->tx_buf[i]);
+			kfree(ep->tx_buf[i]);
 	}
 
 	dma_free_coherent(dev, sizeof(struct ep93xx_descs), ep->descs,
 							ep->descs_dma_addr);
 }
 
-/*
- * The hardware enforces a sub-2K maximum packet size, so we put
- * two buffers on every hardware page.
- */
 static int ep93xx_alloc_buffers(struct ep93xx_priv *ep)
 {
 	struct device *dev = ep->dma_dev;
@@ -503,48 +499,41 @@ static int ep93xx_alloc_buffers(struct ep93xx_priv *ep)
 	if (ep->descs == NULL)
 		return 1;
 
-	for (i = 0; i < RX_QUEUE_ENTRIES; i += 2) {
-		void *page;
+	for (i = 0; i < RX_QUEUE_ENTRIES; i++) {
+		void *buf;
 		dma_addr_t d;
 
-		page = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
-		if (page == NULL)
+		buf = kmalloc(PKT_BUF_SIZE, GFP_KERNEL);
+		if (buf == NULL)
 			goto err;
 
-		d = dma_map_single(dev, page, PAGE_SIZE, DMA_FROM_DEVICE);
+		d = dma_map_single(dev, buf, PKT_BUF_SIZE, DMA_FROM_DEVICE);
 		if (dma_mapping_error(dev, d)) {
-			free_page((unsigned long)page);
+			kfree(buf);
 			goto err;
 		}
 
-		ep->rx_buf[i] = page;
+		ep->rx_buf[i] = buf;
 		ep->descs->rdesc[i].buf_addr = d;
 		ep->descs->rdesc[i].rdesc1 = (i << 16) | PKT_BUF_SIZE;
-
-		ep->rx_buf[i + 1] = page + PKT_BUF_SIZE;
-		ep->descs->rdesc[i + 1].buf_addr = d + PKT_BUF_SIZE;
-		ep->descs->rdesc[i + 1].rdesc1 = ((i + 1) << 16) | PKT_BUF_SIZE;
 	}
 
-	for (i = 0; i < TX_QUEUE_ENTRIES; i += 2) {
-		void *page;
+	for (i = 0; i < TX_QUEUE_ENTRIES; i++) {
+		void *buf;
 		dma_addr_t d;
 
-		page = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
-		if (page == NULL)
+		buf = kmalloc(PKT_BUF_SIZE, GFP_KERNEL);
+		if (buf == NULL)
 			goto err;
 
-		d = dma_map_single(dev, page, PAGE_SIZE, DMA_TO_DEVICE);
+		d = dma_map_single(dev, buf, PKT_BUF_SIZE, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, d)) {
-			free_page((unsigned long)page);
+			kfree(buf);
 			goto err;
 		}
 
-		ep->tx_buf[i] = page;
+		ep->tx_buf[i] = buf;
 		ep->descs->tdesc[i].buf_addr = d;
-
-		ep->tx_buf[i + 1] = page + PKT_BUF_SIZE;
-		ep->descs->tdesc[i + 1].buf_addr = d + PKT_BUF_SIZE;
 	}
 
 	return 0;
-- 
1.7.4.4
