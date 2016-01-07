From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  7 Jan 2016 17:33:01 +0000
Subject: [PATCH V2 3/8] dmaengine: bcm2835: use shared interrupt for channel
 11 to 14.
In-Reply-To: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 dma channel 11 to 14 only have a single shared irq line,
so this patch implements shared interrupts for these channels.

To avoid changes to the device tree (with regards to interrupts listed,
which reflects on pdev->num_resources) a fixed channel count had
to get used in the code instead.

With this patch applied we now have 11 dma channels available to
the ARM side of the SOC.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/dma/bcm2835-dma.c |   46 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e4ca980..0c04236 100644
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
@@ -127,6 +129,19 @@ struct bcm2835_desc {
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
+#define BCM2835_DMA_IRQ_SHARED_MASK (BIT(11) | BIT(12) | BIT(13) | BIT(14))
+#define BCM2835_DMA_IRQ_SHARED		11
+#define BCM2835_DMA_IRQ_ALL		12
+
 static inline struct bcm2835_dmadev *to_bcm2835_dma_dev(struct dma_device *d)
 {
 	return container_of(d, struct bcm2835_dmadev, ddev);
@@ -215,6 +230,15 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
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
@@ -250,7 +274,8 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	return request_irq(c->irq_number,
-			bcm2835_dma_callback, 0, "DMA IRQ", c);
+			   bcm2835_dma_callback,
+			   c->irq_flags, "DMA IRQ", c);
 }
 
 static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
@@ -526,7 +551,8 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id, int irq)
+static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
+				 int irq, unsigned long irq_flags)
 {
 	struct bcm2835_chan *c;
 
@@ -541,6 +567,7 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id, int irq)
 	c->chan_base = BCM2835_DMA_CHANIO(d->base, chan_id);
 	c->ch = chan_id;
 	c->irq_number = irq;
+	c->irq_flags = irq_flags;
 
 	return 0;
 }
@@ -586,6 +613,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	int rc;
 	int i;
 	int irq;
+	unsigned long irq_flags;
 	uint32_t chans_available;
 
 	if (!pdev->dev.dma_mask)
@@ -638,13 +666,21 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		goto err_no_dma;
 	}
 
-	for (i = 0; i < pdev->num_resources; i++) {
-		irq = platform_get_irq(pdev, i);
+	for (i = 0; i <= BCM2835_DMA_MAX_CHANNEL_NUMBER; i++) {
+		if (BCM2835_DMA_IRQ_SHARED_MASK & BIT(i)) {
+			irq = platform_get_irq(pdev,
+					       BCM2835_DMA_IRQ_SHARED);
+			irq_flags = IRQF_SHARED;
+		} else {
+			irq = platform_get_irq(pdev, i);
+			irq_flags = 0;
+		}
+
 		if (irq < 0)
 			break;
 
 		if (chans_available & (1 << i)) {
-			rc = bcm2835_dma_chan_init(od, i, irq);
+			rc = bcm2835_dma_chan_init(od, i, irq, irq_flags);
 			if (rc)
 				goto err_no_dma;
 		}
-- 
1.7.10.4
