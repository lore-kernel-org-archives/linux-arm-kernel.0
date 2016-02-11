From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 11 Feb 2016 15:17:48 +0200
Subject: [PATCH] dmaengine: edma: Fetch echan->edesc while holding lock in
 edma_comletion_handler
Message-ID: <1455196668-9327-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid possible race condition when client drivers are using
dmaengine_terminate_sync() call to disable the channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/edma.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 290e1a721c5b..13b6a23dc06b 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1372,36 +1372,36 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 static void edma_completion_handler(struct edma_chan *echan)
 {
 	struct device *dev = echan->vchan.chan.device->dev;
-	struct edma_desc *edesc = echan->edesc;
-
-	if (!edesc)
-		return;
+	struct edma_desc *edesc;
 
 	spin_lock(&echan->vchan.lock);
-	if (edesc->cyclic) {
-		vchan_cyclic_callback(&edesc->vdesc);
-		spin_unlock(&echan->vchan.lock);
-		return;
-	} else if (edesc->processed == edesc->pset_nr) {
-		edesc->residue = 0;
-		edma_stop(echan);
-		vchan_cookie_complete(&edesc->vdesc);
-		echan->edesc = NULL;
-
-		dev_dbg(dev, "Transfer completed on channel %d\n",
-			echan->ch_num);
-	} else {
-		dev_dbg(dev, "Sub transfer completed on channel %d\n",
-			echan->ch_num);
-
-		edma_pause(echan);
-
-		/* Update statistics for tx_status */
-		edesc->residue -= edesc->sg_len;
-		edesc->residue_stat = edesc->residue;
-		edesc->processed_stat = edesc->processed;
+	edesc = echan->edesc;
+	if (edesc) {
+		if (edesc->cyclic) {
+			vchan_cyclic_callback(&edesc->vdesc);
+			spin_unlock(&echan->vchan.lock);
+			return;
+		} else if (edesc->processed == edesc->pset_nr) {
+			edesc->residue = 0;
+			edma_stop(echan);
+			vchan_cookie_complete(&edesc->vdesc);
+			echan->edesc = NULL;
+
+			dev_dbg(dev, "Transfer completed on channel %d\n",
+				echan->ch_num);
+		} else {
+			dev_dbg(dev, "Sub transfer completed on channel %d\n",
+				echan->ch_num);
+
+			edma_pause(echan);
+
+			/* Update statistics for tx_status */
+			edesc->residue -= edesc->sg_len;
+			edesc->residue_stat = edesc->residue;
+			edesc->processed_stat = edesc->processed;
+		}
+		edma_execute(echan);
 	}
-	edma_execute(echan);
 
 	spin_unlock(&echan->vchan.lock);
 }
-- 
2.7.1
