From: vbabka@suse.cz (Vlastimil Babka)
Date: Mon, 02 Jun 2014 16:33:41 +0200
Subject: [PATCH -mm] mm, compaction: properly signal and act upon lock and
 need_sched() contention - fix
In-Reply-To: <CAOMZO5BKaicq7NkoJO4vU5W3hiDike6kSdH+2eD=h0B5BsDjTg@mail.gmail.com>
References: <1399904111-23520-1-git-send-email-vbabka@suse.cz>	<1400233673-11477-1-git-send-email-vbabka@suse.cz>	<CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>	<CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>	<537F082F.50501@suse.cz>
 <CAOMZO5BKaicq7NkoJO4vU5W3hiDike6kSdH+2eD=h0B5BsDjTg@mail.gmail.com>
Message-ID: <538C8B45.6070803@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compact_should_abort() returns true instead of false and vice versa
due to changes between v1 and v2 of the patch. This makes both async
and sync compaction abort with high probability, and has been reported
to cause e.g. soft lockups on some ARM boards, or drivers calling
dma_alloc_coherent() fail to probe with CMA enabled on different boards.

This patch fixes the return value to match comments and callers expecations.

Reported-and-tested-by: Kevin Hilman <khilman@linaro.org>
Reported-and-tested-by: Shawn Guo <shawn.guo@linaro.org>
Tested-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/compaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a525cd4..5175019 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -237,13 +237,13 @@ static inline bool compact_should_abort(struct compact_control *cc)
 	if (need_resched()) {
 		if (cc->mode == MIGRATE_ASYNC) {
 			cc->contended = true;
-			return false;
+			return true;
 		}
 
 		cond_resched();
 	}
 
-	return true;
+	return false;
 }
 
 /* Returns true if the page is within a block suitable for migration to */
-- 1.8.4.5 
