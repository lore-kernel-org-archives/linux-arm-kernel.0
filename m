From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:39:53 +0000
Subject: [PATCH 29/48] ARM: PL08x: assign ccfg DMA request signal in
	prep_phy_channel()
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt4D-0002hZ-8J@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to wait until we start processing a tx descriptor
before setting up the DMA request selection in the ccfg register.
We know which channel and request will be used in prep_phy_channel(),
so setup the ccfg request selection at txd creation time in
prep_phy_channel().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 75f9e2d..f0a2988 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -194,18 +194,10 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
 	struct pl08x_lli *lli = &txd->llis_va[0];
-	u32 val, ccfg = txd->ccfg;
+	u32 val;
 
 	plchan->at = txd;
 
-	/* Assign the flow control signal to this channel */
-	if (txd->direction == DMA_TO_DEVICE)
-		/* Select signal as destination */
-		ccfg |= phychan->signal << PL080_CONFIG_DST_SEL_SHIFT;
-	else if (txd->direction == DMA_FROM_DEVICE)
-		/* Select signal as source */
-		ccfg |= phychan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
-
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(phychan))
 		cpu_relax();
@@ -214,13 +206,13 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
 		"clli=0x%08x, cctl=0x%08x, ccfg=0x%08x\n",
 		phychan->id, lli->src, lli->dst, lli->lli, lli->cctl,
-		ccfg);
+		txd->ccfg);
 
 	writel(lli->src, phychan->base + PL080_CH_SRC_ADDR);
 	writel(lli->dst, phychan->base + PL080_CH_DST_ADDR);
 	writel(lli->lli, phychan->base + PL080_CH_LLI);
 	writel(lli->cctl, phychan->base + PL080_CH_CONTROL);
-	writel(ccfg, phychan->base + PL080_CH_CONFIG);
+	writel(txd->ccfg, phychan->base + PL080_CH_CONFIG);
 
 	/* Enable the DMA channel */
 	/* Do not access config register until channel shows as disabled */
@@ -1001,6 +993,12 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 			return -EBUSY;
 		}
 		ch->signal = ret;
+
+		/* Assign the flow control signal to this channel */
+		if (txd->direction == DMA_TO_DEVICE)
+			txd->ccfg |= ch->signal << PL080_CONFIG_DST_SEL_SHIFT;
+		else if (txd->direction == DMA_FROM_DEVICE)
+			txd->ccfg |= ch->signal << PL080_CONFIG_SRC_SEL_SHIFT;
 	}
 
 	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d and signal %d for xfer on %s\n",
-- 
1.6.2.5
