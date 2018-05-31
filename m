From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 31 May 2018 07:32:17 -0300
Subject: [PATCH 4/7] perf cs-etm: Fix indexing for decoder packet queue
In-Reply-To: <20180531103220.24684-1-acme@kernel.org>
References: <20180531103220.24684-1-acme@kernel.org>
Message-ID: <20180531103220.24684-5-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The tail of a queue is supposed to be pointing to the next available
slot in a queue.  In this implementation the tail is incremented before
it is used and as such points to the last used element, something that
has the immense advantage of centralizing tail management at a single
location and eliminating a lot of redundant code.

But this needs to be taken into consideration on the dequeueing side
where the head also needs to be incremented before it is used, or the
first available element of the queue will be skipped.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1527289854-10755-1-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index c8b98fa22997..4d5fc374e730 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -96,11 +96,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
 	/* Nothing to do, might as well just return */
 	if (decoder->packet_count == 0)
 		return 0;
+	/*
+	 * The queueing process in function cs_etm_decoder__buffer_packet()
+	 * increments the tail *before* using it.  This is somewhat counter
+	 * intuitive but it has the advantage of centralizing tail management
+	 * at a single location.  Because of that we need to follow the same
+	 * heuristic with the head, i.e we increment it before using its
+	 * value.  Otherwise the first element of the packet queue is not
+	 * used.
+	 */
+	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
 
 	*packet = decoder->packet_buffer[decoder->head];
 
-	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
-
 	decoder->packet_count--;
 
 	return 1;
-- 
2.14.3
