From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 11 Aug 2016 10:21:02 -0600
Subject: [PATCH V5 7/9] perf tools: pushing driver configuration down to the
 kernel
In-Reply-To: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1470932464-726-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that PMU specific driver configuration are queued in
evsel::config_terms, all we need to do is re-use the current
ioctl() mechanism to push down the information to the kernel
driver.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/builtin-record.c |  9 +++++++++
 tools/perf/builtin-stat.c   |  8 ++++++++
 tools/perf/builtin-top.c    | 12 ++++++++++++
 tools/perf/util/evlist.c    | 21 +++++++++++++++++++++
 tools/perf/util/evlist.h    |  3 +++
 tools/perf/util/evsel.c     | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h     |  3 +++
 7 files changed, 80 insertions(+)

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
index 0c16d20d7e32..f003a9e50f4e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -533,6 +533,7 @@ static int __run_perf_stat(int argc, const char **argv)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.file.is_pipe : false;
+	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / 1000;
@@ -604,6 +605,13 @@ try_again:
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
index 097b3ed77fdd..e907877b06b9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1415,6 +1415,27 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 	return err;
 }
 
+int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
+				   struct perf_evsel **err_evsel,
+				   struct perf_evsel_config_term **err_term)
+{
+	struct perf_evsel *evsel;
+	int err = 0;
+	const int ncpus = cpu_map__nr(evlist->cpus),
+		  nthreads = thread_map__nr(evlist->threads);
+
+	evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__apply_drv_configs(evsel, ncpus,
+						    nthreads, err_term);
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
index d9b80ef881cd..69984a2ea162 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1062,6 +1062,30 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
+				  int ncpus, int nthreads,
+				  struct perf_evsel_config_term **err_term)
+{
+	int err = 0;
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		err = perf_evsel__run_ioctl(evsel, ncpus, nthreads,
+					    PERF_EVENT_IOC_SET_DRV_CONFIGS,
+					    (void *)term->val.drv_cfg);
+
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
index 323806082c58..73cff3b2c533 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -239,6 +239,9 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
 			      const char *op, const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
 			     const char *filter);
+int perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
+				  int ncpus, int nthreads,
+				  struct perf_evsel_config_term **err_term);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4
