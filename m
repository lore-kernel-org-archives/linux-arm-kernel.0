From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 30 Aug 2016 10:10:15 -0600
Subject: [PATCH V2] perf tools: adding support for address filters
Message-ID: <1472573415-3618-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to use the current filter
framework with address filters.  That way address filters for
HW tracers such as CoreSight and IntelPT can be communicated
to the kernel drivers.

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

---
Changes for V2:
 - Rebased to v4.8-rc4.
 - Revisited error path.
---

 tools/perf/util/parse-events.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2eb8b1ed4cc8..1df413fbf7f8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1760,12 +1760,26 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
 static int set_filter(struct perf_evsel *evsel, const void *arg)
 {
 	const char *str = arg;
+	bool found = false;
+	int nr_addr_filters = 0;
+	struct perf_pmu *pmu = NULL;
 
-	if (evsel == NULL || evsel->attr.type != PERF_TYPE_TRACEPOINT) {
-		fprintf(stderr,
-			"--filter option should follow a -e tracepoint option\n");
-		return -1;
-	}
+	if (evsel == NULL)
+		goto err;
+
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
+
+	if (evsel->attr.type != PERF_TYPE_TRACEPOINT && !nr_addr_filters)
+		goto err;
 
 	if (perf_evsel__append_filter(evsel, "&&", str) < 0) {
 		fprintf(stderr,
@@ -1774,6 +1788,12 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	}
 
 	return 0;
+
+err:
+	fprintf(stderr,
+		"--filter option should follow a -e tracepoint or HW tracer option\n");
+
+	return -1;
 }
 
 int parse_filter(const struct option *opt, const char *str,
-- 
2.7.4
