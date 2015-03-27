From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 27 Mar 2015 13:35:54 +0200
Subject: [PATCH 4/5] dmaengine: hsu: Fix memory leak when stopping a running
 transfer
In-Reply-To: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1427456155-28990-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vd->node is removed from the lists when the transfer started so the
vchan_get_all_descriptors() will not find it. This results memory leak.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/hsu/hsu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 683ba9b62795..d1864bda008f 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -387,7 +387,10 @@ static int hsu_dma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&hsuc->vchan.lock, flags);
 
 	hsu_dma_stop_channel(hsuc);
-	hsuc->desc = NULL;
+	if (hsuc->desc) {
+		hsu_dma_desc_free(&hsuc->desc->vchan);
+		hsuc->desc = NULL;
+	}
 
 	vchan_get_all_descriptors(&hsuc->vchan, &head);
 	spin_unlock_irqrestore(&hsuc->vchan.lock, flags);
-- 
2.3.3
