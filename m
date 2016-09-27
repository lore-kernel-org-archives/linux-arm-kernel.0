From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 27 Sep 2016 14:44:24 +0100
Subject: [PATCH 2/3] coresight: tmc: Get rid of mode parameter for helper
 routines
In-Reply-To: <1474983865-11816-1-git-send-email-suzuki.poulose@arm.com>
References: <1474983865-11816-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1474983865-11816-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the superfluous mode parameter and the check for
the mode in tmc_etX_enable_sink_{perf/sysfs}. While at it, also
remove the unnecessary WARN_ON() checks.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 18 +++++-------------
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e80a8f4..1549436 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -103,7 +103,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
 	bool used = false;
@@ -111,10 +111,6 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev, u32 mode)
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	 /* This shouldn't be happening */
-	if (WARN_ON(mode != CS_MODE_SYSFS))
-		return -EINVAL;
-
 	/*
 	 * If we don't have a buffer release the lock and allocate memory.
 	 * Otherwise keep the lock and move along.
@@ -176,16 +172,12 @@ out:
 	return ret;
 }
 
-static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etf_sink_perf(struct coresight_device *csdev)
 {
 	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	 /* This shouldn't be happening */
-	if (WARN_ON(mode != CS_MODE_PERF))
-		return -EINVAL;
-
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		ret = -EINVAL;
@@ -202,7 +194,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
 		goto out;
 	}
 
-	drvdata->mode = mode;
+	drvdata->mode = CS_MODE_PERF;
 	tmc_etb_enable_hw(drvdata);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -214,9 +206,9 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
 	switch (mode) {
 	case CS_MODE_SYSFS:
-		return tmc_enable_etf_sink_sysfs(csdev, mode);
+		return tmc_enable_etf_sink_sysfs(csdev);
 	case CS_MODE_PERF:
-		return tmc_enable_etf_sink_perf(csdev, mode);
+		return tmc_enable_etf_sink_perf(csdev);
 	}
 
 	/* We shouldn't be here */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f23ef0c..3b84d0d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -93,7 +93,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
 	bool used = false;
@@ -102,9 +102,6 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev, u32 mode)
 	dma_addr_t paddr;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	 /* This shouldn't be happening */
-	if (WARN_ON(mode != CS_MODE_SYSFS))
-		return -EINVAL;
 
 	/*
 	 * If we don't have a buffer release the lock and allocate memory.
@@ -170,16 +167,12 @@ out:
 	return ret;
 }
 
-static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32 mode)
+static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
 {
 	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	 /* This shouldn't be happening */
-	if (WARN_ON(mode != CS_MODE_PERF))
-		return -EINVAL;
-
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		ret = -EINVAL;
@@ -208,9 +201,9 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
 	switch (mode) {
 	case CS_MODE_SYSFS:
-		return tmc_enable_etr_sink_sysfs(csdev, mode);
+		return tmc_enable_etr_sink_sysfs(csdev);
 	case CS_MODE_PERF:
-		return tmc_enable_etr_sink_perf(csdev, mode);
+		return tmc_enable_etr_sink_perf(csdev);
 	}
 
 	/* We shouldn't be here */
-- 
2.7.4
