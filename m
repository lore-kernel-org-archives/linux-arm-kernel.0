From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Sep 2016 09:49:58 -0600
Subject: [PATCH V8 1/7] perf tools: confining __get_cpuid() to x86 architecture
In-Reply-To: <1474041004-13956-1-git-send-email-mathieu.poirier@linaro.org>
References: <1474041004-13956-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1474041004-13956-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __get_cpuid() test is only valid when compiling for x86.
When compiling for other architectures like ARM/ARM64 the test
fails event if the functionality is not required.

This patch isolate the build-in feature check to x86 platform,
allowing the compilation and usage of PMUs that use the AUXTRACE
infrastructure on other architectures (i.e ARM CoreSight).

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 24803c58049a..72edf83d76b7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -746,10 +746,13 @@ ifdef LIBBABELTRACE
 endif
 
 ifndef NO_AUXTRACE
-  ifeq ($(feature-get_cpuid), 0)
-    msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
-    NO_AUXTRACE := 1
-  else
+  ifeq ($(ARCH),x86)
+    ifeq ($(feature-get_cpuid), 0)
+      msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
+      NO_AUXTRACE := 1
+    endif
+  endif
+  ifndef NO_AUXTRACE
     $(call detected,CONFIG_AUXTRACE)
     CFLAGS += -DHAVE_AUXTRACE_SUPPORT
   endif
-- 
2.7.4
