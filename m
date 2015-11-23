From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2015 17:24:50 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151123165214.GD32300@e104818-lin.cambridge.arm.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
 <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
 <5653387A.2000101@redhat.com>
 <20151123165214.GD32300@e104818-lin.cambridge.arm.com>
Message-ID: <20151123172450.GE32300@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:52:15PM +0000, Catalin Marinas wrote:
> We have other cases where we go for smaller to larger block like the 1GB
> section. I think until MarkR finishes his code to go via a temporary
> TTBR1 + idmap, we should prevent all those. We can hope that going the
> other direction (from bigger to smaller block mapping) is fine but we
> don't have a clear answer yet.

This patch (just briefly tested) prevents going from a smaller block to a
bigger one) and the set_pte() sanity check no longer triggers. We still
get some contiguous entries, though I haven't checked whether they've
been reduced.

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abb66f84d4ac..b3f3f3e3d827 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -89,6 +89,21 @@ static void split_pmd(pmd_t *pmd, pte_t *pte)
 	} while (pte++, i++, i < PTRS_PER_PTE);
 }
 
+static bool __pte_range_none_or_cont(pte_t *pte)
+{
+	int i;
+
+	for (i = 0; i < CONT_PTES; i++) {
+		if (!pte_none(*pte))
+			return false;
+		if (!pte_cont(*pte))
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
@@ -143,7 +158,8 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_kernel(pmd, addr);
 	do {
 		next = min(end, (addr + CONT_SIZE) & CONT_MASK);
-		if (((addr | next | phys) & ~CONT_MASK) == 0) {
+		if (((addr | next | phys) & ~CONT_MASK) == 0 &&
+		    __pte_range_none_or_cont(pte)) {
 			/* a block of CONT_PTES  */
 			__populate_init_pte(pte, addr, next, phys,
 					    __pgprot(pgprot_val(prot) | PTE_CONT));
@@ -206,25 +222,12 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 	do {
 		next = pmd_addr_end(addr, end);
 		/* try section mapping first */
-		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
-			pmd_t old_pmd =*pmd;
+		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
+		    (pmd_none(*pmd) || pmd_sect(*pmd)))
 			set_pmd(pmd, __pmd(phys |
 					   pgprot_val(mk_sect_prot(prot))));
-			/*
-			 * Check for previous table entries created during
-			 * boot (__create_page_tables) and flush them.
-			 */
-			if (!pmd_none(old_pmd)) {
-				flush_tlb_all();
-				if (pmd_table(old_pmd)) {
-					phys_addr_t table = __pa(pte_offset_map(&old_pmd, 0));
-					if (!WARN_ON_ONCE(slab_is_available()))
-						memblock_free(table, PAGE_SIZE);
-				}
-			}
-		} else {
+		else
 			alloc_init_pte(pmd, addr, next, phys, prot, alloc);
-		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
 }
@@ -262,29 +265,12 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if (use_1G_block(addr, next, phys)) {
-			pud_t old_pud = *pud;
+		if (use_1G_block(addr, next, phys) &&
+		    (pud_none(*pud) || pud_sect(*pud)))
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
-				flush_tlb_all();
-				if (pud_table(old_pud)) {
-					phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
-					if (!WARN_ON_ONCE(slab_is_available()))
-						memblock_free(table, PAGE_SIZE);
-				}
-			}
-		} else {
+		else
 			alloc_init_pmd(mm, pud, addr, next, phys, prot, alloc);
-		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
 }

-- 
Catalin
