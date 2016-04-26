From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 26 Apr 2016 16:10:27 -0600
Subject: [PATCH V4 11/18] coresight: tmc: adding mode of operation for
 link/sinks
In-Reply-To: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461708634-6327-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving tmc_drvdata::enable to a local_t mode.  That way the
sink interface is aware of it's orgin and the foundation for
mutual exclusion between the sysFS and Perf interface can be
laid out.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 27 ++++++++++++++++++-------
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 23 ++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 ++--
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 60edf4d1968f..bc0efc1e5b49 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -111,6 +111,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	int ret = 0;
 	bool used = false;
 	char *buf = NULL;
+	long val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -140,6 +141,15 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 		goto out;
 	}
 
+	val = local_xchg(&drvdata->mode, mode);
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
@@ -157,7 +167,6 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	}
 
 	tmc_etb_enable_hw(drvdata);
-	drvdata->enable = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -173,6 +182,7 @@ out:
 
 static void tmc_disable_etf_sink(struct coresight_device *csdev)
 {
+	long val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -182,8 +192,11 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
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
@@ -202,7 +215,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	}
 
 	tmc_etf_enable_hw(drvdata);
-	drvdata->enable = true;
+	local_set(&drvdata->mode, CS_MODE_SYSFS);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC-ETF enabled\n");
@@ -222,7 +235,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	}
 
 	tmc_etf_disable_hw(drvdata);
-	drvdata->enable = false;
+	local_set(&drvdata->mode, CS_MODE_DISABLED);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_info(drvdata->dev, "TMC disabled\n");
@@ -279,7 +292,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->enable)
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
 		tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
@@ -310,7 +323,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Re-enable the TMC if need be */
-	if (drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
 		 * buffer. As such zero-out the buffer so that we don't end
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index d6999b457fb8..0c107811a232 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -86,6 +86,7 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
 	int ret = 0;
 	bool used = false;
+	long val;
 	unsigned long flags;
 	void __iomem *vaddr = NULL;
 	dma_addr_t paddr;
@@ -122,6 +123,15 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 		goto out;
 	}
 
+	val = local_xchg(&drvdata->mode, mode);
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
@@ -137,7 +147,6 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 	memset(drvdata->vaddr, 0, drvdata->size);
 
 	tmc_etr_enable_hw(drvdata);
-	drvdata->enable = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -153,6 +162,7 @@ out:
 
 static void tmc_disable_etr_sink(struct coresight_device *csdev)
 {
+	long val;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -162,8 +172,11 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
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
@@ -200,7 +213,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->enable)
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
 		tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
@@ -223,7 +236,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
-	if (drvdata->enable) {
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
 		 * buffer. As such zero-out the buffer so that we don't end
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 592eb149fe3a..94bc034d3b98 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -98,7 +98,7 @@ enum tmc_mem_intf_width {
  * @paddr:	DMA start location in RAM.
  * @vaddr:	virtual representation of @paddr.
  * @size:	@buf size.
- * @enable:	this TMC is being used.
+ * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -113,7 +113,7 @@ struct tmc_drvdata {
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
