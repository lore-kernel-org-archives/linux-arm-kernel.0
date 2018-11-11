From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 11 Nov 2018 12:59:39 +0800
Subject: [PATCH v1 1/5] perf cs-etm: Correct packets swapping in
 cs_etm__flush()
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1541912383-19915-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not
swap packets if without option '--itrace=il' to generate last branch
entries; thus for this case the 'prev_packet' doesn't point to the
correct previous packet and the stale packet still will be used to
generate sequential sample.  Thus if dump trace with 'perf script'
command we can see the incorrect flow with the stale packet's address
info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so
can save correct content to 'prev_packet'.  Finally this can fix the
wrong program flow dumping issue.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 48ad217..fe18d7b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -997,7 +997,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etmq->etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.7.4
