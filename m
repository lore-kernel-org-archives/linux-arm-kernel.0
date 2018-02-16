From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 16 Feb 2018 16:17:25 -0300
Subject: [PATCH 20/41] perf cs-etm: Freeing allocated memory
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Message-ID: <20180216191746.11095-21-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch frees all the memory allocated in function
cs_etm__alloc_queue().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1518467557-18505-2-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
