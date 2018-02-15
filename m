From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Feb 2018 11:14:56 +0000
Subject: [PATCH] arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing page tables
Message-ID: <1518693296-7339-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In many cases, page tables can be accessed concurrently by either another
CPU (due to things like fast gup) or by the hardware page table walker
itself, which may set access/dirty bits. In such cases, it is important
to use READ_ONCE/WRITE_ONCE when accessing page table entries so that
entries cannot be torn, merged or subject to apparent loss of coherence
due to compiler transformations.

Whilst there are some scenarios where this cannot happen (e.g. pinned
kernel mappings for the linear region), the overhead of using READ_ONCE
/WRITE_ONCE everywhere is minimal and makes the code an awful lot easier
to reason about. This patch consistently uses these macros in the arch
code, as well as explicitly namespacing pointers to page table entries
from the entries themselves by using adopting a 'p' suffix for the former
(as is sometimes used elsewhere in the kernel source).

Cc: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Yury Norov <ynorov@caviumnetworks.com>
Tested-by: Richard Ruigrok <rruigrok@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/hugetlb.h     |   2 +-
 arch/arm64/include/asm/kvm_mmu.h     |  26 ++--
 arch/arm64/include/asm/mmu_context.h |   4 +-
 arch/arm64/include/asm/pgalloc.h     |  44 +++---
 arch/arm64/include/asm/pgtable.h     |  23 +--
 arch/arm64/kernel/efi.c              |   2 +-
 arch/arm64/kernel/hibernate.c        | 148 +++++++++---------
 arch/arm64/mm/dump.c                 |  54 ++++---
 arch/arm64/mm/fault.c                |  44 +++---
 arch/arm64/mm/hugetlbpage.c          |  94 ++++++------
 arch/arm64/mm/kasan_init.c           |  70 ++++-----
 arch/arm64/mm/mmu.c                  | 282 ++++++++++++++++++-----------------
 arch/arm64/mm/pageattr.c             |  32 ++--
 13 files changed, 426 insertions(+), 399 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 1dca41bea16a..e73f68569624 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -22,7 +22,7 @@
 
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
-	return *ptep;
+	return READ_ONCE(*ptep);
 }
 
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 9679067a1574..7faed6e48b46 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -185,42 +185,42 @@ static inline pmd_t kvm_s2pmd_mkexec(pmd_t pmd)
 	return pmd;
 }
 
-static inline void kvm_set_s2pte_readonly(pte_t *pte)
+static inline void kvm_set_s2pte_readonly(pte_t *ptep)
 {
 	pteval_t old_pteval, pteval;
 
-	pteval = READ_ONCE(pte_val(*pte));
+	pteval = READ_ONCE(pte_val(*ptep));
 	do {
 		old_pteval = pteval;
 		pteval &= ~PTE_S2_RDWR;
 		pteval |= PTE_S2_RDONLY;
-		pteval = cmpxchg_relaxed(&pte_val(*pte), old_pteval, pteval);
+		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
 	} while (pteval != old_pteval);
 }
 
-static inline bool kvm_s2pte_readonly(pte_t *pte)
+static inline bool kvm_s2pte_readonly(pte_t *ptep)
 {
-	return (pte_val(*pte) & PTE_S2_RDWR) == PTE_S2_RDONLY;
+	return (READ_ONCE(pte_val(*ptep)) & PTE_S2_RDWR) == PTE_S2_RDONLY;
 }
 
-static inline bool kvm_s2pte_exec(pte_t *pte)
+static inline bool kvm_s2pte_exec(pte_t *ptep)
 {
-	return !(pte_val(*pte) & PTE_S2_XN);
+	return !(READ_ONCE(pte_val(*ptep)) & PTE_S2_XN);
 }
 
-static inline void kvm_set_s2pmd_readonly(pmd_t *pmd)
+static inline void kvm_set_s2pmd_readonly(pmd_t *pmdp)
 {
-	kvm_set_s2pte_readonly((pte_t *)pmd);
+	kvm_set_s2pte_readonly((pte_t *)pmdp);
 }
 
-static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
+static inline bool kvm_s2pmd_readonly(pmd_t *pmdp)
 {
-	return kvm_s2pte_readonly((pte_t *)pmd);
+	return kvm_s2pte_readonly((pte_t *)pmdp);
 }
 
-static inline bool kvm_s2pmd_exec(pmd_t *pmd)
+static inline bool kvm_s2pmd_exec(pmd_t *pmdp)
 {
-	return !(pmd_val(*pmd) & PMD_S2_XN);
+	return !(READ_ONCE(pmd_val(*pmdp)) & PMD_S2_XN);
 }
 
 static inline bool kvm_page_empty(void *ptr)
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 8d3331985d2e..39ec0b8a689e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -141,13 +141,13 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgd)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
 	ttbr_replace_func *replace_phys;
 
-	phys_addr_t pgd_phys = virt_to_phys(pgd);
+	phys_addr_t pgd_phys = virt_to_phys(pgdp);
 
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index e9d9f1b006ef..2e05bcd944c8 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -36,23 +36,23 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 	return (pmd_t *)__get_free_page(PGALLOC_GFP);
 }
 
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
-	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	free_page((unsigned long)pmd);
+	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
+	free_page((unsigned long)pmdp);
 }
 
-static inline void __pud_populate(pud_t *pud, phys_addr_t pmd, pudval_t prot)
+static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 {
-	set_pud(pud, __pud(__phys_to_pud_val(pmd) | prot));
+	set_pud(pudp, __pud(__phys_to_pud_val(pmdp) | prot));
 }
 
-static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 {
-	__pud_populate(pud, __pa(pmd), PMD_TYPE_TABLE);
+	__pud_populate(pudp, __pa(pmdp), PMD_TYPE_TABLE);
 }
 #else
-static inline void __pud_populate(pud_t *pud, phys_addr_t pmd, pudval_t prot)
+static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 {
 	BUILD_BUG();
 }
@@ -65,30 +65,30 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 	return (pud_t *)__get_free_page(PGALLOC_GFP);
 }
 
-static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
 {
-	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	free_page((unsigned long)pud);
+	BUG_ON((unsigned long)pudp & (PAGE_SIZE-1));
+	free_page((unsigned long)pudp);
 }
 
-static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pud, pgdval_t prot)
+static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 {
-	set_pgd(pgdp, __pgd(__phys_to_pgd_val(pud) | prot));
+	set_pgd(pgdp, __pgd(__phys_to_pgd_val(pudp) | prot));
 }
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, pud_t *pudp)
 {
-	__pgd_populate(pgd, __pa(pud), PUD_TYPE_TABLE);
+	__pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
 }
 #else
-static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pud, pgdval_t prot)
+static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 {
 	BUILD_BUG();
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
-extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
+extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
 
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
@@ -114,10 +114,10 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 /*
  * Free a PTE table.
  */
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *ptep)
 {
-	if (pte)
-		free_page((unsigned long)pte);
+	if (ptep)
+		free_page((unsigned long)ptep);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
@@ -126,10 +126,10 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 	__free_page(pte);
 }
 
