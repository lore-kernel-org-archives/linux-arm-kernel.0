From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Apr 2011 12:21:34 +0100
Subject: [PATCH] ARM: perf: ensure pass through zero is counted on overflow
Message-ID: <1301656894-29637-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a737823d ("ARM: perf: ensure overflows aren't missed due to IRQ
latency") changed the way that event deltas are calculated on overflow
so that we don't miss events when the new count value overtakes the
previous one.

Unfortunately, we forget to count the event that passes through zero so
we end up being off by 1. This patch adds on the correction.

Reported-by: Chris Moore <moore@free.fr>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Actually, I don't think this is a new bug. Doing the subtraction as we
used to do also neglects to add on the additional event even when the
the new count is less than the previous one (mod 2^32).

 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 69cfee0..979da39 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -221,7 +221,7 @@ again:
 	prev_raw_count &= armpmu->max_period;
 
 	if (overflow)
-		delta = armpmu->max_period - prev_raw_count + new_raw_count;
+		delta = armpmu->max_period - prev_raw_count + new_raw_count + 1;
 	else
 		delta = new_raw_count - prev_raw_count;
 
-- 
1.7.0.4
