From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Wed, 16 Aug 2017 12:40:46 +0530
Subject: [PATCH v5 2/4] perf tools arm64: Add support for get_cpuid_str
 function.
In-Reply-To: <20170816071048.26087-1-ganapatrao.kulkarni@cavium.com>
References: <20170816071048.26087-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170816071048.26087-3-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function get_cpuid_str returns MIDR string of the first online
cpu from the range of cpus associated with the pmu core device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/arm64/util/Build    |  1 +
 tools/perf/arch/arm64/util/header.c | 61 +++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
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
index 0000000..713ef17
--- /dev/null
+++ b/tools/perf/arch/arm64/util/header.c
@@ -0,0 +1,61 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include "header.h"
+
+#define MIDR "/regs/identification/midr_el1"
+#define MIDR_SIZE 128
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	char *temp = NULL;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	int cpu;
+	unsigned long long midr = 0;
+	struct cpu_map *cpus;
+	FILE *file;
+
+	if (!sysfs || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	cpus = cpu_map__get(pmu->cpus);
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
+				sysfs, cpus->map[cpu]);
+
+		file = fopen(path, "r");
+		if (!file) {
+			pr_err("fopen failed for file %s\n", path);
+			continue;
+		}
+
+		temp = fgets(buf, MIDR_SIZE, file);
+		if (!temp)
+			continue;
+		fclose(file);
+
+		/* Ignore/clear Variant[23:20] and
+		 * Revision[3:0] of MIDR
+		 */
+		midr = strtoll(buf, NULL, 16);
+		midr &= (~(0xf << 20 | 0xf));
+		scnprintf(buf, MIDR_SIZE, "0x%016llx", midr);
+		/* got midr break loop */
+		break;
+	}
+
+	if (!midr) {
+		free(buf);
+		buf = NULL;
+	}
+
+	cpu_map__put(cpus);
+	return buf;
+}
-- 
2.9.4
