From: james.morse@arm.com (James Morse)
Date: Fri,  4 Dec 2015 11:02:25 +0000
Subject: [PATCH v8 1/4] arm64: Store struct task_info in sp_el0
In-Reply-To: <1449226948-14251-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
Message-ID: <1449226948-14251-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jungseok Lee <jungseoklee85@gmail.com>

There is need for figuring out how to manage struct thread_info data when
IRQ stack is introduced. struct thread_info information should be copied
to IRQ stack under the current thread_info calculation logic whenever
context switching is invoked. This is too expensive to keep supporting
the approach.

Instead, this patch pays attention to sp_el0 which is an unused scratch
register in EL1 context. sp_el0 utilization not only simplifies the
management, but also prevents text section size from being increased
largely due to static allocated IRQ stack as removing masking operation
using THREAD_SIZE in many places.

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 10 ++++++++--
 arch/arm64/kernel/entry.S            | 15 ++++++++++++---
 arch/arm64/kernel/head.S             |  5 +++++
 arch/arm64/kernel/sleep.S            |  3 +++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 90c7ff233735..abd64bd1f6d9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -73,10 +73,16 @@ register unsigned long current_stack_pointer asm ("sp");
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
+/*
+ * struct thread_info can be accessed directly via sp_el0.
+ */
 static inline struct thread_info *current_thread_info(void)
 {
-	return (struct thread_info *)
-		(current_stack_pointer & ~(THREAD_SIZE - 1));
+	unsigned long sp_el0;
+
+	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
+
+	return (struct thread_info *)sp_el0;
 }
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ed3d75f6304..fc87373d3f88 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -88,7 +88,8 @@
 
 	.if	\el == 0
 	mrs	x21, sp_el0
-	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
+	mov	tsk, sp
+	and	tsk, tsk, #~(THREAD_SIZE - 1)	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 	.else
@@ -108,6 +109,13 @@
 	.endif
 
 	/*
+	 * Set sp_el0 to current thread_info.
+	 */
+	.if	\el == 0
+	msr	sp_el0, tsk
+	.endif
+
+	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
 	 * x21 - aborted SP
@@ -164,8 +172,7 @@ alternative_endif
 	.endm
 
 	.macro	get_thread_info, rd
-	mov	\rd, sp
-	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
+	mrs	\rd, sp_el0
 	.endm
 
 /*
@@ -599,6 +606,8 @@ ENTRY(cpu_switch_to)
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
 	mov	sp, x9
+	and	x9, x9, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x9
 	ret
 ENDPROC(cpu_switch_to)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 23cfc08fc8ba..b363f340f2c7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -424,6 +424,9 @@ __mmap_switched:
 	b	1b
 2:
 	adr_l	sp, initial_sp, x4
+	mov	x4, sp
+	and	x4, x4, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x4			// Save thread_info
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
 	mov	x29, #0
@@ -606,6 +609,8 @@ ENDPROC(secondary_startup)
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
+	and	x0, x0, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x0			// save thread_info
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index f586f7c875e2..e33fe33876ab 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -173,6 +173,9 @@ ENTRY(cpu_resume)
 	/* load physical address of identity map page table in x1 */
 	adrp	x1, idmap_pg_dir
 	mov	sp, x2
+	/* save thread_info */
+	and	x2, x2, #~(THREAD_SIZE - 1)
+	msr	sp_el0, x2
 	/*
 	 * cpu_do_resume expects x0 to contain context physical address
 	 * pointer and x1 to contain physical address of 1:1 page tables
-- 
2.6.2
