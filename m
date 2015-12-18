From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Dec 2015 13:58:57 -0700
Subject: [PATCH V7 01/24] coresight: implementing 'cpu_id()' API
In-Reply-To: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1450472361-426-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other than plainly parsing the device tree there is no way to
know which CPU a tracer is affined to.  As such adding an
interface to lookup the CPU field enclosed in the etm_drvdata
structure that was initialised at boot time.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 8 ++++++++
 include/linux/coresight.h                     | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d630b7ece735..755f6f4d6d79 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -315,6 +315,13 @@ static void etm_enable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
+static int etm_cpu_id(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	return drvdata->cpu;
+}
+
 static int etm_trace_id(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -421,6 +428,7 @@ static void etm_disable(struct coresight_device *csdev)
 }
 
 static const struct coresight_ops_source etm_source_ops = {
+	.cpu_id		= etm_cpu_id,
 	.trace_id	= etm_trace_id,
 	.enable		= etm_enable,
 	.disable	= etm_disable,
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a7cabfa23b55..bf62b265bf52 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -205,12 +205,15 @@ struct coresight_ops_link {
 /**
  * struct coresight_ops_source - basic operations for a source
  * Operations available for sources.
+ * @cpu_id:	returns the value of the CPU number this component
+ *		is associated to.
  * @trace_id:	returns the value of the component's trace ID as known
 		to the HW.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
  */
 struct coresight_ops_source {
+	int (*cpu_id)(struct coresight_device *csdev);
 	int (*trace_id)(struct coresight_device *csdev);
 	int (*enable)(struct coresight_device *csdev);
 	void (*disable)(struct coresight_device *csdev);
-- 
2.1.4
