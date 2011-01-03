From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:39:13 +0000
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd and
	phychan structures
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we now have all the code accessing the phychan {csrc,cdst,clli,cctl,
ccfg} members in one function, there's no point storing the data into
the struct.  Get rid of the struct members.  Re-order the register dump
in the dev_dbg() to reflect the order we write the registers to the DMA
device.

The txd {csrc,cdst,clli,cctl} values are duplicates of the lli[0]
values, so there's no point duplicating these either.  Program the DMAC
registers directly from the lli[0] values.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   57 ++++++++++++++-----------------------------
 include/linux/amba/pl08x.h |   13 ----------
 2 files changed, 19 insertions(+), 51 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c025a4b..a1a18bd 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -193,33 +193,25 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
-	u32 val;
+	struct pl08x_lli *lli = &txd->llis_va[0];
+	u32 val, ccfg;
 
 	plchan->at = txd;
 
-	/* Copy the basic control register calculated at transfer config */
-	phychan->csrc = txd->csrc;
-	phychan->cdst = txd->cdst;
-	phychan->clli = txd->clli;
-	phychan->cctl = txd->cctl;
-
 	/* Assign the signal to the proper control registers */
-	phychan->ccfg = plchan->cd->ccfg;
-	phychan->ccfg &= ~PL080_CONFIG_SRC_SEL_MASK;
-	phychan->ccfg &= ~PL080_CONFIG_DST_SEL_MASK;
+	ccfg = plchan->cd->ccfg;
+	ccfg &= ~(PL080_CONFIG_SRC_SEL_MASK | PL080_CONFIG_DST_SEL_MASK);
+
 	/* If it wasn't set from AMBA, ignore it */
 	if (txd->direction == DMA_TO_DEVICE)
 		/* Select signal as destination */
-		phychan->ccfg |=
-			(phychan->signal << PL080_CONFIG_DST_SEL_SHIFT);
+		ccfg |= phychan->signal << PL080_CONFIG_DST_SEL_SHIFT;
 	else if (txd->direction == DMA_FROM_DEVICE)
 		/* Select signal as source */
-		phychan->ccfg |=
-			(phychan->signal << PL080_CONFIG_SRC_SEL_SHIFT);
-	/* Always enable error interrupts */
-	phychan->ccfg |= PL080_CONFIG_ERR_IRQ_MASK;
-	/* Always enable terminal interrupts */
-	phychan->ccfg |= PL080_CONFIG_TC_IRQ_MASK;
+		ccfg |= phychan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
+
+	/* Always enable error and terminal interrupts */
+	ccfg |= PL080_CONFIG_ERR_IRQ_MASK | PL080_CONFIG_TC_IRQ_MASK;
 
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(phychan))
@@ -227,19 +219,15 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 
 	dev_vdbg(&pl08x->adev->dev,
 		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
-		 "cctl=0x%08x, clli=0x%08x, ccfg=0x%08x\n",
-		phychan->id,
-		phychan->csrc,
-		phychan->cdst,
-		phychan->cctl,
-		phychan->clli,
-		phychan->ccfg);
-
-	writel(phychan->csrc, phychan->base + PL080_CH_SRC_ADDR);
-	writel(phychan->cdst, phychan->base + PL080_CH_DST_ADDR);
-	writel(phychan->clli, phychan->base + PL080_CH_LLI);
-	writel(phychan->cctl, phychan->base + PL080_CH_CONTROL);
-	writel(phychan->ccfg, phychan->base + PL080_CH_CONFIG);
+		"clli=0x%08x, cctl=0x%08x, ccfg=0x%08x\n",
+		phychan->id, lli->src, lli->dst, lli->lli, lli->cctl,
+		ccfg);
+
+	writel(lli->src, phychan->base + PL080_CH_SRC_ADDR);
+	writel(lli->dst, phychan->base + PL080_CH_DST_ADDR);
+	writel(lli->lli, phychan->base + PL080_CH_LLI);
+	writel(lli->cctl, phychan->base + PL080_CH_CONTROL);
+	writel(ccfg, phychan->base + PL080_CH_CONFIG);
 
 	/* Enable the DMA channel */
 	/* Do not access config register until channel shows as disabled */
@@ -920,13 +908,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 */
 	llis_va[num_llis - 1].cctl |= PL080_CONTROL_TC_IRQ_EN;
 
-	/* Now store the channel register values */
-	txd->csrc = llis_va[0].src;
-	txd->cdst = llis_va[0].dst;
-	txd->clli = llis_va[0].lli;
-	txd->cctl = llis_va[0].cctl;
-	/* ccfg will be set at physical channel allocation time */
-
 #ifdef VERBOSE_DEBUG
 	{
 		int i;
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 2c834ed..29d9745 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -95,11 +95,6 @@ struct pl08x_phy_chan {
 	spinlock_t lock;
 	int signal;
 	struct pl08x_dma_chan *serving;
-	u32 csrc;
-	u32 cdst;
-	u32 clli;
-	u32 cctl;
-	u32 ccfg;
 };
 
 /**
@@ -118,14 +113,6 @@ struct pl08x_txd {
 	void *llis_va;
 	struct pl08x_channel_data *cd;
 	bool active;
-	/*
-	 * Settings to be put into the physical channel when we
-	 * trigger this txd
-	 */
-	u32 csrc;
-	u32 cdst;
-	u32 clli;
-	u32 cctl;
 };
 
 /**
-- 
1.6.2.5
