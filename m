From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 11 Nov 2018 12:59:41 +0800
Subject: [PATCH v1 3/5] perf cs-etm: Support for NO_SYNC packet
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1541912383-19915-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As described in OpenCSD (CoreSight decoder lib), in the decoding stream
it includes one trace element with type OCSD_GEN_TRC_ELEM_NO_SYNC; the
element indicates 'either at start of decode, or after overflow / bad
packet', we should take it as a signal for the tracing off and this will
cause tracing discontinuity.  From the trace dump with 'perf script',
sometimes the element OCSD_GEN_TRC_ELEM_NO_SYNC collaborates with
element OCSD_GEN_TRC_ELEM_TRACE_ON to show the tracing flow have been
turned off and on, in this case the cs-etm code has handled TRACE_ON
packet well so we observe the tracing discontinuity; but in another case
it only inserts the element OCSD_GEN_TRC_ELEM_NO_SYNC into instructions
packets, we miss to handle the case if has only standalone NO_SYNC
element and users cannot receive the info for tracing discontinuity.

This patch introduces new type CS_ETM_TRACE_OFF to generate packet for
receiving element OCSD_GEN_TRC_ELEM_NO_SYNC from decoder; when generate
sample, CS_ETM_TRACE_OFF packet has almost the same behaviour with
CS_ETM_TRACE_ON packet: both of them invokes cs_etm__flush() to generate
samples for the previous instructions packet, and in cs_etm__sample() it
also needs to generate samples if TRACE_OFF packet is followed by one
sequential instructions packet.  This patch also converts the address to
0 for TRACE_OFF packet, this is same with TRACE_ON packet as well.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ++++---
 tools/perf/util/cs-etm.c                        | 15 +++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 5efb616..9d52727 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -369,6 +369,14 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 }
 
 static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
+				 const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_TRACE_OFF);
+}
+
+static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
 				const uint8_t trace_chan_id)
 {
@@ -389,6 +397,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+		resp = cs_etm_decoder__buffer_trace_off(decoder,
+							trace_chan_id);
 		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 9351bd1..a38c97c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,10 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY		= 0,
+	CS_ETM_RANGE		= 1 << 0,
+	CS_ETM_TRACE_ON		= 1 << 1,
+	CS_ETM_TRACE_OFF	= 1 << 2,
 };
 
 enum cs_etm_isa {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f4fa877..2a0cef9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -517,8 +517,9 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for TRACE_ON and TRACE_OFF packets */
+	if (packet->sample_type == CS_ETM_TRACE_ON ||
+	    packet->sample_type == CS_ETM_TRACE_OFF)
 		return 0;
 
 	return packet->start_addr;
@@ -527,8 +528,9 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 static inline
 u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for TRACE_ON and TRACE_OFF packets */
+	if (packet->sample_type == CS_ETM_TRACE_ON ||
+	    packet->sample_type == CS_ETM_TRACE_OFF)
 		return 0;
 
 	return packet->end_addr - packet->last_instr_size;
@@ -930,6 +932,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
 			generate_sample = true;
 
+		/* Generate sample for tracing off packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF)
+			generate_sample = true;
+
 		/* Generate sample for branch taken packet */
 		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
 		    etmq->prev_packet->last_instr_taken_branch)
@@ -1085,6 +1091,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					cs_etm__sample(etmq);
 					break;
 				case CS_ETM_TRACE_ON:
+				case CS_ETM_TRACE_OFF:
 					/*
 					 * Discontinuity in trace, flush
 					 * previous branch stack
-- 
2.7.4
