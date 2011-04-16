From: sonnyrao@chromium.org (Sonny Rao)
Date: Fri, 15 Apr 2011 20:27:25 -0700
Subject: [PATCH] Fix infinite loop in ARM user perf_event backtrace code
Message-ID: <1302924445-18557-1-git-send-email-sonnyrao@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM user backtrace code can get into an infinite loop if it
runs into an invalid stack frame which points back to itself.
This situation has been observed in practice.  Fix it by capping
the number of entries in the backtrace.  This is also what other
architectures do in their backtrace code.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 arch/arm/kernel/perf_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 69cfee0..1e61d60 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -746,7 +746,8 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 
 	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
 
-	while (tail && !((unsigned long)tail & 0x3))
+	while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
+	       tail && !((unsigned long)tail & 0x3))
 		tail = user_backtrace(tail, entry);
 }
 
-- 
1.7.3.1
