From: leo.yan@linaro.org (Leo Yan)
Date: Sat,  3 Jun 2017 22:42:56 +0800
Subject: [PATCH v1 4/4] coresight: etb10: hook panic callback
In-Reply-To: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
References: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1496500976-18362-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to hook panic callback for etb10 driver; so after panic
can dump trace data from it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 979ea6e..c9ea281 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -473,6 +473,21 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	CS_LOCK(drvdata->base);
 }
 
+static int etb_panic_cb(struct coresight_device *csdev)
+{
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	etb_disable_hw(drvdata);
+	etb_dump_hw(drvdata);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_err(drvdata->dev, "Dump ETB buffer 0x%x at 0x%p\n",
+		drvdata->buffer_depth, drvdata->buf);
+	return 0;
+}
+
 static const struct coresight_ops_sink etb_sink_ops = {
 	.enable		= etb_enable,
 	.disable	= etb_disable,
@@ -481,6 +496,7 @@ static const struct coresight_ops_sink etb_sink_ops = {
 	.set_buffer	= etb_set_buffer,
 	.reset_buffer	= etb_reset_buffer,
 	.update_buffer	= etb_update_buffer,
+	.panic_cb	= etb_panic_cb,
 };
 
 static const struct coresight_ops etb_cs_ops = {
-- 
2.7.4