-static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
+static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
 				  pmdval_t prot)
 {
-	set_pmd(pmdp, __pmd(__phys_to_pmd_val(pte) | prot));
+	set_pmd(pmdp, __pmd(__phys_to_pmd_val(ptep) | prot));
 }
 
 /*
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 094374c82db0..7e2c27e63cd8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -218,7 +218,7 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	*ptep = pte;
+	WRITE_ONCE(*ptep, pte);
 
 	/*
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
@@ -250,6 +250,8 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
+	pte_t old_pte;
+
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte, addr);
 
@@ -258,14 +260,15 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * hardware updates of the pte (ptep_set_access_flags safely changes
 	 * valid ptes without going through an invalid entry).
 	 */
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(*ptep) && pte_valid(pte) &&
+	old_pte = READ_ONCE(*ptep);
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
 	   (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
 		VM_WARN_ONCE(!pte_young(pte),
 			     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
-			     __func__, pte_val(*ptep), pte_val(pte));
-		VM_WARN_ONCE(pte_write(*ptep) && !pte_dirty(pte),
+			     __func__, pte_val(old_pte), pte_val(pte));
+		VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
 			     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
-			     __func__, pte_val(*ptep), pte_val(pte));
+			     __func__, pte_val(old_pte), pte_val(pte));
 	}
 
 	set_pte(ptep, pte);
@@ -431,7 +434,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	WRITE_ONCE(*pmdp, pmd);
 	dsb(ishst);
 	isb();
 }
@@ -482,7 +485,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp = pud;
+	WRITE_ONCE(*pudp, pud);
 	dsb(ishst);
 	isb();
 }
@@ -500,7 +503,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 /* Find an entry in the second-level page table. */
 #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 
-#define pmd_offset_phys(dir, addr)	(pud_page_paddr(*(dir)) + pmd_index(addr) * sizeof(pmd_t))
+#define pmd_offset_phys(dir, addr)	(pud_page_paddr(READ_ONCE(*(dir))) + pmd_index(addr) * sizeof(pmd_t))
 #define pmd_offset(dir, addr)		((pmd_t *)__va(pmd_offset_phys((dir), (addr))))
 
 #define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
@@ -535,7 +538,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = pgd;
+	WRITE_ONCE(*pgdp, pgd);
 	dsb(ishst);
 }
 
@@ -552,7 +555,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 /* Find an entry in the frst-level page table. */
 #define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 
