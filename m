From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 29 Sep 2016 11:35:35 -0300
Subject: [PATCH 06/27] perf tools: Make perf_evsel__append_filter() generic
In-Reply-To: <1475159756-21326-1-git-send-email-acme@kernel.org>
References: <1475159756-21326-1-git-send-email-acme@kernel.org>
Message-ID: <1475159756-21326-7-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

By making function perf_evsel__append_filter() take a format rather than
an operator it is possible to reuse the code for other purposes (ex.
Intel PT and CoreSight) than tracepoints.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1474037045-31730-2-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     | 9 +++++++--
 tools/perf/util/evsel.c        | 4 ++--
 tools/perf/util/evsel.h        | 2 +-
 tools/perf/util/parse-events.c | 4 ++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1a54ce9d101c..e04ba9d852d4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2143,6 +2143,7 @@ out_delete_sys_enter:
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
 	int err = -1;
+	struct perf_evsel *sys_exit;
 	char *filter = asprintf_expr_inout_ints("id", !trace->not_ev_qualifier,
 						trace->ev_qualifier_ids.nr,
 						trace->ev_qualifier_ids.entries);
@@ -2150,8 +2151,12 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 	if (filter == NULL)
 		goto out_enomem;
 
-	if (!perf_evsel__append_filter(trace->syscalls.events.sys_enter, "&&", filter))
-		err = perf_evsel__append_filter(trace->syscalls.events.sys_exit, "&&", filter);
+	if (!perf_evsel__append_filter(trace->syscalls.events.sys_enter,
+				       "(%s) && (%s)", filter)) {
+		sys_exit = trace->syscalls.events.sys_exit;
+		err = perf_evsel__append_filter(sys_exit,
+						"(%s) && (%s)", filter);
+	}
 
 	free(filter);
 out:
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f3225a2e6eee..4f327b522e5c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1046,14 +1046,14 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
 }
 
 int perf_evsel__append_filter(struct perf_evsel *evsel,
-			      const char *op, const char *filter)
+			      const char *fmt, const char *filter)
 {
 	char *new_filter;
 
 	if (evsel->filter == NULL)
 		return perf_evsel__set_filter(evsel, filter);
 
-	if (asprintf(&new_filter,"(%s) %s (%s)", evsel->filter, op, filter) > 0) {
+	if (asprintf(&new_filter, fmt, evsel->filter, filter) > 0) {
 		free(evsel->filter);
 		evsel->filter = new_filter;
 		return 0;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 323806082c58..7ef960298b3d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -236,7 +236,7 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
 
 int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_filter(struct perf_evsel *evsel,
-			      const char *op, const char *filter);
+			      const char *fmt, const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
 			     const char *filter);
 int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2eb8b1ed4cc8..b14784c765eb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1767,7 +1767,7 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (perf_evsel__append_filter(evsel, "&&", str) < 0) {
+	if (perf_evsel__append_filter(evsel, "(%s) && (%s)", str) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
@@ -1798,7 +1798,7 @@ static int add_exclude_perf_filter(struct perf_evsel *evsel,
 
 	snprintf(new_filter, sizeof(new_filter), "common_pid != %d", getpid());
 
-	if (perf_evsel__append_filter(evsel, "&&", new_filter) < 0) {
+	if (perf_evsel__append_filter(evsel, "(%s) && (%s)", new_filter) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
-- 
2.7.4
