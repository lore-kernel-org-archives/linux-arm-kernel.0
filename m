From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu,  5 Nov 2009 13:44:26 +0900
Subject: [PATCH 2/5] S3C64XX DMA: Unify callback functions for success/failure
Message-ID: <1257396266-32171-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace s3c64xx_dma_tcirq and s3c64xx_dma_errirq with the common
s3c64xx_dma_buffdone.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |   34 +++++++++++++---------------------
 1 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 6fa706f..5a08a86 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -565,26 +565,11 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
 
 EXPORT_SYMBOL(s3c2410_dma_free);
 
-
-static void s3c64xx_dma_tcirq(struct s3c64xx_dmac *dmac, int offs)
-{
-	struct s3c2410_dma_chan *chan = dmac->channels + offs;
-
-	/* note, we currently do not bother to work out which buffer
-	 * or buffers have been completed since the last tc-irq. */
-
-	if (chan->callback_fn)
-		(chan->callback_fn)(chan, chan->curr->pw, 0, S3C2410_RES_OK);
-}
-
-static void s3c64xx_dma_errirq(struct s3c64xx_dmac *dmac, int offs)
-{
-	printk(KERN_DEBUG "%s: offs %d\n", __func__, offs);
-}
-
 static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
 {
 	struct s3c64xx_dmac *dmac = pw;
+	struct s3c2410_dma_chan *chan;
+	enum s3c2410_dma_buffresult res;
 	u32 tcstat, errstat;
 	u32 bit;
 	int offs;
@@ -593,15 +578,22 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
 	errstat = readl(dmac->regs + PL080_ERR_STATUS);
 
 	for (offs = 0, bit = 1; offs < 8; offs++, bit <<= 1) {
+
+		if (!(errstat & bit) && !(tcstat & bit))
+			continue;
+
+		chan = dmac->channels + offs;
+		res = S3C2410_RES_ERR;
+
 		if (tcstat & bit) {
 			writel(bit, dmac->regs + PL080_TC_CLEAR);
-			s3c64xx_dma_tcirq(dmac, offs);
+			res = S3C2410_RES_OK;
 		}
 
-		if (errstat & bit) {
-			s3c64xx_dma_errirq(dmac, offs);
+		if (errstat & bit)
 			writel(bit, dmac->regs + PL080_ERR_CLEAR);
-		}
+
+		s3c64xx_dma_bufffdone(chan, chan->curr, res);
 	}
 
 	return IRQ_HANDLED;
-- 
1.6.2.5