-#define pud_offset_phys(dir, addr)	(pgd_page_paddr(*(dir)) + pud_index(addr) * sizeof(pud_t))
+#define pud_offset_phys(dir, addr)	(pgd_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
 #define pud_offset(dir, addr)		((pud_t *)__va(pud_offset_phys((dir), (addr))))
 
 #define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index f85ac58d08a3..a8bf1c892b90 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -90,7 +90,7 @@ static int __init set_permissions(pte_t *ptep, pgtable_t token,
 				  unsigned long addr, void *data)
 {
 	efi_memory_desc_t *md = data;
-	pte_t pte = *ptep;
+	pte_t pte = READ_ONCE(*ptep);
 
 	if (md->attribute & EFI_MEMORY_RO)
 		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index f20cf7e99249..1ec5f28c39fc 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -202,10 +202,10 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 gfp_t mask)
 {
 	int rc = 0;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
 	unsigned long dst = (unsigned long)allocator(mask);
 
 	if (!dst) {
@@ -216,38 +216,38 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	flush_icache_range(dst, dst + length);
 
-	pgd = pgd_offset_raw(allocator(mask), dst_addr);
-	if (pgd_none(*pgd)) {
-		pud = allocator(mask);
-		if (!pud) {
+	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
+	if (pgd_none(READ_ONCE(*pgdp))) {
+		pudp = allocator(mask);
+		if (!pudp) {
 			rc = -ENOMEM;
 			goto out;
 		}
-		pgd_populate(&init_mm, pgd, pud);
+		pgd_populate(&init_mm, pgdp, pudp);
 	}
 
-	pud = pud_offset(pgd, dst_addr);
-	if (pud_none(*pud)) {
-		pmd = allocator(mask);
-		if (!pmd) {
+	pudp = pud_offset(pgdp, dst_addr);
+	if (pud_none(READ_ONCE(*pudp))) {
+		pmdp = allocator(mask);
+		if (!pmdp) {
 			rc = -ENOMEM;
 			goto out;
 		}
-		pud_populate(&init_mm, pud, pmd);
+		pud_populate(&init_mm, pudp, pmdp);
 	}
 
-	pmd = pmd_offset(pud, dst_addr);
-	if (pmd_none(*pmd)) {
-		pte = allocator(mask);
-		if (!pte) {
+	pmdp = pmd_offset(pudp, dst_addr);
+	if (pmd_none(READ_ONCE(*pmdp))) {
+		ptep = allocator(mask);
+		if (!ptep) {
 			rc = -ENOMEM;
 			goto out;
 		}
-		pmd_populate_kernel(&init_mm, pmd, pte);
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
-	pte = pte_offset_kernel(pmd, dst_addr);
-	set_pte(pte, pfn_pte(virt_to_pfn(dst), PAGE_KERNEL_EXEC));
+	ptep = pte_offset_kernel(pmdp, dst_addr);
+	set_pte(ptep, pfn_pte(virt_to_pfn(dst), PAGE_KERNEL_EXEC));
 
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
@@ -263,7 +263,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(pgd)), ttbr0_el1);
+	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
@@ -320,9 +320,9 @@ int swsusp_arch_suspend(void)
 	return ret;
 }
 
-static void _copy_pte(pte_t *dst_pte, pte_t *src_pte, unsigned long addr)
+static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
-	pte_t pte = *src_pte;
+	pte_t pte = READ_ONCE(*src_ptep);
 
 	if (pte_valid(pte)) {
 		/*
@@ -330,7 +330,7 @@ static void _copy_pte(pte_t *dst_pte, pte_t *src_pte, unsigned long addr)
 		 * read only (code, rodata). Clear the RDONLY bit from
 		 * the temporary mappings we use during restore.
 		 */
-		set_pte(dst_pte, pte_mkwrite(pte));
+		set_pte(dst_ptep, pte_mkwrite(pte));
 	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
@@ -343,112 +343,116 @@ static void _copy_pte(pte_t *dst_pte, pte_t *src_pte, unsigned long addr)
 		 */
 		BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-		set_pte(dst_pte, pte_mkpresent(pte_mkwrite(pte)));
+		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite(pte)));
 	}
 }
 
-static int copy_pte(pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long start,
+static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
 		    unsigned long end)
 {
-	pte_t *src_pte;
-	pte_t *dst_pte;
+	pte_t *src_ptep;
+	pte_t *dst_ptep;
 	unsigned long addr = start;
 
-	dst_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
-	if (!dst_pte)
+	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
+	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmd, dst_pte);
-	dst_pte = pte_offset_kernel(dst_pmd, start);
+	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
+	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
-	src_pte = pte_offset_kernel(src_pmd, start);
+	src_ptep = pte_offset_kernel(src_pmdp, start);
 	do {
-		_copy_pte(dst_pte, src_pte, addr);
-	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+		_copy_pte(dst_ptep, src_ptep, addr);
+	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
 
 	return 0;
 }
 
-static int copy_pmd(pud_t *dst_pud, pud_t *src_pud, unsigned long start,
+static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 		    unsigned long end)
 {
-	pmd_t *src_pmd;
-	pmd_t *dst_pmd;
+	pmd_t *src_pmdp;
+	pmd_t *dst_pmdp;
 	unsigned long next;
 	unsigned long addr = start;
 
-	if (pud_none(*dst_pud)) {
-		dst_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
-		if (!dst_pmd)
+	if (pud_none(READ_ONCE(*dst_pudp))) {
+		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
+		if (!dst_pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, dst_pud, dst_pmd);
+		pud_populate(&init_mm, dst_pudp, dst_pmdp);
 	}
-	dst_pmd = pmd_offset(dst_pud, start);
+	dst_pmdp = pmd_offset(dst_pudp, start);
 
-	src_pmd = pmd_offset(src_pud, start);
+	src_pmdp = pmd_offset(src_pudp, start);
 	do {
+		pmd_t pmd = READ_ONCE(*src_pmdp);
+
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*src_pmd))
+		if (pmd_none(pmd))
 			continue;
-		if (pmd_table(*src_pmd)) {
-			if (copy_pte(dst_pmd, src_pmd, addr, next))
+		if (pmd_table(pmd)) {
+			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
 				return -ENOMEM;
 		} else {
-			set_pmd(dst_pmd,
-				__pmd(pmd_val(*src_pmd) & ~PMD_SECT_RDONLY));
+			set_pmd(dst_pmdp,
+				__pmd(pmd_val(pmd) & ~PMD_SECT_RDONLY));
 		}
-	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
+	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
 
 	return 0;
 }
 
-static int copy_pud(pgd_t *dst_pgd, pgd_t *src_pgd, unsigned long start,
+static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 		    unsigned long end)
 {
-	pud_t *dst_pud;
-	pud_t *src_pud;
+	pud_t *dst_pudp;
+	pud_t *src_pudp;
 	unsigned long next;
 	unsigned long addr = start;
 
-	if (pgd_none(*dst_pgd)) {
-		dst_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
-		if (!dst_pud)
+	if (pgd_none(READ_ONCE(*dst_pgdp))) {
+		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
+		if (!dst_pudp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, dst_pgd, dst_pud);
+		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
 	}
-	dst_pud = pud_offset(dst_pgd, start);
+	dst_pudp = pud_offset(dst_pgdp, start);
 
-	src_pud = pud_offset(src_pgd, start);
+	src_pudp = pud_offset(src_pgdp, start);
 	do {
+		pud_t pud = READ_ONCE(*src_pudp);
+
 		next = pud_addr_end(addr, end);
-		if (pud_none(*src_pud))
+		if (pud_none(pud))
 			continue;
-		if (pud_table(*(src_pud))) {
-			if (copy_pmd(dst_pud, src_pud, addr, next))
+		if (pud_table(pud)) {
+			if (copy_pmd(dst_pudp, src_pudp, addr, next))
 				return -ENOMEM;
 		} else {
-			set_pud(dst_pud,
-				__pud(pud_val(*src_pud) & ~PMD_SECT_RDONLY));
+			set_pud(dst_pudp,
+				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
 		}
-	} while (dst_pud++, src_pud++, addr = next, addr != end);
+	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
 	return 0;
 }
 
-static int copy_page_tables(pgd_t *dst_pgd, unsigned long start,
+static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 			    unsigned long end)
 {
 	unsigned long next;
 	unsigned long addr = start;
-	pgd_t *src_pgd = pgd_offset_k(start);
+	pgd_t *src_pgdp = pgd_offset_k(start);
 
-	dst_pgd = pgd_offset_raw(dst_pgd, start);
+	dst_pgdp = pgd_offset_raw(dst_pgdp, start);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_none(*src_pgd))
+		if (pgd_none(READ_ONCE(*src_pgdp)))
 			continue;
-		if (copy_pud(dst_pgd, src_pgd, addr, next))
+		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
 			return -ENOMEM;
-	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
 
 	return 0;
 }
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 7b60d62ac593..65dfc8571bf8 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -286,48 +286,52 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 
 }
 
-static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
+static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start)
 {
-	pte_t *pte = pte_offset_kernel(pmd, 0UL);
+	pte_t *ptep = pte_offset_kernel(pmdp, 0UL);
 	unsigned long addr;
 	unsigned i;
 
-	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
+	for (i = 0; i < PTRS_PER_PTE; i++, ptep++) {
 		addr = start + i * PAGE_SIZE;
-		note_page(st, addr, 4, pte_val(*pte));
+		note_page(st, addr, 4, READ_ONCE(pte_val(*ptep)));
 	}
 }
 
-static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
+static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start)
 {
-	pmd_t *pmd = pmd_offset(pud, 0UL);
+	pmd_t *pmdp = pmd_offset(pudp, 0UL);
 	unsigned long addr;
 	unsigned i;
 
-	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
+	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
+		pmd_t pmd = READ_ONCE(*pmdp);
+
 		addr = start + i * PMD_SIZE;
-		if (pmd_none(*pmd) || pmd_sect(*pmd)) {
-			note_page(st, addr, 3, pmd_val(*pmd));
+		if (pmd_none(pmd) || pmd_sect(pmd)) {
+			note_page(st, addr, 3, pmd_val(pmd));
 		} else {
-			BUG_ON(pmd_bad(*pmd));
-			walk_pte(st, pmd, addr);
+			BUG_ON(pmd_bad(pmd));
+			walk_pte(st, pmdp, addr);
 		}
 	}
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
+static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start)
 {
-	pud_t *pud = pud_offset(pgd, 0UL);
+	pud_t *pudp = pud_offset(pgdp, 0UL);
 	unsigned long addr;
 	unsigned i;
 
-	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
+	for (i = 0; i < PTRS_PER_PUD; i++, pudp++) {
+		pud_t pud = READ_ONCE(*pudp);
+
 		addr = start + i * PUD_SIZE;
-		if (pud_none(*pud) || pud_sect(*pud)) {
-			note_page(st, addr, 2, pud_val(*pud));
+		if (pud_none(pud) || pud_sect(pud)) {
+			note_page(st, addr, 2, pud_val(pud));
 		} else {
-			BUG_ON(pud_bad(*pud));
-			walk_pmd(st, pud, addr);
+			BUG_ON(pud_bad(pud));
+			walk_pmd(st, pudp, addr);
 		}
 	}
 }
@@ -335,17 +339,19 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
 		     unsigned long start)
 {
-	pgd_t *pgd = pgd_offset(mm, 0UL);
+	pgd_t *pgdp = pgd_offset(mm, 0UL);
 	unsigned i;
 	unsigned long addr;
 
-	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
+	for (i = 0; i < PTRS_PER_PGD; i++, pgdp++) {
+		pgd_t pgd = READ_ONCE(*pgdp);
+
 		addr = start + i * PGDIR_SIZE;
-		if (pgd_none(*pgd)) {
-			note_page(st, addr, 1, pgd_val(*pgd));
+		if (pgd_none(pgd)) {
+			note_page(st, addr, 1, pgd_val(pgd));
 		} else {
-			BUG_ON(pgd_bad(*pgd));
-			walk_pud(st, pgd, addr);
+			BUG_ON(pgd_bad(pgd));
+			walk_pud(st, pgdp, addr);
 		}
 	}
 }
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f76bb2c3c943..bff11553eb05 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -130,7 +130,8 @@ static void mem_abort_decode(unsigned int esr)
 void show_pte(unsigned long addr)
 {
 	struct mm_struct *mm;
-	pgd_t *pgd;
+	pgd_t *pgdp;
+	pgd_t pgd;
 
 	if (addr < TASK_SIZE) {
 		/* TTBR0 */
@@ -149,33 +150,37 @@ void show_pte(unsigned long addr)
 		return;
 	}
 
-	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgd = %p\n",
+	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp = %p\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
 		 VA_BITS, mm->pgd);
-	pgd = pgd_offset(mm, addr);
-	pr_alert("[%016lx] *pgd=%016llx", addr, pgd_val(*pgd));
+	pgdp = pgd_offset(mm, addr);
+	pgd = READ_ONCE(*pgdp);
+	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
 
 	do {
-		pud_t *pud;
-		pmd_t *pmd;
-		pte_t *pte;
+		pud_t *pudp, pud;
+		pmd_t *pmdp, pmd;
+		pte_t *ptep, pte;
 
-		if (pgd_none(*pgd) || pgd_bad(*pgd))
+		if (pgd_none(pgd) || pgd_bad(pgd))
 			break;
 
-		pud = pud_offset(pgd, addr);
-		pr_cont(", *pud=%016llx", pud_val(*pud));
-		if (pud_none(*pud) || pud_bad(*pud))
+		pudp = pud_offset(pgdp, addr);
+		pud = READ_ONCE(*pudp);
+		pr_cont(", pud=%016llx", pud_val(pud));
+		if (pud_none(pud) || pud_bad(pud))
 			break;
 
-		pmd = pmd_offset(pud, addr);
-		pr_cont(", *pmd=%016llx", pmd_val(*pmd));
-		if (pmd_none(*pmd) || pmd_bad(*pmd))
+		pmdp = pmd_offset(pudp, addr);
+		pmd = READ_ONCE(*pmdp);
+		pr_cont(", pmd=%016llx", pmd_val(pmd));
+		if (pmd_none(pmd) || pmd_bad(pmd))
 			break;
 
-		pte = pte_offset_map(pmd, addr);
-		pr_cont(", *pte=%016llx", pte_val(*pte));
-		pte_unmap(pte);
+		ptep = pte_offset_map(pmdp, addr);
+		pte = READ_ONCE(*ptep);
+		pr_cont(", pte=%016llx", pte_val(pte));
+		pte_unmap(ptep);
 	} while(0);
 
 	pr_cont("\n");
@@ -196,8 +201,9 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  pte_t entry, int dirty)
 {
 	pteval_t old_pteval, pteval;
+	pte_t pte = READ_ONCE(*ptep);
 
-	if (pte_same(*ptep, entry))
+	if (pte_same(pte, entry))
 		return 0;
 
 	/* only preserve the access flags and write permission */
@@ -210,7 +216,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	 * (calculated as: a & b == ~(~a | ~b)).
 	 */
 	pte_val(entry) ^= PTE_RDONLY;
-	pteval = READ_ONCE(pte_val(*ptep));
+	pteval = pte_val(pte);
 	do {
 		old_pteval = pteval;
 		pteval ^= PTE_RDONLY;
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6cb0fa92a651..ecc6818191df 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -54,14 +54,14 @@ static inline pgprot_t pte_pgprot(pte_t pte)
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, size_t *pgsize)
 {
-	pgd_t *pgd = pgd_offset(mm, addr);
-	pud_t *pud;
-	pmd_t *pmd;
+	pgd_t *pgdp = pgd_offset(mm, addr);
+	pud_t *pudp;
+	pmd_t *pmdp;
 
 	*pgsize = PAGE_SIZE;
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	if ((pte_t *)pmd == ptep) {
+	pudp = pud_offset(pgdp, addr);
+	pmdp = pmd_offset(pudp, addr);
+	if ((pte_t *)pmdp == ptep) {
 		*pgsize = PMD_SIZE;
 		return CONT_PMDS;
 	}
@@ -181,11 +181,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	clear_flush(mm, addr, ptep, pgsize, ncontig);
 
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn) {
-		pr_debug("%s: set pte %p to 0x%llx\n", __func__, ptep,
-			 pte_val(pfn_pte(pfn, hugeprot)));
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
 		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
-	}
 }
 
 void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
@@ -203,20 +200,20 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      unsigned long addr, unsigned long sz)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pte_t *pte = NULL;
-
-	pr_debug("%s: addr:0x%lx sz:0x%lx\n", __func__, addr, sz);
-	pgd = pgd_offset(mm, addr);
-	pud = pud_alloc(mm, pgd, addr);
-	if (!pud)
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep = NULL;
+
+	pgdp = pgd_offset(mm, addr);
+	pudp = pud_alloc(mm, pgdp, addr);
+	if (!pudp)
 		return NULL;
 
 	if (sz == PUD_SIZE) {
-		pte = (pte_t *)pud;
+		ptep = (pte_t *)pudp;
 	} else if (sz == (PAGE_SIZE * CONT_PTES)) {
-		pmd_t *pmd = pmd_alloc(mm, pud, addr);
+		pmdp = pmd_alloc(mm, pudp, addr);
 
 		WARN_ON(addr & (sz - 1));
 		/*
@@ -226,60 +223,55 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		 * will be no pte_unmap() to correspond with this
 		 * pte_alloc_map().
 		 */
-		pte = pte_alloc_map(mm, pmd, addr);
+		ptep = pte_alloc_map(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
 		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
-		    pud_none(*pud))
-			pte = huge_pmd_share(mm, addr, pud);
+		    pud_none(READ_ONCE(*pudp)))
+			ptep = huge_pmd_share(mm, addr, pudp);
 		else
-			pte = (pte_t *)pmd_alloc(mm, pud, addr);
+			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
 	} else if (sz == (PMD_SIZE * CONT_PMDS)) {
-		pmd_t *pmd;
-
-		pmd = pmd_alloc(mm, pud, addr);
+		pmdp = pmd_alloc(mm, pudp, addr);
 		WARN_ON(addr & (sz - 1));
-		return (pte_t *)pmd;
+		return (pte_t *)pmdp;
 	}
 
-	pr_debug("%s: addr:0x%lx sz:0x%lx ret pte=%p/0x%llx\n", __func__, addr,
-	       sz, pte, pte_val(*pte));
-	return pte;
+	return ptep;
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
+	pgd_t *pgdp;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
 
-	pgd = pgd_offset(mm, addr);
-	pr_debug("%s: addr:0x%lx pgd:%p\n", __func__, addr, pgd);
-	if (!pgd_present(*pgd))
+	pgdp = pgd_offset(mm, addr);
+	if (!pgd_present(READ_ONCE(*pgdp)))
 		return NULL;
 
-	pud = pud_offset(pgd, addr);
-	if (sz != PUD_SIZE && pud_none(*pud))
+	pudp = pud_offset(pgdp, addr);
+	pud = READ_ONCE(*pudp);
+	if (sz != PUD_SIZE && pud_none(pud))
 		return NULL;
 	/* hugepage or swap? */
-	if (pud_huge(*pud) || !pud_present(*pud))
-		return (pte_t *)pud;
+	if (pud_huge(pud) || !pud_present(pud))
+		return (pte_t *)pudp;
 	/* table; check the next level */
 
 	if (sz == CONT_PMD_SIZE)
 		addr &= CONT_PMD_MASK;
 
-	pmd = pmd_offset(pud, addr);
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
 	if (!(sz == PMD_SIZE || sz == CONT_PMD_SIZE) &&
-	    pmd_none(*pmd))
+	    pmd_none(pmd))
 		return NULL;
-	if (pmd_huge(*pmd) || !pmd_present(*pmd))
-		return (pte_t *)pmd;
+	if (pmd_huge(pmd) || !pmd_present(pmd))
+		return (pte_t *)pmdp;
 
-	if (sz == CONT_PTE_SIZE) {
-		pte_t *pte = pte_offset_kernel(pmd, (addr & CONT_PTE_MASK));
-		return pte;
-	}
+	if (sz == CONT_PTE_SIZE)
+		return pte_offset_kernel(pmdp, (addr & CONT_PTE_MASK));
 
 	return NULL;
 }
