From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:44 -0600
Subject: [PATCH V2 27/30] perf build: adding X86 auxiliary specific flags
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-28-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an X86 specific flag to split AUX components that are
generic and specific to architectures.  That way the auxiliary
area mechanic can be compiled in for other architecture without
including X86 specific code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/x86/util/Build         |  6 +++---
 tools/perf/arch/x86/util/pmu.c         |  2 +-
 tools/perf/builtin-inject.c            |  2 +-
 tools/perf/builtin-record.c            |  2 +-
 tools/perf/config/Makefile             |  3 ++-
 tools/perf/util/Build                  |  6 +++---
 tools/perf/util/auxtrace.h             |  2 +-
 tools/perf/util/intel-bts.h            | 11 +++++++++++
 tools/perf/util/intel-pt-decoder/Build |  2 +-
 tools/perf/util/intel-pt.h             | 15 +++++++++++++++
 10 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index ff63649fa9ac..f6b1ba8b6aad 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -9,6 +9,6 @@ libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
 libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-libperf-$(CONFIG_AUXTRACE) += auxtrace.o
-libperf-$(CONFIG_AUXTRACE) += intel-pt.o
-libperf-$(CONFIG_AUXTRACE) += intel-bts.o
+libperf-$(CONFIG_AUXTRACE_X86) += auxtrace.o
+libperf-$(CONFIG_AUXTRACE_X86) += intel-pt.o
+libperf-$(CONFIG_AUXTRACE_X86) += intel-bts.o
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 79fe07158d00..eef512b9a1bf 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -8,7 +8,7 @@
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
-#ifdef HAVE_AUXTRACE_SUPPORT
+#ifdef HAVE_AUXTRACE_SUPPORT_X86
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME))
 		return intel_pt_pmu_default_config(pmu);
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME))
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f62c49b35be0..c19e034b4023 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -95,7 +95,7 @@ static int perf_event__repipe_attr(struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
-#ifdef HAVE_AUXTRACE_SUPPORT
+#ifdef HAVE_AUXTRACE_SUPPORT_X86
 
 static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
 {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 142eeb341b29..39cbbdb07891 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -141,7 +141,7 @@ static void record__sig_exit(void)
 	raise(signr);
 }
 
-#ifdef HAVE_AUXTRACE_SUPPORT
+#ifdef HAVE_AUXTRACE_SUPPORT_X86
 
 static int record__process_auxtrace(struct perf_tool *tool,
 				    union perf_event *event, void *data1,
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 38a08539f4bf..5fd4843c691d 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -631,7 +631,8 @@ ifndef NO_AUXTRACE
     NO_AUXTRACE := 1
   else
     $(call detected,CONFIG_AUXTRACE)
-    CFLAGS += -DHAVE_AUXTRACE_SUPPORT
+    $(call detected,CONFIG_AUXTRACE_X86)
+    CFLAGS += -DHAVE_AUXTRACE_SUPPORT_X86
   endif
 endif
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e5f18a288b74..448d83b00925 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -80,9 +80,9 @@ libperf-$(CONFIG_AUXTRACE) += tsc.o
 libperf-y += cloexec.o
 libperf-y += thread-stack.o
 libperf-$(CONFIG_AUXTRACE) += auxtrace.o
-libperf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
-libperf-$(CONFIG_AUXTRACE) += intel-pt.o
-libperf-$(CONFIG_AUXTRACE) += intel-bts.o
+libperf-$(CONFIG_AUXTRACE_X86) += intel-pt-decoder/
+libperf-$(CONFIG_AUXTRACE_X86) += intel-pt.o
+libperf-$(CONFIG_AUXTRACE_X86) += intel-bts.o
 libperf-y += parse-branch-options.o
 libperf-y += parse-regs-options.o
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index d76177169484..b9ac99fb5a17 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -309,7 +309,7 @@ struct auxtrace_record {
 	unsigned int alignment;
 };
 
-#ifdef HAVE_AUXTRACE_SUPPORT
+#ifdef HAVE_AUXTRACE_SUPPORT_X86
 
 /*
  * In snapshot mode the mmapped page is read-only which makes using
diff --git a/tools/perf/util/intel-bts.h b/tools/perf/util/intel-bts.h
index ca65e21b3e83..1ef679a9e9c2 100644
--- a/tools/perf/util/intel-bts.h
+++ b/tools/perf/util/intel-bts.h
@@ -35,9 +35,20 @@ struct perf_tool;
 union perf_event;
 struct perf_session;
 
+#ifdef HAVE_AUXTRACE_SUPPORT_X86
 struct auxtrace_record *intel_bts_recording_init(int *err);
 
 int intel_bts_process_auxtrace_info(union perf_event *event,
 				    struct perf_session *session);
+#else
+static inline
+struct auxtrace_record *intel_bts_recording_init(int *err __maybe_unused)
+{ return NULL; }
+
+static inline int
+intel_bts_process_auxtrace_info(union perf_event *event __maybe_unused,
+				struct perf_session *session __maybe_unused)
+{ return -EINVAL; }
+#endif
 
 #endif
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 2386322ece4f..76437e99c659 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -1,4 +1,4 @@
-libperf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
+libperf-$(CONFIG_AUXTRACE_X86) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
 
 inat_tables_script = util/intel-pt-decoder/gen-insn-attr-x86.awk
 inat_tables_maps = util/intel-pt-decoder/x86-opcode-map.txt
diff --git a/tools/perf/util/intel-pt.h b/tools/perf/util/intel-pt.h
index 0065949df693..94dd268718f6 100644
--- a/tools/perf/util/intel-pt.h
+++ b/tools/perf/util/intel-pt.h
@@ -46,11 +46,26 @@ struct perf_session;
 struct perf_event_attr;
 struct perf_pmu;
 
+#ifdef HAVE_AUXTRACE_SUPPORT_X86
 struct auxtrace_record *intel_pt_recording_init(int *err);
 
 int intel_pt_process_auxtrace_info(union perf_event *event,
 				   struct perf_session *session);
 
 struct perf_event_attr *intel_pt_pmu_default_config(struct perf_pmu *pmu);
+#else
+static inline
+struct auxtrace_record *intel_pt_recording_init(int *err __maybe_unused)
+{ return NULL; }
+
+static inline
+int intel_pt_process_auxtrace_info(union perf_event *event __maybe_unused,
+				   struct perf_session *session __maybe_unused)
+{ return -EINVAL; }
+
+static inline struct perf_event_attr
+*intel_pt_pmu_default_config(struct perf_pmu *pmu __maybe_unused)
+{ return NULL; }
+#endif
 
 #endif
-- 
1.9.1
