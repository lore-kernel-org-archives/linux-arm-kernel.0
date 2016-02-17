From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 17 Feb 2016 10:29:54 -0600
Subject: [PATCH v2 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <1455726594-16104-1-git-send-email-jeremy.linton@arm.com>
References: <1455726594-16104-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1455726594-16104-3-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With 64k pages, the next larger segment size is 512M. The linux
kernel also uses different protection flags to cover its code and data.
Because of this requirement, the vast majority of the kernel code and
data structures end up being mapped with 64k pages instead of the larger
pages common with a 4k page kernel.

Recent ARM processors support a contiguous bit in the
page tables which allows the a TLB to cover a range larger than a
single PTE if that range is mapped into physically contiguous
ram.

So, for the kernel its a good idea to set this flag. Some basic
micro benchmarks show it can significantly reduce the number of
L1 dTLB refills.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/mm/mmu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7711554..ab69a99 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1,3 +1,4 @@
+
 /*
  * Based on arch/arm/mm/mmu.c
  *
@@ -103,17 +104,49 @@ static void split_pmd(pmd_t *pmd, pte_t *pte)
 		 * Need to have the least restrictive permissions available
 		 * permissions will be fixed up later
 		 */
-		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC_CONT));
 		pfn++;
 	} while (pte++, i++, i < PTRS_PER_PTE);
 }
 
+static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
+{
+	int i;
+
+	pte -= CONT_RANGE_OFFSET(addr);
+	for (i = 0; i < CONT_PTES; i++) {
+		if (pte_cont(*pte))
+			set_pte(pte, pte_mknoncont(*pte));
+		pte++;
+	}
+	flush_tlb_all();
+}
+
+/*
+ * Given a range of PTEs set the pfn and provided page protection flags
+ */
+static void __populate_init_pte(pte_t *pte, unsigned long addr,
+			       unsigned long end, phys_addr_t phys,
+			       pgprot_t prot)
+{
+	unsigned long pfn = __phys_to_pfn(phys);
+
+	do {
+		/* clear all the bits except the pfn, then apply the prot */
+		set_pte(pte, pfn_pte(pfn, prot));
+		pte++;
+		pfn++;
+		addr += PAGE_SIZE;
+	} while (addr != end);
+}
+
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
-				  unsigned long end, unsigned long pfn,
+				  unsigned long end, phys_addr_t phys,
 				  pgprot_t prot,
 				  phys_addr_t (*pgtable_alloc)(void))
 {
 	pte_t *pte;
+	unsigned long next;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
 		phys_addr_t pte_phys = pgtable_alloc();
@@ -127,10 +160,29 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	BUG_ON(pmd_bad(*pmd));
 
 	pte = pte_set_fixmap_offset(pmd, addr);
+
 	do {
-		set_pte(pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		next = min(end, (addr + CONT_SIZE) & CONT_MASK);
+		if (((addr | next | phys) & ~CONT_MASK) == 0) {
+			/* a block of CONT_PTES	 */
+			__populate_init_pte(pte, addr, next, phys,
+					    prot | __pgprot(PTE_CONT));
+		} else {
+			/*
+			 * If the range being split is already inside of a
+			 * contiguous range but this PTE isn't going to be
+			 * contiguous, then we want to unmark the adjacent
+			 * ranges, then update the portion of the range we
+			 * are interrested in.
+			 */
+			clear_cont_pte_range(pte, addr);
+			__populate_init_pte(pte, addr, next, phys, prot);
+		}
+
+		pte += (next - addr) >> PAGE_SHIFT;
+		phys += next - addr;
+		addr = next;
+	} while (addr != end);
 
 	pte_clear_fixmap();
 }
@@ -194,7 +246,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 				}
 			}
 		} else {
-			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
+			alloc_init_pte(pmd, addr, next, phys,
 				       prot, pgtable_alloc);
 		}
 		phys += next - addr;
-- 
2.4.3