@@ -367,7 +359,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	size_t pgsize;
 	pte_t pte;
 
-	if (!pte_cont(*ptep)) {
+	if (!pte_cont(READ_ONCE(*ptep))) {
 		ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
@@ -391,7 +383,7 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
 	size_t pgsize;
 	int ncontig;
 
-	if (!pte_cont(*ptep)) {
+	if (!pte_cont(READ_ONCE(*ptep))) {
 		ptep_clear_flush(vma, addr, ptep);
 		return;
 	}
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 6e02e6fb4c7b..dabfc1ecda3d 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -44,92 +44,92 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
 	return __pa(p);
 }
 
-static pte_t *__init kasan_pte_offset(pmd_t *pmd, unsigned long addr, int node,
+static pte_t *__init kasan_pte_offset(pmd_t *pmdp, unsigned long addr, int node,
 				      bool early)
 {
-	if (pmd_none(*pmd)) {
+	if (pmd_none(READ_ONCE(*pmdp))) {
 		phys_addr_t pte_phys = early ? __pa_symbol(kasan_zero_pte)
 					     : kasan_alloc_zeroed_page(node);
-		__pmd_populate(pmd, pte_phys, PMD_TYPE_TABLE);
+		__pmd_populate(pmdp, pte_phys, PMD_TYPE_TABLE);
 	}
 
-	return early ? pte_offset_kimg(pmd, addr)
-		     : pte_offset_kernel(pmd, addr);
+	return early ? pte_offset_kimg(pmdp, addr)
+		     : pte_offset_kernel(pmdp, addr);
 }
 
-static pmd_t *__init kasan_pmd_offset(pud_t *pud, unsigned long addr, int node,
+static pmd_t *__init kasan_pmd_offset(pud_t *pudp, unsigned long addr, int node,
 				      bool early)
 {
-	if (pud_none(*pud)) {
+	if (pud_none(READ_ONCE(*pudp))) {
 		phys_addr_t pmd_phys = early ? __pa_symbol(kasan_zero_pmd)
 					     : kasan_alloc_zeroed_page(node);
-		__pud_populate(pud, pmd_phys, PMD_TYPE_TABLE);
+		__pud_populate(pudp, pmd_phys, PMD_TYPE_TABLE);
 	}
 
-	return early ? pmd_offset_kimg(pud, addr) : pmd_offset(pud, addr);
+	return early ? pmd_offset_kimg(pudp, addr) : pmd_offset(pudp, addr);
 }
 
-static pud_t *__init kasan_pud_offset(pgd_t *pgd, unsigned long addr, int node,
+static pud_t *__init kasan_pud_offset(pgd_t *pgdp, unsigned long addr, int node,
 				      bool early)
 {
-	if (pgd_none(*pgd)) {
+	if (pgd_none(READ_ONCE(*pgdp))) {
 		phys_addr_t pud_phys = early ? __pa_symbol(kasan_zero_pud)
 					     : kasan_alloc_zeroed_page(node);
-		__pgd_populate(pgd, pud_phys, PMD_TYPE_TABLE);
+		__pgd_populate(pgdp, pud_phys, PMD_TYPE_TABLE);
 	}
 
-	return early ? pud_offset_kimg(pgd, addr) : pud_offset(pgd, addr);
+	return early ? pud_offset_kimg(pgdp, addr) : pud_offset(pgdp, addr);
 }
 
-static void __init kasan_pte_populate(pmd_t *pmd, unsigned long addr,
+static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 				      unsigned long end, int node, bool early)
 {
 	unsigned long next;
-	pte_t *pte = kasan_pte_offset(pmd, addr, node, early);
+	pte_t *ptep = kasan_pte_offset(pmdp, addr, node, early);
 
 	do {
 		phys_addr_t page_phys = early ? __pa_symbol(kasan_zero_page)
 					      : kasan_alloc_zeroed_page(node);
 		next = addr + PAGE_SIZE;
-		set_pte(pte, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
-	} while (pte++, addr = next, addr != end && pte_none(*pte));
+		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
+	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
 }
 
-static void __init kasan_pmd_populate(pud_t *pud, unsigned long addr,
+static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
 				      unsigned long end, int node, bool early)
 {
 	unsigned long next;
-	pmd_t *pmd = kasan_pmd_offset(pud, addr, node, early);
+	pmd_t *pmdp = kasan_pmd_offset(pudp, addr, node, early);
 
 	do {
 		next = pmd_addr_end(addr, end);
-		kasan_pte_populate(pmd, addr, next, node, early);
-	} while (pmd++, addr = next, addr != end && pmd_none(*pmd));
+		kasan_pte_populate(pmdp, addr, next, node, early);
+	} while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)));
 }
 
-static void __init kasan_pud_populate(pgd_t *pgd, unsigned long addr,
+static void __init kasan_pud_populate(pgd_t *pgdp, unsigned long addr,
 				      unsigned long end, int node, bool early)
 {
 	unsigned long next;
-	pud_t *pud = kasan_pud_offset(pgd, addr, node, early);
+	pud_t *pudp = kasan_pud_offset(pgdp, addr, node, early);
 
 	do {
 		next = pud_addr_end(addr, end);
-		kasan_pmd_populate(pud, addr, next, node, early);
-	} while (pud++, addr = next, addr != end && pud_none(*pud));
+		kasan_pmd_populate(pudp, addr, next, node, early);
+	} while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)));
 }
 
 static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 				      int node, bool early)
 {
 	unsigned long next;
-	pgd_t *pgd;
+	pgd_t *pgdp;
 
-	pgd = pgd_offset_k(addr);
+	pgdp = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		kasan_pud_populate(pgd, addr, next, node, early);
-	} while (pgd++, addr = next, addr != end);
+		kasan_pud_populate(pgdp, addr, next, node, early);
+	} while (pgdp++, addr = next, addr != end);
 }
 
 /* The early shadow maps everything to a single page of zeroes */
