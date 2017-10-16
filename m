From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 17 Oct 2017 00:02:18 +0530
Subject: [PATCH v9 1/5] perf utils: passing pmu as a parameter to function
 get_cpuid_str
In-Reply-To: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171016183222.25750-2-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpuid string will not be same on all CPUs on heterogeneous
platforms like ARM's big.LITTLE, adding provision(using pmu->cpus)
to find cpuid string from associated CPUs of PMU CORE device.

also optimise arguments to function pmu_add_cpu_aliases.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/arch/powerpc/util/header.c |  2 +-
 tools/perf/arch/x86/util/header.c     |  2 +-
 tools/perf/util/header.h              |  3 ++-
 tools/perf/util/metricgroup.c         |  4 ++--
 tools/perf/util/pmu.c                 | 22 +++++++++++-----------
 tools/perf/util/pmu.h                 |  2 +-
 6 files changed, 18 insertions(+), 17 deletions(-)

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
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0ddd9c1..9b8b671 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -270,7 +270,7 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw)
 {
-	struct pmu_events_map *map = perf_pmu__find_map();
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
 	int i;
 	struct rblist groups;
@@ -368,7 +368,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
-	struct pmu_events_map *map = perf_pmu__find_map();
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
 	int ret = -EINVAL;
 	int i, j;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 94cf2c2..8b17db5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -536,12 +536,12 @@ static bool pmu_is_uncore(const char *name)
  * Each architecture should provide a more precise id string that
  * can be use to match the architecture's "mapfile".
  */
-char * __weak get_cpuid_str(void)
+char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	return NULL;
 }
 
-static char *perf_pmu__getcpuid(void)
+static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 {
 	char *cpuid;
 	static bool printed;
@@ -550,7 +550,7 @@ static char *perf_pmu__getcpuid(void)
 	if (cpuid)
 		cpuid = strdup(cpuid);
 	if (!cpuid)
-		cpuid = get_cpuid_str();
+		cpuid = get_cpuid_str(pmu);
 	if (!cpuid)
 		return NULL;
 
@@ -561,10 +561,10 @@ static char *perf_pmu__getcpuid(void)
 	return cpuid;
 }
 
-struct pmu_events_map *perf_pmu__find_map(void)
+struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 {
 	struct pmu_events_map *map;
-	char *cpuid = perf_pmu__getcpuid();
+	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
 	i = 0;
@@ -587,13 +587,14 @@ struct pmu_events_map *perf_pmu__find_map(void)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
+static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
 	int i;
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
+	const char *name = pmu->name;
 
-	map = perf_pmu__find_map();
+	map = perf_pmu__find_map(pmu);
 	if (!map)
 		return;
 
@@ -655,21 +656,20 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
-	pmu_add_cpu_aliases(&aliases, name);
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(name);
-
+	pmu->name = strdup(name);
+	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
-	pmu->name = strdup(name);
-	pmu->type = type;
 	list_add_tail(&pmu->list, &pmus);
 
 	pmu->default_config = perf_pmu__get_default_config(pmu);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7ca6755..abc4728 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -91,6 +91,6 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
-struct pmu_events_map *perf_pmu__find_map(void);
+struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
 #endif /* __PMU_H */
-- 
2.9.4
