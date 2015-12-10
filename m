From: james.morse@arm.com (James Morse)
Date: Thu, 10 Dec 2015 10:22:38 +0000
Subject: [PATCH v8 5/4] arm64: Fix off-by-one in stack tracing when stepping
 off irq stack
In-Reply-To: <1449226948-14251-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
Message-ID: <1449742961-11432-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jungseok Lee <jungseoklee85@gmail.com>

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
I believe Will already has this patch, its included here for completeness.

 arch/arm64/include/asm/irq.h | 2 +-
 arch/arm64/kernel/entry.S    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 6fd25ab534ca..cdc2916a00f0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -27,7 +27,7 @@ DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
  * The offset from irq_stack_ptr where entry.S will store the original
  * stack pointer. Used by unwind_frame() and dump_backtrace().
  */
-#define IRQ_STACK_TO_TASK_STACK(ptr) *((unsigned long *)(ptr - 0x10));
+#define IRQ_STACK_TO_TASK_STACK(ptr) *((unsigned long *)(ptr - 0x20));
 
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2963050e5e9e..76e803118f57 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -199,7 +199,7 @@ alternative_endif
 	/* Add a dummy stack frame */
 	stp     x29, \dummy_lr, [sp, #-16]!           // dummy stack frame
 	mov	x29, sp
-	stp     xzr, x19, [sp, #-16]!
+	stp     x19, xzr, [sp, #-16]!
 
 9998:
 	.endm
-- 
2.6.2
