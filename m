From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun,  1 Jan 2012 11:30:06 +0800
Subject: [PATCH] dma/imx-sdma: save irq flags when use spin_lock in
 sdma_tx_submit
Message-ID: <1325388606-20732-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haitao Zhang <minipanda@linuxrobot.org>

mx53_loco: fix deadlock report from sdma_tx_submit() during boot

BugLink: http://bugs.launchpad.net/bugs/878701

Adjust to use spin_lock_irqsave()/spin_unlock_irqresotre(), so to
make it safe when called from interrupt context.

Signed-off-by: Haitao Zhang <haitao.zhang@linaro.org>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f993955..2b7a88b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -832,17 +832,18 @@ static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 
 static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
+	unsigned long flags;
 	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 	dma_cookie_t cookie;
 
-	spin_lock_irq(&sdmac->lock);
+	spin_lock_irqsave(&sdmac->lock, flags);
 
 	cookie = sdma_assign_cookie(sdmac);
 
 	sdma_enable_channel(sdma, sdmac->channel);
 
-	spin_unlock_irq(&sdmac->lock);
+	spin_unlock_irqrestore(&sdmac->lock, flags);
 
 	return cookie;
 }
-- 
1.7.4.1
