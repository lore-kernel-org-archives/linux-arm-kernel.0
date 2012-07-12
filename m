From: stigge@antcom.de (Roland Stigge)
Date: Thu, 12 Jul 2012 14:22:56 +0200
Subject: [PATCH 1/2] mtd: lpc32xx_slc: Adjust to pl08x DMA interface changes
In-Reply-To: <1342095778-13403-1-git-send-email-stigge@antcom.de>
References: <1342095778-13403-1-git-send-email-stigge@antcom.de>
Message-ID: <1342095778-13403-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adjusts the LPC32xx SLC NAND driver to the new pl08x DMA interface,
fixing the compile error resulting from changed pl08x structures.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Applies to today's linux-next (integrated lpc32xx-next and dma branches which collide)

 drivers/mtd/nand/lpc32xx_slc.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 1719387..c8c1d06 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -714,17 +714,6 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
 	return 0;
 }
 
-static bool lpc32xx_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct pl08x_dma_chan *ch =
-		container_of(chan, struct pl08x_dma_chan, chan);
-
-	/* In LPC32xx's PL080 DMA wiring, the SLC NAND DMA signal is #1 */
-	if (ch->cd->min_signal == 1)
-		return true;
-	return false;
-}
-
 static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 {
 	struct mtd_info *mtd = &host->mtd;
@@ -732,7 +721,7 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-	host->dma_chan = dma_request_channel(mask, lpc32xx_dma_filter, NULL);
+	host->dma_chan = dma_request_channel(mask, pl08x_filter_id, "nand-slc");
 	if (!host->dma_chan) {
 		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
 		return -EBUSY;
-- 
1.7.10.4
