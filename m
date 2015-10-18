From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:42 -0600
Subject: [PATCH V2 25/30] perf tools: adding perf_session to *info_prive_size()
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-26-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some architecture the size of the private header may
be dependent on the number of tracers used in the session.  As
such adding a "struct perf_session" parameter, which should
contain all the required information.

Also adjusting the existing client of the interface to take
the new parameter into account.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/x86/util/intel-bts.c | 4 +++-
 tools/perf/arch/x86/util/intel-pt.c  | 4 +++-
 tools/perf/util/auxtrace.c           | 7 ++++---
 tools/perf/util/auxtrace.h           | 6 ++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 9b94ce520917..6efdc5e86d97 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -60,7 +60,9 @@ struct branch {
 	u64 misc;
 };
 
-static size_t intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused)
+static size_t
+intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			 struct perf_session *session __maybe_unused)
 {
 	return INTEL_BTS_AUXTRACE_PRIV_SIZE;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 2ca10d796c0b..1fd9a16f668c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -273,7 +273,9 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 	return attr;
 }
 
-static size_t intel_pt_info_priv_size(struct auxtrace_record *itr __maybe_unused)
+static size_t
+intel_pt_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			struct perf_session *session __maybe_unused)
 {
 	return INTEL_PT_AUXTRACE_PRIV_SIZE;
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a980e7c50ee0..430df9575dbe 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -478,10 +478,11 @@ void auxtrace_heap__pop(struct auxtrace_heap *heap)
 			 heap_array[last].ordinal);
 }
 
-size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr)
+size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
+				       struct perf_session *session)
 {
 	if (itr)
-		return itr->info_priv_size(itr);
+		return itr->info_priv_size(itr, session);
 	return 0;
 }
 
@@ -852,7 +853,7 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 	int err;
 
 	pr_debug2("Synthesizing auxtrace information\n");
-	priv_size = auxtrace_record__info_priv_size(itr);
+	priv_size = auxtrace_record__info_priv_size(itr, session);
 	ev = zalloc(sizeof(struct auxtrace_info_event) + priv_size);
 	if (!ev)
 		return -ENOMEM;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index bf72b77a588a..d76177169484 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -289,7 +289,8 @@ struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
 				 struct perf_evlist *evlist,
 				 struct record_opts *opts);
-	size_t (*info_priv_size)(struct auxtrace_record *itr);
+	size_t (*info_priv_size)(struct auxtrace_record *itr,
+				 struct perf_session *session);
 	int (*info_fill)(struct auxtrace_record *itr,
 			 struct perf_session *session,
 			 struct auxtrace_info_event *auxtrace_info,
@@ -425,7 +426,8 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct perf_evlist *evlist,
 			     struct record_opts *opts);
-size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr);
+size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
+				       struct perf_session *session);
 int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
 			       struct auxtrace_info_event *auxtrace_info,
-- 
1.9.1
