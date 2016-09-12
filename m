From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Sep 2016 15:16:24 +0100
Subject: [PATCH] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
Message-ID: <1473689784-29745-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the statically allocated zero page from the .bss section to right
before swapper_pg_dir. This allows us to refer to its physical address
by simply reading TTBR1_EL1 (which always points to swapper_pg_dir and
always has its ASID field cleared), and subtracting PAGE_SIZE.

To protect the zero page from inadvertent modification, carve out a
segment that covers it as well as idmap_pg_dir[], and mark it read-only
in both the primary and the linear mappings of the kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: make empty_zero_page[] read-only
    make idmap_pg_dir[] read-only as well
    fix issue in v1 with cpu_reserved_ttbr0()

This is perhaps becoming a bit unwieldy, but I agree with Mark that having
a read-only zero page is a significant improvement.

 arch/arm64/include/asm/mmu_context.h | 19 +++----
 arch/arm64/include/asm/sections.h    |  1 +
 arch/arm64/kernel/vmlinux.lds.S      | 14 ++++-
 arch/arm64/mm/mmu.c                  | 56 ++++++++++++--------
 4 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b1892a0dbcb0..1fe4c4422f0a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -49,13 +49,12 @@ static inline void contextidr_thread_switch(struct task_struct *next)
  */
 static inline void cpu_set_reserved_ttbr0(void)
 {
-	unsigned long ttbr = virt_to_phys(empty_zero_page);
-
-	asm(
-	"	msr	ttbr0_el1, %0			// set TTBR0\n"
-	"	isb"
-	:
-	: "r" (ttbr));
+	/*
+	 * The zero page is located right before swapper_pg_dir, whose
+	 * physical address we can easily fetch from TTBR1_EL1.
+	 */
+	write_sysreg(read_sysreg(ttbr1_el1) - PAGE_SIZE, ttbr0_el1);
+	isb();
 }
 
 /*
@@ -109,7 +108,8 @@ static inline void cpu_uninstall_idmap(void)
 {
 	struct mm_struct *mm = current->active_mm;
 
-	cpu_set_reserved_ttbr0();
+	write_sysreg(virt_to_phys(empty_zero_page), ttbr0_el1);
+	isb();
 	local_flush_tlb_all();
 	cpu_set_default_tcr_t0sz();
 
@@ -119,7 +119,8 @@ static inline void cpu_uninstall_idmap(void)
 
 static inline void cpu_install_idmap(void)
 {
-	cpu_set_reserved_ttbr0();
+	write_sysreg(virt_to_phys(empty_zero_page), ttbr0_el1);
+	isb();
 	local_flush_tlb_all();
 	cpu_set_idmap_tcr_t0sz();
 
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 4e7e7067afdb..44e94e234ba0 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -26,5 +26,6 @@ extern char __hyp_text_start[], __hyp_text_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
+extern char __robss_start[], __robss_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5ce9b2929e0d..eae5036dc725 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -209,9 +209,19 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(SEGMENT_ALIGN);
+	__robss_start = .;
 	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
+	. = ALIGN(. + IDMAP_DIR_SIZE + PAGE_SIZE, SEGMENT_ALIGN);
+	__robss_end = .;
+
+	/*
+	 * Put the zero page right before swapper_pg_dir so we can easily
+	 * obtain its physical address by subtracting PAGE_SIZE from the
+	 * contents of TTBR1_EL1.
+	 */
+	empty_zero_page = __robss_end - PAGE_SIZE;
+
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e634a0f6d62b..adb00035a6a4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -54,7 +54,6 @@ EXPORT_SYMBOL(kimage_voffset);
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
  */
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
@@ -321,16 +320,18 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
 {
-	unsigned long kernel_start = __pa(_text);
-	unsigned long kernel_end = __pa(__init_begin);
+	unsigned long text_start = __pa(_text);
+	unsigned long text_end = __pa(__init_begin);
+	unsigned long robss_start = __pa(__robss_start);
+	unsigned long robss_end = __pa(__robss_end);
 
 	/*
 	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
+	 * read-only text/rodata/robss sections of the kernel image.
 	 */
 
-	/* No overlap with the kernel text/rodata */
-	if (end < kernel_start || start >= kernel_end) {
+	/* No overlap with the kernel text/rodata/robss */
+	if (end < text_start || start >= robss_end) {
 		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
 				     end - start, PAGE_KERNEL,
 				     early_pgtable_alloc,
@@ -342,27 +343,32 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 	 * This block overlaps the kernel text/rodata mappings.
 	 * Map the portion(s) which don't overlap.
 	 */
-	if (start < kernel_start)
-		__create_pgd_mapping(pgd, start,
-				     __phys_to_virt(start),
-				     kernel_start - start, PAGE_KERNEL,
+	if (start < text_start)
+		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
+				     text_start - start, PAGE_KERNEL,
 				     early_pgtable_alloc,
 				     !debug_pagealloc_enabled());
-	if (kernel_end < end)
-		__create_pgd_mapping(pgd, kernel_end,
-				     __phys_to_virt(kernel_end),
-				     end - kernel_end, PAGE_KERNEL,
+	if (robss_end < end)
+		__create_pgd_mapping(pgd, robss_end, __phys_to_virt(robss_end),
+				     end - robss_end, PAGE_KERNEL,
 				     early_pgtable_alloc,
 				     !debug_pagealloc_enabled());
 
 	/*
-	 * Map the linear alias of the [_text, __init_begin) interval as
-	 * read-only/non-executable. This makes the contents of the
-	 * region accessible to subsystems such as hibernate, but
-	 * protects it from inadvertent modification or execution.
+	 * Map the linear alias of the intervals [_text, __init_begin) and
+	 * [robss_start, robss_end) as read-only/non-executable. This makes
+	 * the contents of these regions accessible to subsystems such
+	 * as hibernate, but protects them from inadvertent modification or
+	 * execution.
 	 */
-	__create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
-			     kernel_end - kernel_start, PAGE_KERNEL_RO,
+	__create_pgd_mapping(pgd, text_start, __phys_to_virt(text_start),
+			     text_end - text_start, PAGE_KERNEL_RO,
+			     early_pgtable_alloc, !debug_pagealloc_enabled());
+	__create_pgd_mapping(pgd, text_end, __phys_to_virt(text_end),
+			     robss_start - text_end, PAGE_KERNEL,
+			     early_pgtable_alloc, !debug_pagealloc_enabled());
+	__create_pgd_mapping(pgd, robss_start, __phys_to_virt(robss_start),
+			     robss_end - robss_start, PAGE_KERNEL_RO,
 			     early_pgtable_alloc, !debug_pagealloc_enabled());
 }
 
@@ -436,13 +442,19 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
  */
 static void __init map_kernel(pgd_t *pgd)
 {
-	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
+	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init,
+		vmlinux_data, vmlinux_robss, vmlinux_tail;
 
 	map_kernel_segment(pgd, _text, _etext, PAGE_KERNEL_EXEC, &vmlinux_text);
 	map_kernel_segment(pgd, __start_rodata, __init_begin, PAGE_KERNEL, &vmlinux_rodata);
 	map_kernel_segment(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
 			   &vmlinux_init);
-	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
+	map_kernel_segment(pgd, _data, __robss_start, PAGE_KERNEL,
+			   &vmlinux_data);
+	map_kernel_segment(pgd, __robss_start, __robss_end, PAGE_KERNEL_RO,
+			   &vmlinux_robss);
+	map_kernel_segment(pgd, __robss_end, _end, PAGE_KERNEL,
+			   &vmlinux_tail);
 
 	if (!pgd_val(*pgd_offset_raw(pgd, FIXADDR_START))) {
 		/*
-- 
2.7.4
