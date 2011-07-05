From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 05 Jul 2011 14:11:51 +0100
Subject: [PATCH 4/9] DMA: PL08x: separately store source/destination slave
	address
In-Reply-To: <20110705131030.GE8286@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
Message-ID: <E1Qe5Pr-0005NO-HQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store the source/destination slave address separately into the channel
structure.  This moves us towards being able to avoid a configuration
call each time we use the channel.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   21 +++++++++------------
 include/linux/amba/pl08x.h |    3 ++-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f043284..d587971 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1102,7 +1102,6 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_channel_data *cd = plchan->cd;
 	enum dma_slave_buswidth addr_width;
-	dma_addr_t addr;
 	u32 maxburst;
 	u32 cctl = 0;
 	int i;
@@ -1113,11 +1112,9 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	/* Transfer direction */
 	plchan->runtime_direction = config->direction;
 	if (config->direction == DMA_TO_DEVICE) {
-		addr = config->dst_addr;
 		addr_width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
 	} else if (config->direction == DMA_FROM_DEVICE) {
-		addr = config->src_addr;
 		addr_width = config->src_addr_width;
 		maxburst = config->src_maxburst;
 	} else {
@@ -1161,7 +1158,11 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 		cctl |= burst_sizes[i].reg;
 	}
 
-	plchan->runtime_addr = addr;
+	if (plchan->runtime_direction == DMA_FROM_DEVICE) {
+		plchan->src_addr = config->src_addr;
+	} else {
+		plchan->dst_addr = config->dst_addr;
+	}
 
 	/* Modify the default channel data to fit PrimeCell request */
 	cd->cctl = cctl;
@@ -1396,19 +1397,13 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_SRC_INCR;
 		txd->src_addr = sgl->dma_address;
-		if (plchan->runtime_addr)
-			txd->dst_addr = plchan->runtime_addr;
-		else
-			txd->dst_addr = plchan->cd->addr;
+		txd->dst_addr = plchan->dst_addr;
 		src_buses = pl08x->mem_buses;
 		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_DST_INCR;
-		if (plchan->runtime_addr)
-			txd->src_addr = plchan->runtime_addr;
-		else
-			txd->src_addr = plchan->cd->addr;
+		txd->src_addr = plchan->src_addr;
 		txd->dst_addr = sgl->dma_address;
 		src_buses = plchan->cd->periph_buses;
 		dst_buses = pl08x->mem_buses;
@@ -1704,6 +1699,8 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			chan->slave = true;
 			chan->name = pl08x->pd->slave_channels[i].bus_id;
 			chan->cd = &pl08x->pd->slave_channels[i];
+			chan->src_addr = chan->cd->addr;
+			chan->dst_addr = chan->cd->addr;
 		} else {
 			chan->cd = &pl08x->pd->memcpy_channel;
 			chan->name = kasprintf(GFP_KERNEL, "memcpy%d", i);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 3111385..072ab28 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -173,7 +173,8 @@ struct pl08x_dma_chan {
 	struct tasklet_struct tasklet;
 	char *name;
 	struct pl08x_channel_data *cd;
-	dma_addr_t runtime_addr;
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
 	enum dma_data_direction	runtime_direction;
 	dma_cookie_t lc;
 	struct list_head pend_list;
-- 
1.7.4.4
