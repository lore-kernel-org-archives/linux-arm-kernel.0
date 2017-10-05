From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:17:58 +0100
Subject: [PATCH v3 06/20] arm64: entry.S: convert el1_sync
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-7-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

el1_sync unmasks exceptions on a case-by-case basis, debug exceptions
are unmasked, unless this was a debug exception. IRQs are unmasked
for instruction and data aborts only if the interrupted context had
irqs unmasked.

Following our 'dai' order, el1_dbg should run with everything masked.
For the other cases we can inherit whatever we interrupted.

Add a macro inherit_daif to set daif based on the interrupted pstate.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h |  6 ++++++
 arch/arm64/kernel/entry.S          | 12 ++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 1b0972046a72..abb5abd61ddb 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -48,6 +48,12 @@
 	msr	daif, \flags
 	.endm
 
+	/* Only on aarch64 pstate, PSR_D_BIT is different for aarch32 */
+	.macro	inherit_daif, pstate:req, tmp:req
+	and	\tmp, \pstate, #(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+	msr	daif, \tmp
+	.endm
+
 /*
  * Enable and disable interrupts.
  */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f7d7bf9d76e7..bd54115972a4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -510,11 +510,7 @@ el1_da:
 	 * Data abort handling
 	 */
 	mrs	x3, far_el1
-	enable_dbg
-	// re-enable interrupts if they were enabled in the aborted context
-	tbnz	x23, #7, 1f			// PSR_I_BIT
-	enable_irq
-1:
+	inherit_daif	pstate=x23, tmp=x2
 	clear_address_tag x0, x3
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
@@ -525,7 +521,7 @@ el1_sp_pc:
 	 * Stack or PC alignment exception handling
 	 */
 	mrs	x0, far_el1
-	enable_dbg
+	inherit_daif	pstate=x23, tmp=x2
 	mov	x2, sp
 	bl	do_sp_pc_abort
 	ASM_BUG()
@@ -533,7 +529,7 @@ el1_undef:
 	/*
 	 * Undefined instruction
 	 */
-	enable_dbg
+	inherit_daif	pstate=x23, tmp=x2
 	mov	x0, sp
 	bl	do_undefinstr
 	ASM_BUG()
@@ -550,7 +546,7 @@ el1_dbg:
 	kernel_exit 1
 el1_inv:
 	// TODO: add support for undefined instructions in kernel mode
-	enable_dbg
+	inherit_daif	pstate=x23, tmp=x2
 	mov	x0, sp
 	mov	x2, x1
 	mov	x1, #BAD_SYNC
-- 
2.13.3
