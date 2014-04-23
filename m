From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Apr 2014 21:52:01 +0200
Subject: [PATCH 1/4] dma: ste_dma40: Maintain spinlock order while handling
 pause
Message-ID: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The runtime PM resume callback needs to be executed while holding the
spinlock, make sure to maintain this for the pause operation as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/dma/ste_dma40.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index bf18c78..6e97cf6 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1495,8 +1495,8 @@ static int d40_pause(struct d40_chan *d40c)
 	if (!d40c->busy)
 		return 0;
 
-	pm_runtime_get_sync(d40c->base->dev);
 	spin_lock_irqsave(&d40c->lock, flags);
+	pm_runtime_get_sync(d40c->base->dev);
 
 	res = d40_channel_execute_command(d40c, D40_DMA_SUSPEND_REQ);
 
-- 
1.7.9.5
