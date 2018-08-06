From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:47 +0100
Subject: [PATCH 05/13] coresight: etm3: Add support for handling errors
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for reporting errors back from the SMP cross
function call for enabling ETM.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9ce8fba..771691c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -355,11 +355,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	return 0;
 }
 
-static void etm_enable_hw(void *info)
+static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
 	u32 etmcr;
-	struct etm_drvdata *drvdata = info;
 	struct etm_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
@@ -421,6 +420,21 @@ static void etm_enable_hw(void *info)
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	return 0;
+}
+
+struct etm_enable_arg {
+	struct etm_drvdata *drvdata;
+	int rc;
+}
+
+static void etm_enable_hw_smp_call(void *info)
+{
+	struct etm_enable_arg *arg = info;
+
+	if (WARN_ON(!arg))
+		return;
+	arg->rc = etm_enable_hw(arg->drvdata);
 }
 
 static int etm_cpu_id(struct coresight_device *csdev)
@@ -475,14 +489,13 @@ static int etm_enable_perf(struct coresight_device *csdev,
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
 	/* And enable it */
-	etm_enable_hw(drvdata);
-
-	return 0;
+	return etm_enable_hw(drvdata);
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etm_enable_arg arg = { 0 };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
@@ -492,20 +505,21 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	 * hw configuration will take place on the local CPU during bring up.
 	 */
 	if (cpu_online(drvdata->cpu)) {
+		arg.drvdata = drvdata;
 		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_hw, drvdata, 1);
-		if (ret)
-			goto err;
+					       etm_enable_hw_smp_call, &arg, 1);
+		if (!ret)
+			ret = arg.rc;
+		if (!ret)
+			drvdata->sticky_enable = true;
+	} else {
+		ret = -ENODEV;
 	}
 
-	drvdata->sticky_enable = true;
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
