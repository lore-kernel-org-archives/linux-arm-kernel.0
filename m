From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 14 Jul 2016 12:35:42 -0600
Subject: [PATCH V2 1/3] tools: Copy the header file needed by perf tools
In-Reply-To: <1468521344-15047-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468521344-15047-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468521344-15047-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Directly accessing kernel files is not allowed anymore.  As such
making file coresight-pmu.h accessible by the perf tools and complain
if this copy strays from the one found in the main kernel tree.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/include/linux/coresight-pmu.h | 39 +++++++++++++++++++++++++++++++++++++
 tools/perf/MANIFEST                 |  1 +
 tools/perf/Makefile.perf            |  3 +++
 3 files changed, 43 insertions(+)
 create mode 100644 tools/include/linux/coresight-pmu.h

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
new file mode 100644
index 000000000000..7d410260661b
--- /dev/null
+++ b/tools/include/linux/coresight-pmu.h
@@ -0,0 +1,39 @@
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
+#ifndef _LINUX_CORESIGHT_PMU_H
+#define _LINUX_CORESIGHT_PMU_H
+
+#define CORESIGHT_ETM_PMU_NAME "cs_etm"
+#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/* ETMv3.5/PTM's ETMCR config bit */
+#define ETM_OPT_CYCACC  12
+#define ETM_OPT_TS      28
+
+static inline int coresight_get_trace_id(int cpu)
+{
+	/*
+	 * A trace ID of value 0 is invalid, so let's start at some
+	 * random value that fits in 7 bits and go from there.  Since
+	 * the common convention is to have data trace IDs be I(N) + 1,
+	 * set instruction trace IDs as a function of the CPU number.
+	 */
+	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
+}
+
+#endif
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 923eda2e7d52..475e6304db18 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -77,6 +77,7 @@ tools/include/linux/stringify.h
 tools/include/linux/types.h
 tools/include/linux/err.h
 tools/include/linux/bitmap.h
+tools/include/linux/coresight-pmu.h
 include/asm-generic/bitops/arch_hweight.h
 include/asm-generic/bitops/const_hweight.h
 include/asm-generic/bitops/fls64.h
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a129fbc1ed37..739af9493e14 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -411,6 +411,9 @@ $(PERF_IN): prepare FORCE
 	@(test -f ../../arch/arm64/include/uapi/asm/kvm.h && ( \
         (diff -B ../arch/arm64/include/uapi/asm/kvm.h ../../arch/arm64/include/uapi/asm/kvm.h >/dev/null) \
         || echo "Warning: tools/arch/arm64/include/uapi/asm/kvm.h differs from kernel" >&2 )) || true
+	@(test -f ../../include/linux/coresight-pmu.h && ( \
+        (diff -B ../include/linux/coresight-pmu.h ../../include/linux/coresight-pmu.h >/dev/null) \
+        || echo "Warning: tools/include/linux/coresight-pmu.h differs from kernel" >&2 )) || true
 	$(Q)$(MAKE) $(build)=perf
 
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
-- 
2.7.4
