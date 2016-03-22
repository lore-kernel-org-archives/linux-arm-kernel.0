From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:18 -0600
Subject: [PATCH 10/14] coresight: tmc: make sysFS and Perf mode mutually
 exclusive
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysFS and Perf access methods can't be allowed to interfere
with one another.  As such introducing guards to access
functions that prevents moving forward if a TMC is already
being used.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 76 +++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 77 ++++++++++++++++++++++---
 2 files changed, 139 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index a88c76d7f473..c533b4494969 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -106,7 +106,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
 {
 	u32 val;
 	bool allocated = false;
@@ -127,6 +127,12 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	}
 
 	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	/* No need to continue if already operated from Perf */
+	if (val == CS_MODE_PERF) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		kfree(buf);
+		return -EBUSY;
+	}
 	/*
 	 * In sysFS mode we can have multiple writers per sink.  Since this
 	 * sink is already enabled no memory is needed and the HW need not be
@@ -162,7 +168,7 @@ out:
 	return 0;
 }
 
-static void tmc_disable_etf_sink(struct coresight_device *csdev)
+static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
 {
 	u32 val;
 	unsigned long flags;
@@ -171,16 +177,66 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	/*
+	 * In Perf mode there can be only one writer per sink.  There
+	 * is also no need to continue if the ETB/ETR is already operated
+	 * from sysFS.
+	 */
+	if (val != CS_MODE_DISABLED) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	tmc_etb_enable_hw(drvdata);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return 0;
+}
+
+static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
+{
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		return tmc_enable_etf_sink_sysfs(csdev, mode);
+	case CS_MODE_PERF:
+		return tmc_enable_etf_sink_perf(csdev, mode);
+	}
+
+	/* We shouldn't be here */
+	return -EINVAL;
+}
+
+static void tmc_disable_etf_sink(struct coresight_device *csdev)
+{
+	u32 mode;
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return;
 	}
 
-	val = local_cmpxchg(&drvdata->mode, CS_MODE_SYSFS, CS_MODE_DISABLED);
-	/* Nothing to do, the TMC was already disabled */
-	if (val == CS_MODE_DISABLED)
+	mode = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
+	/* Nothing to do, the ETB/ETF was already disabled */
+	if (mode == CS_MODE_DISABLED)
 		goto out;
 
+	/* The engine has to be stopped in both sysFS and Perf mode */
 	tmc_etb_disable_hw(drvdata);
-	tmc_etb_dump_hw(drvdata);
+
+	/*
+	 * If we operated from sysFS, dump the trace data for retrieval
+	 * via /dev/.  From Perf trace data is handled via the Perf ring
+	 * buffer.
+	 */
+	if (mode == CS_MODE_SYSFS)
+		tmc_etb_dump_hw(drvdata);
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -253,7 +309,13 @@ int tmc_read_prepare_etf(struct tmc_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* The TMC isn't enabled, so there is no need to disable it */
+	/* Don't interfere if operated from Perf */
+	if (local_read(&drvdata->mode) == CS_MODE_PERF) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	/* The ETB/ETF isn't enabled, so there is no need to disable it */
 	if (local_read(&drvdata->mode) == CS_MODE_DISABLED) {
 		/*
 		 * The ETB/ETF is disabled already.  If drvdata::buf is NULL
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 540d0b96a958..50a2e0a83714 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -82,7 +82,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
 {
 	u32 val;
 	bool allocated = false;
@@ -109,6 +109,13 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 	}
 
 	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	/* No need to continue if already operated from Perf */
+	if (val == CS_MODE_PERF) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+		return -EBUSY;
+	}
+
 	/*
 	 * In sysFS mode we can have multiple writers per sink.  Since this
 	 * sink is already enabled no memory is needed and the HW need not be
@@ -143,7 +150,7 @@ out:
 	return 0;
 }
 
-static void tmc_disable_etr_sink(struct coresight_device *csdev)
+static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32 mode)
 {
 	u32 val;
 	unsigned long flags;
@@ -152,16 +159,66 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	/*
+	 * In Perf mode there can be only one writer per sink.  There
+	 * is also no need to continue if the ETR is already operated
+	 * from sysFS.
+	 */
+	if (val != CS_MODE_DISABLED) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	tmc_etr_enable_hw(drvdata);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return 0;
+}
+
+static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
+{
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		return tmc_enable_etr_sink_sysfs(csdev, mode);
+	case CS_MODE_PERF:
+		return tmc_enable_etr_sink_perf(csdev, mode);
+	}
+
+	/* We shouldn't be here */
+	return -EINVAL;
+}
+
+static void tmc_disable_etr_sink(struct coresight_device *csdev)
+{
+	u32 mode;
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return;
 	}
 
-	val = local_cmpxchg(&drvdata->mode, CS_MODE_SYSFS, CS_MODE_DISABLED);
-	/* Nothing to do, the TMC was already disabled */
-	if (val == CS_MODE_DISABLED)
+	mode = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
+	/* Nothing to do, the ETR was already disabled */
+	if (mode == CS_MODE_DISABLED)
 		goto out;
 
+	/* The engine has to be stopped in both sysFS and Perf mode */
 	tmc_etr_disable_hw(drvdata);
-	tmc_etr_dump_hw(drvdata);
+
+	/*
+	 * If we operated from sysFS, dump the trace data for retrieval
+	 * via /dev/.  From Perf trace data is handled via the Perf ring
+	 * buffer.
+	 */
+	if (mode == CS_MODE_SYSFS)
+		tmc_etr_dump_hw(drvdata);
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -184,7 +241,13 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* The TMC isn't enabled, so there is no need to disable it */
+	/* Don't interfere if operated from Perf */
+	if (local_read(&drvdata->mode) == CS_MODE_PERF) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	/* The ETR isn't enabled, so there is no need to disable it */
 	if (local_read(&drvdata->mode) == CS_MODE_DISABLED) {
 		/*
 		 * The ETR is disabled already.  If drvdata::buf is NULL
-- 
2.1.4
