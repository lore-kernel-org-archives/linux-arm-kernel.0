From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:56 +0530
Subject: [PATCH v3 07/17] dmaengine: bcm-sba-raid: Allow arbitrary number free
 sba_request
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-8-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we cannot have any arbitrary number of free sba_request
because sba_prealloc_channel_resources() allocates an array of
sba_request using devm_kcalloc() and kcalloc() cannot provide
memory beyond certain size.

This patch removes "reqs" (sba_request array) from sba_device
and makes "cmds" as variable array (instead of pointer) in
sba_request. This helps sba_prealloc_channel_resources() to
allocate sba_request and associated SBA command in one allocation
which in-turn allows arbitrary number of free sba_request.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 59ef443..cd6e3cd 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -113,9 +113,10 @@ struct sba_request {
 	struct list_head next;
 	atomic_t next_pending_count;
 	/* BRCM message data */
-	struct brcm_sba_command *cmds;
 	struct brcm_message msg;
 	struct dma_async_tx_descriptor tx;
+	/* SBA commands */
+	struct brcm_sba_command cmds[0];
 };
 
 enum sba_version {
@@ -153,7 +154,6 @@ struct sba_device {
 	void *cmds_base;
 	dma_addr_t cmds_dma_base;
 	spinlock_t reqs_lock;
-	struct sba_request *reqs;
 	bool reqs_fence;
 	struct list_head reqs_alloc_list;
 	struct list_head reqs_pending_list;
@@ -1484,26 +1484,20 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	INIT_LIST_HEAD(&sba->reqs_aborted_list);
 	INIT_LIST_HEAD(&sba->reqs_free_list);
 
-	sba->reqs = devm_kcalloc(sba->dev, sba->max_req,
-				 sizeof(*req), GFP_KERNEL);
-	if (!sba->reqs) {
-		ret = -ENOMEM;
-		goto fail_free_cmds_pool;
-	}
-
 	for (i = 0; i < sba->max_req; i++) {
-		req = &sba->reqs[i];
+		req = devm_kzalloc(sba->dev,
+				sizeof(*req) +
+				sba->max_cmd_per_req * sizeof(req->cmds[0]),
+				GFP_KERNEL);
+		if (!req) {
+			ret = -ENOMEM;
+			goto fail_free_cmds_pool;
+		}
 		INIT_LIST_HEAD(&req->node);
 		req->sba = sba;
 		req->flags = SBA_REQUEST_STATE_FREE;
 		INIT_LIST_HEAD(&req->next);
 		atomic_set(&req->next_pending_count, 0);
-		req->cmds = devm_kcalloc(sba->dev, sba->max_cmd_per_req,
-					 sizeof(*req->cmds), GFP_KERNEL);
-		if (!req->cmds) {
-			ret = -ENOMEM;
-			goto fail_free_cmds_pool;
-		}
 		for (j = 0; j < sba->max_cmd_per_req; j++) {
 			req->cmds[j].cmd = 0;
 			req->cmds[j].cmd_dma = sba->cmds_base +
-- 
2.7.4
