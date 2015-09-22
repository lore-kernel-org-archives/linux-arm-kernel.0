From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 22 Sep 2015 12:54:12 +0300
Subject: [PATCH v3 01/24] ARM: common: edma: Fix channel parameter for irq
 callbacks
In-Reply-To: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1442915675-7121-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case when the interrupt happened for the second eDMA the channel
number was incorrectly passed to the client driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <stable@vger.kernel.org>
---
 arch/arm/common/edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 873dbfcc7dc9..56fc339571f9 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -406,7 +406,8 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 					BIT(slot));
 			if (edma_cc[ctlr]->intr_data[channel].callback)
 				edma_cc[ctlr]->intr_data[channel].callback(
-					channel, EDMA_DMA_COMPLETE,
+					EDMA_CTLR_CHAN(ctlr, channel),
+					EDMA_DMA_COMPLETE,
 					edma_cc[ctlr]->intr_data[channel].data);
 		}
 	} while (sh_ipr);
@@ -460,7 +461,8 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 					if (edma_cc[ctlr]->intr_data[k].
 								callback) {
 						edma_cc[ctlr]->intr_data[k].
-						callback(k,
+						callback(
+						EDMA_CTLR_CHAN(ctlr, k),
 						EDMA_DMA_CC_ERROR,
 						edma_cc[ctlr]->intr_data
 						[k].data);
-- 
2.5.2
