From: stefan@agner.ch (Stefan Agner)
Date: Sun,  7 Jun 2015 21:46:10 +0200
Subject: [PATCH] dmaengine: fsl-edma: clear pending interrupts on
 initialization
Message-ID: <1433706370-3867-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear pending interrupts before requesting interrupts and move
interrupt initialization after channels have been initialized.
This avoids a NULL pointer dereference panic when using kexec
while DMA requests were running.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/dma/fsl-edma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 09e2842..915eec3 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -881,10 +881,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	}
 
-	ret = fsl_edma_irq_init(pdev, fsl_edma);
-	if (ret)
-		return ret;
-
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
 
 	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
@@ -900,6 +896,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
+	edma_writel(fsl_edma, ~0, fsl_edma->membase + EDMA_INTR);
+	ret = fsl_edma_irq_init(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
-- 
2.4.2
