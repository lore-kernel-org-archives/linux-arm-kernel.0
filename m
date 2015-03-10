From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 16:39:40 +0100
Subject: [PATCH v4 3/5] arm64: remove __switch_data object from head.S
In-Reply-To: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426001982-20047-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the confusing __switch_data object from head.S,
and replaces it with standard PC-relative references to the
various symbols it encapsulates.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 003db2eadd7a..2b60b587a70f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -263,7 +263,7 @@ ENTRY(stext)
 	 * On return, the CPU will be ready for the MMU to be turned on and
 	 * the TCR will have been set.
 	 */
-	ldr	x27, __switch_data		// address to jump to after
+	ldr	x27, =__mmap_switched		// address to jump to after
 						// MMU has been enabled
 	adrp	lr, __enable_mmu		// return (PIC) address
 	add	lr, lr, #:lo12:__enable_mmu
@@ -432,35 +432,22 @@ __create_page_tables:
 ENDPROC(__create_page_tables)
 	.ltorg
 
-	.align	3
-	.type	__switch_data, %object
-__switch_data:
-	.quad	__mmap_switched
-	.quad	__bss_start			// x6
-	.quad	__bss_stop			// x7
-	.quad	__fdt_pointer			// x5
-	.quad	memstart_addr			// x6
-	.quad	init_thread_union + THREAD_START_SP // sp
-
 /*
- * The following fragment of code is executed with the MMU on in MMU mode, and
- * uses absolute addresses; this is not position independent.
+ * The following fragment of code is executed with the MMU enabled.
  */
+	.set	initial_sp, init_thread_union + THREAD_START_SP
 __mmap_switched:
-	adr	x3, __switch_data + 8
+	adr_l	x6, __bss_start
+	adr_l	x7, __bss_stop
 
-	ldp	x6, x7, [x3], #16
 1:	cmp	x6, x7
 	b.hs	2f
 	str	xzr, [x6], #8			// Clear BSS
 	b	1b
 2:
-	ldr	x5, [x3], #8
-	ldr	x6, [x3], #8
-	ldr	x16, [x3]
-	mov	sp, x16
-	str	x21, [x5]			// Save FDT pointer
-	str	x24, [x6]			// Save PHYS_OFFSET
+	adr_l	sp, initial_sp, x4
+	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
+	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
 	mov	x29, #0
 	b	start_kernel
 ENDPROC(__mmap_switched)
-- 
1.8.3.2
