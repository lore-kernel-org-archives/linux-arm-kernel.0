From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  1 Apr 2011 19:19:12 +0200
Subject: [PATCH 1/5] dmaengine: at_hdmac: modify way to use interrupts
Message-ID: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we use Buffer Transfer Completed interrupts. If we
want a chained buffer completed information, we setup the
ATC_IEN bit in CTRLB register in the lli.
This is done by set_desc_eol() function and used by
memcpy/slave_sg functions.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c      |    4 ++--
 drivers/dma/at_hdmac_regs.h |   11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 3d7d705..13050e6 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -464,7 +464,7 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 
 		for (i = 0; i < atdma->dma_common.chancnt; i++) {
 			atchan = &atdma->chan[i];
-			if (pending & (AT_DMA_CBTC(i) | AT_DMA_ERR(i))) {
+			if (pending & (AT_DMA_BTC(i) | AT_DMA_ERR(i))) {
 				if (pending & AT_DMA_ERR(i)) {
 					/* Disable channel on AHB error */
 					dma_writel(atdma, CHDR, atchan->mask);
@@ -549,7 +549,7 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	}
 
 	ctrla =   ATC_DEFAULT_CTRLA;
-	ctrlb =   ATC_DEFAULT_CTRLB
+	ctrlb =   ATC_DEFAULT_CTRLB | ATC_IEN
 		| ATC_SRC_ADDR_MODE_INCR
 		| ATC_DST_ADDR_MODE_INCR
 		| ATC_FC_MEM2MEM;
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 495457e..8303306 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -309,8 +309,8 @@ static void atc_setup_irq(struct at_dma_chan *atchan, int on)
 	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
 	u32		ebci;
 
-	/* enable interrupts on buffer chain completion & error */
-	ebci =    AT_DMA_CBTC(atchan->chan_common.chan_id)
+	/* enable interrupts on buffer transfer completion & error */
+	ebci =    AT_DMA_BTC(atchan->chan_common.chan_id)
 		| AT_DMA_ERR(atchan->chan_common.chan_id);
 	if (on)
 		dma_writel(atdma, EBCIER, ebci);
@@ -347,7 +347,12 @@ static inline int atc_chan_is_enabled(struct at_dma_chan *atchan)
  */
 static void set_desc_eol(struct at_desc *desc)
 {
-	desc->lli.ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
+	u32 ctrlb = desc->lli.ctrlb;
+
+	ctrlb &= ~ATC_IEN;
+	ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
+
+	desc->lli.ctrlb = ctrlb;
 	desc->lli.dscr = 0;
 }
 
-- 
1.7.3
