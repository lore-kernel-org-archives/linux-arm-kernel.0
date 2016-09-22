From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 22 Sep 2016 18:12:51 -0300
Subject: [PATCH 07/15] perf tools: Add PMU configuration to tools
In-Reply-To: <1474578779-14095-1-git-send-email-acme@kernel.org>
References: <1474578779-14095-1-git-send-email-acme@kernel.org>
Message-ID: <1474578779-14095-8-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Now that the required mechanic is there to deal with PMU specific
configuration, add the functionality to the tools where events can be
selected.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1474041004-13956-7-git-send-email-mathieu.poirier at linaro.org
[ Fix the build on XSI-compliant systems, using str_error_r() to make sure we return a string, not an integer ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 10 ++++++++++
 tools/perf/builtin-stat.c   |  9 +++++++++
 tools/perf/builtin-top.c    | 13 +++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 03251c7f14ec..2d0d69be3bf8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -22,6 +22,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
+#include "util/drv_configs.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/symbol.h"
@@ -383,6 +384,7 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
+	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	perf_evlist__config(evlist, opts, &callchain_param);
@@ -412,6 +414,14 @@ try_again:
 		goto out;
 	}
 
+	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+		      err_term->val.drv_cfg, perf_evsel__name(pos), errno,
+		      str_error_r(errno, msg, sizeof(msg)));
+		rc = -1;
+		goto out;
+	}
+
 	rc = record__mmap(rec);
 	if (rc)
 		goto out;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 90882b1d6a91..688dea7cb08f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -52,6 +52,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
+#include "util/drv_configs.h"
 #include "util/color.h"
 #include "util/stat.h"
 #include "util/header.h"
@@ -540,6 +541,7 @@ static int __run_perf_stat(int argc, const char **argv)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.file.is_pipe : false;
+	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -611,6 +613,13 @@ try_again:
 		return -1;
 	}
 
+	if (perf_evlist__apply_drv_configs(evsel_list, &counter, &err_term)) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+		      err_term->val.drv_cfg, perf_evsel__name(counter), errno,
+		      str_error_r(errno, msg, sizeof(msg)));
+		return -1;
+	}
+
 	if (STAT_RECORD) {
 		int err, fd = perf_data_file__fd(&perf_stat.file);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 400785702566..fe3af9535e85 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -24,6 +24,7 @@
 #include "util/annotate.h"
 #include "util/config.h"
 #include "util/color.h"
+#include "util/drv_configs.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/machine.h"
@@ -913,6 +914,10 @@ static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 
 static int __cmd_top(struct perf_top *top)
 {
+	char msg[512];
+	struct perf_evsel *pos;
+	struct perf_evsel_config_term *err_term;
+	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 	pthread_t thread;
 	int ret;
@@ -947,6 +952,14 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		goto out_delete;
 
+	ret = perf_evlist__apply_drv_configs(evlist, &pos, &err_term);
+	if (ret) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
+			str_error_r(errno, msg, sizeof(msg)));
+		goto out_delete;
+	}
+
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
 
-- 
2.7.4
