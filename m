From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:39:33 +0000
Subject: [PATCH 28/48] ARM: PL08x: move ccfg into txd structure
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt3t-0002P6-3r@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ccfg register is used to configure the channel parameters - the type
and direction of transfer, the flow control signal and IRQ mask enables.
The type and direction of transfer is known in the relevent prep_*
function where a txd is created.  The IRQ mask enables are always set,
and the flow control signals are always set when we start processing a
txd according to phychan->signal.

If we store the ccfg value in the txd structure, we can avoid modifying
platform data - and even having it in platform data at all.

So, remove it from platform data too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   28 ++++++++++++----------------
 include/linux/amba/pl08x.h |    6 +++++-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a1a18bd..75f9e2d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -194,15 +194,11 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
 	struct pl08x_lli *lli = &txd->llis_va[0];
-	u32 val, ccfg;
+	u32 val, ccfg = txd->ccfg;
 
 	plchan->at = txd;
 
-	/* Assign the signal to the proper control registers */
-	ccfg = plchan->cd->ccfg;
-	ccfg &= ~(PL080_CONFIG_SRC_SEL_MASK | PL080_CONFIG_DST_SEL_MASK);
-
-	/* If it wasn't set from AMBA, ignore it */
+	/* Assign the flow control signal to this channel */
 	if (txd->direction == DMA_TO_DEVICE)
 		/* Select signal as destination */
 		ccfg |= phychan->signal << PL080_CONFIG_DST_SEL_SHIFT;
@@ -210,9 +206,6 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 		/* Select signal as source */
 		ccfg |= phychan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
 
-	/* Always enable error and terminal interrupts */
-	ccfg |= PL080_CONFIG_ERR_IRQ_MASK | PL080_CONFIG_TC_IRQ_MASK;
-
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(phychan))
 		cpu_relax();
@@ -1161,8 +1154,6 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 	enum dma_slave_buswidth addr_width;
 	u32 maxburst;
 	u32 cctl = 0;
-	/* Mask out all except src and dst channel */
-	u32 ccfg = cd->ccfg & 0x000003DEU;
 	int i;
 
 	/* Transfer direction */
@@ -1170,13 +1161,11 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 	if (config->direction == DMA_TO_DEVICE) {
 		plchan->runtime_addr = config->dst_addr;
 		cctl |= PL080_CONTROL_SRC_INCR;
-		ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		addr_width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
 	} else if (config->direction == DMA_FROM_DEVICE) {
 		plchan->runtime_addr = config->src_addr;
 		cctl |= PL080_CONTROL_DST_INCR;
-		ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		addr_width = config->src_addr_width;
 		maxburst = config->src_maxburst;
 	} else {
@@ -1226,16 +1215,15 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 
 	/* Modify the default channel data to fit PrimeCell request */
 	cd->cctl = cctl;
-	cd->ccfg = ccfg;
 
 	dev_dbg(&pl08x->adev->dev,
 		"configured channel %s (%s) for %s, data width %d, "
-		"maxburst %d words, LE, CCTL=0x%08x, CCFG=0x%08x\n",
+		"maxburst %d words, LE, CCTL=0x%08x\n",
 		dma_chan_name(chan), plchan->name,
 		(config->direction == DMA_FROM_DEVICE) ? "RX" : "TX",
 		addr_width,
 		maxburst,
-		cctl, ccfg);
+		cctl);
 }
 
 /*
@@ -1340,6 +1328,10 @@ static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
 		dma_async_tx_descriptor_init(&txd->tx, &plchan->chan);
 		txd->tx.tx_submit = pl08x_tx_submit;
 		INIT_LIST_HEAD(&txd->node);
+
+		/* Always enable error and terminal interrupts */
+		txd->ccfg = PL080_CONFIG_ERR_IRQ_MASK |
+			    PL080_CONFIG_TC_IRQ_MASK;
 	}
 	return txd;
 }
@@ -1369,6 +1361,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 
 	/* Set platform data for m2m */
 	txd->cd = &pl08x->pd->memcpy_channel;
+	txd->ccfg |= PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+
 	/* Both to be incremented or the code will break */
 	txd->cd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
 	txd->len = len;
@@ -1424,12 +1418,14 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	 */
 	txd->direction = direction;
 	if (direction == DMA_TO_DEVICE) {
+		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->srcbus.addr = sgl->dma_address;
 		if (plchan->runtime_addr)
 			txd->dstbus.addr = plchan->runtime_addr;
 		else
 			txd->dstbus.addr = plchan->cd->addr;
 	} else if (direction == DMA_FROM_DEVICE) {
+		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		if (plchan->runtime_addr)
 			txd->srcbus.addr = plchan->runtime_addr;
 		else
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 29d9745..8e74cb1 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -58,7 +58,6 @@ struct pl08x_channel_data {
 	int max_signal;
 	u32 muxval;
 	u32 cctl;
-	u32 ccfg;
 	dma_addr_t addr;
 	bool circular_buffer;
 	bool single;
@@ -113,6 +112,11 @@ struct pl08x_txd {
 	void *llis_va;
 	struct pl08x_channel_data *cd;
 	bool active;
+	/*
+	 * Settings to be put into the physical channel when we
+	 * trigger this txd.  Other registers are in llis_va[0].
+	 */
+	u32 ccfg;
 };
 
 /**
-- 
1.6.2.5
