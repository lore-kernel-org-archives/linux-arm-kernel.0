From: james.morse@arm.com (James Morse)
Date: Thu, 10 Dec 2015 10:22:40 +0000
Subject: [PATCH v8 7/4] arm64: when walking onto the task stack,
 check sp & fp are in current->stack
In-Reply-To: <1449742961-11432-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449742961-11432-1-git-send-email-james.morse@arm.com>
Message-ID: <1449742961-11432-3-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When unwind_frame() reaches the bottom of the irq_stack, the last fp
points to the original task stack. unwind_frame() uses
IRQ_STACK_TO_TASK_STACK() to find the sp value. If either values is
wrong, we may end up walking a corrupt stack.

Check these values are sane by testing if they are both on the stack
pointed to by current->stack.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/stacktrace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index b947eeffa5b2..d916d5b6aef6 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -71,9 +71,17 @@ int notrace unwind_frame(struct stackframe *frame)
 	 * to task stack.
 	 * If we reach the end of the stack - and its an interrupt stack,
 	 * read the original task stack pointer from the dummy frame.
+	 *
+	 * Check the frame->fp we read from the bottom of the irq_stack,
+	 * and the original task stack pointer are both in current->stack.
 	 */
-	if (frame->sp == irq_stack_ptr)
-		frame->sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+	if (frame->sp == irq_stack_ptr) {
+		unsigned long orig_sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+
+		if(object_is_on_stack((void *)orig_sp) &&
+		   object_is_on_stack((void *)frame->fp))
+			frame->sp = orig_sp;
+	}
 
 	return 0;
 }
-- 
2.6.2
