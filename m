From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:16 -0600
Subject: [RFC PATCH 02/20] coresight: etm3x: implementing 'is_enabled()' API
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an interface to lookup the status of a tracer along with
a source operation allowing external customers to access it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 13 +++++++++++++
 include/linux/coresight.h                     |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 999c62a59c70..a44bc3532585 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -374,6 +374,18 @@ static int etm_configure(struct coresight_device *csdev)
 					etm_configure_cpu, csdev, 1);
 }
 
+static bool etm_is_enabled(struct coresight_device *csdev)
+{
+	bool enabled;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock(&drvdata->spinlock);
+	enabled = drvdata->enable;
+	spin_unlock(&drvdata->spinlock);
+
+	return enabled;
+}
+
 /**
  * etm_trace_enable - enable ETM tracer
  * @csdev	- the etm that needs to be enabled/disabled.
@@ -525,6 +537,7 @@ static void etm_disable(struct coresight_device *csdev)
 
 static const struct coresight_ops_source etm_source_ops = {
 	.trace_id	= etm_trace_id,
+	.is_enabled	= etm_is_enabled,
 	.configure	= etm_configure,
 	.trace_enable	= etm_trace_enable,
 	.enable		= etm_enable,
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 70f3dafa5194..d16e874079b7 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -207,6 +207,7 @@ struct coresight_ops_link {
  * Operations available for sources.
  * @trace_id:	returns the value of the component's trace ID as known
  *		to the HW.
+ * @is_enabled:	returns whether a source has been enabled or not.
  * @configure:	performs configuration for a source but doesn't enable it.
  * @trace_enable: enable/disable tracing on a source.
  * @enable:	enables tracing for a source.
@@ -216,6 +217,7 @@ struct coresight_ops_link {
  */
 struct coresight_ops_source {
 	int (*trace_id)(struct coresight_device *csdev);
+	bool (*is_enabled)(struct coresight_device *csdev);
 	int (*configure)(struct coresight_device *csdev);
 	int (*trace_enable)(struct coresight_device *csdev, bool enable);
 	int (*enable)(struct coresight_device *csdev);
-- 
1.9.1
