From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 29 Sep 2016 11:35:37 -0300
Subject: [PATCH 08/27] perf evsel: Add support for address filters
In-Reply-To: <1475159756-21326-1-git-send-email-acme@kernel.org>
References: <1475159756-21326-1-git-send-email-acme@kernel.org>
Message-ID: <1475159756-21326-9-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch makes it possible to use the current filter framework with
address filters.  That way address filters for HW tracers such as
CoreSight and Intel PT can be communicated to the kernel drivers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1474037045-31730-4-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c        |  5 +++++
 tools/perf/util/evsel.h        |  2 ++
 tools/perf/util/parse-events.c | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3b4e7c452e43..380e84c3af3d 100644
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
index 1f8c48f87f7d..b1503b0ecdff 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -236,6 +236,8 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
 
 int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
+				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
 			     const char *filter);
 int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 16bf09cc3e8d..33546c3ac1fe 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1760,20 +1760,49 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
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
