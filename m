From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 9 Feb 2011 09:26:07 +0530
Subject: [PATCHv2] ARM: perf/oprofile: fix off-by-one in stack check
In-Reply-To: <001401cbc7a8$f5dee5d0$e19cb170$@deacon@arm.com>
References: <001401cbc7a8$f5dee5d0$e19cb170$@deacon@arm.com>
Message-ID: <1297223767-12827-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since tail is the previous fp - 1, we need to compare the new fp with tail + 1
to ensure that we don't end up passing in the same tail again, in order to
avoid a potential infinite loop in the perf interrupt handler (which has been
observed to occur).  A similar fix seems to be needed in the OProfile code.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
v2: refined check as per Will's comment

 arch/arm/kernel/perf_event.c |    2 +-
 arch/arm/oprofile/common.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5efa264..d150ad1 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -700,7 +700,7 @@ user_backtrace(struct frame_tail __user *tail,
 	 * Frame pointers should strictly progress back up the stack
 	 * (towards higher addresses).
 	 */
-	if (tail >= buftail.fp)
+	if (tail + 1 >= buftail.fp)
 		return NULL;
 
 	return buftail.fp - 1;
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 8aa9744..6adda2b 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -85,7 +85,7 @@ static struct frame_tail* user_backtrace(struct frame_tail *tail)
 
 	/* frame pointers should strictly progress back up the stack
 	 * (towards higher addresses) */
-	if (tail >= buftail[0].fp)
+	if (tail + 1 >= buftail[0].fp)
 		return NULL;
 
 	return buftail[0].fp-1;
-- 
1.7.2.dirty
