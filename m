From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 15 Dec 2017 11:09:15 -0700
Subject: [PATCH] perf tools: cs-etm: Properly deal with cpu maps
Message-ID: <1513361355-29107-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the CoreSight header file to fit topologies where only
a subset of all available CPUs are present, avoiding at the same time
accessing the ETM configuration areas of CPUs that have been offlined.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 51 +++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index fbfc055d3f4d..5c655ad4621e 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -298,12 +298,17 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 {
 	int i;
 	int etmv3 = 0, etmv4 = 0;
-	const struct cpu_map *cpus = evlist->cpus;
+	struct cpu_map *event_cpus = evlist->cpus;
+	struct cpu_map *online_cpus = cpu_map__new(NULL);
 
 	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!cpu_map__empty(cpus)) {
-		for (i = 0; i < cpu_map__nr(cpus); i++) {
-			if (cs_etm_is_etmv4(itr, cpus->map[i]))
+	if (!cpu_map__empty(event_cpus)) {
+		for (i = 0; i < cpu__max_cpu(); i++) {
+			if (!cpu_map__has(event_cpus, i) ||
+			    !cpu_map__has(online_cpus, i))
+				continue;
+
+			if (cs_etm_is_etmv4(itr, i))
 				etmv4++;
 			else
 				etmv3++;
@@ -311,6 +316,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	} else {
 		/* get configuration for all CPUs in the system */
 		for (i = 0; i < cpu__max_cpu(); i++) {
+			if (!cpu_map__has(online_cpus, i))
+				continue;
+
 			if (cs_etm_is_etmv4(itr, i))
 				etmv4++;
 			else
@@ -318,6 +326,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		}
 	}
 
+	cpu_map__put(online_cpus);
+
 	return (CS_ETM_HEADER_SIZE +
 	       (etmv4 * CS_ETMV4_PRIV_SIZE) +
 	       (etmv3 * CS_ETMV3_PRIV_SIZE));
@@ -447,7 +457,9 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	int i;
 	u32 offset;
 	u64 nr_cpu, type;
-	const struct cpu_map *cpus = session->evlist->cpus;
+	struct cpu_map *cpu_map;
+	struct cpu_map *event_cpus = session->evlist->cpus;
+	struct cpu_map *online_cpus = cpu_map__new(NULL);
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
@@ -458,8 +470,21 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	/* If the cpu_map is empty all CPUs are involved */
-	nr_cpu = cpu_map__empty(cpus) ? cpu__max_cpu() : cpu_map__nr(cpus);
+	/* If the cpu_map is empty all online CPUs are involved */
+	if (cpu_map__empty(event_cpus)) {
+		cpu_map = online_cpus;
+	} else {
+		/* Make sure all specified CPUs are online */
+		for (i = 0; i < cpu_map__nr(event_cpus); i++) {
+			if (cpu_map__has(event_cpus, i) &&
+			    !cpu_map__has(online_cpus, i))
+				return -EINVAL;
+		}
+
+		cpu_map = event_cpus;
+	}
+
+	nr_cpu = cpu_map__nr(cpu_map);
 	/* Get PMU type as dynamically assigned by the core */
 	type = cs_etm_pmu->type;
 
@@ -472,15 +497,11 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 
 	offset = CS_ETM_SNAPSHOT + 1;
 
-	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!cpu_map__empty(cpus)) {
-		for (i = 0; i < cpu_map__nr(cpus) && offset < priv_size; i++)
-			cs_etm_get_metadata(cpus->map[i], &offset, itr, info);
-	} else {
-		/* get configuration for all CPUs in the system */
-		for (i = 0; i < cpu__max_cpu(); i++)
+	for (i = 0; i < cpu__max_cpu() && offset < priv_size; i++)
+		if (cpu_map__has(cpu_map, i))
 			cs_etm_get_metadata(i, &offset, itr, info);
-	}
+
+	cpu_map__put(online_cpus);
 
 	return 0;
 }
-- 
2.7.4
