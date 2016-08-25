From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 14:20:44 -0600
Subject: [PATCH V6 4/5] perf tools: Pushing configuration down to PMU driver
In-Reply-To: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472156445-24283-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PMU callback so that drivers can process the
command line configuration elements found in evsel::config_terms.
The callback is then used in various places where events can be
specified.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/builtin-record.c |  9 +++++++++
 tools/perf/builtin-stat.c   |  8 ++++++++
 tools/perf/builtin-top.c    | 12 ++++++++++++
 tools/perf/util/evlist.c    | 18 ++++++++++++++++++
 tools/perf/util/evlist.h    |  3 +++
 tools/perf/util/evsel.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h     |  2 ++
 tools/perf/util/pmu.h       |  2 ++
 8 files changed, 94 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6355902fbfc8..74927d6e147e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -383,6 +383,7 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
+	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	perf_evlist__config(evlist, opts, &callchain_param);
@@ -412,6 +413,14 @@ try_again:
 		goto out;
 	}
 
+	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+		      err_term->val.drv_cfg, perf_evsel__name(pos), errno,
+		      strerror_r(errno, msg, sizeof(msg)));
+		rc = -1;
+		goto out;
+	}
+
 	rc = record__mmap(rec);
 	if (rc)
 		goto out;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c7452b39f57..7f378c551ab6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -539,6 +539,7 @@ static int __run_perf_stat(int argc, const char **argv)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.file.is_pipe : false;
+	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / 1000;
@@ -610,6 +611,13 @@ try_again:
 		return -1;
 	}
 
+	if (perf_evlist__apply_drv_configs(evsel_list, &counter, &err_term)) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+		      err_term->val.drv_cfg, perf_evsel__name(counter), errno,
+		      strerror_r(errno, msg, sizeof(msg)));
+		return -1;
+	}
+
 	if (STAT_RECORD) {
 		int err, fd = perf_data_file__fd(&perf_stat.file);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 418ed94756d3..0e566fe95e1b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -940,6 +940,10 @@ static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 
 static int __cmd_top(struct perf_top *top)
 {
+	char msg[512];
+	struct perf_evsel *pos;
+	struct perf_evsel_config_term *err_term;
+	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 	pthread_t thread;
 	int ret;
@@ -976,6 +980,14 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		goto out_delete;
 
+	ret = perf_evlist__apply_drv_configs(evlist, &pos, &err_term);
+	if (ret) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
+			strerror_r(errno, msg, sizeof(msg)));
+		goto out_delete;
+	}
+
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 097b3ed77fdd..d9d160324f50 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1415,6 +1415,24 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 	return err;
 }
 
+int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
+				   struct perf_evsel **err_evsel,
+				   struct perf_evsel_config_term **err_term)
+{
+	struct perf_evsel *evsel;
+	int err = 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__apply_drv_configs(evsel, err_term);
+		if (err) {
+			*err_evsel = evsel;
+			break;
+		}
+	}
+
+	return err;
+}
+
 int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter)
 {
 	struct perf_evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 4fd034f22d2f..bf7ed0be3f33 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -232,6 +232,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist, struct cpu_map *cpus,
 			   struct thread_map *threads);
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target);
 int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **err_evsel);
+int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
+				   struct perf_evsel **err_evsel,
+				   struct perf_evsel_config_term **term);
 
 void __perf_evlist__set_leader(struct list_head *list);
 void perf_evlist__set_leader(struct perf_evlist *evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d9b80ef881cd..ea53f33a968c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -25,6 +25,7 @@
 #include "thread_map.h"
 #include "target.h"
 #include "perf_regs.h"
+#include "pmu.h"
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
@@ -1062,6 +1063,45 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
+				  struct perf_evsel_config_term **err_term)
+{
+	bool found = false;
+	int err = 0;
+	struct perf_evsel_config_term *term;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL)
+		if (pmu->type == evsel->attr.type) {
+			found = true;
+			break;
+		}
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		/*
+		 * We have a configuration term, report an error if we
+		 * can't find the PMU or if the PMU driver doesn't support
+		 * cmd line driver configuration.
+		 */
+		if (!found || !pmu->set_drv_config) {
+			err = -EINVAL;
+			*err_term = term;
+			break;
+		}
+
+		err = pmu->set_drv_config(term);
+		if (err) {
+			*err_term = term;
+			break;
+		}
+	}
+
+	return err;
+}
+
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
 	int nthreads = thread_map__nr(evsel->threads);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 323806082c58..8ceb7ebb51f5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -239,6 +239,8 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
 			      const char *op, const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
 			     const char *filter);
+int perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
+				  struct perf_evsel_config_term **err_term);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5d7e84466bee..743422ad900b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -4,6 +4,7 @@
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
 #include <stdbool.h>
+#include "evsel.h"
 #include "parse-events.h"
 
 enum {
@@ -25,6 +26,7 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
+	int (*set_drv_config)	(struct perf_evsel_config_term *term);
 };
 
 struct perf_pmu_info {
-- 
2.7.4
