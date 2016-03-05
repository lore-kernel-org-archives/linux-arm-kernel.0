From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:17 +0000
Subject: [PATCH v3 06/11] dmaengine: bcm2835: move cyclic member from
 bcm2835_chan into bcm2835_desc
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-7-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

In preparation to consolidating code we move the cyclic member
into the bcm_2835_desc structure.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/dma/bcm2835-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 2cdc256..23b01c5 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -73,7 +73,6 @@ struct bcm2835_chan {
 	struct list_head node;
 
 	struct dma_slave_config	cfg;
-	bool cyclic;
 	unsigned int dreq;
 
 	int ch;
@@ -95,6 +94,8 @@ struct bcm2835_desc {
 
 	unsigned int frames;
 	size_t size;
+
+	bool cyclic;
 };
 
 #define BCM2835_DMA_CS		0x00
@@ -403,8 +404,6 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	unsigned long flags;
 
-	c->cyclic = true; /* Nothing else is implemented */
-
 	spin_lock_irqsave(&c->vc.lock, flags);
 	if (vchan_issue_pending(&c->vc) && !c->desc)
 		bcm2835_dma_start_desc(c);
@@ -458,6 +457,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	d->c = c;
 	d->dir = direction;
 	d->frames = buf_len / period_len;
+	d->cyclic = true;
 
 	d->cb_list = kcalloc(d->frames, sizeof(*d->cb_list), GFP_KERNEL);
 	if (!d->cb_list) {
-- 
2.1.4
