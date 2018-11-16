From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Nov 2018 11:42:32 -0700
Subject: [PATCH 3/3] perf tools: Add support for PTMv1.1 decoding
In-Reply-To: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
References: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1542393752-10196-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is re-using the mechanic set forth by ETMv3 to add support
for PTM decoding.  Configuration for both encoding protocol is similar
but the generated stream itself is very different, hence requiring
special handling.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 23 +++++++++++++++++++++--
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 84a86d2f25c9..de8d792bc49d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -256,8 +256,11 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
@@ -424,8 +427,11 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index c0c67c919093..029e66b968a6 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -86,6 +86,7 @@ enum {
 	CS_ETM_PROTO_ETMV3 = 1,
 	CS_ETM_PROTO_ETMV4i,
 	CS_ETM_PROTO_ETMV4d,
+	CS_ETM_PROTO_PTM,
 };
 
 enum {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 830e9136ad7c..2f1a176d55e8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -91,6 +91,19 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid, u64 time_);
 
+/* PTMs ETMIDR [11:8] set to b0011 */
+#define ETMIDR_PTM_VERSION 0x00000300
+
+static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
+{
+	etmidr &= ETMIDR_PTM_VERSION;
+
+	if (etmidr == ETMIDR_PTM_VERSION)
+		return CS_ETM_PROTO_PTM;
+
+	return CS_ETM_PROTO_ETMV3;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -123,7 +136,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
@@ -374,7 +390,10 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
-- 
2.7.4
