From: mporter@ti.com (Matt Porter)
Date: Wed, 30 Jan 2013 02:00:21 -0500
Subject: [PATCH v6 02/10] ARM: edma: remove unused transfer controller handlers
In-Reply-To: <1359529229-22207-1-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
Message-ID: <1359529229-22207-3-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build on OMAP, the irqs are undefined on AM33xx.
These error interrupt handlers were hardcoded as disabled
so since they are unused code, simply remove them.

Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/common/edma.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index be3c04a..2dce245 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -494,26 +494,6 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/******************************************************************************
- *
- * Transfer controller error interrupt handlers
- *
- *****************************************************************************/
-
-#define tc_errs_handled	false	/* disabled as long as they're NOPs */
-
-static irqreturn_t dma_tc0err_handler(int irq, void *data)
-{
-	dev_dbg(data, "dma_tc0err_handler\n");
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dma_tc1err_handler(int irq, void *data)
-{
-	dev_dbg(data, "dma_tc1err_handler\n");
-	return IRQ_HANDLED;
-}
-
 static int reserve_contiguous_slots(int ctlr, unsigned int id,
 				     unsigned int num_slots,
 				     unsigned int start_slot)
@@ -1538,23 +1518,6 @@ static int edma_probe(struct platform_device *pdev)
 		arch_num_cc++;
 	}
 
-	if (tc_errs_handled) {
-		status = request_irq(IRQ_TCERRINT0, dma_tc0err_handler, 0,
-					"edma_tc0", &pdev->dev);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "request_irq %d failed --> %d\n",
-				IRQ_TCERRINT0, status);
-			return status;
-		}
-		status = request_irq(IRQ_TCERRINT, dma_tc1err_handler, 0,
-					"edma_tc1", &pdev->dev);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "request_irq %d --> %d\n",
-				IRQ_TCERRINT, status);
-			return status;
-		}
-	}
-
 	return 0;
 
 fail:
-- 
1.7.9.5
