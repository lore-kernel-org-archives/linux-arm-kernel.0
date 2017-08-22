From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:51 +0530
Subject: [PATCH v3 02/17] dmaengine: bcm-sba-raid: Reduce locking context in
 sba_alloc_request()
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't require to hold "sba->reqs_lock" for long-time
in sba_alloc_request() because lock protection is not
required when initializing members of "struct sba_request".

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 76999b7..f81d5ac 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -207,24 +207,24 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	struct sba_request *req = NULL;
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
-
 	req = list_first_entry_or_null(&sba->reqs_free_list,
 				       struct sba_request, node);
 	if (req) {
 		list_move_tail(&req->node, &sba->reqs_alloc_list);
-		req->state = SBA_REQUEST_STATE_ALLOCED;
-		req->fence = false;
-		req->first = req;
-		INIT_LIST_HEAD(&req->next);
-		req->next_count = 1;
-		atomic_set(&req->next_pending_count, 1);
-
 		sba->reqs_free_count--;
-
-		dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
 	}
-
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	if (!req)
+		return NULL;
+
+	req->state = SBA_REQUEST_STATE_ALLOCED;
+	req->fence = false;
+	req->first = req;
+	INIT_LIST_HEAD(&req->next);
+	req->next_count = 1;
+	atomic_set(&req->next_pending_count, 1);
+
+	dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
 
 	return req;
 }
-- 
2.7.4
