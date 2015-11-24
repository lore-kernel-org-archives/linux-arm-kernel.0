From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2015 17:48:58 +0000
Subject: [PATCH] arm64: mm: Prevent the initial page table setup from creating
 larger blocks
Message-ID: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the ARM ARM is not entirely clear, over the years we have assumed
that we can split a large block entry (pmd/pud) into smaller blocks
pointing to the same physical address with little risk of a TLB
conflict. However, remapping a smaller blocks range as a large one (e.g.
from page to sections or to contiguous pages) implies a high risk of TLB
conflict. Excessive TLB flushing would make the window smaller but it
would not remove the issue.

This patch prevents the larger block mappings at all levels _if_ the
existing pud/pmd entry is present _and_ not already a block mapping.
Contiguous ptes are rejected if any of the entries in the range are
non-empty and non-contiguous.

In addition, TLB flushing is added for the cases where an existing block
entry is changed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---

Hi,

We know the page table setup in Linux is currently broken (with or
without contiguous PTEs support, though this makes it more visible). The
architects imply that the risk of TLB conflict is *much* smaller when
going from large to smaller blocks, to the point that it may even be
stated thus in the ARM ARM. In the meantime, this patch is aimed to get
the kernel workin on the old assumption for the 4.4 kernel (potentially
backporting it to earlier kernels for the pud/pmd mappings) until Mark R
has a proper fix for 4.5.

Thanks.

 arch/arm64/mm/mmu.c | 65 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e379fe9f764c..cddd3536ff64 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -126,6 +126,19 @@ static void split_pmd(pmd_t *pmd, pte_t *pte)
 	} while (pte++, i++, i < PTRS_PER_PTE);
 }
 
+static bool __pte_range_none_or_cont(pte_t *pte)
+{
+	int i;
+
+	for (i = 0; i < CONT_PTES; i++) {
+		if (!pte_none(*pte) && !pte_cont(*pte))
+			return false;
+		pte++;
+	}
+
+	return true;
+}
+
 /*
  * Given a PTE with the CONT bit set, determine where the CONT range
  * starts, and clear the entire range of PTE CONT bits.
@@ -150,14 +163,20 @@ static void __populate_init_pte(pte_t *pte, unsigned long addr,
 				pgprot_t prot)
 {
 	unsigned long pfn = __phys_to_pfn(phys);
+	bool flush = false;
 
 	do {
+		if (!pte_none(*pte))
+			flush = true;
 		/* clear all the bits except the pfn, then apply the prot */
 		set_pte(pte, pfn_pte(pfn, prot));
 		pte++;
 		pfn++;
 		addr += PAGE_SIZE;
 	} while (addr != end);
+
+	if (flush)
+		flush_tlb_all();
 }
 
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
@@ -180,7 +199,8 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_kernel(pmd, addr);
 	do {
 		next = min(end, (addr + CONT_SIZE) & CONT_MASK);
-		if (((addr | next | phys) & ~CONT_MASK) == 0) {
+		if (((addr | next | phys) & ~CONT_MASK) == 0 &&
+		    __pte_range_none_or_cont(pte)) {
 			/* a block of CONT_PTES  */
 			__populate_init_pte(pte, addr, next, phys,
 					    __pgprot(pgprot_val(prot) | PTE_CONT));
@@ -192,8 +212,9 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 			 * ranges, then update the portion of the range we
 			 * are interrested in.
 			 */
-			 clear_cont_pte_range(pte, addr);
-			 __populate_init_pte(pte, addr, next, phys, prot);
+			if (pte_cont(*pte))
+				clear_cont_pte_range(pte, addr);
+			__populate_init_pte(pte, addr, next, phys, prot);
 		}
 
 		pte += (next - addr) >> PAGE_SHIFT;
@@ -241,24 +262,15 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 
 	pmd = pmd_offset(pud, addr);
 	do {
+		pmd_t old_pmd = *pmd;
 		next = pmd_addr_end(addr, end);
 		/* try section mapping first */
-		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
-			pmd_t old_pmd =*pmd;
+		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
+		    (pmd_none(old_pmd) || pmd_sect(old_pmd))) {
 			set_pmd(pmd, __pmd(phys |
 					   pgprot_val(mk_sect_prot(prot))));
-			/*
-			 * Check for previous table entries created during
-			 * boot (__create_page_tables) and flush them.
-			 */
-			if (!pmd_none(old_pmd)) {
+			if (!pmd_none(old_pmd))
 				flush_tlb_all();
-				if (pmd_table(old_pmd)) {
-					phys_addr_t table = __pa(pte_offset_map(&old_pmd, 0));
-					if (!WARN_ON_ONCE(slab_is_available()))
-						memblock_free(table, PAGE_SIZE);
-				}
-			}
 		} else {
 			alloc_init_pte(pmd, addr, next, phys, prot, alloc);
 		}
@@ -294,31 +306,18 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 
 	pud = pud_offset(pgd, addr);
 	do {
+		pud_t old_pud = *pud;
 		next = pud_addr_end(addr, end);
 
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if (use_1G_block(addr, next, phys)) {
-			pud_t old_pud = *pud;
+		if (use_1G_block(addr, next, phys) &&
+		    (pud_none(old_pud) || pud_sect(old_pud))) {
 			set_pud(pud, __pud(phys |
 					   pgprot_val(mk_sect_prot(prot))));
-
-			/*
-			 * If we have an old value for a pud, it will
-			 * be pointing to a pmd table that we no longer
-			 * need (from swapper_pg_dir).
-			 *
-			 * Look up the old pmd table and free it.
-			 */
-			if (!pud_none(old_pud)) {
+			if (!pud_none(old_pud))
 				flush_tlb_all();
-				if (pud_table(old_pud)) {
-					phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
-					if (!WARN_ON_ONCE(slab_is_available()))
-						memblock_free(table, PAGE_SIZE);
-				}
-			}
 		} else {
 			alloc_init_pmd(mm, pud, addr, next, phys, prot, alloc);
 		}
