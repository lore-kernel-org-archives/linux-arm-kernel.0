From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Nov 2018 11:42:30 -0700
Subject: [PATCH 1/3] perf tools: Add configuration for ETMv3 trace protocol
In-Reply-To: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
References: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1542393752-10196-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch deals with the proper initialisation of configuration parameters
for the ETMv3 trace protocol in order to properly handle packets generated
by tracers following this specification.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  8 ++++
 tools/perf/util/cs-etm.c                        | 54 ++++++++++++++++++-------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 612b5755f742..c0c67c919093 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -43,6 +43,13 @@ struct cs_etm_queue;
 typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u64,
 				  size_t, u8 *);
 
+struct cs_etmv3_trace_params {
+	u32 reg_ctrl;
+	u32 reg_trc_id;
+	u32 reg_ccer;
+	u32 reg_idr;
+};
+
 struct cs_etmv4_trace_params {
 	u32 reg_idr0;
 	u32 reg_idr1;
@@ -55,6 +62,7 @@ struct cs_etmv4_trace_params {
 struct cs_etm_trace_params {
 	int protocol;
 	union {
+		struct cs_etmv3_trace_params etmv3;
 		struct cs_etmv4_trace_params etmv4;
 	};
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 73430b73570d..830e9136ad7c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -122,15 +122,28 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+						      __perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
@@ -360,15 +373,28 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free;
 
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+							__perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-- 
2.7.4
