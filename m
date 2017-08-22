From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:54 +0530
Subject: [PATCH v3 05/17] dmaengine: bcm-sba-raid: Remove redundant resp_dma
 from sba_request
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both resp and resp_dma are redundant in sba_request because
resp is unused and resp_dma carries same information present
in tx.phys of sba_request. This patch removes both resp and
resp_dma from sba_request.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index e8863e9..7d08d4e 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -113,8 +113,6 @@ struct sba_request {
 	struct list_head next;
 	atomic_t next_pending_count;
 	/* BRCM message data */
-	void *resp;
-	dma_addr_t resp_dma;
 	struct brcm_sba_command *cmds;
 	struct brcm_message msg;
 	struct dma_async_tx_descriptor tx;
@@ -513,6 +511,7 @@ static void sba_fillup_interrupt_msg(struct sba_request *req,
 {
 	u64 cmd;
 	u32 c_mdata;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	/* Type-B command to load dummy data into buf0 */
@@ -528,7 +527,7 @@ static void sba_fillup_interrupt_msg(struct sba_request *req,
 	cmdsp->cmd = cmd;
 	*cmdsp->cmd_dma = cpu_to_le64(cmd);
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_B;
-	cmdsp->data = req->resp_dma;
+	cmdsp->data = resp_dma;
 	cmdsp->data_len = req->sba->hw_resp_size;
 	cmdsp++;
 
@@ -549,11 +548,11 @@ static void sba_fillup_interrupt_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
-	cmdsp->data = req->resp_dma;
+	cmdsp->data = resp_dma;
 	cmdsp->data_len = req->sba->hw_resp_size;
 	cmdsp++;
 
@@ -600,6 +599,7 @@ static void sba_fillup_memcpy_msg(struct sba_request *req,
 {
 	u64 cmd;
 	u32 c_mdata;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	/* Type-B command to load data into buf0 */
@@ -636,7 +636,7 @@ static void sba_fillup_memcpy_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -719,6 +719,7 @@ static void sba_fillup_xor_msg(struct sba_request *req,
 	u64 cmd;
 	u32 c_mdata;
 	unsigned int i;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	/* Type-B command to load data into buf0 */
@@ -774,7 +775,7 @@ static void sba_fillup_xor_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -863,6 +864,7 @@ static void sba_fillup_pq_msg(struct sba_request *req,
 	u64 cmd;
 	u32 c_mdata;
 	unsigned int i;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	if (pq_continue) {
@@ -956,7 +958,7 @@ static void sba_fillup_pq_msg(struct sba_request *req,
 		cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 		if (req->sba->hw_resp_size) {
 			cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-			cmdsp->resp = req->resp_dma;
+			cmdsp->resp = resp_dma;
 			cmdsp->resp_len = req->sba->hw_resp_size;
 		}
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -983,7 +985,7 @@ static void sba_fillup_pq_msg(struct sba_request *req,
 		cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 		if (req->sba->hw_resp_size) {
 			cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-			cmdsp->resp = req->resp_dma;
+			cmdsp->resp = resp_dma;
 			cmdsp->resp_len = req->sba->hw_resp_size;
 		}
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -1037,6 +1039,7 @@ static void sba_fillup_pq_single_msg(struct sba_request *req,
 	u64 cmd;
 	u32 c_mdata;
 	u8 pos, dpos = raid6_gflog[scf];
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	if (!dst_p)
@@ -1115,7 +1118,7 @@ static void sba_fillup_pq_single_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -1236,7 +1239,7 @@ static void sba_fillup_pq_single_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -1458,7 +1461,7 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
 
 static int sba_prealloc_channel_resources(struct sba_device *sba)
 {
-	int i, j, p, ret = 0;
+	int i, j, ret = 0;
 	struct sba_request *req = NULL;
 
 	sba->resp_base = dma_alloc_coherent(sba->dma_dev.dev,
@@ -1492,16 +1495,13 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		goto fail_free_cmds_pool;
 	}
 
-	for (i = 0, p = 0; i < sba->max_req; i++) {
+	for (i = 0; i < sba->max_req; i++) {
 		req = &sba->reqs[i];
 		INIT_LIST_HEAD(&req->node);
 		req->sba = sba;
 		req->flags = SBA_REQUEST_STATE_FREE;
 		INIT_LIST_HEAD(&req->next);
 		atomic_set(&req->next_pending_count, 0);
-		req->resp = sba->resp_base + p;
-		req->resp_dma = sba->resp_dma_base + p;
-		p += sba->hw_resp_size;
 		req->cmds = devm_kcalloc(sba->dev, sba->max_cmd_per_req,
 					 sizeof(*req->cmds), GFP_KERNEL);
 		if (!req->cmds) {
@@ -1519,7 +1519,7 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		memset(&req->msg, 0, sizeof(req->msg));
 		dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
 		req->tx.tx_submit = sba_tx_submit;
-		req->tx.phys = req->resp_dma;
+		req->tx.phys = sba->resp_dma_base + i * sba->hw_resp_size;
 		list_add_tail(&req->node, &sba->reqs_free_list);
 	}
 
-- 
2.7.4
