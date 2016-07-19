From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Jul 2016 16:53:54 -0600
Subject: [PATCH 4/6] perf tools: pushing driver configuration down to the
 kernel
In-Reply-To: <1468968836-12695-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468968836-12695-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468968836-12695-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that PMU specific driver configuration are queued in
evsel::drv_config_terms, all we need to do is re-use the current
ioctl() mechanism to push down the information to the kernel
driver.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/builtin-record.c |  9 +++++++++
 tools/perf/util/evlist.c    | 24 ++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  3 +++
 tools/perf/util/evsel.c     | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h     |  3 +++
 5 files changed, 71 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dc3fcb597e4c..5d2e45e189f0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -348,6 +348,7 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
+	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	perf_evlist__config(evlist, opts, &callchain_param);
@@ -377,6 +378,14 @@ try_again:
 		goto out;
 	}
 
+	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
+		error("failed to set config \"%s\" on event %s with %d (%s)\n",
+			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
+			strerror_r(errno, msg, sizeof(msg)));
+		rc = -1;
+		goto out;
+	}
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages, false,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode) < 0) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e82ba90cc969..084086fc0d6f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1345,6 +1345,30 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
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
+	evlist__for_each(evlist, evsel) {
+		if (list_empty(&evsel->drv_config_terms))
+			continue;
+
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
index d740fb877ab6..b64c501298d9 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -189,6 +189,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist, struct cpu_map *cpus,
 			   struct thread_map *threads);
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target);
 int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **err_evsel);
+int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
+				   struct perf_evsel **err_evsel,
+				   struct perf_evsel_config_term **term);
 
 void __perf_evlist__set_leader(struct list_head *list);
 void perf_evlist__set_leader(struct perf_evlist *evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7f97bae594ff..447c5525e411 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1002,6 +1002,27 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
+				  int ncpus, int nthreads,
+				  struct perf_evsel_config_term **err_term)
+{
+	int err = 0;
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, &evsel->drv_config_terms, list) {
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
@@ -1067,6 +1088,16 @@ static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
 	}
 }
 
+static void perf_evsel__free_drv_config_terms(struct perf_evsel *evsel)
+{
+	struct perf_evsel_config_term *term, *h;
+
+	list_for_each_entry_safe(term, h, &evsel->drv_config_terms, list) {
+		list_del(&term->list);
+		free(term);
+	}
+}
+
 void perf_evsel__close_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 {
 	int cpu, thread;
@@ -1088,6 +1119,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
+	perf_evsel__free_drv_config_terms(evsel);
 	close_cgroup(evsel->cgrp);
 	cpu_map__put(evsel->cpus);
 	cpu_map__put(evsel->own_cpus);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0441be00a366..89ab1d8476be 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -236,6 +236,9 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
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
