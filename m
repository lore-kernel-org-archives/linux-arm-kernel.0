From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 8 Feb 2011 09:46:41 +0530
Subject: [PATCH] ARM: perf/oprofile: fix off-by-one in stack check
Message-ID: <1297138601-29895-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it's fp - 1 that gets passed back in as tail in the next iteration, we
need to ensure that fp - 1 is not the same as tail in order to avoid a
potential infinite loop in the perf interrupt handler (which has been observed
to occur).  A similar fix seems to be needed in the OProfile code.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---

Do we need to  explicitly check for overflow (buftail.fp - 1 > buftail.fp)
also?  Though this should be already caught by the access check in the next
iteration of the loop.

 arch/arm/kernel/perf_event.c |    2 +-
 arch/arm/oprofile/common.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5efa264..dc885f0 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -700,7 +700,7 @@ user_backtrace(struct frame_tail __user *tail,
 	 * Frame pointers should strictly progress back up the stack
 	 * (towards higher addresses).
 	 */
-	if (tail >= buftail.fp)
+	if (tail >= buftail.fp - 1)
 		return NULL;
 
 	return buftail.fp - 1;
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 8aa9744..67b6b87 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -85,7 +85,7 @@ static struct frame_tail* user_backtrace(struct frame_tail *tail)
 
 	/* frame pointers should strictly progress back up the stack
 	 * (towards higher addresses) */
-	if (tail >= buftail[0].fp)
+	if (tail >= buftail[0].fp - 1)
 		return NULL;
 
 	return buftail[0].fp-1;
-- 
1.7.2.dirty
