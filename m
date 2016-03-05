From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:19 +0000
Subject: [PATCH v3 08/11] dmaengine: bcm2835: limit max length based on
 channel type
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-9-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 dma system has 2 basic types of dma-channels:
* "normal" channels
* "light" channels

Lite channels are limited in several aspects:
* internal data-structure is 128 bit (not 256)
* does not support BCM2835_DMA_TDMODE (2D)
* DMA length register is limited to 16 bit.
  so 0-65535 (not 0-65536 as mentioned in the official datasheet)
* BCM2835_DMA_S/D_IGNORE are not supported

The detection of the type of mode is implemented by looking at
the LITE bit in the DEBUG register for each channel.
This allows automatic detection.

Based on this the maximum block size is set to (64K - 4) or to 1G
and this limit is honored during generation of control block
chains. The effect is that when a LITE channel is used more
control blocks are used to do the same transfer (compared
to a normal channel).

As there are several sources/target DREQS that are 32 bit wide
we need to have the transfer to be a multiple of 4 as this would
break he transfer otherwise.

This is why the limit of (64K - 4) was chosen over the
alternative of (64K - 4K).

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/dma/bcm2835-dma.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 1ae53b8..024c949 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -83,6 +83,8 @@ struct bcm2835_chan {
 
 	int irq_number;
 	unsigned long irq_flags;
+
+	bool is_lite_channel;
 };
 
 struct bcm2835_desc {
@@ -185,6 +187,16 @@ struct bcm2835_desc {
 #define BCM2835_DMA_IRQ_SHARED_DEFAULT	11
 #define BCM2835_DMA_IRQ_ALL_DEFAULT	12
 
+/* the max dma length for different channels */
+#define MAX_DMA_LEN SZ_1G
+#define MAX_LITE_DMA_LEN (SZ_64K - 4)
+
+static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
+{
+	/* lite and normal channels have different max frame length */
+	return c->is_lite_channel ? MAX_LITE_DMA_LEN : MAX_DMA_LEN;
+}
+
 /* how many frames of max_len size do we need to transfer len bytes */
 static inline size_t bcm2835_dma_frames_for_length(size_t len,
 						   size_t max_len)
@@ -233,8 +245,10 @@ static void bcm2835_dma_create_cb_set_length(
 	size_t *total_len,
 	u32 finalextrainfo)
 {
-	/* set the length */
-	control_block->length = len;
+	size_t max_len = bcm2835_dma_max_frame_length(chan);
+
+	/* set the length taking lite-channel limitations into account */
+	control_block->length = min_t(u32, len, max_len);
 
 	/* finished if we have no period_length */
 	if (!period_len)
@@ -570,6 +584,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	dma_addr_t src, dst;
 	u32 info = BCM2835_DMA_WAIT_RESP;
 	u32 extra = BCM2835_DMA_INT_EN;
+	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
 	/* Grab configuration */
@@ -612,7 +627,10 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	}
 
 	/* calculate number of frames */
-	frames = DIV_ROUND_UP(buf_len, period_len);
+	frames = /* number of periods */
+		 DIV_ROUND_UP(buf_len, period_len) *
+		 /* number of frames per period */
+		 bcm2835_dma_frames_for_length(period_len, max_len);
 
 	/*
 	 * allocate the CB chain
@@ -713,6 +731,11 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 	c->irq_number = irq;
 	c->irq_flags = irq_flags;
 
+	/* check in DEBUG register if this is a LITE channel */
+	if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
+		BCM2835_DMA_DEBUG_LITE)
+		c->is_lite_channel = true;
+
 	return 0;
 }
 
-- 
2.1.4
