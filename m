From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 29 Jan 2016 18:17:43 -0300
Subject: [PATCH 06/16] perf auxtrace: Add perf_evlist pointer to
 *info_priv_size()
In-Reply-To: <1454102273-16431-1-git-send-email-acme@kernel.org>
References: <1454102273-16431-1-git-send-email-acme@kernel.org>
Message-ID: <1454102273-16431-7-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See http://www.infradead.org/rpr.html

From: Mathieu Poirier <mathieu.poirier@linaro.org>

On some architecture the size of the private header may be dependent on
the number of tracers used in the session.  As such adding a "struct
perf_evlist *" parameter, which should contain all the required
information.

Also adjusting the existing client of the interface to take the new
parameter into account.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-doc at vger.kernel.org
Cc: Mike Leach <mike.leach@arm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Tor Jeremiassen <tor@ti.com>
Link: http://lkml.kernel.org/r/1452807977-8069-22-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 4 +++-
 tools/perf/arch/x86/util/intel-pt.c  | 4 +++-
 tools/perf/util/auxtrace.c           | 7 ++++---
 tools/perf/util/auxtrace.h           | 6 ++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 8d8150f1cf9b..d66f9ad4df2e 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -60,7 +60,9 @@ struct branch {
 	u64 misc;
 };
 
-static size_t intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused)
+static size_t
+intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			 struct perf_evlist *evlist __maybe_unused)
 {
 	return INTEL_BTS_AUXTRACE_PRIV_SIZE;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index f05daacc9e78..6f7d453b0e32 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -273,7 +273,9 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 	return attr;
 }
 
-static size_t intel_pt_info_priv_size(struct auxtrace_record *itr __maybe_unused)
+static size_t
+intel_pt_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			struct perf_evlist *evlist __maybe_unused)
 {
 	return INTEL_PT_AUXTRACE_PRIV_SIZE;
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 360fda01f3b0..ec164fe70718 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -478,10 +478,11 @@ void auxtrace_heap__pop(struct auxtrace_heap *heap)
 			 heap_array[last].ordinal);
 }
 
-size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr)
+size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
+				       struct perf_evlist *evlist)
 {
 	if (itr)
-		return itr->info_priv_size(itr);
+		return itr->info_priv_size(itr, evlist);
 	return 0;
 }
 
@@ -852,7 +853,7 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 	int err;
 
 	pr_debug2("Synthesizing auxtrace information\n");
-	priv_size = auxtrace_record__info_priv_size(itr);
+	priv_size = auxtrace_record__info_priv_size(itr, session->evlist);
 	ev = zalloc(sizeof(struct auxtrace_info_event) + priv_size);
 	if (!ev)
 		return -ENOMEM;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b86f90db1352..e5a8e2d4f2af 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -293,7 +293,8 @@ struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
 				 struct perf_evlist *evlist,
 				 struct record_opts *opts);
-	size_t (*info_priv_size)(struct auxtrace_record *itr);
+	size_t (*info_priv_size)(struct auxtrace_record *itr,
+				 struct perf_evlist *evlist);
 	int (*info_fill)(struct auxtrace_record *itr,
 			 struct perf_session *session,
 			 struct auxtrace_info_event *auxtrace_info,
@@ -429,7 +430,8 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct perf_evlist *evlist,
 			     struct record_opts *opts);
-size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr);
+size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
+				       struct perf_evlist *evlist);
 int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
 			       struct auxtrace_info_event *auxtrace_info,
-- 
2.5.0
