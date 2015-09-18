From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:27 -0600
Subject: [RFC PATCH 13/20] coresight: etm-perf: new PMU driver for ETM tracers
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-14-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf is a well known and used tool for performance monitoring
and much more. A such it is an ideal condaditate for integration
with coresight based HW tracing.

This patch introduce a minimal PMU that represent a coresight
tracer to the Perf core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS                                      |  1 +
 drivers/hwtracing/coresight/Makefile             |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 65 ++++++++++++++++++++++++
 include/linux/coresight-pmu.h                    | 18 +++++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 include/linux/coresight-pmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab749c85..b462a90a256d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -989,6 +989,7 @@ ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	include/linux/coresight*
 F:	drivers/hwtracing/coresight/*
 F:	Documentation/trace/coresight.txt
 F:	Documentation/devicetree/bindings/arm/coresight.txt
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 99f8e5f6256e..2ab2627060a4 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o
+obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
 obj-$(CONFIG_OF) += of_coresight.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
new file mode 100644
index 000000000000..759b8d69b4e6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright(C) 2015 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/perf_event.h>
+#include <linux/mm.h>
+#include <linux/list.h>
+
+#include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
+
+#include "coresight-priv.h"
+
+static struct pmu etm_pmu;
+
+/* ETMCR is 'config' */
+PMU_FORMAT_ATTR(cycacc,		"config:12");
+PMU_FORMAT_ATTR(timestamp,	"config:28");
+
+static struct attribute *etm_config_formats_attr[] = {
+	&format_attr_cycacc.attr,
+	&format_attr_timestamp.attr,
+	NULL,
+};
+
+static struct attribute_group etm_pmu_format_group = {
+	.name   = "format",
+	.attrs  = etm_config_formats_attr,
+};
+
+static const struct attribute_group *etm_pmu_attr_groups[] = {
+	&etm_pmu_format_group,
+	NULL,
+};
+
+static void etm_event_read(struct perf_event *event) {}
+
+static int __init etm_perf_init(void)
+{
+	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
+
+	etm_pmu.attr_groups	= etm_pmu_attr_groups;
+	etm_pmu.task_ctx_nr	= perf_sw_context;
+	etm_pmu.read		= etm_event_read;
+
+	return perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
+}
+module_init(etm_perf_init);
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
new file mode 100644
index 000000000000..261361060f0b
--- /dev/null
+++ b/include/linux/coresight-pmu.h
@@ -0,0 +1,18 @@
+/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
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
+#ifndef _LINUX_CORESIGHT_PMU_H
+#define _LINUX_CORESIGHT_PMU_H
+
+#define CORESIGHT_ETM_PMU_NAME	"cs_etm"
+
+#endif
-- 
1.9.1
