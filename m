From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:14:08 -0600
Subject: [PATCH V3 11/18] coresight: tmc: adding mode of operation for
 link/sinks
In-Reply-To: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461345255-11758-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving tmc_drvdata::enable to a local_t mode.  That way the
sink interface is aware of it's orgin and the foundation for
mutual exclusion between the sysFS and Perf interface can be
laid out.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 28 ++++++++++++++++++-------
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 24 ++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 ++--
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index bcfa40e8cd1c..d090a9745c73 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -110,6 +110,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
 	bool used = false;
 	char *buf = NULL;
+	long val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -147,6 +148,15 @@ fast_path:
 		return -EBUSY;
 	}
 
+	val = local_xchg(&drvdata->mode, mode);
+	/*
+	 * In sysFS mode we can have multiple writers per sink.  Since this
+	 * sink is already enabled no memory is needed and the HW need not be
+	 * touched.
+	 */
+	if (val == CS_MODE_SYSFS)
+		goto spin_unlock;
+
 	/*
 	 * If drvdata::buf isn't NULL, memory was allocated for a previous
 	 * trace run but wasn't read.  If so simply zero-out the memory.
@@ -164,7 +174,7 @@ fast_path:
 	}
 
 	tmc_etb_enable_hw(drvdata);
-	drvdata->enable = true;
+spin_unlock:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
@@ -177,6 +187,7 @@ fast_path:
 
 static void tmc_disable_etf_sink(struct coresight_device *csdev)
 {
+	long val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -186,8 +197,11 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 		return;
 	}
 
-	tmc_etb_disable_hw(drvdata);
-	drvdata->enable = false;
+	val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
+	/* Disable the TMC only if it needs to */
+	if (val != CS_MODE_DISABLED)
+		tmc_etb_disable_hw(drvdata);
+
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
@@ -206,7 +220,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	}
 
 	tmc_etf_enable_hw(drvdata);
-	drvdata->enable = true;
+	local_set(&drvdata->mode, CS_MODE_SYSFS);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETF enabled\n");
@@ -226,7 +240,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	}
 
 	tmc_etf_disable_hw(drvdata);
-	drvdata->enable = false;
+	local_set(&drvdata->mode, CS_MODE_DISABLED);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC disabled\n");
@@ -278,7 +292,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->enable)
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
 		tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
@@ -309,7 +323,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Re-enable the TMC if need be */
-	if (drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
 		 * buffer. As such zero-out the buffer so that we don't end
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 474c70c089f3..8bbbf3ab1387 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -85,6 +85,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
 	bool used = false;
+	long val;
 	unsigned long flags;
 	void __iomem *vaddr = NULL;
 	dma_addr_t paddr;
@@ -126,6 +127,15 @@ fast_path:
 		return -EBUSY;
 	}
 
+	val = local_xchg(&drvdata->mode, mode);
+	/*
+	 * In sysFS mode we can have multiple writers per sink.  Since this
+	 * sink is already enabled no memory is needed and the HW need not be
+	 * touched.
+	 */
+	if (val == CS_MODE_SYSFS)
+		goto spin_unlock;
+
 	/*
 	 * If drvdata::buf == NULL, use the memory allocated above.
 	 * Otherwise a buffer still exists from a previous session, so
@@ -141,7 +151,7 @@ fast_path:
 	memset(drvdata->vaddr, 0, drvdata->size);
 
 	tmc_etr_enable_hw(drvdata);
-	drvdata->enable = true;
+spin_unlock:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
@@ -154,6 +164,7 @@ fast_path:
 
 static void tmc_disable_etr_sink(struct coresight_device *csdev)
 {
+	long val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -163,8 +174,11 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 		return;
 	}
 
-	tmc_etr_disable_hw(drvdata);
-	drvdata->enable = false;
+	val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
+	/* Disable the TMC only if it needs to */
+	if (val != CS_MODE_DISABLED)
+		tmc_etr_disable_hw(drvdata);
+
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETR disabled\n");
@@ -196,7 +210,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->enable)
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
 		tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
@@ -218,7 +232,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
-	if (drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
 		 * buffer. As such zero-out the buffer so that we don't end
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index df661903f83c..9b4c215d2b6b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -99,7 +99,7 @@ enum tmc_mem_intf_width {
  * @paddr:	DMA start location in RAM.
  * @vaddr:	virtual representation of @paddr.
  * @size:	@buf size.
- * @enable:	this TMC is being used.
+ * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -115,7 +115,7 @@ struct tmc_drvdata {
 	dma_addr_t		paddr;
 	void __iomem		*vaddr;
 	u32			size;
-	bool			enable;
+	local_t			mode;
 	enum tmc_config_type	config_type;
 	u32			trigger_cntr;
 };
-- 
2.5.0
