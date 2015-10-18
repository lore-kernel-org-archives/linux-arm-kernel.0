From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:23 -0600
Subject: [PATCH V2 06/30] coresight: clearly labeling source operarions
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When integrating coresight with Perf, it is important to
clearly identify which operations are used by sysFS and
which ones by Perf.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c |  8 ++++----
 drivers/hwtracing/coresight/coresight-etm4x.c |  8 ++++----
 drivers/hwtracing/coresight/coresight.c       |  8 ++++----
 include/linux/coresight.h                     | 12 ++++++------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 713ffe1b761f..3d7fa0b2acf9 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -346,7 +346,7 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
-static int etm_enable(struct coresight_device *csdev)
+static int sysfs_etm_enable(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
@@ -407,7 +407,7 @@ static void etm_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
-static void etm_disable(struct coresight_device *csdev)
+static void sysfs_etm_disable(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -436,8 +436,8 @@ static void etm_disable(struct coresight_device *csdev)
 
 static const struct coresight_ops_source etm_source_ops = {
 	.trace_id	= etm_trace_id,
-	.enable		= etm_enable,
-	.disable	= etm_disable,
+	.sysfs_enable	= sysfs_etm_enable,
+	.sysfs_disable	= sysfs_etm_disable,
 };
 
 static const struct coresight_ops etm_cs_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 254a81a4e6f4..0808cc5a51a0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -180,7 +180,7 @@ static void etm4_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
-static int etm4_enable(struct coresight_device *csdev)
+static int sysfs_etm4_enable(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
@@ -231,7 +231,7 @@ static void etm4_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
-static void etm4_disable(struct coresight_device *csdev)
+static void sysfs_etm4_disable(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -261,8 +261,8 @@ static void etm4_disable(struct coresight_device *csdev)
 
 static const struct coresight_ops_source etm4_source_ops = {
 	.trace_id	= etm4_trace_id,
-	.enable		= etm4_enable,
-	.disable	= etm4_disable,
+	.sysfs_enable	= sysfs_etm4_enable,
+	.sysfs_disable	= sysfs_etm4_disable,
 };
 
 static const struct coresight_ops etm4_cs_ops = {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index a3dcafb81700..d318a338a517 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -212,8 +212,8 @@ static int coresight_enable_source(struct coresight_device *csdev)
 	}
 
 	if (!csdev->enable) {
-		if (source_ops(csdev)->enable) {
-			ret = source_ops(csdev)->enable(csdev);
+		if (source_ops(csdev)->sysfs_enable) {
+			ret = source_ops(csdev)->sysfs_enable(csdev);
 			if (ret)
 				return ret;
 		}
@@ -228,8 +228,8 @@ static int coresight_enable_source(struct coresight_device *csdev)
 static void coresight_disable_source(struct coresight_device *csdev)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
-		if (source_ops(csdev)->disable) {
-			source_ops(csdev)->disable(csdev);
+		if (source_ops(csdev)->sysfs_disable) {
+			source_ops(csdev)->sysfs_disable(csdev);
 			csdev->enable = false;
 		}
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a7cabfa23b55..97155527dbdd 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -205,15 +205,15 @@ struct coresight_ops_link {
 /**
  * struct coresight_ops_source - basic operations for a source
  * Operations available for sources.
- * @trace_id:	returns the value of the component's trace ID as known
-		to the HW.
- * @enable:	enables tracing for a source.
- * @disable:	disables tracing for a source.
+ * @trace_id:		returns the value of the component's trace ID as known
+			to the HW.
+ * @sysfs_enable:	enables tracing for a source, from sysFS.
+ * @sysfs_disable:	disables tracing for a source, from sysFS.
  */
 struct coresight_ops_source {
 	int (*trace_id)(struct coresight_device *csdev);
-	int (*enable)(struct coresight_device *csdev);
-	void (*disable)(struct coresight_device *csdev);
+	int (*sysfs_enable)(struct coresight_device *csdev);
+	void (*sysfs_disable)(struct coresight_device *csdev);
 };
 
 struct coresight_ops {
-- 
1.9.1
