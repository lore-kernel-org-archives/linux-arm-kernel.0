From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:38:52 +0000
Subject: [PATCH 26/48] ARM: PL08x: combine functions to start DMA into one
	function
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt3E-0001ot-Tf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need for pl08x_config_phychan_for_txd(), pl08x_set_cregs()
and pl08x_enable_phy_chan() to be separate - they are always called in
sequence.  Combine them into one function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   98 ++++++++++++++++++----------------------------
 1 files changed, 38 insertions(+), 60 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 202c9e2..c025a4b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -185,37 +185,17 @@ static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
 /*
  * Set the initial DMA register values i.e. those for the first LLI
  * The next LLI pointer and the configuration interrupt bit have
- * been set when the LLIs were constructed
+ * been set when the LLIs were constructed.  Poke them into the hardware
+ * and start the transfer.
  */
-static void pl08x_set_cregs(struct pl08x_driver_data *pl08x,
-			    struct pl08x_phy_chan *ch)
+static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
+	struct pl08x_txd *txd)
 {
-	/* Wait for channel inactive */
-	while (pl08x_phy_channel_busy(ch))
-		cpu_relax();
-
-	dev_vdbg(&pl08x->adev->dev,
-		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
-		 "cctl=0x%08x, clli=0x%08x, ccfg=0x%08x\n",
-		ch->id,
-		ch->csrc,
-		ch->cdst,
-		ch->cctl,
-		ch->clli,
-		ch->ccfg);
-
-	writel(ch->csrc, ch->base + PL080_CH_SRC_ADDR);
-	writel(ch->cdst, ch->base + PL080_CH_DST_ADDR);
-	writel(ch->clli, ch->base + PL080_CH_LLI);
-	writel(ch->cctl, ch->base + PL080_CH_CONTROL);
-	writel(ch->ccfg, ch->base + PL080_CH_CONFIG);
-}
-
-static inline void pl08x_config_phychan_for_txd(struct pl08x_dma_chan *plchan)
-{
-	struct pl08x_channel_data *cd = plchan->cd;
+	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
-	struct pl08x_txd *txd = plchan->at;
+	u32 val;
+
+	plchan->at = txd;
 
 	/* Copy the basic control register calculated at transfer config */
 	phychan->csrc = txd->csrc;
@@ -224,7 +204,7 @@ static inline void pl08x_config_phychan_for_txd(struct pl08x_dma_chan *plchan)
 	phychan->cctl = txd->cctl;
 
 	/* Assign the signal to the proper control registers */
-	phychan->ccfg = cd->ccfg;
+	phychan->ccfg = plchan->cd->ccfg;
 	phychan->ccfg &= ~PL080_CONFIG_SRC_SEL_MASK;
 	phychan->ccfg &= ~PL080_CONFIG_DST_SEL_MASK;
 	/* If it wasn't set from AMBA, ignore it */
@@ -240,32 +220,38 @@ static inline void pl08x_config_phychan_for_txd(struct pl08x_dma_chan *plchan)
 	phychan->ccfg |= PL080_CONFIG_ERR_IRQ_MASK;
 	/* Always enable terminal interrupts */
 	phychan->ccfg |= PL080_CONFIG_TC_IRQ_MASK;
-}
 
-/*
- * Enable the DMA channel
- * Assumes all other configuration bits have been set
- * as desired before this code is called
- */
-static void pl08x_enable_phy_chan(struct pl08x_driver_data *pl08x,
-				  struct pl08x_phy_chan *ch)
-{
-	u32 val;
+	/* Wait for channel inactive */
+	while (pl08x_phy_channel_busy(phychan))
+		cpu_relax();
 
-	/*
-	 * Do not access config register until channel shows as disabled
-	 */
-	while (readl(pl08x->base + PL080_EN_CHAN) & (1 << ch->id))
+	dev_vdbg(&pl08x->adev->dev,
+		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
+		 "cctl=0x%08x, clli=0x%08x, ccfg=0x%08x\n",
+		phychan->id,
+		phychan->csrc,
+		phychan->cdst,
+		phychan->cctl,
+		phychan->clli,
+		phychan->ccfg);
+
+	writel(phychan->csrc, phychan->base + PL080_CH_SRC_ADDR);
+	writel(phychan->cdst, phychan->base + PL080_CH_DST_ADDR);
+	writel(phychan->clli, phychan->base + PL080_CH_LLI);
+	writel(phychan->cctl, phychan->base + PL080_CH_CONTROL);
+	writel(phychan->ccfg, phychan->base + PL080_CH_CONFIG);
+
+	/* Enable the DMA channel */
+	/* Do not access config register until channel shows as disabled */
+	while (readl(pl08x->base + PL080_EN_CHAN) & (1 << phychan->id))
 		cpu_relax();
 
-	/*
-	 * Do not access config register until channel shows as inactive
-	 */
-	val = readl(ch->base + PL080_CH_CONFIG);
+	/* Do not access config register until channel shows as inactive */
+	val = readl(phychan->base + PL080_CH_CONFIG);
 	while ((val & PL080_CONFIG_ACTIVE) || (val & PL080_CONFIG_ENABLE))
-		val = readl(ch->base + PL080_CH_CONFIG);
+		val = readl(phychan->base + PL080_CH_CONFIG);
 
-	writel(val | PL080_CONFIG_ENABLE, ch->base + PL080_CH_CONFIG);
+	writel(val | PL080_CONFIG_ENABLE, phychan->base + PL080_CH_CONFIG);
 }
 
 /*
@@ -1278,7 +1264,6 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 static void pl08x_issue_pending(struct dma_chan *chan)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
-	struct pl08x_driver_data *pl08x = plchan->host;
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->lock, flags);
@@ -1296,13 +1281,9 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 					struct pl08x_txd,
 					node);
 		list_del(&next->node);
-		plchan->at = next;
 		plchan->state = PL08X_CHAN_RUNNING;
 
-		/* Configure the physical channel for the active txd */
-		pl08x_config_phychan_for_txd(plchan);
-		pl08x_set_cregs(pl08x, plchan->phychan);
-		pl08x_enable_phy_chan(pl08x, plchan->phychan);
+		pl08x_start_txd(plchan, next);
 	}
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
@@ -1630,11 +1611,8 @@ static void pl08x_tasklet(unsigned long data)
 					struct pl08x_txd,
 					node);
 		list_del(&next->node);
-		plchan->at = next;
-		/* Configure the physical channel for the next txd */
-		pl08x_config_phychan_for_txd(plchan);
-		pl08x_set_cregs(pl08x, plchan->phychan);
-		pl08x_enable_phy_chan(pl08x, plchan->phychan);
+
+		pl08x_start_txd(plchan, next);
 	} else {
 		struct pl08x_dma_chan *waiting = NULL;
 
-- 
1.6.2.5
