From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 29 Sep 2016 11:35:36 -0300
Subject: [PATCH 07/27] perf evsel: New tracepoint specific function
In-Reply-To: <1475159756-21326-1-git-send-email-acme@kernel.org>
References: <1475159756-21326-1-git-send-email-acme@kernel.org>
Message-ID: <1475159756-21326-8-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Making function perf_evsel__append_filter() static and introducing a new
tracepoint specific function to append filters.  That way we eliminate
redundant code and avoid formatting mistake.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1474037045-31730-3-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     | 7 +++----
 tools/perf/util/evsel.c        | 9 +++++++--
 tools/perf/util/evsel.h        | 3 +--
 tools/perf/util/parse-events.c | 4 ++--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e04ba9d852d4..c298bd3e1d90 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2151,11 +2151,10 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 	if (filter == NULL)
 		goto out_enomem;
 
-	if (!perf_evsel__append_filter(trace->syscalls.events.sys_enter,
-				       "(%s) && (%s)", filter)) {
+	if (!perf_evsel__append_tp_filter(trace->syscalls.events.sys_enter,
+					  filter)) {
 		sys_exit = trace->syscalls.events.sys_exit;
-		err = perf_evsel__append_filter(sys_exit,
-						"(%s) && (%s)", filter);
+		err = perf_evsel__append_tp_filter(sys_exit, filter);
 	}
 
 	free(filter);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f327b522e5c..3b4e7c452e43 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1045,8 +1045,8 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
 	return -1;
 }
 
-int perf_evsel__append_filter(struct perf_evsel *evsel,
-			      const char *fmt, const char *filter)
+static int perf_evsel__append_filter(struct perf_evsel *evsel,
+				     const char *fmt, const char *filter)
 {
 	char *new_filter;
 
@@ -1062,6 +1062,11 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
+{
+	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
+}
+
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
 	int nthreads = thread_map__nr(evsel->threads);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 7ef960298b3d..1f8c48f87f7d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -235,8 +235,7 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
 			       bool use_sample_identifier);
 
 int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
-int perf_evsel__append_filter(struct perf_evsel *evsel,
-			      const char *fmt, const char *filter);
+int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
 			     const char *filter);
 int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b14784c765eb..16bf09cc3e8d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1767,7 +1767,7 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (perf_evsel__append_filter(evsel, "(%s) && (%s)", str) < 0) {
+	if (perf_evsel__append_tp_filter(evsel, str) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
@@ -1798,7 +1798,7 @@ static int add_exclude_perf_filter(struct perf_evsel *evsel,
 
 	snprintf(new_filter, sizeof(new_filter), "common_pid != %d", getpid());
 
-	if (perf_evsel__append_filter(evsel, "(%s) && (%s)", new_filter) < 0) {
+	if (perf_evsel__append_tp_filter(evsel, new_filter) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
-- 
2.7.4
