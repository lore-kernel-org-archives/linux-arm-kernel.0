From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Thu, 12 Feb 2015 11:46:20 +0530
Subject: [PATCH RESEND] dmaengine: qcom_bam_dma: Fix error path in probe
 function
Message-ID: <1423721780-16385-1-git-send-email-pramod.gurav@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calls tasklet_kill() in error path of the probe function were missing.
Add the same in error path.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---

Resending it with linux-arm-msm in cc.

 drivers/dma/qcom_bam_dma.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
index 3122a99..a1ff4a6 100644
--- a/drivers/dma/qcom_bam_dma.c
+++ b/drivers/dma/qcom_bam_dma.c
@@ -1115,7 +1115,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	if (!bdev->channels) {
 		ret = -ENOMEM;
-		goto err_disable_clk;
+		goto err_tasklet_kill;
 	}
 
 	/* allocate and initialize channels */
@@ -1127,7 +1127,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
 			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
 	if (ret)
-		goto err_disable_clk;
+		goto err_bam_channel_exit;
 
 	/* set max dma segment size */
 	bdev->common.dev = bdev->dev;
@@ -1135,7 +1135,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_set_max_seg_size(bdev->common.dev, BAM_MAX_DATA_SIZE);
 	if (ret) {
 		dev_err(bdev->dev, "cannot set maximum segment size\n");
-		goto err_disable_clk;
+		goto err_bam_channel_exit;
 	}
 
 	platform_set_drvdata(pdev, bdev);
@@ -1156,7 +1156,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_disable_clk;
+		goto err_bam_channel_exit;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1168,8 +1168,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_bam_channel_exit:
+	for (i = 0; i < bdev->num_channels; i++)
+		tasklet_kill(&bdev->channels[i].vc.task);
+err_tasklet_kill:
+	tasklet_kill(&bdev->task);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
+
 	return ret;
 }
 
-- 
1.7.9.5
