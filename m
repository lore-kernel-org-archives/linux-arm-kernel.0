From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:33:56 -0600
Subject: [PATCH 22/27] coresight: tmc: make sysFS and Perf mode mutually
 exclusive
In-Reply-To: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1462296841-12327-23-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysFS and Perf access methods can't be allowed to interfere
with one another.  As such introducing guards to access
functions that prevents moving forward if a TMC is already
being used.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 60 +++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 62 +++++++++++++++++++++++--
 2 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index b5e5e6ac67eb..b11c52be54a9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -111,7 +111,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
 {
 	int ret = 0;
 	bool used = false;
@@ -185,6 +185,54 @@ out:
 	return ret;
 }
 
+static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
+{
+	int ret = 0;
+	long val;
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	 /* This shouldn't be happening */
+	if (WARN_ON(mode != CS_MODE_PERF))
+		return -EINVAL;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	val = local_xchg(&drvdata->mode, mode);
+	/*
+	 * In Perf mode there can be only one writer per sink.  There
+	 * is also no need to continue if the ETB/ETR is already operated
+	 * from sysFS.
+	 */
+	if (val != CS_MODE_DISABLED) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmc_etb_enable_hw(drvdata);
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return ret;
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
 static void tmc_disable_etf_sink(struct coresight_device *csdev)
 {
 	long val;
@@ -267,6 +315,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 {
+	long val;
 	enum tmc_mode mode;
 	int ret = 0;
 	unsigned long flags;
@@ -290,6 +339,13 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
+	val = local_read(&drvdata->mode);
+	/* Don't interfere if operated from Perf */
+	if (val == CS_MODE_PERF) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* If drvdata::buf is NULL the trace data has been read already */
 	if (drvdata->buf == NULL) {
 		ret = -EINVAL;
@@ -297,7 +353,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
+	if (val == CS_MODE_SYSFS)
 		tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 7208584d0da7..847d1b5f2c13 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -87,7 +87,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
 {
 	int ret = 0;
 	bool used = false;
@@ -165,6 +165,54 @@ out:
 	return ret;
 }
 
+static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32 mode)
+{
+	int ret = 0;
+	long val;
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	 /* This shouldn't be happening */
+	if (WARN_ON(mode != CS_MODE_PERF))
+		return -EINVAL;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	val = local_xchg(&drvdata->mode, mode);
+	/*
+	 * In Perf mode there can be only one writer per sink.  There
+	 * is also no need to continue if the ETR is already operated
+	 * from sysFS.
+	 */
+	if (val != CS_MODE_DISABLED) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmc_etr_enable_hw(drvdata);
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return ret;
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
 static void tmc_disable_etr_sink(struct coresight_device *csdev)
 {
 	long val;
@@ -199,6 +247,7 @@ const struct coresight_ops tmc_etr_cs_ops = {
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
+	long val;
 	unsigned long flags;
 
 	/* config types are set a boot time and never change */
@@ -211,6 +260,13 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
+	val = local_read(&drvdata->mode);
+	/* Don't interfere if operated from Perf */
+	if (val == CS_MODE_PERF) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* If drvdata::buf is NULL the trace data has been read already */
 	if (drvdata->buf == NULL) {
 		ret = -EINVAL;
@@ -218,14 +274,14 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
+	if (val == CS_MODE_SYSFS)
 		tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	return 0;
+	return ret;
 }
 
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
-- 
2.5.0
