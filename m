From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:24 +0200
Subject: [PATCH 8/8] arm64/kernel: drop global kaslr_offset in x23 from head.S
In-Reply-To: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459781544-14310-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of keeping a global kaslr_offset variable with file scope in
head.S, pass the kaslr_offset as an argument to __create_page_tables()
and __mmap_switched(), and return the new kaslr_offset from the latter
if it returns to __enable_mmu() in order to configure KASLR.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 46 +++++++++++++-------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 23d03da7ecfe..02e37f052263 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -212,8 +212,9 @@ section_table:
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
-	mov	x23, xzr			// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
+
+	mov	x0, xzr				// KASLR offset, defaults to 0
 	bl	__create_page_tables
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -305,14 +306,19 @@ ENDPROC(preserve_boot_args)
 	.endm
 
 /*
+ * __create_page_tables(u64 kaslr_offset)
+ *
  * Setup the initial page tables. We only setup the barest amount which is
  * required to get the kernel running. The following sections are required:
  *   - identity mapping to enable the MMU (low address, TTBR0)
  *   - first few MB of the kernel linear mapping to jump to once the MMU has
  *     been enabled
+ *
+ * Clobbers callee saved registers x27 and x28
  */
 __create_page_tables:
 	mov	x28, lr
+	mov	x27, x0
 
 	/*
 	 * Invalidate the idmap and swapper page tables to avoid potential
@@ -391,7 +397,7 @@ __create_page_tables:
 	 */
 	adrp	x0, swapper_pg_dir
 	ldr	x5, =KIMAGE_VADDR
-	add	x5, x5, x23			// add KASLR displacement
+	add	x5, x5, x27			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
 	ldr	w6, kernel_img_size
 	add	x6, x6, x5
@@ -416,7 +422,10 @@ kernel_img_size:
 	.ltorg
 
 /*
- * __mmap_switched(u64 phys_offset) - virtual entry point for the boot CPU
+ * __mmap_switched(u64 phys_offset, u64 kaslr_offset) - virtual entry point for
+ *							the boot CPU
+ *
+ * Clobbers callee saved register x26
  */
 __mmap_switched:
 	adrp	x4, init_thread_union
@@ -431,6 +440,7 @@ __mmap_switched:
 	isb
 
 #ifdef CONFIG_RELOCATABLE
+	mov	x26, x1				// preserve kaslr_offset
 
 	/*
 	 * Iterate over each entry in the relocation table, and apply the
@@ -446,8 +456,8 @@ __mmap_switched:
 	ldr	x13, [x9, #-8]
 	cmp	w12, #R_AARCH64_RELATIVE
 	b.ne	1f
-	add	x13, x13, x23			// relocate
-	str	x13, [x11, x23]
+	add	x13, x13, x1			// relocate
+	str	x13, [x11, x1]
 	b	0b
 
 1:	cmp	w12, #R_AARCH64_ABS64
@@ -457,10 +467,10 @@ __mmap_switched:
 	ldrsh	w14, [x12, #6]			// Elf64_Sym::st_shndx
 	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
 	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
-	add	x14, x15, x23			// relocate
+	add	x14, x15, x1			// relocate
 	csel	x15, x14, x15, ne
 	add	x15, x13, x15
-	str	x15, [x11, x23]
+	str	x15, [x11, x1]
 	b	0b
 
 2:	adr_l	x8, kimage_vaddr		// make relocated kimage_vaddr
@@ -485,11 +495,10 @@ __mmap_switched:
 	bl	kasan_early_init
 #endif
 #ifdef CONFIG_RANDOMIZE_BASE
-	cbnz	x23, 0f				// already running randomized?
+	cbnz	x26, 0f				// already running randomized?
 	ldr_l	x0, boot_args			// pass FDT address in x0
 	bl	kaslr_early_init		// parse FDT for KASLR options
 	cbz	x0, 0f				// KASLR disabled? just proceed
-	mov	x23, x0				// record KASLR offset
 	ldp	x29, x30, [sp], #16		// we must enable KASLR, return
 	ret					// to __enable_mmu()
 0:
@@ -747,6 +756,8 @@ ENTRY(__early_cpu_boot_status)
  *
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
+ *
+ * Clobbers callee saved registers x22, x23, x24 and x25
  */
 	.section	".idmap.text", "ax"
 __enable_mmu:
@@ -771,30 +782,33 @@ __enable_mmu:
 	ic	iallu
 	dsb	nsh
 	isb
-	mov	x20, x1				// preserve branch target
+	mov	x25, x1				// preserve branch target
+	mov	x1, xzr
 #ifdef CONFIG_RANDOMIZE_BASE
-	mov	x19, x0				// preserve new SCTLR_EL1 value
+	mov	x24, x0				// preserve new SCTLR_EL1 value
 	adrp	x0, __PHYS_OFFSET
-	blr	x1
+	blr	x25
 
 	/*
-	 * If we return here, we have a KASLR displacement in x23 which we need
+	 * If we return here, we have a KASLR displacement in x0 which we need
 	 * to take into account by discarding the current kernel mapping and
 	 * creating a new one.
 	 */
 	msr	sctlr_el1, x22			// disable the MMU
 	isb
+	mov	x23, x0				// preserve new kaslr_offset
 	bl	__create_page_tables		// recreate kernel mapping
 
-	msr	sctlr_el1, x19			// re-enable the MMU
+	msr	sctlr_el1, x24			// re-enable the MMU
 	isb
 	ic	iallu				// flush instructions fetched
 	dsb	nsh				// via old mapping
 	isb
-	add	x20, x20, x23			// relocated __mmap_switched
+	add	x25, x25, x23			// relocated __mmap_switched
+	mov	x1, x23
 #endif
 	adrp	x0, __PHYS_OFFSET
-	br	x20
+	br	x25
 ENDPROC(__enable_mmu)
 
 __no_granule_support:
-- 
2.5.0
