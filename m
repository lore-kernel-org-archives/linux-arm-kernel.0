From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Thu, 12 Oct 2017 19:41:14 +0530
Subject: [PATCH v8 2/4] perf tools arm64: Add support for get_cpuid_str
 function.
In-Reply-To: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
References: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171012141116.32475-3-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function get_cpuid_str returns MIDR string of the first online
cpu from the range of cpus associated with the pmu core device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/arm64/util/Build    |  1 +
 tools/perf/arch/arm64/util/header.c | 65 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
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
index 0000000..74567d7
--- /dev/null
+++ b/tools/perf/arch/arm64/util/header.c
@@ -0,0 +1,65 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include "header.h"
+
+#define MIDR "/regs/identification/midr_el1"
+#define MIDR_SIZE 19
+#define MIDR_REVISION_MASK      0xf
+#define MIDR_VARIANT_SHIFT      20
+#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	int cpu;
+	u64 midr = 0;
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
+			pr_debug("fopen failed for file %s\n", path);
+			continue;
+		}
+
+		if (!fgets(buf, MIDR_SIZE, file)) {
+			fclose(file);
+			continue;
+		}
+		fclose(file);
+
+		/* Ignore/clear Variant[23:20] and
+		 * Revision[3:0] of MIDR
+		 */
+		midr = strtoul(buf, NULL, 16);
+		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
+		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
+		/* got midr break loop */
+		break;
+	}
+
+	if (!midr) {
+		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
+		free(buf);
+		buf = NULL;
+	}
+
+	cpu_map__put(cpus);
+	return buf;
+}
-- 
2.9.4
