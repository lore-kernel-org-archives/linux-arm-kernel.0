From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:45 -0600
Subject: [PATCH V2 28/30] perf tools: making coresight PMU listable
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-29-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the required mechanic allowing 'perf list pmu' to
discover coresight ETM/PTM tracers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/Build |  2 ++
 tools/perf/arch/arm/util/pmu.c | 18 ++++++++++++++++++
 tools/perf/builtin-inject.c    |  2 +-
 tools/perf/builtin-record.c    |  2 +-
 tools/perf/config/Makefile     | 20 ++++++++++++++------
 tools/perf/util/auxtrace.h     |  2 +-
 6 files changed, 37 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/pmu.c

diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index d22e3d07de3d..371a3bf12297 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -2,3 +2,5 @@ libperf-$(CONFIG_DWARF) += dwarf-regs.o
 
 libperf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
 libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+
+libperf-$(CONFIG_AUXTRACE_ARM) += pmu.o
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
new file mode 100644
index 000000000000..2870a4e04e48
--- /dev/null
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -0,0 +1,18 @@
+#include <string.h>
+
+#include <linux/coresight-pmu.h>
+#include <linux/perf_event.h>
+
+#include "../../util/pmu.h"
+
+struct perf_event_attr
+*perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
+{
+#ifdef HAVE_AUXTRACE_SUPPORT_ARM
+	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
+		/* add ETM default config here */
+		pmu->selectable = true;
+	}
+#endif
+	return NULL;
+}
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c19e034b4023..a567cd628156 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -95,7 +95,7 @@ static int perf_event__repipe_attr(struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
-#ifdef HAVE_AUXTRACE_SUPPORT_X86
+#if defined(HAVE_AUXTRACE_SUPPORT_X86) || defined(HAVE_AUXTRACE_SUPPORT_ARM)
 
 static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
 {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 39cbbdb07891..f37f890f676e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -141,7 +141,7 @@ static void record__sig_exit(void)
 	raise(signr);
 }
 
-#ifdef HAVE_AUXTRACE_SUPPORT_X86
+#if defined(HAVE_AUXTRACE_SUPPORT_X86) || defined(HAVE_AUXTRACE_SUPPORT_ARM)
 
 static int record__process_auxtrace(struct perf_tool *tool,
 				    union perf_event *event, void *data1,
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 5fd4843c691d..62fa7596b507 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -626,13 +626,21 @@ ifdef LIBBABELTRACE
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
+      $(call detected,CONFIG_AUXTRACE_X86)
+      CFLAGS += -DHAVE_AUXTRACE_SUPPORT_X86
+    endif
   else
-    $(call detected,CONFIG_AUXTRACE)
-    $(call detected,CONFIG_AUXTRACE_X86)
-    CFLAGS += -DHAVE_AUXTRACE_SUPPORT_X86
+    ifeq ($(ARCH),$(filter $(ARCH), arm arm64))
+      $(call detected,CONFIG_AUXTRACE)
+      $(call detected,CONFIG_AUXTRACE_ARM)
+      CFLAGS += -DHAVE_AUXTRACE_SUPPORT_ARM
+    endif
   endif
 endif
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b9ac99fb5a17..ed1c940be883 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -309,7 +309,7 @@ struct auxtrace_record {
 	unsigned int alignment;
 };
 
-#ifdef HAVE_AUXTRACE_SUPPORT_X86
+#if defined(HAVE_AUXTRACE_SUPPORT_X86) || defined(HAVE_AUXTRACE_SUPPORT_ARM)
 
 /*
  * In snapshot mode the mmapped page is read-only which makes using
-- 
1.9.1
