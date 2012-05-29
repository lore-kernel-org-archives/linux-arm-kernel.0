From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:39:39 +0100
Subject: [RFC 13/34] dmaengine: PL08x: move the bus and increment selection
 to dma prepare function
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZItv-0006zZ-9O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the bus and transfer increment selection to the DMA prepare
function rather than the slave configuration function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 0f27c77..93ad50d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1254,13 +1254,9 @@ static int dma_set_runtime_config(struct dma_chan *chan,
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
@@ -1447,6 +1443,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct scatterlist *sg;
 	dma_addr_t slave_addr;
 	int ret, tmp;
+	u8 src_buses, dst_buses;
+	u32 cctl;
 
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 			__func__, sgl->length, plchan->name);
@@ -1470,11 +1468,15 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
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
@@ -1482,6 +1484,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	txd->cctl = cctl | pl08x_select_bus(src_buses, dst_buses);
+
 	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
 			PL080_FLOW_PER2MEM_PER;
@@ -1778,10 +1782,8 @@ static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
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
