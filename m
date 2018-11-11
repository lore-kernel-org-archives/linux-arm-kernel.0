From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 11 Nov 2018 12:59:42 +0800
Subject: [PATCH v1 4/5] perf cs-etm: Generate branch sample for exception
 packet
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1541912383-19915-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exception packet appears as one element with 'elem_type' ==
OCSD_GEN_TRC_ELEM_EXCEPTION or OCSD_GEN_TRC_ELEM_EXCEPTION_RET,
which present for exception entry and exit respectively.  The decoder
set packet fields 'packet->exc' and 'packet->exc_ret' to indicate the
exception packets; but exception packets don't have dedicated sample
type and shares the same sample type CS_ETM_RANGE with normal
instruction packets.

As result, the exception packets are taken as normal instruction packets
and this introduces confusion to mix different packet types.
Furthermore, these instruction range packets will be processed for
branch sample only when 'packet->last_instr_taken_branch' is true,
otherwise they will be omitted, this can introduce mess for exception
and exception returning due we don't have complete address range info
for context switching.

To process exception packets properly, this patch introduce two new
sample type: CS_ETM_EXCEPTION and CS_ETM_EXCEPTION_RET; for these two
kind packets, they will be handled by cs_etm__exception().  The func
cs_etm__exception() forces to set previous CS_ETM_RANGE packet flag
'prev_packet->last_instr_taken_branch' to true, this matches well with
the program flow when the exception is trapped from user space to kernel
space, no matter if the most recent flow has branch taken or not; this
is also safe for returning to user space after exception handling.

After exception packets have their own sample type, the packet fields
'packet->exc' and 'packet->exc_ret' aren't needed anymore, so remove
them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 26 +++++++++++++++++------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 ++--
 tools/perf/util/cs-etm.c                        | 28 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 9d52727..b8cb7a3e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -269,8 +269,6 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].last_instr_size = 0;
-		decoder->packet_buffer[i].exc = false;
-		decoder->packet_buffer[i].exc_ret = false;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -298,8 +296,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 
 	decoder->packet_buffer[et].sample_type = sample_type;
 	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].exc = false;
-	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
@@ -384,6 +380,22 @@ cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
 					     CS_ETM_TRACE_ON);
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_EXCEPTION);
+}
+
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_decoder *decoder,
+				     const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_EXCEPTION_RET);
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -411,10 +423,12 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		decoder->packet_buffer[decoder->tail].exc = true;
+		resp = cs_etm_decoder__buffer_exception(decoder,
+							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		decoder->packet_buffer[decoder->tail].exc_ret = true;
+		resp = cs_etm_decoder__buffer_exception_ret(decoder,
+							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
 	case OCSD_GEN_TRC_ELEM_EO_TRACE:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a38c97c..0d1c18d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -27,6 +27,8 @@ enum cs_etm_sample_type {
 	CS_ETM_RANGE		= 1 << 0,
 	CS_ETM_TRACE_ON		= 1 << 1,
 	CS_ETM_TRACE_OFF	= 1 << 2,
+	CS_ETM_EXCEPTION	= 1 << 3,
+	CS_ETM_EXCEPTION_RET	= 1 << 4,
 };
 
 enum cs_etm_isa {
@@ -44,8 +46,6 @@ struct cs_etm_packet {
 	u32 instr_count;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-	u8 exc;
-	u8 exc_ret;
 	int cpu;
 };
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2a0cef9..455f132 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -961,6 +961,25 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__exception(struct cs_etm_queue *etmq)
+{
+	/*
+	 * When the exception packet is inserted, whether the last instruction
+	 * in previous range packet is taken branch or not, we need to force
+	 * to set 'prev_packet->last_instr_taken_branch' to true.  This ensures
+	 * to generate branch sample for the instruction range before the
+	 * exception is trapped to kernel or before the exception returning.
+	 *
+	 * The exception packet includes the dummy address values, so don't
+	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
+	 * for generating instruction and branch samples.
+	 */
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+		etmq->prev_packet->last_instr_taken_branch = true;
+
+	return 0;
+}
+
 static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
 {
 	int err = 0;
@@ -1090,6 +1109,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__sample(etmq);
 					break;
+				case CS_ETM_EXCEPTION:
+				case CS_ETM_EXCEPTION_RET:
+					/*
+					 * If the exception packet is coming,
+					 * make sure the previous instruction
+					 * range packet to be handled properly.
+					 */
+					cs_etm__exception(etmq);
+					break;
 				case CS_ETM_TRACE_ON:
 				case CS_ETM_TRACE_OFF:
 					/*
-- 
2.7.4