@@ -155,14 +155,14 @@ static void __init kasan_map_populate(unsigned long start, unsigned long end,
  */
 void __init kasan_copy_shadow(pgd_t *pgdir)
 {
-	pgd_t *pgd, *pgd_new, *pgd_end;
+	pgd_t *pgdp, *pgdp_new, *pgdp_end;
 
-	pgd = pgd_offset_k(KASAN_SHADOW_START);
-	pgd_end = pgd_offset_k(KASAN_SHADOW_END);
-	pgd_new = pgd_offset_raw(pgdir, KASAN_SHADOW_START);
+	pgdp = pgd_offset_k(KASAN_SHADOW_START);
+	pgdp_end = pgd_offset_k(KASAN_SHADOW_END);
+	pgdp_new = pgd_offset_raw(pgdir, KASAN_SHADOW_START);
 	do {
-		set_pgd(pgd_new, *pgd);
-	} while (pgd++, pgd_new++, pgd != pgd_end);
+		set_pgd(pgdp_new, READ_ONCE(*pgdp));
+	} while (pgdp++, pgdp_new++, pgdp != pgdp_end);
 }
 
 static void __init clear_pgds(unsigned long start,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4694cda823c9..3161b853f29e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -125,45 +125,48 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	return ((old ^ new) & ~mask) == 0;
 }
 
