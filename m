From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  2 Oct 2015 15:47:44 -0500
Subject: [PATCH 6/7] arm64: Mark kernel page ranges contiguous
In-Reply-To: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1443818865-19846-7-git-send-email-jeremy.linton@arm.com>
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

Add boot option to enable/disable CONT marking, as well as fix a
bug found by Steve Capper.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/mm/mmu.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9211b85..4949f1d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -69,6 +69,8 @@ static void __init *early_alloc(unsigned long sz)
 	return ptr;
 }
 
+early_param_on_off("contpte", "nocontpte", cont_linear_ptes, 1);
+
 /*
  * remap a PMD into pages
  */
@@ -80,19 +82,58 @@ static void split_pmd(pmd_t *pmd, pte_t *pte)
 	do {
 		/*
 		 * Need to have the least restrictive permissions available
-		 * permissions will be fixed up later
+		 * permissions will be fixed up later. Default the new page
+		 * range as contiguous ptes.
 		 */
-		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+		if (cont_linear_ptes)
+			set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC_CONT));
+		else
+			set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
 		pfn++;
 	} while (pte++, i++, i < PTRS_PER_PTE);
 }
 
+/*
+ * Given a PTE with the CONT bit set, determine where the CONT range
+ * starts, and clear the entire range of PTE CONT bits.
+ */
+static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
+{
+	int i;
+
+	pte -= CONT_RANGE_OFFSET(addr);
+	for (i = 0; i < CONT_RANGE; i++) {
+		set_pte(pte, pte_mknoncont(*pte));
+		pte++;
+	}
+	flush_tlb_all();
+}
+
+/*
+ * Given a range of PTEs set the pfn and provided page protection flags
+ */
+static void __populate_init_pte(pte_t *pte, unsigned long addr,
+				unsigned long end, phys_addr_t phys,
+				pgprot_t prot)
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
 				  void *(*alloc)(unsigned long size))
 {
 	pte_t *pte;
+	unsigned long next;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
 		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
@@ -104,10 +145,31 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	BUG_ON(pmd_bad(*pmd));
 
 	pte = pte_offset_kernel(pmd, addr);
-	do {
-		set_pte(pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	if (!cont_linear_ptes)
+		__populate_init_pte(pte, addr, end, phys, prot);
+	else
+	    do {
+		next = min(end, (addr + CONT_SIZE) & CONT_MASK);
+		if (((addr | next | phys) & CONT_RANGE_MASK) == 0) {
+			/* a block of CONT_RANGE_SIZE PTEs */
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
+			 clear_cont_pte_range(pte, addr);
+			 __populate_init_pte(pte, addr, next, phys, prot);
+		}
+
+		pte += (next - addr) >> PAGE_SHIFT;
+		phys += next - addr;
+		addr = next;
+	} while (addr != end);
 }
 
 void split_pud(pud_t *old_pud, pmd_t *pmd)
@@ -168,8 +230,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 				}
 			}
 		} else {
-			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
-				       prot, alloc);
+			alloc_init_pte(pmd, addr, next, phys, prot, alloc);
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
-- 
2.4.3
