From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 17:43:50 +0200
Subject: [PATCH v3 36/59] dmaengine: bam-dma: Split device_control
In-Reply-To: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413992653-21963-37-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the device_control callback of the Qualcomm BAM DMA driver to make use
of the newly introduced callbacks, that will eventually be used to retrieve
slave capabilities.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/qcom_bam_dma.c | 85 +++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
index 7a4bbb0f80a5..03b1bf2afd4e 100644
--- a/drivers/dma/qcom_bam_dma.c
+++ b/drivers/dma/qcom_bam_dma.c
@@ -448,11 +448,18 @@ static void bam_free_chan(struct dma_chan *chan)
  * Sets slave configuration for channel
  *
  */
-static void bam_slave_config(struct bam_chan *bchan,
-		struct dma_slave_config *cfg)
+static int bam_slave_config(struct dma_chan *chan,
+			    struct dma_slave_config *cfg)
 {
+	struct bam_chan *bchan = to_bam_chan(chan);
+	unsigned long flag;
+
+	spin_lock_irqsave(&bchan->vc.lock, flag);
 	memcpy(&bchan->slave, cfg, sizeof(*cfg));
 	bchan->reconfigure = 1;
+	spin_unlock_irqrestore(&bchan->vc.lock, flag);
+
+	return 0;
 }
 
 /**
@@ -545,8 +552,9 @@ err_out:
  * No callbacks are done
  *
  */
-static void bam_dma_terminate_all(struct bam_chan *bchan)
+static int bam_dma_terminate_all(struct dma_chan *chan)
 {
+	struct bam_chan *bchan = to_bam_chan(chan);
 	unsigned long flag;
 	LIST_HEAD(head);
 
@@ -561,56 +569,46 @@ static void bam_dma_terminate_all(struct bam_chan *bchan)
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
 
 	vchan_dma_desc_free_list(&bchan->vc, &head);
+
+	return 0;
 }
 
 /**
- * bam_control - DMA device control
+ * bam_pause - Pause DMA channel
  * @chan: dma channel
- * @cmd: control cmd
- * @arg: cmd argument
  *
- * Perform DMA control command
+ */
+static int bam_pause(struct dma_chan *chan)
+{
+	struct bam_chan *bchan = to_bam_chan(chan);
+	struct bam_device *bdev = bchan->bdev;
+	unsigned long flag;
+
+	spin_lock_irqsave(&bchan->vc.lock, flag);
+	writel_relaxed(1, bdev->regs + BAM_P_HALT(bchan->id));
+	bchan->paused = 1;
+	spin_unlock_irqrestore(&bchan->vc.lock, flag);
+
+	return 0;
+}
+
+/**
+ * bam_resume - Resume DMA channel operations
+ * @chan: dma channel
  *
  */
-static int bam_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-	unsigned long arg)
+static int bam_resume(struct dma_chan *chan)
 {
 	struct bam_chan *bchan = to_bam_chan(chan);
 	struct bam_device *bdev = bchan->bdev;
-	int ret = 0;
 	unsigned long flag;
 
-	switch (cmd) {
-	case DMA_PAUSE:
-		spin_lock_irqsave(&bchan->vc.lock, flag);
-		writel_relaxed(1, bdev->regs + BAM_P_HALT(bchan->id));
-		bchan->paused = 1;
-		spin_unlock_irqrestore(&bchan->vc.lock, flag);
-		break;
-
-	case DMA_RESUME:
-		spin_lock_irqsave(&bchan->vc.lock, flag);
-		writel_relaxed(0, bdev->regs + BAM_P_HALT(bchan->id));
-		bchan->paused = 0;
-		spin_unlock_irqrestore(&bchan->vc.lock, flag);
-		break;
-
-	case DMA_TERMINATE_ALL:
-		bam_dma_terminate_all(bchan);
-		break;
-
-	case DMA_SLAVE_CONFIG:
-		spin_lock_irqsave(&bchan->vc.lock, flag);
-		bam_slave_config(bchan, (struct dma_slave_config *)arg);
-		spin_unlock_irqrestore(&bchan->vc.lock, flag);
-		break;
-
-	default:
-		ret = -ENXIO;
-		break;
-	}
+	spin_lock_irqsave(&bchan->vc.lock, flag);
+	writel_relaxed(0, bdev->regs + BAM_P_HALT(bchan->id));
+	bchan->paused = 0;
+	spin_unlock_irqrestore(&bchan->vc.lock, flag);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1050,7 +1048,10 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_alloc_chan_resources = bam_alloc_chan;
 	bdev->common.device_free_chan_resources = bam_free_chan;
 	bdev->common.device_prep_slave_sg = bam_prep_slave_sg;
-	bdev->common.device_control = bam_control;
+	bdev->common.device_config = bam_slave_config;
+	bdev->common.device_pause = bam_pause;
+	bdev->common.device_resume = bam_resume;
+	bdev->common.device_terminate_all = bam_dma_terminate_all;
 	bdev->common.device_issue_pending = bam_issue_pending;
 	bdev->common.device_tx_status = bam_tx_status;
 	bdev->common.dev = bdev->dev;
@@ -1089,7 +1090,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 	devm_free_irq(bdev->dev, bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
-		bam_dma_terminate_all(&bdev->channels[i]);
+		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
 		tasklet_kill(&bdev->channels[i].vc.task);
 
 		dma_free_writecombine(bdev->dev, BAM_DESC_FIFO_SIZE,
-- 
2.1.1
