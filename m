From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:45 +0100
Subject: [PATCH 03/13] coresight: tmc-etb/etf: Prepare to handle errors
 enabling
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare to handle errors in enabling the hardware and
report it back to the core driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 71 +++++++++++++++----------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4156c95..ceb4b30 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -15,7 +15,7 @@
 static int tmc_set_etf_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle);
 
-static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -34,6 +34,12 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etb_enable_hw(drvdata);
+	return 0;
+}
+
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
 	char *bufp;
@@ -76,7 +82,7 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -92,6 +98,12 @@ static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etf_enable_hw(drvdata);
+	return 0;
+}
+
 static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -174,8 +186,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		drvdata->buf = buf;
 	}
 
-	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etb_enable_hw(drvdata);
+	ret = tmc_etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
+	else
+		/* Free up the buffer if we failed to enable */
+		used = false;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -194,27 +210,25 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
+	do {
 		ret = -EINVAL;
-		goto out;
-	}
+		if (drvdata->reading)
+			break;
+		/*
+		 * In Perf mode there can be only one writer per sink.  There
+		 * is also no need to continue if the ETB/ETF is already
+		 * operated from sysFS.
+		 */
+		if (drvdata->mode != CS_MODE_DISABLED)
+			break;
 
-	/*
-	 * In Perf mode there can be only one writer per sink.  There
-	 * is also no need to continue if the ETB/ETR is already operated
-	 * from sysFS.
-	 */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = tmc_set_etf_buffer(csdev, handle);
-	if (!ret) {
-		drvdata->mode = CS_MODE_PERF;
-		tmc_etb_enable_hw(drvdata);
-	}
-out:
+		ret = tmc_set_etf_buffer(csdev, handle);
+		if (ret)
+			break;
+		ret  = tmc_etb_enable_hw(drvdata);
+		if (!ret)
+			drvdata->mode = CS_MODE_PERF;
+	} while (0);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
@@ -271,6 +285,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 static int tmc_enable_etf_link(struct coresight_device *csdev,
 			       int inport, int outport)
 {
+	int ret;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -280,11 +295,13 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	tmc_etf_enable_hw(drvdata);
-	drvdata->mode = CS_MODE_SYSFS;
+	ret = tmc_etf_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
+	if (!ret)
+		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
 	return 0;
 }
 
@@ -579,7 +596,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 		 * can't be NULL.
 		 */
 		memset(drvdata->buf, 0, drvdata->size);
-		tmc_etb_enable_hw(drvdata);
+		__tmc_etb_enable_hw(drvdata);
 	} else {
 		/*
 		 * The ETB/ETF is not tracing and the buffer was just read.
-- 
2.7.4
