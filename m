From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 22 Sep 2016 18:12:48 -0300
Subject: [PATCH 04/15] perf tools: Make coresight PMU listable
In-Reply-To: <1474578779-14095-1-git-send-email-acme@kernel.org>
References: <1474578779-14095-1-git-send-email-acme@kernel.org>
Message-ID: <1474578779-14095-5-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Adding the required mechanic allowing 'perf list pmu' to discover
coresight ETM/PTM tracers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1474041004-13956-3-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS                      |  1 +
 tools/perf/arch/arm/util/Build   |  2 ++
 tools/perf/arch/arm/util/pmu.c   | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/arch/arm64/util/Build |  2 ++
 4 files changed, 39 insertions(+)
 create mode 100644 tools/perf/arch/arm/util/pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index db814a89599c..7407fe779053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1123,6 +1123,7 @@ F:	drivers/hwtracing/coresight/*
 F:	Documentation/trace/coresight.txt
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
+F:	tools/perf/arch/arm/util/pmu.c
 
 ARM/CORGI MACHINE SUPPORT
 M:	Richard Purdie <rpurdie@rpsys.net>
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index f98da17357c0..4093fd146f46 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -2,3 +2,5 @@ libperf-$(CONFIG_DWARF) += dwarf-regs.o
 
 libperf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+
+libperf-$(CONFIG_AUXTRACE) += pmu.o
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
new file mode 100644
index 000000000000..af9fb666b44f
--- /dev/null
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -0,0 +1,34 @@
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
+#include <string.h>
+#include <linux/coresight-pmu.h>
+#include <linux/perf_event.h>
+
+#include "../../util/pmu.h"
+
+struct perf_event_attr
+*perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
+{
+#ifdef HAVE_AUXTRACE_SUPPORT
+	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
+		/* add ETM default config here */
+		pmu->selectable = true;
+	}
+#endif
+	return NULL;
+}
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 02f41dba4f4f..3876dd05bb8b 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,2 +1,4 @@
 libperf-$(CONFIG_DWARF)     += dwarf-regs.o
 libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
+
+libperf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o
-- 
2.7.4
