From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 26 Jul 2017 11:06:40 +0530
Subject: [PATCH 2/6] dma: bcm-sba-raid: Peek mbox when we are left with no
 free requests
In-Reply-To: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1501047404-14456-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should peek mbox channels when we are left with no free
sba_requests in sba_alloc_request()

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 6d15fed..321420b 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -199,6 +199,14 @@ static inline u32 __pure sba_cmd_pq_c_mdata(u32 d, u32 b1, u32 b0)
 
 /* ====== General helper routines ===== */
 
+static void sba_peek_mchans(struct sba_device *sba)
+{
+	int mchan_idx;
+
+	for (mchan_idx = 0; mchan_idx < sba->mchans_count; mchan_idx++)
+		mbox_client_peek_data(sba->mchans[mchan_idx]);
+}
+
 static struct sba_request *sba_alloc_request(struct sba_device *sba)
 {
 	unsigned long flags;
@@ -210,8 +218,17 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	if (req)
 		list_move_tail(&req->node, &sba->reqs_alloc_list);
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
-	if (!req)
+
+	if (!req) {
+		/*
+		 * We have no more free requests so, we peek
+		 * mailbox channels hoping few active requests
+		 * would have completed which will create more
+		 * room for new requests.
+		 */
+		sba_peek_mchans(sba);
 		return NULL;
+	}
 
 	req->flags = SBA_REQUEST_STATE_ALLOCED;
 	req->first = req;
@@ -558,17 +575,15 @@ static enum dma_status sba_tx_status(struct dma_chan *dchan,
 				     dma_cookie_t cookie,
 				     struct dma_tx_state *txstate)
 {
-	int mchan_idx;
 	enum dma_status ret;
 	struct sba_device *sba = to_sba_device(dchan);
 
-	for (mchan_idx = 0; mchan_idx < sba->mchans_count; mchan_idx++)
-		mbox_client_peek_data(sba->mchans[mchan_idx]);
-
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
 
+	sba_peek_mchans(sba);
+
 	return dma_cookie_status(dchan, cookie, txstate);
 }
 
-- 
2.7.4
