From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 20 Aug 2014 18:20:36 -0700
Subject: [PATCHv3 4/7] arm64: Move some head.text functions to executable
 section
In-Reply-To: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1408584039-12735-5-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code in the head.text section of the kernel exists in the
same section as the swapper_pg_dir which means it needs the
same page table permissions. The swapper_pg_dir needs to be
writeable but shouldn't be executable. The head.text section
is intended to be run at early bootup before any of the regular
kernel mappings have been setup so there is no issue at bootup.
The suspend/resume/hotplug code path requires some of these
head.S functions to run however which means they need to be
executable. We can't easily move all of the head.text to
an executable section, so split it into two parts: that which
is used only at early head.S bootup and that which is used
after bootup. There is a small bit of code duplication because
of some relocation issues related to accessing code more than
1MB away.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/head.S        | 424 +++++++++++++++++++++-------------------
 arch/arm64/kernel/vmlinux.lds.S |   1 +
 2 files changed, 228 insertions(+), 197 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 61bc210..dbdb378 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -238,7 +238,7 @@ ENTRY(stext)
 	mov	x0, x22
 	bl	lookup_processor_type
 	mov	x23, x0				// x23=current cpu_table
-	cbz	x23, __error_p			// invalid processor (x23=0)?
+	cbz	x23, __h_error_p		// invalid processor (x23=0)?
 	bl	__vet_fdt
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
 	/*
@@ -250,12 +250,236 @@ ENTRY(stext)
 	 */
 	ldr	x27, __switch_data		// address to jump to after
 						// MMU has been enabled
