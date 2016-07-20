From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Jul 2016 14:16:06 -0600
Subject: [PATCH V3 1/3] tools: Copy the header file needed by perf tools
In-Reply-To: <1469045768-17549-1-git-send-email-mathieu.poirier@linaro.org>
References: <1469045768-17549-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1469045768-17549-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Directly accessing kernel files is not allowed anymore.  As such
making file coresight-pmu.h accessible by the perf tools and complain
if this copy strays from the one found in the main kernel tree.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/MANIFEST      | 1 +
 tools/perf/Makefile.perf | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index ad2534df4ba6..f181c613d9aa 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -77,4 +77,5 @@ tools/include/linux/stringify.h
 tools/include/linux/types.h
 tools/include/linux/err.h
 tools/include/linux/bitmap.h
+tools/include/linux/coresight-pmu.h
 tools/arch/*/include/uapi/asm/perf_regs.h
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6641abb97f0a..9ad53b9868d8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -429,6 +429,9 @@ $(PERF_IN): prepare FORCE
 	@(test -f ../../include/asm-generic/bitops/fls64.h && ( \
         (diff -B ../include/asm-generic/bitops/fls64.h ../../include/asm-generic/bitops/fls64.h >/dev/null) \
         || echo "Warning: tools/include/asm-generic/bitops/fls64.h differs from kernel" >&2 )) || true
+	@(test -f ../../include/linux/coresight-pmu.h && ( \
+	(diff -B ../include/linux/coresight-pmu.h ../../include/linux/coresight-pmu.h >/dev/null) \
+	|| echo "Warning: tools/include/linux/coresight-pmu.h differs from kernel" >&2 )) || true
 	$(Q)$(MAKE) $(build)=perf
 
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
-- 
2.7.4
