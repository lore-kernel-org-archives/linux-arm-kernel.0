From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 17 Jul 2018 18:11:39 +0100
Subject: [PATCH v2 08/10] coresight: perf: Add helper to retrieve sink
 configuration
In-Reply-To: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531847501-22226-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can always find the sink configuration for a given perf_output_handle.
Add a helper to retrieve the sink configuration for a given
perf_output_handle. This will be used to get rid of the set_buffer()
call back.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
 drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6a4252b..3cc4a0b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -23,20 +23,6 @@
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
-/**
- * struct etm_event_data - Coresight specifics associated to an event
- * @work:		Handle to free allocated memory outside IRQ context.
- * @mask:		Hold the CPU(s) this event was set for.
- * @snk_config:		The sink configuration.
- * @path:		An array of path, each slot for one CPU.
- */
-struct etm_event_data {
-	struct work_struct work;
-	cpumask_t mask;
-	void *snk_config;
-	struct list_head * __percpu *path;
-};
-
 static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4..da7d933 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -7,6 +7,7 @@
 #ifndef _CORESIGHT_ETM_PERF_H
 #define _CORESIGHT_ETM_PERF_H
 
+#include <linux/percpu-defs.h>
 #include "coresight-priv.h"
 
 struct coresight_device;
@@ -42,14 +43,39 @@ struct etm_filters {
 	bool			ssstatus;
 };
 
+/**
+ * struct etm_event_data - Coresight specifics associated to an event
+ * @work:		Handle to free allocated memory outside IRQ context.
+ * @mask:		Hold the CPU(s) this event was set for.
+ * @snk_config:		The sink configuration.
+ * @path:		An array of path, each slot for one CPU.
+ */
+struct etm_event_data {
+	struct work_struct work;
+	cpumask_t mask;
+	void *snk_config;
+	struct list_head * __percpu *path;
+};
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
+static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
+{
+	struct etm_event_data *data = perf_get_aux(handle);
 
+	if (data)
+		return data->snk_config;
+	return NULL;
+}
 #else
 static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
 { return -EINVAL; }
 
+static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_CORESIGHT */
 
 #endif
-- 
2.7.4
