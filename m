From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:46 +0100
Subject: [PATCH 04/13] coresight: etm4x: Add support for handling errors
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for handling errors in enabling the component.
The ETM is enabled via cross call to owner CPU. Make
necessary changes to report the error back from the cross
call.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index c1dcc7c..4f9e6bb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -77,10 +77,14 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
-static void etm4_enable_hw(void *info)
+struct etm4_enable_arg {
+	struct etmv4_drvdata *drvdata;
+	int rc;
+};
+
+static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i;
-	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
@@ -177,6 +181,16 @@ static void etm4_enable_hw(void *info)
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	return 0;
+}
+
+static void etm4_enable_hw_smp_call(void *info)
+{
+	struct etm4_enable_arg *arg = info;
+
+	if (WARN_ON(!arg))
+		return;
+	arg->rc = etm4_enable_hw(arg->drvdata);
 }
 
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
@@ -242,7 +256,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	if (ret)
 		goto out;
 	/* And enable it */
-	etm4_enable_hw(drvdata);
+	ret = etm4_enable_hw(drvdata);
 
 out:
 	return ret;
@@ -251,6 +265,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etm4_enable_arg arg = { 0 };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
@@ -259,19 +274,17 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
+	arg.drvdata = drvdata;
 	ret = smp_call_function_single(drvdata->cpu,
-				       etm4_enable_hw, drvdata, 1);
-	if (ret)
-		goto err;
-
-	drvdata->sticky_enable = true;
+				       etm4_enable_hw_smp_call, &arg, 1);
+	if (!ret)
+		ret = arg.rc;
+	if (!ret)
+		drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
-	return 0;
-
-err:
-	spin_unlock(&drvdata->spinlock);
+	if (!ret)
+		dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
-- 
2.7.4
