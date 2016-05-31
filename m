From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 31 May 2016 11:10:32 -0600
Subject: [PATCH 1/2] perf tools: making coresight PMU listable
In-Reply-To: <1464714633-16697-1-git-send-email-mathieu.poirier@linaro.org>
References: <1464714633-16697-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1464714633-16697-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the required mechanic allowing 'perf list pmu' to
discover coresight ETM/PTM tracers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS                    |  1 +
 tools/perf/MANIFEST            |  1 +
 tools/perf/arch/arm/util/Build |  2 ++
 tools/perf/arch/arm/util/pmu.c | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/config/Makefile     | 11 ++++++++---
 5 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e37a98..d3451007718b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1085,6 +1085,7 @@ F:	drivers/hwtracing/coresight/*
 F:	Documentation/trace/coresight.txt
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
+F:	tools/perf/arch/arm/util/pmu.c
 
 ARM/CORGI MACHINE SUPPORT
 M:	Richard Purdie <rpurdie@rpsys.net>
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 8c8c6b9ce915..c6683e60e603 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -64,6 +64,7 @@ include/asm-generic/bitops/const_hweight.h
 include/asm-generic/bitops/fls64.h
 include/asm-generic/bitops/__fls.h
 include/asm-generic/bitops/fls.h
+include/linux/coresight-pmu.h
 include/linux/perf_event.h
 include/linux/list.h
 include/linux/hash.h
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index d22e3d07de3d..66ab0b05549c 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -2,3 +2,5 @@ libperf-$(CONFIG_DWARF) += dwarf-regs.o
 
 libperf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
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
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 5ad0255f8756..494a672aa11d 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -681,9 +681,14 @@ ifdef LIBBABELTRACE
 endif
 
 ifndef NO_AUXTRACE
-  ifeq ($(feature-get_cpuid), 0)
-    msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
-    NO_AUXTRACE := 1
+  ifeq ($(ARCH),x86)
+    ifeq ($(feature-get_cpuid), 0)
+      msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
+      NO_AUXTRACE := 1
+    else
+      $(call detected,CONFIG_AUXTRACE)
+      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
+    endif
   else
     $(call detected,CONFIG_AUXTRACE)
     CFLAGS += -DHAVE_AUXTRACE_SUPPORT
-- 
2.5.0
