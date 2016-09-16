From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Sep 2016 08:44:05 -0600
Subject: [PATCH V7 3/3] perf tools: adding support for address filters
In-Reply-To: <1474037045-31730-1-git-send-email-mathieu.poirier@linaro.org>
References: <1474037045-31730-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1474037045-31730-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to use the current filter
framework with address filters.  That way address filters for
HW tracers such as CoreSight and Intel PT can be communicated
to the kernel drivers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c        |  5 +++++
 tools/perf/util/evsel.h        |  2 ++
 tools/perf/util/parse-events.c | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a99e82d97df2..e0bb399dcdd4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1067,6 +1067,11 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
 }
 
+int perf_evsel__append_addr_filter(struct perf_evsel *evsel, const char *filter)
+{
+	return perf_evsel__append_filter(evsel, "%s,%s", filter);
+}
+
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
 	int nthreads = thread_map__nr(evsel->threads);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 36ed0997e65b..49c51fb3d05c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -234,6 +234,8 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
 
 int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
+				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
 			     const char *filter);
 int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 751b48fc641c..c23f2d5fc134 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1755,20 +1755,49 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
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
+	if (evsel == NULL)
+		goto err;
+
+	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
+		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
+			fprintf(stderr,
+				"not enough memory to hold filter string\n");
+			return -1;
+		}
+
+		return 0;
 	}
 
-	if (perf_evsel__append_tp_filter(evsel, str) < 0) {
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
+	if (!nr_addr_filters)
+		goto err;
+
+	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
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
