From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Wed,  6 Dec 2017 11:41:02 -0300
Subject: [PATCH 23/36] perf pmu: Add check for valid cpuid in
 perf_pmu__find_map()
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Message-ID: <20171206144115.15097-24-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

On some platforms(arm/arm64) which uses cpus map to get corresponding
cpuid string, cpuid can be NULL for PMUs other than CORE PMUs.  Adding
check for NULL cpuid in function perf_pmu__find_map to avoid
segmentation fault.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/20171016183222.25750-6-ganapatrao.kulkarni at cavium.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 732ff579ec65..8b7c151579c0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -601,6 +601,12 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
+	/* on some platforms which uses cpus map, cpuid can be NULL for
+	 * PMUs other than CORE PMUs.
+	 */
+	if (!cpuid)
+		return NULL;
+
 	i = 0;
 	for (;;) {
 		map = &pmu_events_map[i++];
-- 
2.13.6
