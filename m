From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 16:36:55 +0100
Subject: [PATCH 3/4] arm64: move kernel text below PAGE_OFFSET
In-Reply-To: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427125016-3873-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the virtual mapping of the kernel Image down into
the lower half of the kernel virtual memory range, moving it
out of the linear mapping.

An exception is made for the statically allocated translation
tables: these are so entangled with the translation regime that
they need to be accessed via the linear mapping exclusively.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h |  9 +++++++--
 arch/arm64/kernel/head.S        | 39 +++++++++++++++++++++++++++++----------
 arch/arm64/kernel/vmlinux.lds.S |  4 ++--
 arch/arm64/mm/mmu.c             |  2 ++
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 7dfe1b0c9c01..2b2d2fccfee3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -38,6 +38,8 @@
  */
 #define PCI_IO_SIZE		SZ_16M
 
+#define KIMAGE_OFFSET		SZ_64M
+
 /*
  * PAGE_OFFSET - the virtual address of the start of the kernel image (top
  *		 (VA_BITS - 1))
@@ -49,7 +51,8 @@
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
-#define MODULES_END		(PAGE_OFFSET)
+#define KIMAGE_VADDR		(PAGE_OFFSET - KIMAGE_OFFSET)
+#define MODULES_END		KIMAGE_VADDR
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
 #define PCI_IO_END		(MODULES_VADDR - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
@@ -117,6 +120,8 @@ extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
 #define PHYS_OFFSET		({ memstart_addr; })
 
+extern u64 image_offset;
+
 /*
  * PFNs are used to describe any physical page; this means
  * PFN 0 == physical address 0.
@@ -151,7 +156,7 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 static inline phys_addr_t __text_to_phys(unsigned long x)
 {
-	return __virt_to_phys(__VIRT(x));
+	return __virt_to_phys(__VIRT(x)) + image_offset;
 }
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 504423422e20..16134608eecf 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -235,7 +235,10 @@ section_table:
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+
 	adrp	x24, __PHYS_OFFSET
+	mov	x23, #KIMAGE_OFFSET
+
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
 	/*
@@ -279,13 +282,15 @@ ENDPROC(preserve_boot_args)
  * Corrupts:	tmp1, tmp2
  * Returns:	tbl -> next level table page address
  */
-	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
+	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2, off=0
 	lsr	\tmp1, \virt, #\shift
+	.if	\off
+	add	\tmp1, \tmp1, #\off
+	.endif
 	and	\tmp1, \tmp1, #\ptrs - 1	// table index
-	add	\tmp2, \tbl, #PAGE_SIZE
+	add	\tmp2, \tbl, #(\off + 1) * PAGE_SIZE
 	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
 	str	\tmp2, [\tbl, \tmp1, lsl #3]
-	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	.endm
 
 /*
@@ -298,8 +303,13 @@ ENDPROC(preserve_boot_args)
 	.macro	create_pgd_entry, tbl, virt, tmp1, tmp2
 	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2
 #if SWAPPER_PGTABLE_LEVELS == 3
+	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	create_table_entry \tbl, \virt, TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2
+	create_table_entry \tbl, \virt, TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2, 1
+#else
+	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2, 1
 #endif
+	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	.endm
 
 /*
@@ -312,15 +322,15 @@ ENDPROC(preserve_boot_args)
 	.macro	create_block_map, tbl, flags, phys, start, end
 	lsr	\phys, \phys, #BLOCK_SHIFT
 	lsr	\start, \start, #BLOCK_SHIFT
-	and	\start, \start, #PTRS_PER_PTE - 1	// table index
 	orr	\phys, \flags, \phys, lsl #BLOCK_SHIFT	// table entry
 	lsr	\end, \end, #BLOCK_SHIFT
-	and	\end, \end, #PTRS_PER_PTE - 1		// table end index
+	sub	\end, \end, \start
+	and	\start, \start, #PTRS_PER_PTE - 1	// table index
 9999:	str	\phys, [\tbl, \start, lsl #3]		// store the entry
 	add	\start, \start, #1			// next entry
 	add	\phys, \phys, #BLOCK_SIZE		// next block
-	cmp	\start, \end
-	b.ls	9999b
+	subs	\end, \end, #1
+	b.pl	9999b
 	.endm
 
 /*
@@ -371,10 +381,18 @@ __create_page_tables:
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
 	mov	x0, x26				// swapper_pg_dir
-	mov	x5, #PAGE_OFFSET
+	ldr	x5, =KERNEL_START		// VA of __PHYS_OFFSET
 	create_pgd_entry x0, x5, x3, x6
-	ldr	x6, =KERNEL_END			// __va(KERNEL_END)
-	mov	x3, x24				// phys offset
+	ldr	x6, =__pgdir_start		// VA of KERNEL_END
+	adrp	x3, KERNEL_START		// phys offset
+	create_block_map x0, x7, x3, x5, x6
+
+	ldr	x5, =__pgdir_start
+	add	x5, x5, x23
+	adrp	x3, idmap_pg_dir
+	add	x0, x0, #PAGE_SIZE
+	ldr	x6, =__pgdir_stop
+	add	x6, x6, x23
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
@@ -406,6 +424,7 @@ __mmap_switched:
 2:
 	adr_l	sp, initial_sp, x4
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
+	str_l	x23, image_offset, x5
 	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
 	mov	x29, #0
 	b	start_kernel
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index d3885043f0b7..9f514a0a38ad 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -74,7 +74,7 @@ SECTIONS
 		*(.discard.*)
 	}
 
-	. = __TEXT(PAGE_OFFSET) + TEXT_OFFSET;
+	. = __TEXT(KIMAGE_VADDR) + TEXT_OFFSET;
 
 	.head.text : {
 		_text = .;
@@ -176,4 +176,4 @@ ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) > __hyp_idmap_text_end),
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
-ASSERT(_text == (__TEXT(PAGE_OFFSET) + TEXT_OFFSET), "HEAD is misaligned")
+ASSERT(_text == (__TEXT(KIMAGE_VADDR) + TEXT_OFFSET), "HEAD is misaligned")
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index bb3ce41130f3..14ba1dd80932 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -47,6 +47,8 @@
 struct page *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
+u64 image_offset;
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-- 
1.8.3.2
