From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:55 +0530
Subject: [PATCH v3 06/17] dmaengine: bcm-sba-raid: Remove reqs_free_count from
 sba_device
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-7-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reqs_free_count member of sba_device is not used anywhere
hence no point in tracking number of free sba_request.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 7d08d4e..59ef443 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -162,7 +162,6 @@ struct sba_device {
 	struct list_head reqs_completed_list;
 	struct list_head reqs_aborted_list;
 	struct list_head reqs_free_list;
-	int reqs_free_count;
 };
 
 /* ====== Command helper routines ===== */
@@ -207,10 +206,8 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	spin_lock_irqsave(&sba->reqs_lock, flags);
 	req = list_first_entry_or_null(&sba->reqs_free_list,
 				       struct sba_request, node);
-	if (req) {
+	if (req)
 		list_move_tail(&req->node, &sba->reqs_alloc_list);
-		sba->reqs_free_count--;
-	}
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 	if (!req)
 		return NULL;
@@ -276,7 +273,6 @@ static void _sba_free_request(struct sba_device *sba,
 	list_move_tail(&req->node, &sba->reqs_free_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
-	sba->reqs_free_count++;
 }
 
 static void sba_received_request(struct sba_request *req)
@@ -1523,8 +1519,6 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		list_add_tail(&req->node, &sba->reqs_free_list);
 	}
 
-	sba->reqs_free_count = sba->max_req;
-
 	return 0;
 
 fail_free_cmds_pool:
-- 
2.7.4
