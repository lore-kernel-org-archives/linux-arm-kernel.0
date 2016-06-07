From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 18:38:37 +0100
Subject: [PATCH 4/8] dmaengine: s3c24xx: Simplify code in
 s3c24xx_dma_tx_status()
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465321121-22238-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doing so saves a few lines of code in the driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/s3c24xx-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 17ccdfd..f7d2c7a 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -768,16 +768,12 @@ static enum dma_status s3c24xx_dma_tx_status(struct dma_chan *chan,
 
 	spin_lock_irqsave(&s3cchan->vc.lock, flags);
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE) {
-		spin_unlock_irqrestore(&s3cchan->vc.lock, flags);
-		return ret;
-	}
 
 	/*
 	 * There's no point calculating the residue if there's
 	 * no txstate to store the value.
 	 */
-	if (!txstate) {
+	if (ret == DMA_COMPLETE || !txstate) {
 		spin_unlock_irqrestore(&s3cchan->vc.lock, flags);
 		return ret;
 	}
-- 
1.9.1
