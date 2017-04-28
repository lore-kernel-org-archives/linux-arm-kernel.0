From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Fri, 28 Apr 2017 10:23:45 +0530
Subject: [PATCH v2 2/4] perf tools arm64: Add support for get_cpuid_str
 function.
In-Reply-To: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1493355227-31492-3-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function get_cpuid_str returns MIDR string of the first online
cpu from the range of cpus associated with the pmu core device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/arm64/util/Build    |  1 +
 tools/perf/arch/arm64/util/header.c | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/header.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index cef6fb3..b1ab72d 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,3 +1,4 @@
+libperf-y += header.o
 libperf-$(CONFIG_DWARF)     += dwarf-regs.o
 libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 
diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
new file mode 100644
index 0000000..d8980a6b
--- /dev/null
+++ b/tools/perf/arch/arm64/util/header.c
@@ -0,0 +1,41 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include "header.h"
+
+#define LINUX_SYS_CPU_DIRECTORY "/sys/devices/system/cpu/"
+#define MIDR "/regs/identification/midr_el1"
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = malloc(128);
+	FILE *file;
+	char *ret = NULL;
+	int cpu;
+	char sys_file[256];
+	struct cpu_map *cpus;
+
+	if (!pmu->cpus)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	cpus = cpu_map__get(pmu->cpus);
+
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		sprintf(sys_file, LINUX_SYS_CPU_DIRECTORY"cpu%d"MIDR,
+				cpus->map[cpu]);
+		file = fopen(sys_file, "r");
+		if (file) {
+			ret = fgets(buf, 128, file);
+			if (ret) {
+				buf[strlen(buf)-1] = '\0';
+				fclose(file);
+				cpu_map__put(cpus);
+				return buf;
+			}
+			fclose(file);
+		}
+	}
+	cpu_map__put(cpus);
+	free(buf);
+	return ret;
+}
-- 
1.8.1.4
