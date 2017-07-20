From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 20 Jul 2017 10:32:24 +0100
Subject: [PATCH 1/4] ARM: use aliases for registers in entry-common
In-Reply-To: <20170720093144.GV31807@n2100.armlinux.org.uk>
References: <20170720093144.GV31807@n2100.armlinux.org.uk>
Message-ID: <E1dY7om-0004qb-AU@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use aliases for the saved (and preserved) PSR and PC values so that we
can control which registers are used.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/entry-common.S | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index eb5cd77bf1d8..9abe47a206d9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -27,6 +27,8 @@
 
 #include "entry-header.S"
 
+saved_psr	.req	r8
+saved_pc	.req	lr
 
 	.align	5
 #if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
@@ -141,9 +143,9 @@ ENTRY(vector_swi)
  ARM(	stmdb	r8, {sp, lr}^		)	@ Calling sp, lr
  THUMB(	mov	r8, sp			)
  THUMB(	store_user_sp_lr r8, r10, S_SP	)	@ calling sp, lr
-	mrs	r8, spsr			@ called from non-FIQ mode, so ok.
-	str	lr, [sp, #S_PC]			@ Save calling PC
-	str	r8, [sp, #S_PSR]		@ Save CPSR
+	mrs	saved_psr, spsr			@ called from non-FIQ mode, so ok.
+	str	saved_pc, [sp, #S_PC]		@ Save calling PC
+	str	saved_psr, [sp, #S_PSR]		@ Save CPSR
 	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
 #endif
 	zero_fp
@@ -163,11 +165,11 @@ ENTRY(vector_swi)
 	 * value to determine if it is an EABI or an old ABI call.
 	 */
 #ifdef CONFIG_ARM_THUMB
-	tst	r8, #PSR_T_BIT
+	tst	saved_psr, #PSR_T_BIT
 	movne	r10, #0				@ no thumb OABI emulation
- USER(	ldreq	r10, [lr, #-4]		)	@ get SWI instruction
+ USER(	ldreq	r10, [saved_pc, #-4]	)	@ get SWI instruction
 #else
- USER(	ldr	r10, [lr, #-4]		)	@ get SWI instruction
+ USER(	ldr	r10, [saved_pc, #-4]	)	@ get SWI instruction
 #endif
  ARM_BE8(rev	r10, r10)			@ little endian instruction
 
@@ -178,15 +180,17 @@ ENTRY(vector_swi)
 	 */
 #elif defined(CONFIG_ARM_THUMB)
 	/* Legacy ABI only, possibly thumb mode. */
-	tst	r8, #PSR_T_BIT			@ this is SPSR from save_user_regs
+	tst	saved_psr, #PSR_T_BIT		@ this is SPSR from save_user_regs
 	addne	scno, r7, #__NR_SYSCALL_BASE	@ put OS number in
- USER(	ldreq	scno, [lr, #-4]		)
+ USER(	ldreq	scno, [saved_pc, #-4]	)
 
 #else
 	/* Legacy ABI only. */
- USER(	ldr	scno, [lr, #-4]		)	@ get SWI instruction
+ USER(	ldr	scno, [saved_pc, #-4]	)	@ get SWI instruction
 #endif
 
+	/* saved_psr and saved_pc are now dead */
+
 	uaccess_disable tbl
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
@@ -234,7 +238,7 @@ ENTRY(vector_swi)
 	 * current task.
 	 */
 9001:
-	sub	lr, lr, #4
+	sub	lr, saved_pc, #4
 	str	lr, [sp, #S_PC]
 	b	ret_fast_syscall
 #endif
-- 
2.7.4
