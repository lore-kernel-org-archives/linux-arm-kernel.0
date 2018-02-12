From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 12 Feb 2018 13:32:35 -0700
Subject: [PATCH 1/3] perf tools: Freeing allocated memory
In-Reply-To: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1518467557-18505-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch frees all the memory allocated in function
cs_etm__alloc_queue().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b9f0a53dfa65..f2c98774e665 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -174,6 +174,12 @@ static void cs_etm__free_queue(void *priv)
 {
 	struct cs_etm_queue *etmq = priv;
 
+	if (!etmq)
+		return;
+
+	thread__zput(etmq->thread);
+	cs_etm_decoder__free(etmq->decoder);
+	zfree(&etmq->event_buf);
 	free(etmq);
 }
 
-- 
2.7.4
