From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 30 Aug 2016 10:19:25 -0600
Subject: [PATCH V7 5/5] perf tools: adding sink configuration for cs_etm PMU
In-Reply-To: <1472573965-3881-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472573965-3881-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472573965-3881-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the PMU::set_drv_config() callback to enable the CoreSight
sink that will be used for the trace session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 56 +++++++++++++++++++++++++++++++++++++++
 tools/perf/arch/arm/util/cs-etm.h |  3 +++
 tools/perf/arch/arm/util/pmu.c    |  3 +++
 3 files changed, 62 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 829c479614f1..dfea6b635525 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -27,12 +27,16 @@
 #include "../../util/auxtrace.h"
 #include "../../util/cpumap.h"
 #include "../../util/evlist.h"
+#include "../../util/evsel.h"
 #include "../../util/pmu.h"
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
 #include <stdlib.h>
 
+#define ENABLE_SINK_MAX	128
+#define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
+
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
@@ -557,3 +561,55 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 out:
 	return NULL;
 }
+
+static FILE *cs_device__open_file(const char *name)
+{
+	struct stat st;
+	char path[PATH_MAX];
+	const char *sysfs;
+
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return NULL;
+
+	snprintf(path, PATH_MAX,
+		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
+
+	if (stat(path, &st) < 0)
+		return NULL;
+
+	return fopen(path, "w");
+
+}
+
+static __attribute__((format(printf, 2, 3)))
+int cs_device__print_file(const char *name, const char *fmt, ...)
+{
+	va_list args;
+	FILE *file;
+	int ret = -EINVAL;
+
+	va_start(args, fmt);
+	file = cs_device__open_file(name);
+	if (file) {
+		ret = vfprintf(file, fmt, args);
+		fclose(file);
+	}
+	va_end(args);
+	return ret;
+}
+
+int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
+{
+	int ret;
+	char enable_sink[ENABLE_SINK_MAX];
+
+	snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
+		 term->val.drv_cfg, "enable_sink");
+
+	ret = cs_device__print_file(enable_sink, "%d", 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 909f486d02d1..5256741be549 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -18,6 +18,9 @@
 #ifndef INCLUDE__PERF_CS_ETM_H__
 #define INCLUDE__PERF_CS_ETM_H__
 
+#include "../../util/evsel.h"
+
 struct auxtrace_record *cs_etm_record_init(int *err);
+int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
 
 #endif
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index af9fb666b44f..c11f8a13d14d 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -19,8 +19,10 @@
 #include <linux/coresight-pmu.h>
 #include <linux/perf_event.h>
 
+#include "cs-etm.h"
 #include "../../util/pmu.h"
 
+
 struct perf_event_attr
 *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -28,6 +30,7 @@ struct perf_event_attr
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
+		pmu->set_drv_config = cs_etm_set_drv_config;
 	}
 #endif
 	return NULL;
-- 
2.7.4
