From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:43:35 +0000
Subject: [PATCH 40/48] ARM: PL08x: shrink srcbus/dstbus in txd structure
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt7n-0003S0-Oq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only need to store the dma address.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   20 ++++++++++----------
 include/linux/amba/pl08x.h |    4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 39970c5..8d8d33c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -595,8 +595,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 	bd.txd = txd;
 	bd.pl08x = pl08x;
-	bd.srcbus.addr = txd->srcbus.addr;
-	bd.dstbus.addr = txd->dstbus.addr;
+	bd.srcbus.addr = txd->src_addr;
+	bd.dstbus.addr = txd->dst_addr;
 
 	/* Find maximum width of the source bus */
 	bd.srcbus.maxwidth =
@@ -1313,8 +1313,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	}
 
 	txd->direction = DMA_NONE;
-	txd->srcbus.addr = src;
-	txd->dstbus.addr = dest;
+	txd->src_addr = src;
+	txd->dst_addr = dest;
 	txd->len = len;
 
 	/* Set platform data for m2m */
@@ -1393,21 +1393,21 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_SRC_INCR;
-		txd->srcbus.addr = sgl->dma_address;
+		txd->src_addr = sgl->dma_address;
 		if (plchan->runtime_addr)
-			txd->dstbus.addr = plchan->runtime_addr;
+			txd->dst_addr = plchan->runtime_addr;
 		else
-			txd->dstbus.addr = plchan->cd->addr;
+			txd->dst_addr = plchan->cd->addr;
 		src_buses = pl08x->mem_buses;
 		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_DST_INCR;
 		if (plchan->runtime_addr)
-			txd->srcbus.addr = plchan->runtime_addr;
+			txd->src_addr = plchan->runtime_addr;
 		else
-			txd->srcbus.addr = plchan->cd->addr;
-		txd->dstbus.addr = sgl->dma_address;
+			txd->src_addr = plchan->cd->addr;
+		txd->dst_addr = sgl->dma_address;
 		src_buses = plchan->cd->periph_buses;
 		dst_buses = pl08x->mem_buses;
 	} else {
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index f858651..4e9e718 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -114,8 +114,8 @@ struct pl08x_txd {
 	struct dma_async_tx_descriptor tx;
 	struct list_head node;
 	enum dma_data_direction	direction;
-	struct pl08x_bus_data srcbus;
-	struct pl08x_bus_data dstbus;
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
 	size_t len;
 	dma_addr_t llis_bus;
 	void *llis_va;
-- 
1.6.2.5
