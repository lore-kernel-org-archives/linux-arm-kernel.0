From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 25 Mar 2017 19:04:03 -0400
Subject: [PATCH 2/2] dmaengine: qcom_hidma: pause the channel on shutdown
In-Reply-To: <1490483043-4364-1-git-send-email-okaya@codeaurora.org>
References: <1490483043-4364-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1490483043-4364-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to ensure that all DMAs and interrupts are cleared during
shutdown operation in order for kexec to start the next kernel clearly.

Otherwise, HW could be performing a DMA into random addresses in the
middle of second kernel start.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 3c982c9..5072a7d 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -865,6 +865,20 @@ static int hidma_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static void hidma_shutdown(struct platform_device *pdev)
+{
+	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
+
+	dev_info(dmadev->ddev.dev, "HI-DMA engine shutdown\n");
+
+	pm_runtime_get_sync(dmadev->ddev.dev);
+	if (hidma_ll_disable(dmadev->lldev))
+		dev_warn(dmadev->ddev.dev, "channel did not stop\n");
+	pm_runtime_mark_last_busy(dmadev->ddev.dev);
+	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+
+}
+
 static int hidma_remove(struct platform_device *pdev)
 {
 	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
@@ -908,6 +922,7 @@ static int hidma_remove(struct platform_device *pdev)
 static struct platform_driver hidma_driver = {
 	.probe = hidma_probe,
 	.remove = hidma_remove,
+	.shutdown = hidma_shutdown,
 	.driver = {
 		   .name = "hidma",
 		   .of_match_table = hidma_match,
-- 
1.9.1
