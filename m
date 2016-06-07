From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 18:38:40 +0100
Subject: [PATCH 7/8] dmaengine: tegra20-apb-dma: Only calculate residue if
 txstate exists.
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465321121-22238-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point calculating the residue if there is
no txstate to store the value.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 01e316f..7f4af8c 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -814,7 +814,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	unsigned int residual;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
-	if (ret == DMA_COMPLETE)
+	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
 	spin_lock_irqsave(&tdc->lock, flags);
-- 
1.9.1
