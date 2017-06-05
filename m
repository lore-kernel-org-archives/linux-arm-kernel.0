From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:05 -0600
Subject: [PATCH 04/17] coresight: tmc: minor fix for output log
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

In current code the output logs are not well symmetric for sink and link
enabling and disabling. This patch is to fix that so can output paired
logs.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index aec61a6d5c63..e3b9fb82eb8d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -166,9 +166,6 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	if (!used)
 		kfree(buf);
 
-	if (!ret)
-		dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
-
 	return ret;
 }
 
@@ -204,15 +201,27 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev)
 
 static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
+	int ret;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
 	switch (mode) {
 	case CS_MODE_SYSFS:
-		return tmc_enable_etf_sink_sysfs(csdev);
+		ret = tmc_enable_etf_sink_sysfs(csdev);
+		break;
 	case CS_MODE_PERF:
-		return tmc_enable_etf_sink_perf(csdev);
+		ret = tmc_enable_etf_sink_perf(csdev);
+		break;
+	/* We shouldn't be here */
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
-	/* We shouldn't be here */
-	return -EINVAL;
+	if (ret)
+		return ret;
+
+	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
+	return 0;
 }
 
 static void tmc_disable_etf_sink(struct coresight_device *csdev)
@@ -273,7 +282,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC disabled\n");
+	dev_info(drvdata->dev, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
-- 
2.7.4
