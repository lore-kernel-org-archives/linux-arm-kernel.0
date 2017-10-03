From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:52:57 +0530
Subject: [PATCH 1/4] dmaengine: bcm-sba-raid: serialize dma_cookie_complete()
 using reqs_lock
In-Reply-To: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
References: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008180-27171-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As-per documentation in driver/dma/dmaengine.h, the
dma_cookie_complete() API should be called with lock
held.

This patch ensures that Broadcom SBA RAID driver calls
the dma_cookie_complete() API with reqs_lock held.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 6c2c447..15c5585 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -442,7 +442,9 @@ static void sba_process_received_request(struct sba_device *sba,
 
 		WARN_ON(tx->cookie < 0);
 		if (tx->cookie > 0) {
+			spin_lock_irqsave(&sba->reqs_lock, flags);
 			dma_cookie_complete(tx);
+			spin_unlock_irqrestore(&sba->reqs_lock, flags);
 			dmaengine_desc_get_callback_invoke(tx, NULL);
 			dma_descriptor_unmap(tx);
 			tx->callback = NULL;
-- 
2.7.4
