From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 11 Apr 2017 17:10:29 +0800
Subject: [PATCH RFC 4/4] coresight: tmc: dump RAM for panic
In-Reply-To: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
References: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1491901829-18477-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If coresight ETB/ETF have been enabled by 'sysfs' or 'perf' modes and we
can rely on panic notifier to save all ETB RAM data into memory. Relies
on Kdump, finally the ETB RAM data can be extracted from kernel's
vmcore, so we can analyse panic reason from dumped ETB RAM data.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 52 +++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h     |  2 +
 2 files changed, 54 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5e709af..bc52cad 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -102,6 +102,47 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etb_notify(struct notifier_block *nb,
+			  unsigned long mode, void *_unused)
+{
+	struct tmc_drvdata *drvdata = container_of(nb, struct tmc_drvdata,
+						   panic_nb);
+	unsigned long flags;
+	int ret = 0;
+
+	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
+			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
+		return -EINVAL;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* There is no point in reading a TMC in HW FIFO mode */
+	mode = readl_relaxed(drvdata->base + TMC_MODE);
+	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* If drvdata::buf is NULL the trace data has been read already */
+	if (drvdata->buf == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_etb_dump_hw(drvdata);
+
+	dev_info(drvdata->dev, "Flush ETB buffer 0x%x at 0x%p\n",
+			drvdata->len, drvdata->buf);
+
+	CS_LOCK(drvdata->base);
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
 static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -245,6 +286,12 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	if (ret)
 		return ret;
 
+	drvdata->panic_nb.notifier_call = tmc_etb_notify;
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &drvdata->panic_nb);
+	if (ret)
+		return ret;
+
 	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
@@ -262,6 +309,11 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 
 	/* Disable the TMC only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
+		/* Unregister panic notifier */
+		drvdata->panic_nb.notifier_call = NULL;
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+				&drvdata->panic_nb);
+
 		tmc_etb_disable_hw(drvdata);
 		drvdata->mode = CS_MODE_DISABLED;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 51c0185..bb563b8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -93,6 +93,7 @@ enum tmc_mem_intf_width {
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated to this component.
  * @csdev:	component vitals needed by the framework.
+ * @panic_nb:	notifier callback for panic.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
  * @spinlock:	only one at a time pls.
  * @buf:	area of memory where trace data get sent.
@@ -109,6 +110,7 @@ struct tmc_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct coresight_device	*csdev;
+	struct notifier_block	panic_nb;
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	bool			reading;
-- 
2.7.4
