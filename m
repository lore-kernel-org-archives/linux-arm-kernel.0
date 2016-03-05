From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:21 +0000
Subject: [PATCH v3 10/11] dmaengine: bcm2835: add dma_memcopy support to
 bcm2835-dma
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-11-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add dma_memcopy support to bcm2835-dma.

Also added check for an error condition in bcm2835_dma_create_cb_chain
that showed up during development of this patch.

Tested using dmatest for all 11 available dma channels with the
following output:
[  476.543529] dmatest: Started 1 threads using dma0chan0
[  489.011154] dmatest: dma0chan0-copy0: summary 10000 tests, 0 failures 802 iops 6452 KB/s (0)
[  489.078379] dmatest: Started 1 threads using dma0chan1
[  501.494448] dmatest: dma0chan1-copy0: summary 10000 tests, 0 failures 806 iops 6376 KB/s (0)
[  501.562567] dmatest: Started 1 threads using dma0chan10
[  514.515164] dmatest: dma0chan10-copy: summary 10000 tests, 0 failures 772 iops 6169 KB/s (0)
[  514.582969] dmatest: Started 1 threads using dma0chan2
[  527.092284] dmatest: dma0chan2-copy0: summary 10000 tests, 0 failures 800 iops 6405 KB/s (0)
[  527.160290] dmatest: Started 1 threads using dma0chan3
[  539.541064] dmatest: dma0chan3-copy0: summary 10000 tests, 0 failures 808 iops 6424 KB/s (0)
[  539.608849] dmatest: Started 1 threads using dma0chan4
[  552.402978] dmatest: dma0chan4-copy0: summary 10000 tests, 0 failures 782 iops 6286 KB/s (0)
[  552.470852] dmatest: Started 1 threads using dma0chan5
[  565.184158] dmatest: dma0chan5-copy0: summary 10000 tests, 0 failures 787 iops 6231 KB/s (0)
[  565.251846] dmatest: Started 1 threads using dma0chan6
[  577.959385] dmatest: dma0chan6-copy0: summary 10000 tests, 0 failures 787 iops 6244 KB/s (0)
[  578.027259] dmatest: Started 1 threads using dma0chan7
[  590.834078] dmatest: dma0chan7-copy0: summary 10000 tests, 0 failures 781 iops 6295 KB/s (0)
[  590.901668] dmatest: Started 1 threads using dma0chan8
[  603.640192] dmatest: dma0chan8-copy0: summary 10000 tests, 0 failures 785 iops 6265 KB/s (0)
[  603.708531] dmatest: Started 1 threads using dma0chan9
[  616.420882] dmatest: dma0chan9-copy0: summary 10000 tests, 0 failures 787 iops 6285 KB/s (0)

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/dma/bcm2835-dma.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6c4b4e2..2884285 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -326,6 +326,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	struct bcm2835_cb_entry *cb_entry;
 	struct bcm2835_dma_cb *control_block;
 
+	if (!frames)
+		return NULL;
+
 	/* allocate and setup the descriptor. */
 	d = kzalloc(sizeof(*d) + frames * sizeof(struct bcm2835_cb_entry),
 		    gfp);
@@ -623,6 +626,34 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
 
+struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
+	struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
+	size_t len, unsigned long flags)
+{
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	struct bcm2835_desc *d;
+	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC;
+	u32 extra = BCM2835_DMA_INT_EN | BCM2835_DMA_WAIT_RESP;
+	size_t max_len = bcm2835_dma_max_frame_length(c);
+	size_t frames;
+
+	/* if src, dst or len is not given return with an error */
+	if (!src || !dst || !len)
+		return NULL;
+
+	/* calculate number of frames */
+	frames = bcm2835_dma_frames_for_length(len, max_len);
+
+	/* allocate the CB chain - this also fills in the pointers */
+	d = bcm2835_dma_create_cb_chain(chan, DMA_MEM_TO_MEM, false,
+					info, extra, frames,
+					src, dst, len, 0, GFP_KERNEL);
+	if (!d)
+		return NULL;
+
+	return vchan_tx_prep(&c->vc, &d->vd, flags);
+}
+
 static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct dma_chan *chan,
 	struct scatterlist *sgl, unsigned int sg_len,
@@ -909,17 +940,20 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = bcm2835_dma_alloc_chan_resources;
 	od->ddev.device_free_chan_resources = bcm2835_dma_free_chan_resources;
 	od->ddev.device_tx_status = bcm2835_dma_tx_status;
 	od->ddev.device_issue_pending = bcm2835_dma_issue_pending;
 	od->ddev.device_prep_dma_cyclic = bcm2835_dma_prep_dma_cyclic;
 	od->ddev.device_prep_slave_sg = bcm2835_dma_prep_slave_sg;
+	od->ddev.device_prep_dma_memcpy = bcm2835_dma_prep_dma_memcpy;
 	od->ddev.device_config = bcm2835_dma_slave_config;
 	od->ddev.device_terminate_all = bcm2835_dma_terminate_all;
 	od->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
+			      BIT(DMA_MEM_TO_MEM);
 	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
-- 
2.1.4
