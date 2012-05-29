From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:38:59 +0100
Subject: [RFC 11/34] dmaengine: PL08x: get src/dst addr direct from
 dma_slave_config struct
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZItH-0006zR-2R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dma_slave_config struct to struct pl08x_dma_chan, and move the
src_addr/dst_addr arguments into this struct.  This is a step away
from using the dma_slave_config's direction member.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 0ba1426..f83db39 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -235,8 +235,7 @@ struct pl08x_dma_chan {
 	struct tasklet_struct tasklet;
 	const char *name;
 	const struct pl08x_channel_data *cd;
-	dma_addr_t src_addr;
-	dma_addr_t dst_addr;
+	struct dma_slave_config cfg;
 	u32 src_cctl;
 	u32 dst_cctl;
 	enum dma_transfer_direction runtime_direction;
@@ -1241,6 +1240,8 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 		return -EINVAL;
 	}
 
+	plchan->cfg = *config;
+
 	cctl |= width << PL080_CONTROL_SWIDTH_SHIFT;
 	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
 
@@ -1259,12 +1260,10 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	plchan->device_fc = config->device_fc;
 
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_addr = config->src_addr;
 		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
 			pl08x_select_bus(plchan->cd->periph_buses,
 					 pl08x->mem_buses);
 	} else {
-		plchan->dst_addr = config->dst_addr;
 		plchan->dst_cctl = pl08x_cctl(cctl) | PL080_CONTROL_SRC_INCR |
 			pl08x_select_bus(pl08x->mem_buses,
 					 plchan->cd->periph_buses);
@@ -1478,10 +1477,10 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 
 	if (direction == DMA_MEM_TO_DEV) {
 		txd->cctl = plchan->dst_cctl;
-		slave_addr = plchan->dst_addr;
+		slave_addr = plchan->cfg.dst_addr;
 	} else if (direction == DMA_DEV_TO_MEM) {
 		txd->cctl = plchan->src_cctl;
-		slave_addr = plchan->src_addr;
+		slave_addr = plchan->cfg.src_addr;
 	} else {
 		pl08x_free_txd(pl08x, txd);
 		dev_err(&pl08x->adev->dev,
@@ -1783,8 +1782,8 @@ static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
 
 	chan->slave = true;
 	chan->name = chan->cd->bus_id;
-	chan->src_addr = chan->cd->addr;
-	chan->dst_addr = chan->cd->addr;
+	chan->cfg.src_addr = chan->cd->addr;
+	chan->cfg.dst_addr = chan->cd->addr;
 	chan->src_cctl = cctl | PL080_CONTROL_DST_INCR |
 		pl08x_select_bus(chan->cd->periph_buses, chan->host->mem_buses);
 	chan->dst_cctl = cctl | PL080_CONTROL_SRC_INCR |
-- 
1.7.4.4
