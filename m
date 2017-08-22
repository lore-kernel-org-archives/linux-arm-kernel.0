From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:53 +0530
Subject: [PATCH v3 04/17] dmaengine: bcm-sba-raid: Remove redundant next_count
 from sba_request
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The next_count in sba_request is redundant because same information
is captured by next_pending_count. This patch removes next_count
from sba_request.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 6fa3df1..e8863e9 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -111,7 +111,6 @@ struct sba_request {
 	/* Chained requests management */
 	struct sba_request *first;
 	struct list_head next;
-	unsigned int next_count;
 	atomic_t next_pending_count;
 	/* BRCM message data */
 	void *resp;
@@ -221,7 +220,6 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	req->flags = SBA_REQUEST_STATE_ALLOCED;
 	req->first = req;
 	INIT_LIST_HEAD(&req->next);
-	req->next_count = 1;
 	atomic_set(&req->next_pending_count, 1);
 
 	dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
@@ -342,8 +340,7 @@ static void sba_chain_request(struct sba_request *first,
 
 	list_add_tail(&req->next, &first->next);
 	req->first = first;
-	first->next_count++;
-	atomic_set(&first->next_pending_count, first->next_count);
+	atomic_inc(&first->next_pending_count);
 
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
@@ -1501,7 +1498,6 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		req->sba = sba;
 		req->flags = SBA_REQUEST_STATE_FREE;
 		INIT_LIST_HEAD(&req->next);
-		req->next_count = 1;
 		atomic_set(&req->next_pending_count, 0);
 		req->resp = sba->resp_base + p;
 		req->resp_dma = sba->resp_dma_base + p;
-- 
2.7.4
