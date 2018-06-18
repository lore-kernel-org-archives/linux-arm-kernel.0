From: zsm@chromium.org (Zubin Mithra)
Date: Mon, 18 Jun 2018 08:30:50 -0700
Subject: [RFC v2 1/4] arm: Store address of thread_info in sp^
In-Reply-To: <20180618153053.186224-1-zsm@chromium.org>
References: <20180618153053.186224-1-zsm@chromium.org>
Message-ID: <20180618153053.186224-2-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a need to store thread_info in a register so that subsequent
patches can move thread_info into task_struct. This would also
facilitate having separate IRQ stacks.

Banked register sp is an unused scratch register in EL1 context. We can
utilize this register for stashing the current thread_info.

The macro save_ti_sp_usr is used to stash the address of thread_info
into sp^. The macro get_thread_info is modified to retrieve thread_info
from sp^. Additionally, upon context switch, sp^ is set to current's
thread_info by using set_sp_usr.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/arm/include/asm/assembler.h   | 27 ++++++++++++++++++++++-----
 arch/arm/include/asm/switch_to.h   | 11 +++++++++++
 arch/arm/include/asm/thread_info.h | 14 ++++++++++++--
 arch/arm/kernel/entry-armv.S       |  5 ++++-
 arch/arm/kernel/entry-common.S     |  2 ++
 arch/arm/kernel/head-common.S      |  2 ++
 arch/arm/kernel/head.S             |  1 +
 7 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 0cd4dccbae78..be18a364f590 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -205,11 +205,28 @@
 /*
  * Get current thread_info.
  */
-	.macro	get_thread_info, rd
- ARM(	mov	\rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
- THUMB(	mov	\rd, sp			)
- THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
-	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
+	.macro get_thread_info, rd
+	sub sp, #4
+	stm sp, {sp}^
+	pop {\rd}
+	.endm
+
+	.macro save_ti_sp_usr, tmp, restore=0
+	.if \restore
+	push	{\tmp}
+	.endif
+
+ ARM(	mov	\tmp, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
+ THUMB(	mov	\tmp, sp			)
+ THUMB(	lsr	\tmp, \tmp, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
+	mov	\tmp, \tmp, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
+	push	{\tmp}
+	ldm	sp, {sp}^
+	add	sp, 4
+
+	.if \restore
+	pop	{\tmp}
+	.endif
 	.endm
 
 /*
diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index d3e937dcee4d..5b4572f78cf4 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -16,6 +16,16 @@
 #define __complete_pending_tlbi()
 #endif
 
+static inline void set_sp_usr(unsigned long ti)
+{
+       asm volatile(
+		"push {%0}\n"
+		"ldm sp, {sp}^\n"
+		"add sp, #4\n"
+		:: "r"(ti)
+       );
+}
+
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
@@ -27,6 +37,7 @@ extern struct task_struct *__switch_to(struct task_struct *, struct thread_info
 do {									\
 	__complete_pending_tlbi();					\
 	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
+	set_sp_usr(current_stack_pointer & ~(THREAD_SIZE - 1));		\
 } while (0)
 
 #endif /* __ASM_ARM_SWITCH_TO_H */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index e71cc35de163..4a351e0aba0e 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -80,6 +80,7 @@ struct thread_info {
  */
 register unsigned long current_stack_pointer asm ("sp");
 
+
 /*
  * how to get the thread information struct from C
  */
@@ -87,8 +88,17 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
 static inline struct thread_info *current_thread_info(void)
 {
-	return (struct thread_info *)
-		(current_stack_pointer & ~(THREAD_SIZE - 1));
+	unsigned long ti;
+
+	asm volatile(
+		"sub sp, #4\n"
+		"stm sp, {sp}^\n"
+		"ldr %0, [sp]\n"
+		"add sp, #4\n"
+		: "=r" (ti)
+	);
+
+	return (struct thread_info *)ti;
 }
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 179a9f6bd1e3..af79f9053530 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -181,7 +181,8 @@ ENDPROC(__und_invalid)
 	@
 	stmia	r7, {r2 - r6}
 
-	get_thread_info tsk
+	save_ti_sp_usr tsk restore=0
+
 	ldr	r0, [tsk, #TI_ADDR_LIMIT]
 	mov	r1, #TASK_SIZE
 	str	r1, [tsk, #TI_ADDR_LIMIT]
@@ -411,6 +412,8 @@ ENDPROC(__fiq_abt)
 	uaccess_disable ip
 	.endif
 
+	save_ti_sp_usr tsk restore=0
+
 	@ Enable the alignment trap while in kernel mode
  ATRAP(	teq	r8, r7)
  ATRAP( mcrne	p15, 0, r8, c1, c0, 0)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 106a1466518d..0dbeaccebf62 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -149,6 +149,7 @@ ENDPROC(ret_to_user)
  * This is how we return from a fork.
  */
 ENTRY(ret_from_fork)
+	save_ti_sp_usr	tsk
 	bl	schedule_tail
 	cmp	r5, #0
 	movne	r0, r4
@@ -185,6 +186,7 @@ ENTRY(vector_swi)
 	asm_trace_hardirqs_on save=0
 	enable_irq_notrace
 	ct_user_exit save=0
+	save_ti_sp_usr tsk
 
 	/*
 	 * Get the system call number.
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 6e0375e7db05..84e649144a32 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -109,6 +109,8 @@ __mmap_switched:
 	mov	r1, #0
 	bl	memset				@ clear .bss
 
+	save_ti_sp_usr r9
+
 	ldmia	r4, {r0, r1, r2, r3}
 	str	r9, [r0]			@ Save processor ID
 	str	r7, [r1]			@ Save machine type
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 6b1148cafffd..66bba1b27d2c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -418,6 +418,7 @@ ENDPROC(secondary_startup_arm)
 ENTRY(__secondary_switched)
 	ldr	sp, [r7, #12]			@ get secondary_data.stack
 	mov	fp, #0
+	save_ti_sp_usr r0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
 
-- 
2.18.0.rc1.244.gcf134e6275-goog
