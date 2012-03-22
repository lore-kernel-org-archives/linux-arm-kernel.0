From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 22 Mar 2012 14:54:15 +0100
Subject: [PATCH v4 15/15] dmaengine: i.MX: Fix merge of cookie branch.
In-Reply-To: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
References: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1332424455-15594-16-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When merging DMA cookie changes a small chunk
of code was dropped. This broke imx-dma driver.

This patch adds this chunk again and fixes the problem.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/dma/imx-dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 2155d82..32b1f86 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -679,6 +679,7 @@ static dma_cookie_t imxdma_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdma->lock, flags);
+	list_move_tail(imxdmac->ld_free.next, &imxdmac->ld_queue);
 	cookie = dma_cookie_assign(tx);
 	spin_unlock_irqrestore(&imxdma->lock, flags);
 
-- 
1.7.0.4
