From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:13 +0000
Subject: [PATCH v3 02/11] dmaengine: bcm2835: remove unnecessary masking of
 dma channels
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The original patch contained 3 dma channels that were masked out.

These - as far as research and discussions show - are a
artefacts remaining from the downstream legacy dma-api.

Right now down-stream still includes a legacy api used only
in a single (downstream only) driver (bcm2708_fb) that requires
2D DMA for speedup (DMA-channel 0).
Formerly the sd-card support driver also was using this legacy
api (DMA-channel 2), but since has been moved over to use
dmaengine directly.

The DMA-channel 3 is already masked out in the devicetree in
the default property "brcm,dma-channel-mask = <0x7f35>;"

So we can remove the whole masking of DMA channels.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/dma/bcm2835-dma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 2d72fe8..e4ca980 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -123,9 +123,6 @@ struct bcm2835_desc {
 #define BCM2835_DMA_DATA_TYPE_S32	4
 #define BCM2835_DMA_DATA_TYPE_S128	16
 
-#define BCM2835_DMA_BULK_MASK	BIT(0)
-#define BCM2835_DMA_FIQ_MASK	(BIT(2) | BIT(3))
-
 /* Valid only for channels 0 - 14, 15 has its own base address */
 #define BCM2835_DMA_CHAN(n)	((n) << 8) /* Base address */
 #define BCM2835_DMA_CHANIO(base, n) ((base) + BCM2835_DMA_CHAN(n))
@@ -641,12 +638,6 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		goto err_no_dma;
 	}
 
-	/*
-	 * Do not use the FIQ and BULK channels,
-	 * because they are used by the GPU.
-	 */
-	chans_available &= ~(BCM2835_DMA_FIQ_MASK | BCM2835_DMA_BULK_MASK);
-
 	for (i = 0; i < pdev->num_resources; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0)
-- 
2.1.4
