From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 24 Sep 2015 13:02:05 +0300
Subject: [PATCH v4 18/25] dmaengine: edma: Print warning when linking slots
 from different eDMA
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1443088932-21731-19-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning message in case of linking between paRAM slots in different eDMA
controllers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d759abc80bef..b0102984e98d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -598,6 +598,9 @@ static void edma_free_slot(struct edma_cc *ecc, unsigned slot)
  */
 static void edma_link(struct edma_cc *ecc, unsigned from, unsigned to)
 {
+	if (unlikely(EDMA_CTLR(from) != EDMA_CTLR(to)))
+		dev_warn(ecc->dev, "Ignoring eDMA instance for linking\n");
+
 	from = EDMA_CHAN_SLOT(from);
 	to = EDMA_CHAN_SLOT(to);
 	if (from >= ecc->num_slots || to >= ecc->num_slots)
-- 
2.5.2
