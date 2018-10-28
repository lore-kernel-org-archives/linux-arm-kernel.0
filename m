From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 28 Oct 2018 20:34:55 +0800
Subject: [PATCH v1 4/4] perf cs-etm: Add support sample flags
In-Reply-To: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
References: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1540730095-6732-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have prepared the flags in the packet structure, so need to copy
the related value into sample structure thus perf tool can facilitate
sample flags.

The PREV_PACKET contains the branch instruction flags and PACKET
actually contains the flags for next branch instruction.  So this patch
is to set sample flags with 'etmq->prev_packet->flags'.

This patch includes two fixing up: if there has TRACE_ON packet in the
middle of instruction packets, the TRACE_ON packet indicates the trace
is discontinuous, so append the flag PERF_IP_FLAG_TRACE_END to the
previous packet; if the coming packet is exception packet or exception
return packet, also update the previous packet for exception specific
flags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 00a95d7..7e36dcf 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -655,7 +655,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.insn_len = 1;
 	sample.cpumode = event->header.misc;
 
@@ -711,7 +711,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.cpumode = PERF_RECORD_MISC_USER;
 
 	/*
@@ -945,9 +945,13 @@ static int cs_etm__exception(struct cs_etm_queue *etmq)
 	 * The exception packet includes the dummy address values, so don't
 	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
 	 * for generating instruction and branch samples.
+	 *
+	 * Also update flags so can tell perf it is exception related.
 	 */
-	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		etmq->prev_packet->last_instr_taken_branch = true;
+		etmq->prev_packet->flags = etmq->packet->flags;
+	}
 
 	return 0;
 }
@@ -965,6 +969,14 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
 		goto swap_packet;
 
+	/*
+	 * The start tracing packet is in the middle of instruction range
+	 * packets, this means the trace is discontinuous; so need to set
+	 * the previous packet flag to PERF_IP_FLAG_TRACE_END.
+	 */
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+		etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
+
 	if (etmq->etm->synth_opts.last_branch &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		/*
-- 
2.7.4
