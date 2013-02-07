From: dirac3000@gmail.com (Alvaro Moran)
Date: Thu,  7 Feb 2013 11:38:43 +0100
Subject: [PATCH 1/1] DMA: PL330: allow submitting 2 requests at a time
Message-ID: <1360233523-20825-1-git-send-email-dirac3000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the original driver design, only one request was processed at a
time by the driver, even if the low-level part of the driver was able to
handle 2 requests.
With this patch we are able to create 2 microcodes per thread and to
launch the second transfer on the interrupt handler of the first one,
instead of having to wait for the tasklet to generate the microcode.

Signed-off-by: Alvaro Moran <dirac3000@gmail.com>
---
 drivers/dma/pl330.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 80680ee..7814f8e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -486,6 +486,8 @@ struct pl330_thread {
 	/* Index of the last submitted request or -1 if the DMA is stopped */
 	int req_running;
 };
+/* We handle two requests at a time */
+#define NR_MAX_REQUESTS	2
 
 enum pl330_dmac_state {
 	UNINIT,
@@ -2276,13 +2278,18 @@ static inline void handle_cyclic_desc_list(struct list_head *list)
 static inline void fill_queue(struct dma_pl330_chan *pch)
 {
 	struct dma_pl330_desc *desc;
+	int busy_reqs = 0;
 	int ret;
 
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
-			break;
+		if (desc->status == BUSY) {
+			busy_reqs++;
+			if (busy_reqs == NR_MAX_REQUESTS)
+				break;
+			continue;
+		}
 
 		ret = pl330_submit_req(pch->pl330_chid,
 						&desc->req);
-- 
1.7.10.4
