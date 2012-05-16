From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 May 2012 12:06:12 +0100
Subject: [PATCH 4/6] DMA: PL08x: move the bus and increment selection to dma
 prepare function
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <E1SUc3Y-0001mp-El@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the bus and transfer increment selection to the DMA prepare
function rather than the slave configuration function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c2e510a..af62c35 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1199,13 +1199,9 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
 
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
-			pl08x_select_bus(plchan->cd->periph_buses,
-					 pl08x->mem_buses);
+		plchan->src_cctl = pl08x_cctl(cctl);
 	} else {
-		plchan->dst_cctl = pl08x_cctl(cctl) | PL080_CONTROL_SRC_INCR |
-			pl08x_select_bus(pl08x->mem_buses,
-					 plchan->cd->periph_buses);
+		plchan->dst_cctl = pl08x_cctl(cctl);
 	}
 
 	dev_dbg(&pl08x->adev->dev,
@@ -1392,6 +1388,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct scatterlist *sg;
 	dma_addr_t slave_addr;
 	int ret, tmp;
+	u8 src_buses, dst_buses;
+	u32 cctl;
 
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 			__func__, sgl->length, plchan->name);
@@ -1415,11 +1413,15 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	txd->direction = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
-		txd->cctl = plchan->dst_cctl;
+		cctl = plchan->dst_cctl | PL080_CONTROL_SRC_INCR;
 		slave_addr = plchan->cfg.dst_addr;
+		src_buses = pl08x->mem_buses;
+		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_DEV_TO_MEM) {
-		txd->cctl = plchan->src_cctl;
+		cctl = plchan->src_cctl | PL080_CONTROL_DST_INCR;
 		slave_addr = plchan->cfg.src_addr;
+		src_buses = plchan->cd->periph_buses;
+		dst_buses = pl08x->mem_buses;
 	} else {
 		pl08x_free_txd(pl08x, txd);
 		dev_err(&pl08x->adev->dev,
@@ -1427,6 +1429,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	cctl |= pl08x_select_bus(src_buses, dst_buses);
+
 	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
 			PL080_FLOW_PER2MEM_PER;
@@ -1434,7 +1438,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER :
 			PL080_FLOW_PER2MEM;
 
-	txd->ccfg |= tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+	txd->ccfg = cctl | (tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT);
 
 	for_each_sg(sgl, sg, sg_len, tmp) {
 		dsg = kzalloc(sizeof(struct pl08x_sg), GFP_NOWAIT);
@@ -1723,10 +1727,8 @@ static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
 	chan->name = chan->cd->bus_id;
 	chan->cfg.src_addr = chan->cd->addr;
 	chan->cfg.dst_addr = chan->cd->addr;
-	chan->src_cctl = cctl | PL080_CONTROL_DST_INCR |
-		pl08x_select_bus(chan->cd->periph_buses, chan->host->mem_buses);
-	chan->dst_cctl = cctl | PL080_CONTROL_SRC_INCR |
-		pl08x_select_bus(chan->host->mem_buses, chan->cd->periph_buses);
+	chan->src_cctl = cctl;
+	chan->dst_cctl = cctl;
 }
 
 /*
-- 
1.7.4.4