-	adr	lr, __enable_mmu		// return (PIC) address
+	adr	lr, __h_enable_mmu		// return (PIC) address
 	ldr	x12, [x23, #CPU_INFO_SETUP]
 	add	x12, x12, x28			// __virt_to_phys
 	br	x12				// initialise processor
 ENDPROC(stext)
 
+__h_error_p:
+ENDPROC(__h_error_p)
+
+__h_error:
+1:
+	nop
+	b	1b
+ENDPROC(__h_error)
+
+__h_enable_mmu:
+	ldr	x5, =vectors
+	msr	vbar_el1, x5
+	msr	ttbr0_el1, x25			// load TTBR0
+	msr	ttbr1_el1, x26			// load TTBR1
+	isb
+	b	__h_turn_mmu_on
+ENDPROC(__h_enable_mmu)
+
+	.align	4
+__h_turn_mmu_on:
+	msr	sctlr_el1, x0
+	isb
+	br	x27
+ENDPROC(__h_turn_mmu_on)
+
+/*
+ * Determine validity of the x21 FDT pointer.
+ * The dtb must be 8-byte aligned and live in the first 512M of memory.
+ */
+__vet_fdt:
+	tst	x21, #0x7
+	b.ne	1f
+	cmp	x21, x24
+	b.lt	1f
+	mov	x0, #(1 << 29)
+	add	x0, x0, x24
+	cmp	x21, x0
+	b.ge	1f
+	ret
+1:
+	mov	x21, #0
+	ret
+ENDPROC(__vet_fdt)
+/*
+ * Macro to create a table entry to the next page.
+ *
+ *	tbl:	page table address
+ *	virt:	virtual address
+ *	shift:	#imm page table shift
+ *	ptrs:	#imm pointers per table page
+ *
+ * Preserves:	virt
+ * Corrupts:	tmp1, tmp2
+ * Returns:	tbl -> next level table page address
+ */
+	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
+	lsr	\tmp1, \virt, #\shift
+	and	\tmp1, \tmp1, #\ptrs - 1	// table index
+	add	\tmp2, \tbl, #PAGE_SIZE
+	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
+	str	\tmp2, [\tbl, \tmp1, lsl #3]
+	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
+	.endm
+
+/*
+ * Macro to populate the PGD (and possibily PUD) for the corresponding
+ * block entry in the next level (tbl) for the given virtual address.
+ *
+ * Preserves:	tbl, next, virt
+ * Corrupts:	tmp1, tmp2
+ */
+	.macro	create_pgd_entry, tbl, virt, tmp1, tmp2
+	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2
+#if SWAPPER_PGTABLE_LEVELS == 3
+	create_table_entry \tbl, \virt, TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2
+#endif
+	.endm
+
+/*
+ * Macro to populate block entries in the page table for the start..end
+ * virtual range (inclusive).
+ *
+ * Preserves:	tbl, flags
+ * Corrupts:	phys, start, end, pstate
+ */
+	.macro	create_block_map, tbl, flags, phys, start, end
+	lsr	\phys, \phys, #BLOCK_SHIFT
+	lsr	\start, \start, #BLOCK_SHIFT
+	and	\start, \start, #PTRS_PER_PTE - 1	// table index
+	orr	\phys, \flags, \phys, lsl #BLOCK_SHIFT	// table entry
+	lsr	\end, \end, #BLOCK_SHIFT
+	and	\end, \end, #PTRS_PER_PTE - 1		// table end index
+9999:	str	\phys, [\tbl, \start, lsl #3]		// store the entry
+	add	\start, \start, #1			// next entry
+	add	\phys, \phys, #BLOCK_SIZE		// next block
+	cmp	\start, \end
+	b.ls	9999b
+	.endm
+
+/*
+ * Setup the initial page tables. We only setup the barest amount which is
+ * required to get the kernel running. The following sections are required:
+ *   - identity mapping to enable the MMU (low address, TTBR0)
+ *   - first few MB of the kernel linear mapping to jump to once the MMU has
+ *     been enabled, including the FDT blob (TTBR1)
+ *   - pgd entry for fixed mappings (TTBR1)
+ */
+__create_page_tables:
+	pgtbl	x25, x26, x28			// idmap_pg_dir and swapper_pg_dir addresses
+	mov	x27, lr
+
+	/*
+	 * Invalidate the idmap and swapper page tables to avoid potential
+	 * dirty cache lines being evicted.
+	 */
+	mov	x0, x25
+	add	x1, x26, #SWAPPER_DIR_SIZE
+	bl	__inval_cache_range
+
+	/*
+	 * Clear the idmap and swapper page tables.
+	 */
+	mov	x0, x25
+	add	x6, x26, #SWAPPER_DIR_SIZE
+1:	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	cmp	x0, x6
+	b.lo	1b
+
+	ldr	x7, =MM_MMUFLAGS
+
+	/*
+	 * Create the identity mapping.
+	 */
+	mov	x0, x25				// idmap_pg_dir
+	ldr	x3, =KERNEL_START
+	add	x3, x3, x28			// __pa(KERNEL_START)
+	create_pgd_entry x0, x3, x5, x6
+	ldr	x6, =KERNEL_END
+	mov	x5, x3				// __pa(KERNEL_START)
+	add	x6, x6, x28			// __pa(KERNEL_END)
+	create_block_map x0, x7, x3, x5, x6
+
+	/*
+	 * Map the kernel image (starting with PHYS_OFFSET).
+	 */
+	mov	x0, x26				// swapper_pg_dir
+	mov	x5, #PAGE_OFFSET
+	create_pgd_entry x0, x5, x3, x6
+	ldr	x6, =KERNEL_END
+	mov	x3, x24				// phys offset
+	create_block_map x0, x7, x3, x5, x6
+
+	/*
+	 * Map the FDT blob (maximum 2MB; must be within 512MB of
+	 * PHYS_OFFSET).
+	 */
+	mov	x3, x21				// FDT phys address
+	and	x3, x3, #~((1 << 21) - 1)	// 2MB aligned
+	mov	x6, #PAGE_OFFSET
+	sub	x5, x3, x24			// subtract PHYS_OFFSET
+	tst	x5, #~((1 << 29) - 1)		// within 512MB?
+	csel	x21, xzr, x21, ne		// zero the FDT pointer
+	b.ne	1f
+	add	x5, x5, x6			// __va(FDT blob)
+	add	x6, x5, #1 << 21		// 2MB for the FDT blob
+	sub	x6, x6, #1			// inclusive range
+	create_block_map x0, x7, x3, x5, x6
+1:
+	/*
+	 * Since the page tables have been populated with non-cacheable
+	 * accesses (MMU disabled), invalidate the idmap and swapper page
+	 * tables again to remove any speculatively loaded cache lines.
+	 */
+	mov	x0, x25
+	add	x1, x26, #SWAPPER_DIR_SIZE
+	bl	__inval_cache_range
+
+	mov	lr, x27
+	ret
+ENDPROC(__create_page_tables)
+	.ltorg
+
+	.align	3
+	.type	__switch_data, %object
+__switch_data:
+	.quad	__mmap_switched
+	.quad	__bss_start			// x6
+	.quad	__bss_stop			// x7
+	.quad	processor_id			// x4
+	.quad	__fdt_pointer			// x5
+	.quad	memstart_addr			// x6
+	.quad	init_thread_union + THREAD_START_SP // sp
+
+/*
+ * The following fragment of code is executed with the MMU on in MMU mode, and
+ * uses absolute addresses; this is not position independent.
+ */
+__mmap_switched:
+	adr	x3, __switch_data + 8
+
+	ldp	x6, x7, [x3], #16
+1:	cmp	x6, x7
+	b.hs	2f
+	str	xzr, [x6], #8			// Clear BSS
+	b	1b
+2:
+	ldp	x4, x5, [x3], #16
+	ldr	x6, [x3], #8
+	ldr	x16, [x3]
+	mov	sp, x16
+	str	x22, [x4]			// Save processor ID
+	str	x21, [x5]			// Save FDT pointer
+	str	x24, [x6]			// Save PHYS_OFFSET
+	mov	x29, #0
+	b	start_kernel
+ENDPROC(__mmap_switched)
+
+/*
+ * end 'true' head section, begin head section that can be read only
+ */
+	.section ".latehead.text","ax"
 /*
  * If we're fortunate enough to boot@EL2, ensure that the world is
  * sane before dropping to EL1.
@@ -497,183 +721,6 @@ ENDPROC(__calc_phys_offset)
 	.quad	PAGE_OFFSET
 
 /*
- * Macro to create a table entry to the next page.
- *
- *	tbl:	page table address
- *	virt:	virtual address
- *	shift:	#imm page table shift
- *	ptrs:	#imm pointers per table page
- *
- * Preserves:	virt
- * Corrupts:	tmp1, tmp2
- * Returns:	tbl -> next level table page address
- */
-	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
-	lsr	\tmp1, \virt, #\shift
-	and	\tmp1, \tmp1, #\ptrs - 1	// table index
-	add	\tmp2, \tbl, #PAGE_SIZE
-	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
-	str	\tmp2, [\tbl, \tmp1, lsl #3]
-	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
-	.endm
-
-/*
- * Macro to populate the PGD (and possibily PUD) for the corresponding
- * block entry in the next level (tbl) for the given virtual address.
- *
- * Preserves:	tbl, next, virt
- * Corrupts:	tmp1, tmp2
- */
-	.macro	create_pgd_entry, tbl, virt, tmp1, tmp2
-	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2
-#if SWAPPER_PGTABLE_LEVELS == 3
-	create_table_entry \tbl, \virt, TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2
-#endif
-	.endm
-
-/*
- * Macro to populate block entries in the page table for the start..end
- * virtual range (inclusive).
- *
- * Preserves:	tbl, flags
- * Corrupts:	phys, start, end, pstate
- */
-	.macro	create_block_map, tbl, flags, phys, start, end
-	lsr	\phys, \phys, #BLOCK_SHIFT
-	lsr	\start, \start, #BLOCK_SHIFT
-	and	\start, \start, #PTRS_PER_PTE - 1	// table index
-	orr	\phys, \flags, \phys, lsl #BLOCK_SHIFT	// table entry
-	lsr	\end, \end, #BLOCK_SHIFT
-	and	\end, \end, #PTRS_PER_PTE - 1		// table end index
-9999:	str	\phys, [\tbl, \start, lsl #3]		// store the entry
-	add	\start, \start, #1			// next entry
-	add	\phys, \phys, #BLOCK_SIZE		// next block
-	cmp	\start, \end
-	b.ls	9999b
-	.endm
-
-/*
- * Setup the initial page tables. We only setup the barest amount which is
- * required to get the kernel running. The following sections are required:
- *   - identity mapping to enable the MMU (low address, TTBR0)
- *   - first few MB of the kernel linear mapping to jump to once the MMU has
- *     been enabled, including the FDT blob (TTBR1)
- *   - pgd entry for fixed mappings (TTBR1)
- */
-__create_page_tables:
-	pgtbl	x25, x26, x28			// idmap_pg_dir and swapper_pg_dir addresses
-	mov	x27, lr
-
-	/*
-	 * Invalidate the idmap and swapper page tables to avoid potential
-	 * dirty cache lines being evicted.
-	 */
-	mov	x0, x25
-	add	x1, x26, #SWAPPER_DIR_SIZE
-	bl	__inval_cache_range
-
-	/*
-	 * Clear the idmap and swapper page tables.
-	 */
-	mov	x0, x25
-	add	x6, x26, #SWAPPER_DIR_SIZE
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	cmp	x0, x6
-	b.lo	1b
-
-	ldr	x7, =MM_MMUFLAGS
-
-	/*
-	 * Create the identity mapping.
-	 */
-	mov	x0, x25				// idmap_pg_dir
-	ldr	x3, =KERNEL_START
-	add	x3, x3, x28			// __pa(KERNEL_START)
-	create_pgd_entry x0, x3, x5, x6
-	ldr	x6, =KERNEL_END
-	mov	x5, x3				// __pa(KERNEL_START)
-	add	x6, x6, x28			// __pa(KERNEL_END)
-	create_block_map x0, x7, x3, x5, x6
-
-	/*
-	 * Map the kernel image (starting with PHYS_OFFSET).
-	 */
-	mov	x0, x26				// swapper_pg_dir
-	mov	x5, #PAGE_OFFSET
-	create_pgd_entry x0, x5, x3, x6
-	ldr	x6, =KERNEL_END
-	mov	x3, x24				// phys offset
-	create_block_map x0, x7, x3, x5, x6
-
-	/*
-	 * Map the FDT blob (maximum 2MB; must be within 512MB of
-	 * PHYS_OFFSET).
-	 */
-	mov	x3, x21				// FDT phys address
-	and	x3, x3, #~((1 << 21) - 1)	// 2MB aligned
-	mov	x6, #PAGE_OFFSET
-	sub	x5, x3, x24			// subtract PHYS_OFFSET
-	tst	x5, #~((1 << 29) - 1)		// within 512MB?
-	csel	x21, xzr, x21, ne		// zero the FDT pointer
-	b.ne	1f
-	add	x5, x5, x6			// __va(FDT blob)
-	add	x6, x5, #1 << 21		// 2MB for the FDT blob
-	sub	x6, x6, #1			// inclusive range
-	create_block_map x0, x7, x3, x5, x6
-1:
-	/*
-	 * Since the page tables have been populated with non-cacheable
-	 * accesses (MMU disabled), invalidate the idmap and swapper page
-	 * tables again to remove any speculatively loaded cache lines.
-	 */
-	mov	x0, x25
-	add	x1, x26, #SWAPPER_DIR_SIZE
-	bl	__inval_cache_range
-
-	mov	lr, x27
-	ret
-ENDPROC(__create_page_tables)
-	.ltorg
-
-	.align	3
-	.type	__switch_data, %object
-__switch_data:
-	.quad	__mmap_switched
-	.quad	__bss_start			// x6
-	.quad	__bss_stop			// x7
-	.quad	processor_id			// x4
-	.quad	__fdt_pointer			// x5
-	.quad	memstart_addr			// x6
-	.quad	init_thread_union + THREAD_START_SP // sp
-
-/*
- * The following fragment of code is executed with the MMU on in MMU mode, and
- * uses absolute addresses; this is not position independent.
- */
-__mmap_switched:
-	adr	x3, __switch_data + 8
-
-	ldp	x6, x7, [x3], #16
-1:	cmp	x6, x7
-	b.hs	2f
-	str	xzr, [x6], #8			// Clear BSS
-	b	1b
-2:
-	ldp	x4, x5, [x3], #16
-	ldr	x6, [x3], #8
-	ldr	x16, [x3]
-	mov	sp, x16
-	str	x22, [x4]			// Save processor ID
-	str	x21, [x5]			// Save FDT pointer
-	str	x24, [x6]			// Save PHYS_OFFSET
-	mov	x29, #0
-	b	start_kernel
-ENDPROC(__mmap_switched)
-
-/*
  * Exception handling. Something went wrong and we can't proceed. We ought to
  * tell the user, but since we don't have any guarantee that we're even
  * running on the right architecture, we do virtually nothing.
@@ -721,21 +768,4 @@ __lookup_processor_type_data:
 	.quad	cpu_table
 	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
 
-/*
- * Determine validity of the x21 FDT pointer.
- * The dtb must be 8-byte aligned and live in the first 512M of memory.
- */
-__vet_fdt:
-	tst	x21, #0x7
-	b.ne	1f
-	cmp	x21, x24
-	b.lt	1f
-	mov	x0, #(1 << 29)
-	add	x0, x0, x24
-	cmp	x21, x0
-	b.ge	1f
-	ret
-1:
-	mov	x21, #0
-	ret
-ENDPROC(__vet_fdt)
+
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 97f0c04..2b674c5 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -56,6 +56,7 @@ SECTIONS
 	}
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
+			*(.latehead.text)
 			__exception_text_start = .;
 			*(.exception.text)
 			__exception_text_end = .;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
