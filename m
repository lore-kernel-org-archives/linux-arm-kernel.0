From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:31 -0600
Subject: [RFC PATCH 17/20] coresight: etm-perf: adding symbolic link for CPUs
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-18-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other than probing each device entry under /sys/bus/coresight/devices/,
there is no way for user space to know which CPU is associated to which
tracer.  But knowing those association is important to discover tracer
specifics and configuration options.

As such introducing a symbolic link under
/sys/bus/event_source/devices/cs_etm/cpuX that reference the coresight
device a CPU is associated with.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 22 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h | 27 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm3x.c    |  6 ++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index edacf4b1d0bc..de0198e72603 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -341,6 +341,28 @@ static int etm_event_add(struct perf_event *event, int mode)
 	return 0;
 }
 
+int etm_perf_symlink(struct coresight_device *csdev, bool link)
+{
+	char entry[sizeof("cpu9999999")];
+	int ret = 0, cpu = source_ops(csdev)->cpu_id(csdev);
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device *cs_dev = &csdev->dev;
+
+	sprintf(entry, "cpu%d", cpu);
+
+	if (link) {
+		ret = sysfs_create_link(&pmu_dev->kobj, &cs_dev->kobj, entry);
+		if (ret)
+			return ret;
+		per_cpu(csdev_src, cpu) = csdev;
+	} else {
+		sysfs_remove_link(&pmu_dev->kobj, entry);
+		per_cpu(csdev_src, cpu) = NULL;
+	}
+
+	return 0;
+}
+
 static int __init etm_perf_init(void)
 {
 	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
new file mode 100644
index 000000000000..4dd900f2362a
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -0,0 +1,27 @@
+/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CORESIGHT_ETM_PERF_H
+#define _CORESIGHT_ETM_PERF_H
+
+struct coresight_device;
+
+#ifdef CONFIG_CORESIGHT
+int etm_perf_symlink(struct coresight_device *csdev, bool link);
+
+#else
+static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
+{ return -EINVAL; }
+
+#endif /* CONFIG_CORESIGHT */
+
+#endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index a4c158df0fef..6a44ea330a4a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -34,6 +34,7 @@
 #include <asm/sections.h>
 
 #include "coresight-etm.h"
+#include "coresight-etm-perf.h"
 
 static int boot_enable;
 module_param_named(boot_enable, boot_enable, int, S_IRUGO);
@@ -1995,6 +1996,11 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
+	if (etm_perf_symlink(drvdata->csdev, true)) {
+		ret = -EPROBE_DEFER;
+		goto err_arch_supported;
+	}
+
 	pm_runtime_put(&adev->dev);
 	dev_info(dev, "%s initialized\n", (char *)id->data);
 
-- 
1.9.1
