From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon,  9 May 2011 18:11:37 +0200
Subject: [PATCH] dmaengine: at_hdmac: pause: no need to wait for FIFO empty
In-Reply-To: <be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>
References: <be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>
Message-ID: <1304957497-22814-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addition of the pause feature to atc_control an active wait was introduced
to check the FIFO empty event. This event was not always happening and
a timout contition was needed.
But, in some cases, this event depend on the peripheral connected to the
channel that is paused: FIFO becomes empty if the peripheral consumes data.
The timeout is pretty difficult to evaluate. Moreover, this check is not
needed.
In conclusion, it seems sensible to entirely remove the checking of
"FIFO empty" status when pausing.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Vinod,

This additional patch goes on top of your current "next" branch. It is a
removing of some code added to the pause/resume patch sent earlier and can be
folded into this one if you want to.

Thanks, best regards,

Nicolas.

 drivers/dma/at_hdmac.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 2c6bc3a..3134003 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -933,25 +933,9 @@ static int atc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	dev_vdbg(chan2dev(chan), "atc_control (%d)\n", cmd);
 
 	if (cmd == DMA_PAUSE) {
-		int pause_timeout = 1000;
-
 		spin_lock_bh(&atchan->lock);
 
 		dma_writel(atdma, CHER, AT_DMA_SUSP(chan_id));
-
-		/* wait for FIFO to be empty */
-		while (!(dma_readl(atdma, CHSR) & AT_DMA_EMPT(chan_id))) {
-			if (pause_timeout-- > 0) {
-				/* the FIFO can only drain if the peripheral
-				 * is still requesting data:
-				 * -> timeout if it is not the case. */
-				dma_writel(atdma, CHDR, AT_DMA_RES(chan_id));
-				spin_unlock_bh(&atchan->lock);
-				return -ETIMEDOUT;
-			}
-			cpu_relax();
-		}
-
 		set_bit(ATC_IS_PAUSED, &atchan->status);
 
 		spin_unlock_bh(&atchan->lock);
-- 
1.7.3
