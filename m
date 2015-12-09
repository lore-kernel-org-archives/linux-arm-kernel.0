From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:41 +0000
Subject: [RFC PATCH 06/20] arm64: mm: place empty_zero_page in bss
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the zero page is set up in paging_init, and thus we cannot use
the zero page earlier. We use the zero page as a reserved TTBR value
from which no TLB entries may be allocated (e.g. when uninstalling the
idmap). To enable such usage earlier (as may be required for invasive
changes to the kernel page tables), and to minimise the time that the
idmap is active, we need to be able to use the zero page before
paging_init.

This patch follows the example set by x86, by allocating the zero page
at compile time, in .bss. This means that the zero page itself is
available immediately upon entry to start_kernel (as we zero .bss before
this), and also means that the zero page takes up no space in the raw
Image binary. The associated struct page is allocated in bootmem_init,
and remains unavailable until this time.

Outside of arch code, the only users of empty_zero_page assume that the
empty_zero_page symbol refers to the zeroed memory itself, and that
ZERO_PAGE(x) must be used to acquire the associated struct page,
following the example of x86. This patch also brings arm64 inline with
these assumptions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/include/asm/pgtable.h     | 4 ++--
 arch/arm64/mm/mmu.c                  | 9 +--------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2416578..600eacb 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -48,7 +48,7 @@ static inline void contextidr_thread_switch(struct task_struct *next)
  */
 static inline void cpu_set_reserved_ttbr0(void)
 {
-	unsigned long ttbr = page_to_phys(empty_zero_page);
+	unsigned long ttbr = virt_to_phys(empty_zero_page);
 
 	asm(
 	"	msr	ttbr0_el1, %0			// set TTBR0\n"
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e074f9..00f5a4b8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -121,8 +121,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern struct page *empty_zero_page;
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+#define ZERO_PAGE(vaddr)	virt_to_page(empty_zero_page)
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 304ff23..7559c22 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -48,7 +48,7 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
@@ -441,18 +441,11 @@ void fixup_init(void)
  */
 void __init paging_init(void)
 {
-	void *zero_page;
-
 	map_mem();
 	fixup_executable();
 
-	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
-
 	bootmem_init();
 
-	empty_zero_page = virt_to_page(zero_page);
-
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
 	 * point to zero page to avoid speculatively fetching new entries.
-- 
1.9.1
