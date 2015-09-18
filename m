From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:17 -0600
Subject: [RFC PATCH 03/20] coresight: etm3x: implementing 'cpu_id()' API
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an interface to lookup the CPU a tracer has been affined
to along with a source operation allowing external customers to
access it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 14 ++++++++++++++
 include/linux/coresight.h                     |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index a44bc3532585..4ce9cfc06e93 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -441,6 +441,19 @@ static void etm_config_enable(void *info)
 	spin_unlock(&drvdata->spinlock);
 }
 
+static int etm_cpu_id(struct coresight_device *csdev)
+{
+	int cpu;
+	unsigned long flags;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	cpu = drvdata->cpu;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return cpu;
+}
+
 static int etm_trace_id(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -536,6 +549,7 @@ static void etm_disable(struct coresight_device *csdev)
 }
 
 static const struct coresight_ops_source etm_source_ops = {
+	.cpu_id		= etm_cpu_id,
 	.trace_id	= etm_trace_id,
 	.is_enabled	= etm_is_enabled,
 	.configure	= etm_configure,
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d16e874079b7..9fe2ccf1cc36 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -205,6 +205,8 @@ struct coresight_ops_link {
 /**
  * struct coresight_ops_source - basic operations for a source
  * Operations available for sources.
+ * @cpu_id:	returns the value of the CPU number this component
+ *		is associated to.
  * @trace_id:	returns the value of the component's trace ID as known
  *		to the HW.
  * @is_enabled:	returns whether a source has been enabled or not.
@@ -216,6 +218,7 @@ struct coresight_ops_link {
  * @poweroff:	switch off power to a source.
  */
 struct coresight_ops_source {
+	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
 	bool (*is_enabled)(struct coresight_device *csdev);
 	int (*configure)(struct coresight_device *csdev);
-- 
1.9.1
