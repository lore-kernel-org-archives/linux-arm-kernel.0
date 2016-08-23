From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 23 Aug 2016 13:51:11 -0600
Subject: [PATCH] perf tools: Adding support for address filters
Message-ID: <1471981871-2025-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to use the current filter
framework with address filters.  That way address filters for
HW tracers such as CoreSight and IntelPT can be communicated
to the kernel drivers.

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/parse-events.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2eb8b1ed4cc8..912b43108da5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1760,8 +1760,24 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
 static int set_filter(struct perf_evsel *evsel, const void *arg)
 {
 	const char *str = arg;
+	bool found = false;
+	int nr_addr_filters = 0;
+	struct perf_pmu *pmu = NULL;
 
-	if (evsel == NULL || evsel->attr.type != PERF_TYPE_TRACEPOINT) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL)
+		if (pmu->type == evsel->attr.type) {
+			found = true;
+			break;
+		}
+
+	if (found)
+		perf_pmu__scan_file(pmu, "nr_addr_filters",
+				    "%d", &nr_addr_filters);
+
+	if (evsel == NULL)
+		return -1;
+
+	if (evsel->attr.type != PERF_TYPE_TRACEPOINT && !nr_addr_filters) {
 		fprintf(stderr,
 			"--filter option should follow a -e tracepoint option\n");
 		return -1;
-- 
2.7.4
