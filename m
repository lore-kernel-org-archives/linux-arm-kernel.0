From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Thu, 12 Oct 2017 19:41:13 +0530
Subject: [PATCH v8 1/4] perf utils: passing pmu as a parameter to function
 get_cpuid_str
In-Reply-To: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
References: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171012141116.32475-2-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpuid string will not be same on all CPUs on heterogeneous
platforms like ARM's big.LITTLE, adding provision(using pmu->cpus)
to find cpuid string from associated CPUs of PMU CORE device.

also optimise arguments to function pmu_add_cpu_aliases.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/powerpc/util/header.c |  2 +-
 tools/perf/arch/x86/util/header.c     |  2 +-
 tools/perf/util/header.h              |  3 ++-
 tools/perf/util/pmu.c                 | 13 +++++++------
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 9aaa6f5..2953681 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -34,7 +34,7 @@ get_cpuid(char *buffer, size_t sz)
 }
 
 char *
-get_cpuid_str(void)
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *bufp;
 
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index a74a48d..d52bc27 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -65,7 +65,7 @@ get_cpuid(char *buffer, size_t sz)
 }
 
 char *
-get_cpuid_str(void)
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf = malloc(128);
 
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index f7a16ee..3de4be9 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include "event.h"
 #include "env.h"
+#include "pmu.h"
 
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
@@ -165,5 +166,5 @@ int write_padded(struct feat_fd *fd, const void *bf,
  */
 int get_cpuid(char *buffer, size_t sz);
 
-char *get_cpuid_str(void);
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ac16a9d..18edf86 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -511,7 +511,7 @@ static struct cpu_map *pmu_cpumask(const char *name)
  * Each architecture should provide a more precise id string that
  * can be use to match the architecture's "mapfile".
  */
-char * __weak get_cpuid_str(void)
+char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	return NULL;
 }
@@ -521,19 +521,20 @@ char * __weak get_cpuid_str(void)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
+static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
 	int i;
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	char *cpuid;
 	static bool printed;
+	const char *name = pmu->name;
 
 	cpuid = getenv("PERF_CPUID");
 	if (cpuid)
 		cpuid = strdup(cpuid);
 	if (!cpuid)
-		cpuid = get_cpuid_str();
+		cpuid = get_cpuid_str(pmu);
 	if (!cpuid)
 		return;
 
@@ -610,19 +611,19 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
-	pmu_add_cpu_aliases(&aliases, name);
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(name);
+	pmu->name = strdup(name);
+	pmu->type = type;
+	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
-	pmu->name = strdup(name);
-	pmu->type = type;
 	list_add_tail(&pmu->list, &pmus);
 
 	pmu->default_config = perf_pmu__get_default_config(pmu);
-- 
2.9.4
