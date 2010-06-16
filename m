From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jun 2010 16:33:22 -0400
Subject: [PATCH 4/5] ARM: stack protector: change the canary value per task
In-Reply-To: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
Message-ID: <1276720403-27918-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new random value for the canary is stored in the task struct whenever
a new task is forked.  This is meant to allow for different canary values
per task.  On ARM, GCC expects the canary value to be found in a global
variable called __stack_chk_guard.  So this variable has to be updated
with the value stored in the task struct whenever a task switch occurs.

Because the variable GCC expects is global, this cannot work on SMP
unfortunately.  So, on SMP, the same initial canary value is kept
throughout, making this feature a bit less effective although it is still
useful.

One way to overcome this GCC limitation would be to locate the
__stack_chk_guard variable into a memory page of its own for each CPU,
and then use TLB locking to have each CPU see its own page at the same
virtual address for each of them.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/asm-offsets.c |    3 +++
 arch/arm/kernel/entry-armv.S  |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 8835115..85f2a01 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -40,6 +40,9 @@
 int main(void)
 {
   DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
+#ifdef CONFIG_CC_STACKPROTECTOR
+  DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
+#endif
   BLANK();
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7ee48e7..2d14081 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -745,6 +745,11 @@ ENTRY(__switch_to)
 	mov	r4, #0xffff0fff
 	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
 #endif
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	ldr	r7, [r2, #TI_TASK]
+	ldr	r8, =__stack_chk_guard
+	ldr	r7, [r7, #TSK_STACK_CANARY]
+#endif
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
@@ -753,6 +758,9 @@ ENTRY(__switch_to)
 	ldr	r0, =thread_notify_head
 	mov	r1, #THREAD_NOTIFY_SWITCH
 	bl	atomic_notifier_call_chain
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	str	r7, [r8]
+#endif
  THUMB(	mov	ip, r4			   )
 	mov	r0, r5
  ARM(	ldmia	r4, {r4 - sl, fp, sp, pc}  )	@ Load all regs saved previously
-- 
1.7.1.337.gbd0bc
