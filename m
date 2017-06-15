From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 15 Jun 2017 12:55:21 -0500
Subject: [PATCH 2/2] perf coresight: Remove superfluous check before use
Message-ID: <20170615125521.80cc128dc856bc1f2e61b730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cs_etm_evsel is guaranteed to be set at this point in the function.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 29361d9b635a..8e1e9469caf2 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -202,19 +202,18 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
 			  opts->auxtrace_snapshot_size);
 
-	if (cs_etm_evsel) {
-		/*
-		 * To obtain the auxtrace buffer file descriptor, the auxtrace
-		 * event must come first.
-		 */
-		perf_evlist__to_front(evlist, cs_etm_evsel);
-		/*
-		 * In the case of per-cpu mmaps, we need the CPU on the
-		 * AUX event.
-		 */
-		if (!cpu_map__empty(cpus))
-			perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
-	}
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace
+	 * event must come first.
+	 */
+	perf_evlist__to_front(evlist, cs_etm_evsel);
+
+	/*
+	 * In the case of per-cpu mmaps, we need the CPU on the
+	 * AUX event.
+	 */
+	if (!cpu_map__empty(cpus))
+		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
 
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
-- 
2.11.0
