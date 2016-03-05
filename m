From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:14 +0000
Subject: [PATCH v3 03/11] dmaengine: bcm2835: use shared interrupt for channel
 11 to 14.
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 dma channel 11 to 14 only have a single shared irq line,
so this patch implements shared interrupts for these channels.

This patch also introduces 2 new device-tree properties
(optional for compatibility with older device-trees):
* brcm,dma-channel-shared-mask - default: 0x0780
* brcm,dma-shared-irq-index    - default: 11

With this patch applied we now have 11 dma channels available to
the ARM side of the SOC.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/dma/bcm2835-dma.c | 64 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e4ca980..fe7d5a6 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -81,7 +81,9 @@ struct bcm2835_chan {
 	struct dma_pool *cb_pool;
 
 	void __iomem *chan_base;
+
 	int irq_number;
+	unsigned long irq_flags;
 };
 
 struct bcm2835_desc {
@@ -127,6 +129,20 @@ struct bcm2835_desc {
 #define BCM2835_DMA_CHAN(n)	((n) << 8) /* Base address */
 #define BCM2835_DMA_CHANIO(base, n) ((base) + BCM2835_DMA_CHAN(n))
 
+/*
+ * number of dma channels we support
+ * we do not support DMA channel 15, as it is in a separate IO range,
+ * does not have a separate IRQ line except for the "catch all IRQ line"
+ * finally this channel is used by the firmware so is not available
+ */
+#define BCM2835_DMA_MAX_CHANNEL_NUMBER	14
+
+/* the DMA channels 11 to 14 share a common interrupt */
+#define BCM2835_DMA_IRQ_SHARED_MASK_DEFAULT \
+	(BIT(11) | BIT(12) | BIT(13) | BIT(14))
+#define BCM2835_DMA_IRQ_SHARED_DEFAULT	11
+#define BCM2835_DMA_IRQ_ALL_DEFAULT	12
+
 static inline struct bcm2835_dmadev *to_bcm2835_dma_dev(struct dma_device *d)
 {
 	return container_of(d, struct bcm2835_dmadev, ddev);
@@ -215,6 +231,15 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	struct bcm2835_desc *d;
 	unsigned long flags;
 
+	/* check the shared interrupt */
+	if (c->irq_flags & IRQF_SHARED) {
+		/* check if the interrupt is enabled */
+		flags = readl(c->chan_base + BCM2835_DMA_CS);
+		/* if not set then we are not the reason for the irq */
+		if (!(flags & BCM2835_DMA_INT))
+			return IRQ_NONE;
+	}
+
 	spin_lock_irqsave(&c->vc.lock, flags);
 
 	/* Acknowledge interrupt */
@@ -250,7 +275,8 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	return request_irq(c->irq_number,
-			bcm2835_dma_callback, 0, "DMA IRQ", c);
+			   bcm2835_dma_callback,
+			   c->irq_flags, "DMA IRQ", c);
 }
 
 static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
@@ -526,7 +552,8 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id, int irq)
+static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
+				 int irq, unsigned long irq_flags)
 {
 	struct bcm2835_chan *c;
 
@@ -541,6 +568,7 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id, int irq)
 	c->chan_base = BCM2835_DMA_CHANIO(d->base, chan_id);
 	c->ch = chan_id;
 	c->irq_number = irq;
+	c->irq_flags = irq_flags;
 
 	return 0;
 }
@@ -586,7 +614,8 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	int rc;
 	int i;
 	int irq;
-	uint32_t chans_available;
+	unsigned long irq_flags;
+	u32 chans_available, chans_shared_irq_mask, shared_irq_index;
 
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
@@ -637,14 +666,37 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		rc = -EINVAL;
 		goto err_no_dma;
 	}
+	/* we do not support more channels */
+	chans_available &= BIT(BCM2835_DMA_MAX_CHANNEL_NUMBER + 1) - 1;
+
+	/* get shared irq mask falling back to defaults */
+	chans_shared_irq_mask = BCM2835_DMA_IRQ_SHARED_MASK_DEFAULT;
+	of_property_read_u32(pdev->dev.of_node,
+			     "brcm,dma-channel-shared-mask",
+			     &chans_shared_irq_mask);
+
+	/* get shared irq index falling back to default */
+	shared_irq_index = BCM2835_DMA_IRQ_SHARED_DEFAULT;
+	of_property_read_u32(pdev->dev.of_node,
+			     "brcm,dma-shared-irq-index",
+			     &shared_irq_index);
+
+	/* loop over all channels */
+	for (i = 0; i <= fls(chans_available); i++) {
+		if (chans_shared_irq_mask & BIT(i)) {
+			irq = platform_get_irq(pdev,
+					       shared_irq_index);
+			irq_flags = IRQF_SHARED;
+		} else {
+			irq = platform_get_irq(pdev, i);
+			irq_flags = 0;
+		}
 
-	for (i = 0; i < pdev->num_resources; i++) {
-		irq = platform_get_irq(pdev, i);
 		if (irq < 0)
 			break;
 
 		if (chans_available & (1 << i)) {
-			rc = bcm2835_dma_chan_init(od, i, irq);
+			rc = bcm2835_dma_chan_init(od, i, irq, irq_flags);
 			if (rc)
 				goto err_no_dma;
 		}
-- 
2.1.4
