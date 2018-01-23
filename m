From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 23 Jan 2018 10:12:41 -0300
Subject: [PATCH 33/43] perf tools: Add functionality to communicate with the
 openCSD decoder
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Message-ID: <20180123131251.28197-34-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch adds functions to communicate with the openCSD trace decoder,
more specifically to access program memory, fetch trace packets and
reset the decoder.

Co-authored-by: Tor Jeremiassen <tor@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1516211539-5166-7-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 60 +++++++++++++++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  9 ++++
 2 files changed, 69 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 57b020b0b36f..1fb01849f1c7 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -45,6 +45,66 @@ struct cs_etm_decoder {
 	struct cs_etm_packet packet_buffer[MAX_BUFFER];
 };
 
+static u32
+cs_etm_decoder__mem_access(const void *context,
+			   const ocsd_vaddr_t address,
+			   const ocsd_mem_space_acc_t mem_space __maybe_unused,
+			   const u32 req_size,
+			   u8 *buffer)
+{
+	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
+
+	return decoder->mem_access(decoder->data,
+				   address,
+				   req_size,
+				   buffer);
+}
+
+int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
+				      u64 start, u64 end,
+				      cs_etm_mem_cb_type cb_func)
+{
+	decoder->mem_access = cb_func;
+
+	if (ocsd_dt_add_callback_mem_acc(decoder->dcd_tree, start, end,
+					 OCSD_MEM_SPACE_ANY,
+					 cs_etm_decoder__mem_access, decoder))
+		return -1;
+
+	return 0;
+}
+
+int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
+{
+	ocsd_datapath_resp_t dp_ret;
+
+	dp_ret = ocsd_dt_process_data(decoder->dcd_tree, OCSD_OP_RESET,
+				      0, 0, NULL, NULL);
+	if (OCSD_DATA_RESP_IS_FATAL(dp_ret))
+		return -1;
+
+	return 0;
+}
+
+int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
+			       struct cs_etm_packet *packet)
+{
+	if (!decoder || !packet)
+		return -EINVAL;
+
+	/* Nothing to do, might as well just return */
+	if (decoder->packet_count == 0)
+		return 0;
+
+	*packet = decoder->packet_buffer[decoder->head];
+
+	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
+
+	decoder->packet_count--;
+
+	return 1;
+}
+
 static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 					     ocsd_etmv4_cfg *config)
 {
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a1e9b0ac5965..3d2e6205d186 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -93,4 +93,13 @@ cs_etm_decoder__new(int num_cpu,
 
 void cs_etm_decoder__free(struct cs_etm_decoder *decoder);
 
+int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
+				      u64 start, u64 end,
+				      cs_etm_mem_cb_type cb_func);
+
+int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
+			       struct cs_etm_packet *packet);
+
+int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
+
 #endif /* INCLUDE__CS_ETM_DECODER_H__ */
-- 
2.14.3
