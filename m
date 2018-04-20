From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 20 Apr 2018 11:46:17 +0100
Subject: [RFC PATCH 1/3] arm64: stacktrace: Constify stacktrace.h functions
In-Reply-To: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
References: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1524221179-19473-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on_accessible_stack() and on_task_stack() shouldn't (and don't)
modify their task argument, so it can be const.

This patch adds the appropriate modifiers.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/stacktrace.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 902f9ed..63c0379 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -50,7 +50,8 @@ static inline bool on_irq_stack(unsigned long sp)
 	return (low <= sp && sp < high);
 }
 
-static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp)
+static inline bool on_task_stack(struct task_struct const *tsk,
+				 unsigned long sp)
 {
 	unsigned long low = (unsigned long)task_stack_page(tsk);
 	unsigned long high = low + THREAD_SIZE;
@@ -76,7 +77,8 @@ static inline bool on_overflow_stack(unsigned long sp) { return false; }
  * We can only safely access per-cpu stacks from current in a non-preemptible
  * context.
  */
-static inline bool on_accessible_stack(struct task_struct *tsk, unsigned long sp)
+static inline bool on_accessible_stack(struct task_struct const *tsk,
+				       unsigned long sp)
 {
 	if (on_task_stack(tsk, sp))
 		return true;
-- 
2.1.4
