From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 May 2012 12:06:52 +0100
Subject: [PATCH 6/6] DMA: PL08x: ignore 'direction' argument in
 dma_slave_config
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <E1SUc4C-0001my-Li@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ignore the direction argument in dma_slave_config, and configure both
directions independently.  We still check that the configuration for
the intended direction is valid; this check will eventually be dropped.
This check is just for debugging at present.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   53 +++++++++++++++-----------------------------
 include/linux/amba/pl08x.h |    3 --
 2 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index bf94156..97f5df4 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1180,50 +1180,31 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
-	enum dma_slave_buswidth addr_width;
-	u32 maxburst, cctl = 0;
+	u32 src_cctl, dst_cctl;
 
 	if (!plchan->slave)
 		return -EINVAL;
 
-	/* Transfer direction */
-	plchan->runtime_direction = config->direction;
-	if (config->direction == DMA_MEM_TO_DEV) {
-		addr_width = config->dst_addr_width;
-		maxburst = config->dst_maxburst;
-	} else if (config->direction == DMA_DEV_TO_MEM) {
-		addr_width = config->src_addr_width;
-		maxburst = config->src_maxburst;
-	} else {
+	dst_cctl = pl08x_get_cctl(plchan, config->dst_addr_width,
+				  config->dst_maxburst);
+	if (dst_cctl == ~0 && config->direction == DMA_MEM_TO_DEV) {
 		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien transfer direction\n");
+			"bad runtime_config: alien address width (M2D)\n");
 		return -EINVAL;
 	}
 
-	cctl = pl08x_get_cctl(plchan, addr_width, maxburst);
-	if (cctl == ~0) {
+	src_cctl = pl08x_get_cctl(plchan, config->src_addr_width,
+				  config->src_maxburst);
+	if (src_cctl == ~0 && config->direction == DMA_DEV_TO_MEM) {
 		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien address width\n");
+			"bad runtime_config: alien address width (D2M)\n");
 		return -EINVAL;
 	}
 
+	plchan->dst_cctl = dst_cctl;
+	plchan->src_cctl = src_cctl;
 	plchan->cfg = *config;
 
-	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_cctl = cctl;
-	} else {
-		plchan->dst_cctl = cctl;
-	}
-
-	dev_dbg(&pl08x->adev->dev,
-		"configured channel %s (%s) for %s, data width %d, "
-		"maxburst %d words, LE, CCTL=0x%08x\n",
-		dma_chan_name(chan), plchan->name,
-		(config->direction == DMA_DEV_TO_MEM) ? "RX" : "TX",
-		addr_width,
-		maxburst,
-		cctl);
-
 	return 0;
 }
 
@@ -1411,11 +1392,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
-	if (direction != plchan->runtime_direction)
-		dev_err(&pl08x->adev->dev, "%s DMA setup does not match "
-			"the direction configured for the PrimeCell\n",
-			__func__);
-
 	/*
 	 * Set up addresses, the PrimeCell configured address
 	 * will take precedence since this may configure the
@@ -1440,6 +1416,13 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	if (cctl == ~0) {
+		pl08x_free_txd(pl08x, txd);
+		dev_err(&pl08x->adev->dev,
+			"DMA slave configuration botched?\n");
+		return NULL;
+	}
+
 	cctl |= pl08x_select_bus(src_buses, dst_buses);
 
 	if (plchan->cfg.device_fc)
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 199ea4b..5f8e6d7 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -100,8 +100,6 @@ enum pl08x_dma_chan_state {
  * @name: name of channel
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
- * @runtime_direction: current direction of this channel according to
- * runtime config
  * @pend_list: queued transactions pending on this channel
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
@@ -121,7 +119,6 @@ struct pl08x_dma_chan {
 	struct dma_slave_config cfg;
 	u32 src_cctl;
 	u32 dst_cctl;
-	enum dma_transfer_direction runtime_direction;
 	struct list_head pend_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
-- 
1.7.4.4
