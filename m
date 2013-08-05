From: joelf@ti.com (Joel Fernandes)
Date: Mon, 5 Aug 2013 11:14:57 -0500
Subject: [PATCH v3 12/12] dma: edma: Return if nothing left todo in
 edma_execute
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Message-ID: <1375719297-12871-13-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible edma_execute is called even when all the SG
elements have been submitted for transmission, we add a check
for the same and avoid executing the rest of the function.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index eca1b47..62987fc 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -168,6 +168,9 @@ static void edma_execute(struct edma_chan *echan)
 	total_left = edesc->pset_nr - edesc->total_processed;
 	total_link_set = total_left > MAX_NR_LS ? MAX_NR_LS : total_left;
 
+	if (!total_left)
+		return;
+
 	/* First time, setup 2 cyclically linked sets, each containing half
 	   the slots allocated for this channel */
 	if (edesc->total_processed == 0) {
-- 
1.7.9.5
