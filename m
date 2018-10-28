From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 28 Oct 2018 20:34:53 +0800
Subject: [PATCH v1 2/4] perf cs-etm: Track exception number
In-Reply-To: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
References: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1540730095-6732-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an exception packet comes, it contains the info for exception
number; the exception number indicates the exception types, so from it
we can know if the exception is taken for interrupt, system call or
other traps, etc.  But because the exception return packet cannot
delivery exception number correctly by decoder thus when prepare sample
flags we cannot know what's type for exception return.

This patch adds a new 'exc_num' array in decoder structure to record
exception number per CPU, the exception number is recorded in the array
when the exception packet comes and this exception number can be used by
exception return packet.  If detect there have discontinuous trace with
TRACE_ON packet, the exception number is set to invalid value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 51 ++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0f29534..efc4332 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -43,6 +43,7 @@ struct cs_etm_decoder {
 	u32 packet_count;
 	u32 head;
 	u32 tail;
+	u32 *exc_num;
 	struct cs_etm_packet packet_buffer[MAX_BUFFER];
 };
 
@@ -368,16 +369,44 @@ static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
 				const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_TRACE_ON);
+	int ret;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_TRACE_ON);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	/* Clear execption number for discontinuous trace */
+	decoder->exc_num[packet->cpu] = UINT32_MAX;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+	int ret;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	/*
+	 * Exception number is recorded per CPU and later can be used
+	 * for exception return instruction analysis.
+	 */
+	decoder->exc_num[packet->cpu] = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -413,7 +442,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
@@ -501,6 +530,10 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	if (!decoder)
 		return NULL;
 
+	decoder->exc_num = zalloc(sizeof(*decoder->exc_num) * num_cpu);
+	if (!decoder->exc_num)
+		goto err_free_decoder;
+
 	decoder->data = d_params->data;
 	decoder->prev_return = OCSD_RESP_CONT;
 	cs_etm_decoder__clear_buffer(decoder);
@@ -521,7 +554,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	decoder->dcd_tree = ocsd_create_dcd_tree(format, flags);
 
 	if (decoder->dcd_tree == 0)
-		goto err_free_decoder;
+		goto err_free_decoder_exc_num;
 
 	/* init library print logging support */
 	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
@@ -532,6 +565,9 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
 
 	for (i = 0; i < num_cpu; i++) {
+		/* init expcetion number to an invalid value */
+		decoder->exc_num[i] = UINT32_MAX;
+
 		ret = cs_etm_decoder__create_etm_decoder(d_params,
 							 &t_params[i],
 							 decoder);
@@ -543,6 +579,8 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 
 err_free_decoder_tree:
 	ocsd_destroy_dcd_tree(decoder->dcd_tree);
+err_free_decoder_exc_num:
+	free(decoder->exc_num);
 err_free_decoder:
 	free(decoder);
 	return NULL;
@@ -603,5 +641,6 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
 
 	ocsd_destroy_dcd_tree(decoder->dcd_tree);
 	decoder->dcd_tree = NULL;
+	free(decoder->exc_num);
 	free(decoder);
 }
-- 
2.7.4
