From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:43 +0200
Subject: [PATCH 3/8] arm64: kernel: perform relocation processing from ID map
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1460992188-23295-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor the relocation processing so that the code executes from the
ID map while accessing the relocation tables via the virtual mapping.
This way, we can use literals containing virtual addresses as before,
instead of having to use convoluted absolute expressions.

For symmetry with the secondary code path, the relocation code and the
subsequent jump to the virtual entry point are implemented in a function
called __primary_switch(), and __mmap_switched() is renamed to
__primary_switched(). Also, the call sequence in stext() is aligned with
the one in secondary_startup(), by replacing the awkward 'adr_l lr' and
'b cpu_setup' sequence with a simple branch and link.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S        | 96 +++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S |  7 +-
 2 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index f13276d4ca91..0d487d90d221 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -223,13 +223,11 @@ ENTRY(stext)
 	 * On return, the CPU will be ready for the MMU to be turned on and
 	 * the TCR will have been set.
 	 */
-	ldr	x27, 0f				// address to jump to after
-	neg	x27, x27			// MMU has been enabled
-	adr_l	lr, __enable_mmu		// return (PIC) address
-	b	__cpu_setup			// initialise processor
+	bl	__cpu_setup			// initialise processor
+	adr_l	x27, __primary_switch		// address to jump to after
+						// MMU has been enabled
+	b	__enable_mmu
 ENDPROC(stext)
-	.align	3
-0:	.quad	(_text - TEXT_OFFSET) - __mmap_switched - KIMAGE_VADDR
 
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
@@ -421,7 +419,7 @@ ENDPROC(__create_page_tables)
  * The following fragment of code is executed with the MMU enabled.
  */
 	.set	initial_sp, init_thread_union + THREAD_START_SP
-__mmap_switched:
+__primary_switched:
 	mov	x28, lr				// preserve LR
 	adr_l	x8, vectors			// load VBAR_EL1 with virtual
 	msr	vbar_el1, x8			// vector table address
@@ -435,42 +433,6 @@ __mmap_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
-#ifdef CONFIG_RELOCATABLE
-
-	/*
-	 * Iterate over each entry in the relocation table, and apply the
-	 * relocations in place.
-	 */
-	adr_l	x8, __dynsym_start		// start of symbol table
-	adr_l	x9, __reloc_start		// start of reloc table
-	adr_l	x10, __reloc_end		// end of reloc table
-
-0:	cmp	x9, x10
-	b.hs	2f
-	ldp	x11, x12, [x9], #24
-	ldr	x13, [x9, #-8]
-	cmp	w12, #R_AARCH64_RELATIVE
-	b.ne	1f
-	add	x13, x13, x23			// relocate
-	str	x13, [x11, x23]
-	b	0b
-
-1:	cmp	w12, #R_AARCH64_ABS64
-	b.ne	0b
-	add	x12, x12, x12, lsl #1		// symtab offset: 24x top word
-	add	x12, x8, x12, lsr #(32 - 3)	// ... shifted into bottom word
-	ldrsh	w14, [x12, #6]			// Elf64_Sym::st_shndx
-	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
-	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
-	add	x14, x15, x23			// relocate
-	csel	x15, x14, x15, ne
-	add	x15, x13, x15
-	str	x15, [x11, x23]
-	b	0b
-
-2:
-#endif
-
 	adr_l	sp, initial_sp, x4
 	mov	x4, sp
 	and	x4, x4, #~(THREAD_SIZE - 1)
@@ -496,7 +458,7 @@ __mmap_switched:
 0:
 #endif
 	b	start_kernel
-ENDPROC(__mmap_switched)
+ENDPROC(__primary_switched)
 
 /*
  * end early head section, begin head code that is also used for
@@ -788,7 +750,6 @@ __enable_mmu:
 	ic	iallu				// flush instructions fetched
 	dsb	nsh				// via old mapping
 	isb
-	add	x27, x27, x23			// relocated __mmap_switched
 #endif
 	br	x27
 ENDPROC(__enable_mmu)
@@ -802,6 +763,51 @@ __no_granule_support:
 	b 1b
 ENDPROC(__no_granule_support)
 
+__primary_switch:
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Iterate over each entry in the relocation table, and apply the
+	 * relocations in place.
+	 */
+	ldr	w8, =__dynsym_offset		// offset to symbol table
+	ldr	w9, =__rela_offset		// offset to reloc table
+	ldr	w10, =__rela_size		// size of reloc table
+
+	ldr	x11, =KIMAGE_VADDR		// default virtual offset
+	add	x11, x11, x23			// actual virtual offset
+	add	x8, x8, x11			// __va(.dynsym)
+	add	x9, x9, x11			// __va(.rela)
+	add	x10, x9, x10			// __va(.rela) + sizeof(.rela)
+
+0:	cmp	x9, x10
+	b.hs	2f
+	ldp	x11, x12, [x9], #24
+	ldr	x13, [x9, #-8]
+	cmp	w12, #R_AARCH64_RELATIVE
+	b.ne	1f
+	add	x13, x13, x23			// relocate
+	str	x13, [x11, x23]
+	b	0b
+
+1:	cmp	w12, #R_AARCH64_ABS64
+	b.ne	0b
+	add	x12, x12, x12, lsl #1		// symtab offset: 24x top word
+	add	x12, x8, x12, lsr #(32 - 3)	// ... shifted into bottom word
+	ldrsh	w14, [x12, #6]			// Elf64_Sym::st_shndx
+	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
+	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
+	add	x14, x15, x23			// relocate
+	csel	x15, x14, x15, ne
+	add	x15, x13, x15
+	str	x15, [x11, x23]
+	b	0b
+
+2:
+#endif
+	ldr	x8, =__primary_switched
+	br	x8
+ENDPROC(__primary_switch)
+
 __secondary_switch:
 	ldr	x8, =__secondary_switched
 	br	x8
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 77d86c976abd..8918b303cc61 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -158,12 +158,9 @@ SECTIONS
 		*(.altinstr_replacement)
 	}
 	.rela : ALIGN(8) {
-		__reloc_start = .;
 		*(.rela .rela*)
-		__reloc_end = .;
 	}
 	.dynsym : ALIGN(8) {
-		__dynsym_start = .;
 		*(.dynsym)
 	}
 	.dynstr : {
@@ -173,6 +170,10 @@ SECTIONS
 		*(.hash)
 	}
 
+	__rela_offset	= ADDR(.rela) - KIMAGE_VADDR;
+	__rela_size	= SIZEOF(.rela);
+	__dynsym_offset	= ADDR(.dynsym) - KIMAGE_VADDR;
+
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_end = .;
 
-- 
2.5.0
