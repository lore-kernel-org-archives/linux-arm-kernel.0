From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 23 May 2014 10:34:55 +0200
Subject: [PATCH v2] mm, compaction: properly signal and act upon lock
 and need_sched() contention
In-Reply-To: <CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>
References: <1399904111-23520-1-git-send-email-vbabka@suse.cz>	<1400233673-11477-1-git-send-email-vbabka@suse.cz>	<CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>
 <CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>
Message-ID: <537F082F.50501@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2014 04:48 AM, Shawn Guo wrote:
> On 23 May 2014 07:49, Kevin Hilman <khilman@linaro.org> wrote:
>> On Fri, May 16, 2014 at 2:47 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
>>> Compaction uses compact_checklock_irqsave() function to periodically check for
>>> lock contention and need_resched() to either abort async compaction, or to
>>> free the lock, schedule and retake the lock. When aborting, cc->contended is
>>> set to signal the contended state to the caller. Two problems have been
>>> identified in this mechanism.
>>
>> This patch (or later version) has hit next-20140522 (in the form
>> commit 645ceea9331bfd851bc21eea456dda27862a10f4) and according to my
>> bisect, appears to be the culprit of several boot failures on ARM
>> platforms.
> 
> On i.MX6 where CMA is enabled, the commit causes the drivers calling
> dma_alloc_coherent() fail to probe.  Tracing it a little bit, it seems
> dma_alloc_from_contiguous() always return page as NULL after this
> commit.
> 
> Shawn
> 

Really sorry, guys :/

-----8<-----
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 May 2014 10:18:56 +0200
Subject: mm-compaction-properly-signal-and-act-upon-lock-and-need_sched-contention-fix2

Step 1: Change function name and comment between v1 and v2 so that the return
        value signals the opposite thing.
Step 2: Change the call sites to reflect the opposite return value.
Step 3: ???
Step 4: Make a complete fool of yourself.

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
-- 
1.8.4.5
