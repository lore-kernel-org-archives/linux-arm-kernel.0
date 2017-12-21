From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Dec 2017 16:20:13 +0800
Subject: [PATCH v3 4/6] coresight: tmc: Hook callback for panic kdump
In-Reply-To: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
References: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1513844415-11427-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the panic kdump functionality has been ready, this patch is to
hook panic callback function for ETB/ETF.  Since the driver data
structure has allocated buffer when the session started, so simply save
ETB/ETF trace data into the buffer when panic happens and update
related info into dump node.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e2513b7..f823464 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -504,6 +504,34 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	CS_LOCK(drvdata->base);
 }
 
+static void tmc_panic_cb(void *data)
+{
+	struct coresight_device *csdev = (struct coresight_device *)data;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
+			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
+		return;
+
+	if (drvdata->mode == CS_MODE_DISABLED)
+		return;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_etb_dump_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+
+	/* Update buffer info for panic dump */
+	coresight_kdump_update(csdev, drvdata->buf, drvdata->len);
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -512,6 +540,7 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.set_buffer	= tmc_set_etf_buffer,
 	.reset_buffer	= tmc_reset_etf_buffer,
 	.update_buffer	= tmc_update_etf_buffer,
+	.panic_cb	= tmc_panic_cb,
 };
 
 static const struct coresight_ops_link tmc_etf_link_ops = {
-- 
2.7.4
