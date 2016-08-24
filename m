From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:36:05 +0200
Subject: [PATCH v2 8/9] arm64: head.S: use ordinary stack frame for
 __primary_switched()
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472049366-10922-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of stashing the value of the link register in x28 before setting
up the stack and calling into C code, create an ordinary PCS compatible
stack frame so that we can push the return address onto the stack.

Since exception handlers require a stack as well, assign the stach pointer
register before installing the vector table.

Note that this accounts for the difference between THREAD_START_SP and
THREAD_SIZE, given that the stack pointer is always decremented before
calling into any C code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 27f51272de68..ad1dc61d67ac 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -415,13 +415,18 @@ ENDPROC(__create_page_tables)
  *
  *   x0 = __PHYS_OFFSET
  */
-	.set	initial_sp, init_thread_union + THREAD_START_SP
 __primary_switched:
-	mov	x28, lr				// preserve LR
+	adrp	x4, init_thread_union
+	add	sp, x4, #THREAD_SIZE
+	msr	sp_el0, x4			// Save thread_info
+
 	adr_l	x8, vectors			// load VBAR_EL1 with virtual
 	msr	vbar_el1, x8			// vector table address
 	isb
 
+	stp	xzr, x30, [sp, #-16]!
+	mov	x29, sp
+
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 
 	ldr_l	x4, kimage_vaddr		// Save the offset between
@@ -436,11 +441,6 @@ __primary_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
-	adr_l	sp, initial_sp, x4
-	mov	x4, sp
-	and	x4, x4, #~(THREAD_SIZE - 1)
-	msr	sp_el0, x4			// Save thread_info
-	mov	x29, #0
 #ifdef CONFIG_KASAN
 	bl	kasan_early_init
 #endif
@@ -452,8 +452,8 @@ __primary_switched:
 	bl	kaslr_early_init		// parse FDT for KASLR options
 	cbz	x0, 0f				// KASLR disabled? just proceed
 	orr	x23, x23, x0			// record KASLR offset
-	ret	x28				// we must enable KASLR, return
-						// to __primary_switch()
+	ldp	x29, x30, [sp], #16		// we must enable KASLR, return
+	ret					// to __primary_switch()
 0:
 #endif
 	b	start_kernel
-- 
2.7.4
