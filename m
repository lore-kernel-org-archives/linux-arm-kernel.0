From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 15:14:28 +0100
Subject: [PATCH v2 6/9] dmaengine: st_fdma: Add fdma suspend and resume
 callbacks.
In-Reply-To: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441980871-24475-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the functions to gate the xp70 clock on
suspend and resume.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/st_fdma.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 4288e79..de3afefb 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -1127,10 +1127,56 @@ static int st_fdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int st_fdma_pm_suspend(struct device *dev)
+{
+	struct st_fdma_dev *fdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (atomic_read(&fdev->fw_loaded)) {
+		ret = st_fdma_disable(fdev);
+		if (ret & FDMA_EN_RUN) {
+			dev_warn(fdev->dev, "Failed to disable channels");
+			return -EBUSY;
+		}
+	}
+
+	st_fdma_clk_disable(fdev);
+
+	return 0;
+}
+
+static int st_fdma_pm_resume(struct device *dev)
+{
+	struct st_fdma_dev *fdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = st_fdma_clk_enable(fdev);
+	if (ret) {
+		dev_err(fdev->dev, "Failed to enable clocks\n");
+		goto out;
+	}
+
+	ret = st_fdma_get_fw(fdev);
+out:
+	return ret;
+}
+
+static const struct dev_pm_ops st_fdma_pm = {
+	.suspend_late = st_fdma_pm_suspend,
+	.resume_early = st_fdma_pm_resume,
+};
+
+#define ST_FDMA_PM	(&st_fdma_pm)
+#else
+#define ST_FDMA_PM	NULL
+#endif
+
 static struct platform_driver st_fdma_platform_driver = {
 	.driver = {
 		.name = "st-fdma",
 		.of_match_table = st_fdma_match,
+		.pm = ST_FDMA_PM,
 	},
 	.probe = st_fdma_probe,
 	.remove = st_fdma_remove,
-- 
1.9.1
