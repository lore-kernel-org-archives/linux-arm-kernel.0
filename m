From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 19 Jun 2017 22:54:48 -0300
Subject: [PATCH 12/23] perf coresight: Remove superfluous check before use
In-Reply-To: <20170620015459.29381-1-acme@kernel.org>
References: <20170620015459.29381-1-acme@kernel.org>
Message-ID: <20170620015459.29381-13-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kim Phillips <kim.phillips@arm.com>

The cs_etm_evsel variable is guaranteed to be set at this point in
cs_etm_recording_options().

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/20170615125521.80cc128dc856bc1f2e61b730 at arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 02a649bfec3c..7ce3d1a25133 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -203,19 +203,18 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
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
2.9.4
