From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Jul 2016 14:38:18 -0600
Subject: [PATCH V2 4/6] perf tools: pushing driver configuration down to the
 kernel
In-Reply-To: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1469047100-18131-5-git-send-email-mathieu.poirier@linaro.org>
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
index 8f2c16d9275f..dffea1033b8e 100644
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
+			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
+			strerror_r(errno, msg, sizeof(msg)));
+		rc = -1;
+		goto out;
+	}
+
 	rc = record__mmap(rec);
 	if (rc)
 		goto out;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2a40b8e1def7..0f485cebae18 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1433,6 +1433,30 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
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
index b16f1621ce3e..e5b30d02a5dd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1035,6 +1035,27 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
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
@@ -1100,6 +1121,16 @@ static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
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
@@ -1121,6 +1152,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
+	perf_evsel__free_drv_config_terms(evsel);
 	close_cgroup(evsel->cgrp);
 	cpu_map__put(evsel->cpus);
 	cpu_map__put(evsel->own_cpus);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e25fd5e4c740..305b2e11992a 100644
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