-static void init_pte(pmd_t *pmd, unsigned long addr, unsigned long end,
+static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
-	pte_t *pte;
+	pte_t *ptep;
 
-	pte = pte_set_fixmap_offset(pmd, addr);
+	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
-		pte_t old_pte = *pte;
+		pte_t old_pte = READ_ONCE(*ptep);
 
-		set_pte(pte, pfn_pte(__phys_to_pfn(phys), prot));
+		set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
 
 		/*
 		 * After the PTE entry has been populated once, we
 		 * only allow updates to the permission attributes.
 		 */
-		BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(*pte)));
+		BUG_ON(!pgattr_change_is_safe(pte_val(old_pte),
+					      READ_ONCE(pte_val(*ptep))));
 
 		phys += PAGE_SIZE;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
 
 	pte_clear_fixmap();
 }
 
-static void alloc_init_cont_pte(pmd_t *pmd, unsigned long addr,
+static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
 				phys_addr_t (*pgtable_alloc)(void),
 				int flags)
 {
 	unsigned long next;
+	pmd_t pmd = READ_ONCE(*pmdp);
 
-	BUG_ON(pmd_sect(*pmd));
-	if (pmd_none(*pmd)) {
+	BUG_ON(pmd_sect(pmd));
+	if (pmd_none(pmd)) {
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc();
-		__pmd_populate(pmd, pte_phys, PMD_TYPE_TABLE);
+		__pmd_populate(pmdp, pte_phys, PMD_TYPE_TABLE);
+		pmd = READ_ONCE(*pmdp);
 	}
-	BUG_ON(pmd_bad(*pmd));
+	BUG_ON(pmd_bad(pmd));
 
 	do {
 		pgprot_t __prot = prot;
@@ -175,67 +178,69 @@ static void alloc_init_cont_pte(pmd_t *pmd, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pte(pmd, addr, next, phys, __prot);
+		init_pte(pmdp, addr, next, phys, __prot);
 
 		phys += next - addr;
 	} while (addr = next, addr != end);
 }
 
-static void init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
+static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
 		     phys_addr_t (*pgtable_alloc)(void), int flags)
 {
 	unsigned long next;
-	pmd_t *pmd;
+	pmd_t *pmdp;
 
-	pmd = pmd_set_fixmap_offset(pud, addr);
+	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
-		pmd_t old_pmd = *pmd;
+		pmd_t old_pmd = READ_ONCE(*pmdp);
 
 		next = pmd_addr_end(addr, end);
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pmd_set_huge(pmd, phys, prot);
+			pmd_set_huge(pmdp, phys, prot);
 
 			/*
 			 * After the PMD entry has been populated once, we
 			 * only allow updates to the permission attributes.
 			 */
 			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
-						      pmd_val(*pmd)));
+						      READ_ONCE(pmd_val(*pmdp))));
 		} else {
-			alloc_init_cont_pte(pmd, addr, next, phys, prot,
+			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
 					    pgtable_alloc, flags);
 
 			BUG_ON(pmd_val(old_pmd) != 0 &&
-			       pmd_val(old_pmd) != pmd_val(*pmd));
+			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
 		}
 		phys += next - addr;
-	} while (pmd++, addr = next, addr != end);
+	} while (pmdp++, addr = next, addr != end);
 
 	pmd_clear_fixmap();
 }
 
-static void alloc_init_cont_pmd(pud_t *pud, unsigned long addr,
+static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
 				phys_addr_t (*pgtable_alloc)(void), int flags)
 {
 	unsigned long next;
+	pud_t pud = READ_ONCE(*pudp);
 
 	/*
 	 * Check for initial section mappings in the pgd/pud.
 	 */
-	BUG_ON(pud_sect(*pud));
-	if (pud_none(*pud)) {
+	BUG_ON(pud_sect(pud));
+	if (pud_none(pud)) {
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc();
-		__pud_populate(pud, pmd_phys, PUD_TYPE_TABLE);
+		__pud_populate(pudp, pmd_phys, PUD_TYPE_TABLE);
+		pud = READ_ONCE(*pudp);
 	}
-	BUG_ON(pud_bad(*pud));
+	BUG_ON(pud_bad(pud));
 
 	do {
 		pgprot_t __prot = prot;
@@ -247,7 +252,7 @@ static void alloc_init_cont_pmd(pud_t *pud, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pmd(pud, addr, next, phys, __prot, pgtable_alloc, flags);
+		init_pmd(pudp, addr, next, phys, __prot, pgtable_alloc, flags);
 
 		phys += next - addr;
 	} while (addr = next, addr != end);
@@ -265,25 +270,27 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 	return true;
 }
 
-static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot,
-				  phys_addr_t (*pgtable_alloc)(void),
-				  int flags)
+static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
+			   phys_addr_t phys, pgprot_t prot,
+			   phys_addr_t (*pgtable_alloc)(void),
+			   int flags)
 {
-	pud_t *pud;
 	unsigned long next;
+	pud_t *pudp;
+	pgd_t pgd = READ_ONCE(*pgdp);
 
-	if (pgd_none(*pgd)) {
+	if (pgd_none(pgd)) {
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc();
-		__pgd_populate(pgd, pud_phys, PUD_TYPE_TABLE);
+		__pgd_populate(pgdp, pud_phys, PUD_TYPE_TABLE);
+		pgd = READ_ONCE(*pgdp);
 	}
-	BUG_ON(pgd_bad(*pgd));
+	BUG_ON(pgd_bad(pgd));
 
-	pud = pud_set_fixmap_offset(pgd, addr);
+	pudp = pud_set_fixmap_offset(pgdp, addr);
 	do {
-		pud_t old_pud = *pud;
+		pud_t old_pud = READ_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
 
@@ -292,23 +299,23 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		 */
 		if (use_1G_block(addr, next, phys) &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pud_set_huge(pud, phys, prot);
+			pud_set_huge(pudp, phys, prot);
 
 			/*
 			 * After the PUD entry has been populated once, we
 			 * only allow updates to the permission attributes.
 			 */
 			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
-						      pud_val(*pud)));
+						      READ_ONCE(pud_val(*pudp))));
 		} else {
-			alloc_init_cont_pmd(pud, addr, next, phys, prot,
+			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
 					    pgtable_alloc, flags);
 
 			BUG_ON(pud_val(old_pud) != 0 &&
-			       pud_val(old_pud) != pud_val(*pud));
+			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
 		}
 		phys += next - addr;
-	} while (pud++, addr = next, addr != end);
+	} while (pudp++, addr = next, addr != end);
 
 	pud_clear_fixmap();
 }
