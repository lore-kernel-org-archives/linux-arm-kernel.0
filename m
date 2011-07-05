From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 05 Jul 2011 14:13:11 +0100
Subject: [PATCH 8/9] DMA: PL08x: avoid recalculating cctl at each prepare
In-Reply-To: <20110705131030.GE8286@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
Message-ID: <E1Qe5R9-0005Ne-WB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have separate cctl values for M>P and P>M transfers, we can
avoid calculating the cctl value each time we prepare a transaction.
Move the bus selection and increment setting to the slave configuration
and initialization functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   78 ++++++++++++++++++++++++---------------------
 1 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 985bc29..4e139d7 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1095,6 +1095,23 @@ static const struct burst_table burst_sizes[] = {
 	},
 };
 
+/*
+ * Given the source and destination available bus masks, select which
+ * will be routed to each port.  We try to have source and destination
+ * on separate ports, but always respect the allowable settings.
+ */
+static u32 pl08x_select_bus(u8 src, u8 dst)
+{
+	u32 cctl = 0;
+
+	if (!(dst & PL08X_AHB1) || ((dst & PL08X_AHB2) && (src & PL08X_AHB1)))
+		cctl |= PL080_CONTROL_DST_AHB2;
+	if (!(src & PL08X_AHB1) || ((src & PL08X_AHB2) && !(dst & PL08X_AHB2)))
+		cctl |= PL080_CONTROL_SRC_AHB2;
+
+	return cctl;
+}
+
 static u32 pl08x_cctl(u32 cctl)
 {
 	cctl &= ~(PL080_CONTROL_SRC_AHB2 | PL080_CONTROL_DST_AHB2 |
@@ -1173,10 +1190,14 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 
 	if (plchan->runtime_direction == DMA_FROM_DEVICE) {
 		plchan->src_addr = config->src_addr;
-		plchan->src_cctl = pl08x_cctl(cctl);
+		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
+			pl08x_select_bus(plchan->cd->periph_buses,
+					 pl08x->mem_buses);
 	} else {
 		plchan->dst_addr = config->dst_addr;
-		plchan->dst_cctl = pl08x_cctl(cctl);
+		plchan->dst_cctl = pl08x_cctl(cctl) | PL080_CONTROL_SRC_INCR |
+			pl08x_select_bus(pl08x->mem_buses,
+					 plchan->cd->periph_buses);
 	}
 
 	dev_dbg(&pl08x->adev->dev,
@@ -1277,23 +1298,6 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	return 0;
 }
 
-/*
- * Given the source and destination available bus masks, select which
- * will be routed to each port.  We try to have source and destination
- * on separate ports, but always respect the allowable settings.
- */
-static u32 pl08x_select_bus(struct pl08x_driver_data *pl08x, u8 src, u8 dst)
-{
-	u32 cctl = 0;
-
-	if (!(dst & PL08X_AHB1) || ((dst & PL08X_AHB2) && (src & PL08X_AHB1)))
-		cctl |= PL080_CONTROL_DST_AHB2;
-	if (!(src & PL08X_AHB1) || ((src & PL08X_AHB2) && !(dst & PL08X_AHB2)))
-		cctl |= PL080_CONTROL_SRC_AHB2;
-
-	return cctl;
-}
-
 static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan,
 	unsigned long flags)
 {
@@ -1345,8 +1349,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	txd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
 
 	if (pl08x->vd->dualmaster)
-		txd->cctl |= pl08x_select_bus(pl08x,
-					pl08x->mem_buses, pl08x->mem_buses);
+		txd->cctl |= pl08x_select_bus(pl08x->mem_buses,
+					      pl08x->mem_buses);
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
@@ -1363,7 +1367,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_txd *txd;
-	u8 src_buses, dst_buses;
 	int ret;
 
 	/*
@@ -1399,26 +1402,20 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-		txd->cctl = plchan->dst_cctl | PL080_CONTROL_SRC_INCR;
+		txd->cctl = plchan->dst_cctl;
 		txd->src_addr = sgl->dma_address;
 		txd->dst_addr = plchan->dst_addr;
-		src_buses = pl08x->mem_buses;
-		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-		txd->cctl = plchan->src_cctl | PL080_CONTROL_DST_INCR;
+		txd->cctl = plchan->src_cctl;
 		txd->src_addr = plchan->src_addr;
 		txd->dst_addr = sgl->dma_address;
-		src_buses = plchan->cd->periph_buses;
-		dst_buses = pl08x->mem_buses;
 	} else {
 		dev_err(&pl08x->adev->dev,
 			"%s direction unsupported\n", __func__);
 		return NULL;
 	}
 
-	txd->cctl |= pl08x_select_bus(pl08x, src_buses, dst_buses);
-
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
 		return NULL;
@@ -1669,6 +1666,20 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 	return mask ? IRQ_HANDLED : IRQ_NONE;
 }
 
+static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
+{
+	u32 cctl = pl08x_cctl(chan->cd->cctl);
+
+	chan->slave = true;
+	chan->name = chan->cd->bus_id;
+	chan->src_addr = chan->cd->addr;
+	chan->dst_addr = chan->cd->addr;
+	chan->src_cctl = cctl | PL080_CONTROL_DST_INCR |
+		pl08x_select_bus(chan->cd->periph_buses, chan->host->mem_buses);
+	chan->dst_cctl = cctl | PL080_CONTROL_SRC_INCR |
+		pl08x_select_bus(chan->host->mem_buses, chan->cd->periph_buses);
+}
+
 /*
  * Initialise the DMAC memcpy/slave channels.
  * Make a local wrapper to hold required data
@@ -1700,13 +1711,8 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 		chan->state = PL08X_CHAN_IDLE;
 
 		if (slave) {
-			chan->slave = true;
-			chan->name = pl08x->pd->slave_channels[i].bus_id;
 			chan->cd = &pl08x->pd->slave_channels[i];
-			chan->src_addr = chan->cd->addr;
-			chan->dst_addr = chan->cd->addr;
-			chan->src_cctl = pl08x_cctl(chan->cd->cctl);
-			chan->dst_cctl = pl08x_cctl(chan->cd->cctl);
+			pl08x_dma_slave_init(chan);
 		} else {
 			chan->cd = &pl08x->pd->memcpy_channel;
 			chan->name = kasprintf(GFP_KERNEL, "memcpy%d", i);
-- 
1.7.4.4
