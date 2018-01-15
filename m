From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 15 Jan 2018 11:13:05 -0700
Subject: [PATCH v2 01/10] perf tools: Integrating the CoreSight decoding
 library
In-Reply-To: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
References: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1516039994-314-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Open CoreSight Decoding Library (openCSD) is a free and open
library to decode traces collected by the CoreSight hardware
infrastructure.

This patch adds the required mechanic to recognise the presence
of the openCSD library on a system and set up miscellaneous flags
to be used in the compilation of the trace decoding feature.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/build/Makefile.feature          |  6 ++++--
 tools/build/feature/Makefile          |  7 ++++++-
 tools/build/feature/test-all.c        |  5 +++++
 tools/build/feature/test-libopencsd.c |  8 ++++++++
 tools/perf/Makefile.config            | 25 +++++++++++++++++++++++++
 tools/perf/Makefile.perf              |  2 ++
 6 files changed, 50 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-libopencsd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index e52fcefee379..dc3d97b248ab 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
         bpf                             \
         sched_getcpu			\
         sdt				\
-        setns
+        setns				\
+	libopencsd
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -108,7 +109,8 @@ FEATURE_DISPLAY ?=              \
          zlib                   \
          lzma                   \
          get_cpuid              \
-         bpf
+         bpf			\
+	 libopencsd
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cff38f342283..2b108a6cfac3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -52,7 +52,8 @@ FILES=                                          \
          test-cxx.bin                           \
          test-jvmti.bin				\
          test-sched_getcpu.bin			\
-         test-setns.bin
+         test-setns.bin				\
+	 test-libopencsd.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -104,6 +105,10 @@ $(OUTPUT)test-sched_getcpu.bin:
 $(OUTPUT)test-setns.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libopencsd.bin:
+	$(BUILD) # -lopencsd_c_api -lopencsd provided by
+		 # $(FEATURE_CHECK_LDFLAGS-libopencsd)
+
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
 DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6fdf83263ab7..38ab0fd7a74c 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -162,6 +162,10 @@
 # include "test-setns.c"
 #undef main
 
+#define main main_test_setns
+# include "test-libopencsd.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -199,6 +203,7 @@ int main(int argc, char *argv[])
 	main_test_sched_getcpu();
 	main_test_sdt();
 	main_test_setns();
+	main_test_libopencsd();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
new file mode 100644
index 000000000000..cd4fb99eb9d3
--- /dev/null
+++ b/tools/build/feature/test-libopencsd.c
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <opencsd/c_api/opencsd_c_api.h>
+
+int main(void)
+{
+	(void)ocsd_get_version();
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 12dec6ea5ed2..15ef1e55c7d0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -105,6 +105,16 @@ FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 
+ifdef CSINCLUDES
+  LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
+endif
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
+ifdef CSLIBS
+  LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
+endif
+FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
+
 ifeq ($(NO_PERF_REGS),0)
   CFLAGS += -DHAVE_PERF_REGS_SUPPORT
 endif
@@ -353,6 +363,21 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
+ifndef NO_CORESIGHT
+  ifeq ($(feature-libopencsd), 1)
+    CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
+    LDFLAGS += $(LIBOPENCSD_LDFLAGS)
+    EXTLIBS += $(OPENCSDLIBS)
+    $(call detected,CONFIG_LIBOPENCSD)
+    ifdef CSTRACE_RAW
+      CFLAGS += -DCS_DEBUG_RAW
+      ifeq (${CSTRACE_RAW}, packed)
+        CFLAGS += -DCS_RAW_PACKED
+      endif
+    endif
+  endif
+endif
+
 ifndef NO_LIBELF
   CFLAGS += -DHAVE_LIBELF_SUPPORT
   EXTLIBS += -lelf
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9fdefd748e2e..92dfa9580eab 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -98,6 +98,8 @@ include ../scripts/utilities.mak
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
 
+# Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
 LC_COLLATE=C
-- 
2.7.4
