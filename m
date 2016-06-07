From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 18:38:38 +0100
Subject: [PATCH 5/8] dmaengine: ste_dma40: Only calculate residue if txstate
 exists.
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465321121-22238-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point calculating the residue if there is
no txstate to store the value.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/ste_dma40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 6fb8307..378cc47 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2588,7 +2588,7 @@ static enum dma_status d40_tx_status(struct dma_chan *chan,
 	}
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret != DMA_COMPLETE)
+	if (ret != DMA_COMPLETE && txstate)
 		dma_set_residue(txstate, stedma40_residue(chan));
 
 	if (d40_is_paused(d40c))
-- 
1.9.1
