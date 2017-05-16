From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 16 May 2017 14:03:37 +0530
Subject: [PATCH v3 2/4] perf tools arm64: Add support for get_cpuid_str
 function.
In-Reply-To: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1494923619-18687-3-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function get_cpuid_str returns MIDR string of the first online
cpu from the range of cpus associated with the pmu core device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/arm64/util/Build    |  1 +
 tools/perf/arch/arm64/util/header.c | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
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
index 0000000..4e25498
--- /dev/null
+++ b/tools/perf/arch/arm64/util/header.c
@@ -0,0 +1,59 @@
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
+	char *buf = malloc(MIDR_SIZE);
+	char *temp = NULL;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	int cpu, ret;
+	unsigned long long midr;
+	struct cpu_map *cpus;
+	FILE *file;
+
+	if (!pmu->cpus)
+		return NULL;
+
+	if (!sysfs)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	cpus = cpu_map__get(pmu->cpus);
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		ret = snprintf(path, PATH_MAX,
+				"%s/devices/system/cpu/cpu%d"MIDR,
+				sysfs, cpus->map[cpu]);
+		if (ret == PATH_MAX) {
+			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
+			goto err;
+		}
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		temp = fgets(buf, MIDR_SIZE, file);
+		fclose(file);
+		if (!temp)
+			continue;
+
+		/* Ignore/clear Variant[23:20] and
+		 * Revision[3:0] of MIDR
+		 */
+		midr = strtoll(buf, NULL, 16);
+		midr &= (~(0xf << 20 | 0xf));
+		snprintf(buf, MIDR_SIZE, "0x%016llx", midr);
+		cpu_map__put(cpus);
+		return buf;
+	}
+
+err:	cpu_map__put(cpus);
+	free(buf);
+	return NULL;
+}
-- 
1.8.1.4
