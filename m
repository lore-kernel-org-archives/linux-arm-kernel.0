From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 16 May 2017 14:03:36 +0530
Subject: [PATCH v3 1/4] perf utils: passing pmu as a parameter to function
 get_cpuid_str
In-Reply-To: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1494923619-18687-2-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpuid string will not be same on all CPUs on heterogeneous
platforms like ARM's big.LITTLE, adding provision(using pmu->cpus)
to find cpuid string from associated CPUs of PMU CORE device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/powerpc/util/header.c | 2 +-
 tools/perf/arch/x86/util/header.c     | 2 +-
 tools/perf/util/header.h              | 3 ++-
 tools/perf/util/pmu.c                 | 9 +++++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 9aaa6f5..2953681 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -34,7 +34,7 @@
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
@@ -65,7 +65,7 @@
 }
 
 char *
-get_cpuid_str(void)
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf = malloc(128);
 
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d30109b..05e5758 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include "event.h"
 #include "env.h"
+#include "pmu.h"
 
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
@@ -151,5 +152,5 @@ int perf_event__process_build_id(struct perf_tool *tool,
  */
 int get_cpuid(char *buffer, size_t sz);
 
-char *get_cpuid_str(void);
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ac16a9d..aefdbd1 100644
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
@@ -521,7 +521,8 @@ char * __weak get_cpuid_str(void)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
+static void pmu_add_cpu_aliases(struct list_head *head, const char *name,
+		struct perf_pmu *pmu)
 {
 	int i;
 	struct pmu_events_map *map;
@@ -533,7 +534,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
 	if (cpuid)
 		cpuid = strdup(cpuid);
 	if (!cpuid)
-		cpuid = get_cpuid_str();
+		cpuid = get_cpuid_str(pmu);
 	if (!cpuid)
 		return;
 
@@ -610,12 +611,12 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
-	pmu_add_cpu_aliases(&aliases, name);
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(name);
+	pmu_add_cpu_aliases(&aliases, name, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
-- 
1.8.1.4
