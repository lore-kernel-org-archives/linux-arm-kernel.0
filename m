From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Mar 2014 11:18:34 +0200
Subject: [PATCH 12/18] dma: edma: Add channel number to debug prints
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1394702320-21743-13-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It helps to identify issues if we have some information regarding to the
channel which the event is associated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 07ac5f4eeb56..47abaac7eb18 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -185,7 +185,8 @@ static void edma_execute(struct edma_chan *echan)
 	edma_resume(echan->ch_num);
 
 	if (edesc->processed <= MAX_NR_SG) {
-		dev_dbg(dev, "first transfer starting %d\n", echan->ch_num);
+		dev_dbg(dev, "first transfer starting on channel %d\n",
+			echan->ch_num);
 		edma_start(echan->ch_num);
 	}
 
@@ -195,7 +196,7 @@ static void edma_execute(struct edma_chan *echan)
 	 * MAX_NR_SG
 	 */
 	if (echan->missed) {
-		dev_dbg(dev, "missed event in execute detected\n");
+		dev_dbg(dev, "missed event on channel %d\n", echan->ch_num);
 		edma_clean_channel(echan->ch_num);
 		edma_stop(echan->ch_num);
 		edma_start(echan->ch_num);
@@ -732,7 +733,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	echan->alloced = true;
 	echan->slot[0] = echan->ch_num;
 
-	dev_dbg(dev, "allocated channel for %u:%u\n",
+	dev_dbg(dev, "allocated channel %d for %u:%u\n", echan->ch_num,
 		EDMA_CTLR(echan->ch_num), EDMA_CHAN_SLOT(echan->ch_num));
 
 	return 0;
-- 
1.9.0
