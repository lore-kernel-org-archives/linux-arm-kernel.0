From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:25 -0600
Subject: [PATCH V2 08/30] coresight: etm3x: implementing 'cpu_id()' API
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an interface to lookup the CPU a tracer has been affined
to along with a source operation allowing external customers to
access it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 8 ++++++++
 include/linux/coresight.h                     | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 3fe6433764d4..e199746bba05 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -312,6 +312,13 @@ static void etm_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
+static int etm_cpu_id(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	return drvdata->cpu;
+}
+
 int etm_get_trace_id(struct etm_drvdata *drvdata)
 {
 	unsigned long flags;
@@ -444,6 +451,7 @@ static void sysfs_etm_disable(struct coresight_device *csdev)
 }
 
 static const struct coresight_ops_source etm_source_ops = {
+	.cpu_id		= etm_cpu_id,
 	.trace_id	= etm_trace_id,
 	.sysfs_enable	= sysfs_etm_enable,
 	.sysfs_disable	= sysfs_etm_disable,
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 97155527dbdd..f9210df15f03 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -205,12 +205,15 @@ struct coresight_ops_link {
 /**
  * struct coresight_ops_source - basic operations for a source
  * Operations available for sources.
+ * @cpu_id:		returns the value of the CPU number this component
+ *			is associated to.
  * @trace_id:		returns the value of the component's trace ID as known
 			to the HW.
  * @sysfs_enable:	enables tracing for a source, from sysFS.
  * @sysfs_disable:	disables tracing for a source, from sysFS.
  */
 struct coresight_ops_source {
+	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
 	int (*sysfs_enable)(struct coresight_device *csdev);
 	void (*sysfs_disable)(struct coresight_device *csdev);
-- 
1.9.1
