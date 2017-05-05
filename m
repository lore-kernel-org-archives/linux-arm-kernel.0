From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:53 +0200
Subject: [PATCH 10/10] dma: mv_xor_v2: add support for suspend/resume
In-Reply-To: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493978274-12805-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

This commit adds the support for suspend/resume in the mv_xor_v2
driver. The suspend suspend function disables the XOR engine after the
DMA stack has handled all pending descriptors in the queue. The resume
function re-configures the XOR engine and re-enables the engine.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor_v2.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index f386b88..f652a0e 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -696,6 +696,27 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
 	return 0;
 }
 
+static int mv_xor_v2_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct mv_xor_v2_device *xor_dev = platform_get_drvdata(dev);
+
+	/* Set this bit to disable to stop the XOR unit. */
+	writel(0x1, xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_STOP_OFF);
+
+	return 0;
+}
+
+static int mv_xor_v2_resume(struct platform_device *dev)
+{
+	struct mv_xor_v2_device *xor_dev = platform_get_drvdata(dev);
+
+	mv_xor_v2_set_desc_size(xor_dev);
+	mv_xor_v2_enable_imsg_thrd(xor_dev);
+	mv_xor_v2_descq_init(xor_dev);
+
+	return 0;
+}
+
 static int mv_xor_v2_probe(struct platform_device *pdev)
 {
 	struct mv_xor_v2_device *xor_dev;
@@ -877,6 +898,8 @@ MODULE_DEVICE_TABLE(of, mv_xor_v2_dt_ids);
 
 static struct platform_driver mv_xor_v2_driver = {
 	.probe		= mv_xor_v2_probe,
+	.suspend	= mv_xor_v2_suspend,
+	.resume		= mv_xor_v2_resume,
 	.remove		= mv_xor_v2_remove,
 	.driver		= {
 		.name	= "mv_xor_v2",
-- 
2.7.4
