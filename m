From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu,  3 May 2012 17:50:30 -0700
Subject: [PATCH] dma: pl330: assign a new cookie when restarting tx
 descriptors in cyclic mode
Message-ID: <1336092630-20627-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cookie of completed transfer descriptors are marked as zero. In case of
cyclic transfers, a new cookie needs to be assigned to the transfer descriptors
which are picked up from the work_list list before they are re-enabled for
transfer. This prevents hitting BUG_ON in dma_cookie_complete function when
transfer descriptors are recycled from the work_list list.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/dma/pl330.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 2ee6e23..7f8f422 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2265,6 +2265,7 @@ static inline void handle_cyclic_desc_list(struct list_head *list)
 		dma_async_tx_callback callback;
 
 		/* Change status to reload it */
+		dma_cookie_assign(&desc->txd);
 		desc->status = PREP;
 		pch = desc->pchan;
 		callback = desc->txd.callback;
-- 
1.7.5.4
