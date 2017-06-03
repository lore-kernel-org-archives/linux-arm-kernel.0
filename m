From: leo.yan@linaro.org (Leo Yan)
Date: Sat,  3 Jun 2017 22:42:55 +0800
Subject: [PATCH v1 3/4] coresight: tmc: hook panic callback for ETB/ETF
In-Reply-To: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
References: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1496500976-18362-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The panic dump functionality has been ready, this patch is to hook
panic callback function for ETB/ETF. Because the driver data structure
has allocated buffer when the session started, so simply save ETB/ETF
trace data into the buffer when panic happens.

Below is simple usage when we connect kdump to extract trace data:

- During kernel panic, tmc driver prints out below log.
  Dump ETB buffer 0x2000 at 0xffff80003bd5a180

- After get kernel dump file 'vmcore', use below command to extract
  ETB/ETF trace data.
  crash vmlinux vmcore
  rd 0xffff80003bd5a180 0x2000 -r cs_etb_trace.bin

- Generate perf formatted file, so can be analyzed by perf tool:
  python perf_cs_dump_wrapper.py -i cs_etb_trace.bin -o perf.data
  ./perf script -v -F cpu,event,ip,sym,symoff --kallsyms ksymbol -i perf.data -k vmlinux

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e3b9fb8..4cadbb1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -476,6 +476,31 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_panic_cb(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
+			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
+		return -EINVAL;
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
+	dev_err(drvdata->dev, "Dump ETB buffer 0x%x at 0x%p\n",
+		drvdata->len, drvdata->buf);
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -484,6 +509,7 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.set_buffer	= tmc_set_etf_buffer,
 	.reset_buffer	= tmc_reset_etf_buffer,
 	.update_buffer	= tmc_update_etf_buffer,
+	.panic_cb	= tmc_panic_cb,
 };
 
 static const struct coresight_ops_link tmc_etf_link_ops = {
-- 
2.7.4
