From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 11 Jul 2018 15:45:40 +0800
Subject: [PATCH v2 1/6] perf cs-etm: Introduce invalid address macro
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1531295145-596-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces invalid address macro and uses it to replace dummy
value '0xdeadbeefdeadbeefUL'.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 4d5fc37..938def6 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -31,6 +31,8 @@
 #endif
 #endif
 
+#define CS_ETM_INVAL_ADDR	0xdeadbeefdeadbeefUL
+
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
@@ -261,8 +263,8 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 	decoder->tail = 0;
 	decoder->packet_count = 0;
 	for (i = 0; i < MAX_BUFFER; i++) {
-		decoder->packet_buffer[i].start_addr = 0xdeadbeefdeadbeefUL;
-		decoder->packet_buffer[i].end_addr = 0xdeadbeefdeadbeefUL;
+		decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
+		decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].exc = false;
 		decoder->packet_buffer[i].exc_ret = false;
@@ -295,8 +297,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].exc = false;
 	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
-	decoder->packet_buffer[et].start_addr = 0xdeadbeefdeadbeefUL;
-	decoder->packet_buffer[et].end_addr = 0xdeadbeefdeadbeefUL;
+	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
+	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
-- 
2.7.4
