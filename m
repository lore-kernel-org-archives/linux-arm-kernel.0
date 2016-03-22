From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:17 -0600
Subject: [PATCH 09/14] coresight: tmc: adding mode of operation for link/sinks
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving tmc_drvdata::enable to a local_t mode.  That way the
sink interface is aware of it's orgin and the foundation for
mutual exclusion between the sysFS and Perf interface can be
laid out.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 29 ++++++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 25 +++++++++++++++++----
 drivers/hwtracing/coresight/coresight-tmc.h     |  5 +++--
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e5d67e01409c..a88c76d7f473 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -108,6 +108,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
+	u32 val;
 	bool allocated = false;
 	char *buf = NULL;
 	unsigned long flags;
@@ -125,6 +126,15 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 		return -EBUSY;
 	}
 
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	/*
+	 * In sysFS mode we can have multiple writers per sink.  Since this
+	 * sink is already enabled no memory is needed and the HW need not be
+	 * touched.
+	 */
+	if (val == CS_MODE_SYSFS)
+		goto out;
+
 	/*
 	 * If drvdata::buf isn't NULL, memory was allocated for a previous
 	 * trace run but wasn't read.  If so simply zero-out the memory.
@@ -141,9 +151,9 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	}
 
 	tmc_etb_enable_hw(drvdata);
-	drvdata->enable = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+out:
 	/* Free memory outside the spinlock if need be */
 	if (!allocated)
 		kfree(buf);
@@ -154,6 +164,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 
 static void tmc_disable_etf_sink(struct coresight_device *csdev)
 {
+	u32 val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -163,9 +174,15 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 		return;
 	}
 
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_SYSFS, CS_MODE_DISABLED);
+	/* Nothing to do, the TMC was already disabled */
+	if (val == CS_MODE_DISABLED)
+		goto out;
+
 	tmc_etb_disable_hw(drvdata);
 	tmc_etb_dump_hw(drvdata);
-	drvdata->enable = false;
+
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
@@ -184,7 +201,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	}
 
 	tmc_etf_enable_hw(drvdata);
-	drvdata->enable = true;
+	local_set(&drvdata->mode, CS_MODE_SYSFS);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETF enabled\n");
@@ -204,7 +221,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	}
 
 	tmc_etf_disable_hw(drvdata);
-	drvdata->enable = false;
+	local_set(&drvdata->mode, CS_MODE_DISABLED);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC disabled\n");
@@ -237,7 +254,7 @@ int tmc_read_prepare_etf(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* The TMC isn't enabled, so there is no need to disable it */
-	if (!drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_DISABLED) {
 		/*
 		 * The ETB/ETF is disabled already.  If drvdata::buf is NULL
 		 * trace data has been harvested.
@@ -288,7 +305,7 @@ int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata)
 	}
 
 	/* The TMC isn't enabled, so there is no need to enable it */
-	if (!drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_DISABLED) {
 		/*
 		 * The ETB/ETF is not tracing and the buffer was just read.
 		 * As such prepare to free the trace buffer.
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c4962568276e..540d0b96a958 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -84,6 +84,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
+	u32 val;
 	bool allocated = false;
 	unsigned long flags;
 	void __iomem *vaddr;
@@ -107,6 +108,15 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 		return -EBUSY;
 	}
 
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	/*
+	 * In sysFS mode we can have multiple writers per sink.  Since this
+	 * sink is already enabled no memory is needed and the HW need not be
+	 * touched.
+	 */
+	if (val == CS_MODE_SYSFS)
+		goto out;
+
 	/*
 	 * If drvdata::buf == NULL, use the memory allocated above.
 	 * Otherwise a buffer still exists from a previous session, so
@@ -122,9 +132,9 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 	memset(drvdata->vaddr, 0, drvdata->size);
 
 	tmc_etr_enable_hw(drvdata);
-	drvdata->enable = true;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
+out:
 	/* Free memory outside the spinlock if need be */
 	if (!allocated)
 		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
@@ -135,6 +145,7 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 
 static void tmc_disable_etr_sink(struct coresight_device *csdev)
 {
+	u32 val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -144,9 +155,15 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 		return;
 	}
 
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_SYSFS, CS_MODE_DISABLED);
+	/* Nothing to do, the TMC was already disabled */
+	if (val == CS_MODE_DISABLED)
+		goto out;
+
 	tmc_etr_disable_hw(drvdata);
 	tmc_etr_dump_hw(drvdata);
-	drvdata->enable = false;
+
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETR disabled\n");
@@ -168,7 +185,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* The TMC isn't enabled, so there is no need to disable it */
-	if (!drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_DISABLED) {
 		/*
 		 * The ETR is disabled already.  If drvdata::buf is NULL
 		 * trace data has been harvested.
@@ -210,7 +227,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	/* The TMC isn't enabled, so there is no need to enable it */
-	if (!drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_DISABLED) {
 		/*
 		 * The ETR is not tracing and trace data was just read. As
 		 * such prepare to free the trace buffer.
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6b11caf77ad1..6dbd70861b17 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -18,6 +18,7 @@
 #ifndef _CORESIGHT_TMC_H
 #define _CORESIGHT_TMC_H
 
+#include <linux/io.h>
 #include <linux/miscdevice.h>
 
 #define TMC_RSZ			0x004
@@ -100,7 +101,7 @@ enum tmc_mem_intf_width {
  * @paddr:	DMA start location in RAM.
  * @vaddr:	virtual representation of @paddr.
  * @size:	@buf size.
- * @enable:	this TMC is being used.
+ * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -116,7 +117,7 @@ struct tmc_drvdata {
 	dma_addr_t		paddr;
 	void __iomem		*vaddr;
 	u32			size;
-	bool			enable;
+	local_t			mode;
 	enum tmc_config_type	config_type;
 	u32			trigger_cntr;
 };
-- 
2.1.4
