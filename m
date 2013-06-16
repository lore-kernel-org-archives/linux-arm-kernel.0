From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 16 Jun 2013 22:54:10 +0200
Subject: [RFC PATCH 03/11] dma: amba-pl08x: Add support for different offset
 of CONFIG register
In-Reply-To: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1371416058-22047-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some variants of PL08x (namely PL080S, found in Samsung S3C64xx SoCs)
have CONFIG register at different offset. This patch makes the driver
use offset from vendor data struct.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/dma/amba-pl08x.c | 51 ++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 1e57ded..93913b4 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -107,6 +107,7 @@ struct pl08x_driver_data;
  * @flags: Vendor-specific flags, see PL08X_IS_*
  */
 struct vendor_data {
+	u8 config_offset;
 	u8 channels;
 	u32 flags;
 };
@@ -334,11 +335,12 @@ static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
  */
 
 /* Whether a certain channel is busy or not */
-static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
+static int pl08x_phy_channel_busy(struct pl08x_driver_data *pl08x,
+						struct pl08x_phy_chan *ch)
 {
 	unsigned int val;
 
-	val = readl(ch->base + PL080_CH_CONFIG);
+	val = readl(ch->base + pl08x->vd->config_offset);
 	return val & PL080_CONFIG_ACTIVE;
 }
 
@@ -362,7 +364,7 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 	plchan->at = txd;
 
 	/* Wait for channel inactive */
-	while (pl08x_phy_channel_busy(phychan))
+	while (pl08x_phy_channel_busy(pl08x, phychan))
 		cpu_relax();
 
 	lli = &txd->llis_va[0];
@@ -377,7 +379,7 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 	writel(lli->dst, phychan->base + PL080_CH_DST_ADDR);
 	writel(lli->lli, phychan->base + PL080_CH_LLI);
 	writel(lli->cctl, phychan->base + PL080_CH_CONTROL);
-	writel(txd->ccfg, phychan->base + PL080_CH_CONFIG);
+	writel(txd->ccfg, phychan->base + pl08x->vd->config_offset);
 
 	/* Enable the DMA channel */
 	/* Do not access config register until channel shows as disabled */
@@ -385,11 +387,13 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 		cpu_relax();
 
 	/* Do not access config register until channel shows as inactive */
-	val = readl(phychan->base + PL080_CH_CONFIG);
+
+	val = readl(phychan->base + pl08x->vd->config_offset);
 	while ((val & PL080_CONFIG_ACTIVE) || (val & PL080_CONFIG_ENABLE))
-		val = readl(phychan->base + PL080_CH_CONFIG);
+		val = readl(phychan->base + pl08x->vd->config_offset);
 
-	writel(val | PL080_CONFIG_ENABLE, phychan->base + PL080_CH_CONFIG);
+	writel(val | PL080_CONFIG_ENABLE,
+				phychan->base + pl08x->vd->config_offset);
 }
 
 /*
@@ -402,34 +406,36 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
  * For P->M transfers, disable the peripheral first to stop it filling
  * the DMAC FIFO, and then pause the DMAC.
  */
-static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
+static void pl08x_pause_phy_chan(struct pl08x_driver_data *pl08x,
+						struct pl08x_phy_chan *ch)
 {
 	u32 val;
 	int timeout;
 
 	/* Set the HALT bit and wait for the FIFO to drain */
-	val = readl(ch->base + PL080_CH_CONFIG);
+	val = readl(ch->base + pl08x->vd->config_offset);
 	val |= PL080_CONFIG_HALT;
-	writel(val, ch->base + PL080_CH_CONFIG);
+	writel(val, ch->base + pl08x->vd->config_offset);
 
 	/* Wait for channel inactive */
 	for (timeout = 1000; timeout; timeout--) {
-		if (!pl08x_phy_channel_busy(ch))
+		if (!pl08x_phy_channel_busy(pl08x, ch))
 			break;
 		udelay(1);
 	}
-	if (pl08x_phy_channel_busy(ch))
+	if (pl08x_phy_channel_busy(pl08x, ch))
 		pr_err("pl08x: channel%u timeout waiting for pause\n", ch->id);
 }
 
-static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
+static void pl08x_resume_phy_chan(struct pl08x_driver_data *pl08x,
+						struct pl08x_phy_chan *ch)
 {
 	u32 val;
 
 	/* Clear the HALT bit */
-	val = readl(ch->base + PL080_CH_CONFIG);
+	val = readl(ch->base + pl08x->vd->config_offset);
 	val &= ~PL080_CONFIG_HALT;
-	writel(val, ch->base + PL080_CH_CONFIG);
+	writel(val, ch->base + pl08x->vd->config_offset);
 }
 
 /*
@@ -441,12 +447,12 @@ static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
 static void pl08x_terminate_phy_chan(struct pl08x_driver_data *pl08x,
 	struct pl08x_phy_chan *ch)
 {
-	u32 val = readl(ch->base + PL080_CH_CONFIG);
+	u32 val = readl(ch->base + pl08x->vd->config_offset);
 
 	val &= ~(PL080_CONFIG_ENABLE | PL080_CONFIG_ERR_IRQ_MASK |
 	         PL080_CONFIG_TC_IRQ_MASK);
 
-	writel(val, ch->base + PL080_CH_CONFIG);
+	writel(val, ch->base + pl08x->vd->config_offset);
 
 	writel(1 << ch->id, pl08x->base + PL080_ERR_CLEAR);
 	writel(1 << ch->id, pl08x->base + PL080_TC_CLEAR);
@@ -1576,11 +1582,11 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		pl08x_free_txd_list(pl08x, plchan);
 		break;
 	case DMA_PAUSE:
-		pl08x_pause_phy_chan(plchan->phychan);
+		pl08x_pause_phy_chan(pl08x, plchan->phychan);
 		plchan->state = PL08X_CHAN_PAUSED;
 		break;
 	case DMA_RESUME:
-		pl08x_resume_phy_chan(plchan->phychan);
+		pl08x_resume_phy_chan(pl08x, plchan->phychan);
 		plchan->state = PL08X_CHAN_RUNNING;
 		break;
 	default:
@@ -1966,7 +1972,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		if (vd->flags & PL08X_IS_NOMADIK) {
 			u32 val;
 
-			val = readl(ch->base + PL080_CH_CONFIG);
+			val = readl(ch->base + vd->config_offset);
 			if (val & (PL080N_CONFIG_ITPROT | PL080N_CONFIG_SECPROT)) {
 				dev_info(&adev->dev, "physical channel %d reserved for secure access only\n", i);
 				ch->locked = true;
@@ -1974,7 +1980,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 
 		dev_dbg(&adev->dev, "physical channel %d is %s\n",
-			i, pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
+			i, pl08x_phy_channel_busy(pl08x, ch) ? "BUSY" : "FREE");
 	}
 
 	/* Register as many memcpy channels as there are physical channels */
@@ -2049,16 +2055,19 @@ out_no_pl08x:
 static struct vendor_data vendor_pl080 = {
 	.channels = 8,
 	.flags = PL08X_IS_DUALMASTER,
+	.config_offset = PL080_CH_CONFIG,
 };
 
 static struct vendor_data vendor_nomadik = {
 	.channels = 8,
 	.flags = PL08X_IS_DUALMASTER | PL08X_IS_NOMADIK,
+	.config_offset = PL080_CH_CONFIG,
 };
 
 static struct vendor_data vendor_pl081 = {
 	.channels = 2,
 	.flags = 0,
+	.config_offset = PL080_CH_CONFIG,
 };
 
 static struct amba_id pl08x_ids[] = {
-- 
1.8.2.1
