From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 05 Jul 2011 14:12:11 +0100
Subject: [PATCH 5/9] DMA: PL08x: separately store source/destination cctl
In-Reply-To: <20110705131030.GE8286@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
Message-ID: <E1Qe5QB-0005NS-L1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store the source/destination cctl values into the channel structure.
This moves us towards being able to avoid a configuration call each
time we use the channel.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   30 ++++++++++++++++--------------
 include/linux/amba/pl08x.h |    2 ++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d587971..cb17d92 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1095,12 +1095,21 @@ static const struct burst_table burst_sizes[] = {
 	},
 };
 
+static u32 pl08x_cctl(u32 cctl)
+{
+	cctl &= ~(PL080_CONTROL_SRC_AHB2 | PL080_CONTROL_DST_AHB2 |
+		  PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR |
+		  PL080_CONTROL_PROT_MASK);
+
+	/* Access the cell in privileged mode, non-bufferable, non-cacheable */
+	return cctl | PL080_CONTROL_PROT_SYS;
+}
+
 static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
-	struct pl08x_channel_data *cd = plchan->cd;
 	enum dma_slave_buswidth addr_width;
 	u32 maxburst;
 	u32 cctl = 0;
@@ -1160,13 +1169,12 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 
 	if (plchan->runtime_direction == DMA_FROM_DEVICE) {
 		plchan->src_addr = config->src_addr;
+		plchan->src_cctl = pl08x_cctl(cctl);
 	} else {
 		plchan->dst_addr = config->dst_addr;
+		plchan->dst_cctl = pl08x_cctl(cctl);
 	}
 
-	/* Modify the default channel data to fit PrimeCell request */
-	cd->cctl = cctl;
-
 	dev_dbg(&pl08x->adev->dev,
 		"configured channel %s (%s) for %s, data width %d, "
 		"maxburst %d words, LE, CCTL=0x%08x\n",
@@ -1385,24 +1393,16 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	txd->direction = direction;
 	txd->len = sgl->length;
 
-	txd->cctl = plchan->cd->cctl &
-			~(PL080_CONTROL_SRC_AHB2 | PL080_CONTROL_DST_AHB2 |
-			  PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR |
-			  PL080_CONTROL_PROT_MASK);
-
-	/* Access the cell in privileged mode, non-bufferable, non-cacheable */
-	txd->cctl |= PL080_CONTROL_PROT_SYS;
-
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-		txd->cctl |= PL080_CONTROL_SRC_INCR;
+		txd->cctl = plchan->dst_cctl | PL080_CONTROL_SRC_INCR;
 		txd->src_addr = sgl->dma_address;
 		txd->dst_addr = plchan->dst_addr;
 		src_buses = pl08x->mem_buses;
 		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-		txd->cctl |= PL080_CONTROL_DST_INCR;
+		txd->cctl = plchan->src_cctl | PL080_CONTROL_DST_INCR;
 		txd->src_addr = plchan->src_addr;
 		txd->dst_addr = sgl->dma_address;
 		src_buses = plchan->cd->periph_buses;
@@ -1701,6 +1701,8 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			chan->cd = &pl08x->pd->slave_channels[i];
 			chan->src_addr = chan->cd->addr;
 			chan->dst_addr = chan->cd->addr;
+			chan->src_cctl = pl08x_cctl(chan->cd->cctl);
+			chan->dst_cctl = pl08x_cctl(chan->cd->cctl);
 		} else {
 			chan->cd = &pl08x->pd->memcpy_channel;
 			chan->name = kasprintf(GFP_KERNEL, "memcpy%d", i);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 072ab28..47cfe31 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -175,6 +175,8 @@ struct pl08x_dma_chan {
 	struct pl08x_channel_data *cd;
 	dma_addr_t src_addr;
 	dma_addr_t dst_addr;
+	u32 src_cctl;
+	u32 dst_cctl;
 	enum dma_data_direction	runtime_direction;
 	dma_cookie_t lc;
 	struct list_head pend_list;
-- 
1.7.4.4
