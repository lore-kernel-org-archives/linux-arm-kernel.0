From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 15 Dec 2017 09:44:50 -0700
Subject: [PATCH 01/10] perf tools: Integrating the CoreSight decoding library
In-Reply-To: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1513356299-26274-2-git-send-email-mathieu.poirier@linaro.org>
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
 tools/build/feature/Makefile          |  6 +++++-
 tools/build/feature/test-all.c        |  5 +++++
 tools/build/feature/test-libopencsd.c |  8 ++++++++
 tools/perf/Makefile.config            | 13 +++++++++++++
 5 files changed, 35 insertions(+), 3 deletions(-)
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
index cff38f342283..2aae2d3fb5f6 100644
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
 
@@ -104,6 +105,9 @@ $(OUTPUT)test-sched_getcpu.bin:
 $(OUTPUT)test-setns.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libopencsd.bin:
+	$(BUILD) -lopencsd_c_api
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
index 79b117a03fd7..2d0b99f7b4e7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -346,6 +346,19 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
+ifeq ($(feature-libopencsd), 1)
+  CFLAGS += -DHAVE_CSTRACE_SUPPORT
+  LIBCSTRACE = -lopencsd_c_api -lopencsd
+  EXTLIBS += $(LIBCSTRACE)
+  $(call detected,CONFIG_LIBOPENCSD)
+  ifdef CSTRACE_RAW
+    CFLAGS += -DCS_DEBUG_RAW
+    ifeq (${CSTRACE_RAW}, packed)
+      CFLAGS += -DCS_RAW_PACKED
+    endif
+  endif
+endif
+
 ifndef NO_LIBELF
   CFLAGS += -DHAVE_LIBELF_SUPPORT
   EXTLIBS += -lelf
-- 
2.7.4
