From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 17 Oct 2017 00:02:22 +0530
Subject: [PATCH v9 5/5] perf utils: add check for valid cpuid in function
 perf_pmu__find_map
In-Reply-To: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171016183222.25750-6-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms(arm/arm64) which uses cpus map to get corresponding
cpuid string, cpuid can be NULL for PMUs other than CORE PMUs.
Adding check for NULL cpuid in function perf_pmu__find_map to
avoid segmentation fault.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9110718..569fb0c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -567,6 +567,12 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
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
2.9.4