@@ -320,7 +327,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 int flags)
 {
 	unsigned long addr, length, end, next;
-	pgd_t *pgd = pgd_offset_raw(pgdir, virt);
+	pgd_t *pgdp = pgd_offset_raw(pgdir, virt);
 
 	/*
 	 * If the virtual and physical address don't have the same offset
@@ -336,10 +343,10 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(pgd, addr, next, phys, prot, pgtable_alloc,
+		alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
 			       flags);
 		phys += next - addr;
-	} while (pgd++, addr = next, addr != end);
+	} while (pgdp++, addr = next, addr != end);
 }
 
 static phys_addr_t pgd_pgtable_alloc(void)
@@ -401,10 +408,10 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 	flush_tlb_kernel_range(virt, virt + size);
 }
 
-static void __init __map_memblock(pgd_t *pgd, phys_addr_t start,
+static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 				  phys_addr_t end, pgprot_t prot, int flags)
 {
-	__create_pgd_mapping(pgd, start, __phys_to_virt(start), end - start,
+	__create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
 			     prot, early_pgtable_alloc, flags);
 }
 
@@ -418,7 +425,7 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static void __init map_mem(pgd_t *pgd)
+static void __init map_mem(pgd_t *pgdp)
 {
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
@@ -451,7 +458,7 @@ static void __init map_mem(pgd_t *pgd)
 		if (memblock_is_nomap(reg))
 			continue;
 
-		__map_memblock(pgd, start, end, PAGE_KERNEL, flags);
+		__map_memblock(pgdp, start, end, PAGE_KERNEL, flags);
 	}
 
 	/*
@@ -464,7 +471,7 @@ static void __init map_mem(pgd_t *pgd)
 	 * Note that contiguous mappings cannot be remapped in this way,
 	 * so we should avoid them here.
 	 */
-	__map_memblock(pgd, kernel_start, kernel_end,
+	__map_memblock(pgdp, kernel_start, kernel_end,
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
@@ -475,7 +482,7 @@ static void __init map_mem(pgd_t *pgd)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 	if (crashk_res.end) {
-		__map_memblock(pgd, crashk_res.start, crashk_res.end + 1,
+		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
 			       PAGE_KERNEL,
 			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
 		memblock_clear_nomap(crashk_res.start,
@@ -499,7 +506,7 @@ void mark_rodata_ro(void)
 	debug_checkwx();
 }
 
-static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
+static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
 				      pgprot_t prot, struct vm_struct *vma,
 				      int flags, unsigned long vm_flags)
 {
@@ -509,7 +516,7 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
 	BUG_ON(!PAGE_ALIGNED(pa_start));
 	BUG_ON(!PAGE_ALIGNED(size));
 
-	__create_pgd_mapping(pgd, pa_start, (unsigned long)va_start, size, prot,
+	__create_pgd_mapping(pgdp, pa_start, (unsigned long)va_start, size, prot,
 			     early_pgtable_alloc, flags);
 
 	if (!(vm_flags & VM_NO_GUARD))
@@ -562,7 +569,7 @@ core_initcall(map_entry_trampoline);
 /*
  * Create fine-grained mappings for the kernel.
  */
-static void __init map_kernel(pgd_t *pgd)
+static void __init map_kernel(pgd_t *pgdp)
 {
 	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_inittext,
 				vmlinux_initdata, vmlinux_data;
@@ -578,24 +585,24 @@ static void __init map_kernel(pgd_t *pgd)
 	 * Only rodata will be remapped with different permissions later on,
 	 * all other segments are allowed to use contiguous mappings.
 	 */
-	map_kernel_segment(pgd, _text, _etext, text_prot, &vmlinux_text, 0,
+	map_kernel_segment(pgdp, _text, _etext, text_prot, &vmlinux_text, 0,
 			   VM_NO_GUARD);
-	map_kernel_segment(pgd, __start_rodata, __inittext_begin, PAGE_KERNEL,
+	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
 			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
-	map_kernel_segment(pgd, __inittext_begin, __inittext_end, text_prot,
+	map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
 			   &vmlinux_inittext, 0, VM_NO_GUARD);
-	map_kernel_segment(pgd, __initdata_begin, __initdata_end, PAGE_KERNEL,
+	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
 			   &vmlinux_initdata, 0, VM_NO_GUARD);
-	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
+	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
 
-	if (!pgd_val(*pgd_offset_raw(pgd, FIXADDR_START))) {
+	if (!READ_ONCE(pgd_val(*pgd_offset_raw(pgdp, FIXADDR_START)))) {
 		/*
 		 * The fixmap falls in a separate pgd to the kernel, and doesn't
 		 * live in the carveout for the swapper_pg_dir. We can simply
 		 * re-use the existing dir for the fixmap.
 		 */
-		set_pgd(pgd_offset_raw(pgd, FIXADDR_START),
-			*pgd_offset_k(FIXADDR_START));
+		set_pgd(pgd_offset_raw(pgdp, FIXADDR_START),
+			READ_ONCE(*pgd_offset_k(FIXADDR_START)));
 	} else if (CONFIG_PGTABLE_LEVELS > 3) {
 		/*
 		 * The fixmap shares its top level pgd entry with the kernel
@@ -604,14 +611,15 @@ static void __init map_kernel(pgd_t *pgd)
 		 * entry instead.
 		 */
 		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
-		pud_populate(&init_mm, pud_set_fixmap_offset(pgd, FIXADDR_START),
+		pud_populate(&init_mm,
+			     pud_set_fixmap_offset(pgdp, FIXADDR_START),
 			     lm_alias(bm_pmd));
 		pud_clear_fixmap();
 	} else {
 		BUG();
 	}
 
-	kasan_copy_shadow(pgd);
+	kasan_copy_shadow(pgdp);
 }
 
 /*
@@ -621,10 +629,10 @@ static void __init map_kernel(pgd_t *pgd)
 void __init paging_init(void)
 {
 	phys_addr_t pgd_phys = early_pgtable_alloc();
-	pgd_t *pgd = pgd_set_fixmap(pgd_phys);
+	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
 
-	map_kernel(pgd);
-	map_mem(pgd);
+	map_kernel(pgdp);
+	map_mem(pgdp);
 
 	/*
 	 * We want to reuse the original swapper_pg_dir so we don't have to
@@ -635,7 +643,7 @@ void __init paging_init(void)
 	 * To do this we need to go via a temporary pgd.
 	 */
 	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgd, PGD_SIZE);
+	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
 	pgd_clear_fixmap();
@@ -655,37 +663,40 @@ void __init paging_init(void)
  */
 int kern_addr_valid(unsigned long addr)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pgd_t *pgdp;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
 
 	if ((((long)addr) >> VA_BITS) != -1UL)
 		return 0;
 
-	pgd = pgd_offset_k(addr);
-	if (pgd_none(*pgd))
+	pgdp = pgd_offset_k(addr);
+	if (pgd_none(READ_ONCE(*pgdp)))
 		return 0;
 
-	pud = pud_offset(pgd, addr);
-	if (pud_none(*pud))
+	pudp = pud_offset(pgdp, addr);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
 		return 0;
 
-	if (pud_sect(*pud))
-		return pfn_valid(pud_pfn(*pud));
+	if (pud_sect(pud))
+		return pfn_valid(pud_pfn(pud));
 
-	pmd = pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (pmd_none(pmd))
 		return 0;
 
-	if (pmd_sect(*pmd))
-		return pfn_valid(pmd_pfn(*pmd));
+	if (pmd_sect(pmd))
+		return pfn_valid(pmd_pfn(pmd));
 
-	pte = pte_offset_kernel(pmd, addr);
-	if (pte_none(*pte))
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = READ_ONCE(*ptep);
+	if (pte_none(pte))
 		return 0;
 
-	return pfn_valid(pte_pfn(*pte));
+	return pfn_valid(pte_pfn(pte));
 }
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 #if !ARM64_SWAPPER_USES_SECTION_MAPS
@@ -700,32 +711,32 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	unsigned long addr = start;
 	unsigned long next;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
 
 	do {
 		next = pmd_addr_end(addr, end);
 
-		pgd = vmemmap_pgd_populate(addr, node);
-		if (!pgd)
+		pgdp = vmemmap_pgd_populate(addr, node);
+		if (!pgdp)
 			return -ENOMEM;
 
-		pud = vmemmap_pud_populate(pgd, addr, node);
-		if (!pud)
+		pudp = vmemmap_pud_populate(pgdp, addr, node);
+		if (!pudp)
 			return -ENOMEM;
 
-		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd)) {
+		pmdp = pmd_offset(pudp, addr);
+		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
 			if (!p)
 				return -ENOMEM;
 
-			pmd_set_huge(pmd, __pa(p), __pgprot(PROT_SECT_NORMAL));
+			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
 		} else
-			vmemmap_verify((pte_t *)pmd, node, addr, next);
+			vmemmap_verify((pte_t *)pmdp, node, addr, next);
 	} while (addr = next, addr != end);
 
 	return 0;
@@ -739,20 +750,22 @@ void vmemmap_free(unsigned long start, unsigned long end,
 
 static inline pud_t * fixmap_pud(unsigned long addr)
 {
-	pgd_t *pgd = pgd_offset_k(addr);
+	pgd_t *pgdp = pgd_offset_k(addr);
+	pgd_t pgd = READ_ONCE(*pgdp);
 
-	BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
+	BUG_ON(pgd_none(pgd) || pgd_bad(pgd));
 
-	return pud_offset_kimg(pgd, addr);
+	return pud_offset_kimg(pgdp, addr);
 }
 
 static inline pmd_t * fixmap_pmd(unsigned long addr)
 {
-	pud_t *pud = fixmap_pud(addr);
+	pud_t *pudp = fixmap_pud(addr);
+	pud_t pud = READ_ONCE(*pudp);
 
-	BUG_ON(pud_none(*pud) || pud_bad(*pud));
+	BUG_ON(pud_none(pud) || pud_bad(pud));
 
-	return pmd_offset_kimg(pud, addr);
+	return pmd_offset_kimg(pudp, addr);
 }
 
 static inline pte_t * fixmap_pte(unsigned long addr)
@@ -768,30 +781,31 @@ static inline pte_t * fixmap_pte(unsigned long addr)
  */
 void __init early_fixmap_init(void)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
+	pgd_t *pgdp, pgd;
+	pud_t *pudp;
+	pmd_t *pmdp;
 	unsigned long addr = FIXADDR_START;
 
-	pgd = pgd_offset_k(addr);
+	pgdp = pgd_offset_k(addr);
+	pgd = READ_ONCE(*pgdp);
 	if (CONFIG_PGTABLE_LEVELS > 3 &&
-	    !(pgd_none(*pgd) || pgd_page_paddr(*pgd) == __pa_symbol(bm_pud))) {
+	    !(pgd_none(pgd) || pgd_page_paddr(pgd) == __pa_symbol(bm_pud))) {
 		/*
 		 * We only end up here if the kernel mapping and the fixmap
 		 * share the top level pgd entry, which should only happen on
 		 * 16k/4 levels configurations.
 		 */
 		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
-		pud = pud_offset_kimg(pgd, addr);
+		pudp = pud_offset_kimg(pgdp, addr);
 	} else {
-		if (pgd_none(*pgd))
-			__pgd_populate(pgd, __pa_symbol(bm_pud), PUD_TYPE_TABLE);
-		pud = fixmap_pud(addr);
+		if (pgd_none(pgd))
+			__pgd_populate(pgdp, __pa_symbol(bm_pud), PUD_TYPE_TABLE);
+		pudp = fixmap_pud(addr);
 	}
-	if (pud_none(*pud))
-		__pud_populate(pud, __pa_symbol(bm_pmd), PMD_TYPE_TABLE);
-	pmd = fixmap_pmd(addr);
-	__pmd_populate(pmd, __pa_symbol(bm_pte), PMD_TYPE_TABLE);
+	if (pud_none(READ_ONCE(*pudp)))
+		__pud_populate(pudp, __pa_symbol(bm_pmd), PMD_TYPE_TABLE);
+	pmdp = fixmap_pmd(addr);
+	__pmd_populate(pmdp, __pa_symbol(bm_pte), PMD_TYPE_TABLE);
 
 	/*
 	 * The boot-ioremap range spans multiple pmds, for which
@@ -800,11 +814,11 @@ void __init early_fixmap_init(void)
 	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
 
-	if ((pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)))
-	     || pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_END))) {
+	if ((pmdp != fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)))
+	     || pmdp != fixmap_pmd(fix_to_virt(FIX_BTMAP_END))) {
 		WARN_ON(1);
-		pr_warn("pmd %p != %p, %p\n",
-			pmd, fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)),
+		pr_warn("pmdp %p != %p, %p\n",
+			pmdp, fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)),
 			fixmap_pmd(fix_to_virt(FIX_BTMAP_END)));
 		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
 			fix_to_virt(FIX_BTMAP_BEGIN));
@@ -824,16 +838,16 @@ void __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
 	unsigned long addr = __fix_to_virt(idx);
-	pte_t *pte;
+	pte_t *ptep;
 
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
-	pte = fixmap_pte(addr);
+	ptep = fixmap_pte(addr);
 
 	if (pgprot_val(flags)) {
-		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
+		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 	} else {
-		pte_clear(&init_mm, addr, pte);
+		pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
 }
@@ -915,36 +929,36 @@ int __init arch_ioremap_pmd_supported(void)
 	return 1;
 }
 
-int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
+int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pud, pfn_pud(__phys_to_pfn(phys), sect_prot));
+	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
-int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
+int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmd, pfn_pmd(__phys_to_pfn(phys), sect_prot));
+	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
-int pud_clear_huge(pud_t *pud)
+int pud_clear_huge(pud_t *pudp)
 {
-	if (!pud_sect(*pud))
+	if (!pud_sect(READ_ONCE(*pudp)))
 		return 0;
-	pud_clear(pud);
+	pud_clear(pudp);
 	return 1;
 }
 
-int pmd_clear_huge(pmd_t *pmd)
+int pmd_clear_huge(pmd_t *pmdp)
 {
-	if (!pmd_sect(*pmd))
+	if (!pmd_sect(READ_ONCE(*pmdp)))
 		return 0;
-	pmd_clear(pmd);
+	pmd_clear(pmdp);
 	return 1;
 }
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a682a0a2a0fa..a56359373d8b 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -29,7 +29,7 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
 			void *data)
 {
 	struct page_change_data *cdata = data;
-	pte_t pte = *ptep;
+	pte_t pte = READ_ONCE(*ptep);
 
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
@@ -156,30 +156,32 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
  */
 bool kernel_page_present(struct page *page)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pgd_t *pgdp;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep;
 	unsigned long addr = (unsigned long)page_address(page);
 
-	pgd = pgd_offset_k(addr);
-	if (pgd_none(*pgd))
+	pgdp = pgd_offset_k(addr);
+	if (pgd_none(READ_ONCE(*pgdp)))
 		return false;
 
-	pud = pud_offset(pgd, addr);
-	if (pud_none(*pud))
+	pudp = pud_offset(pgdp, addr);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
 		return false;
-	if (pud_sect(*pud))
+	if (pud_sect(pud))
 		return true;
 
-	pmd = pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (pmd_none(pmd))
 		return false;
-	if (pmd_sect(*pmd))
+	if (pmd_sect(pmd))
 		return true;
 
-	pte = pte_offset_kernel(pmd, addr);
-	return pte_valid(*pte);
+	ptep = pte_offset_kernel(pmdp, addr);
+	return pte_valid(READ_ONCE(*ptep));
 }
 #endif /* CONFIG_HIBERNATION */
 #endif /* CONFIG_DEBUG_PAGEALLOC */
-- 
2.1.4
