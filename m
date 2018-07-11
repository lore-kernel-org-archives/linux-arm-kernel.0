From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 11 Jul 2018 15:45:44 +0800
Subject: [PATCH v2 5/6] perf cs-etm: Generate branch sample when receiving a
 CS_ETM_TRACE_ON packet
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1531295145-596-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If one CS_ETM_TRACE_ON packet is inserted, we miss to generate branch
sample for the previous CS_ETM_RANGE packet.

This patch is to generate branch sample when receiving a CS_ETM_TRACE_ON
packet, so this can save complete info for the previous CS_ETM_RANGE
packet just before CS_ETM_TRACE_ON packet.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 976db84..d3b7942 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -935,6 +935,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
 	if (!etmq->prev_packet)
@@ -965,6 +966,13 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 	}
 
+	if (etm->sample_branches &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		err = cs_etm__synth_branch_sample(etmq);
+		if (err)
+			return err;
+	}
+
 swap_packet:
 	if (etmq->etm->synth_opts.last_branch) {
 		/*
-- 
2.7.4
