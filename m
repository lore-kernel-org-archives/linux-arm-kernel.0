From: ajeet.yadav.77@gmail.com (Ajeet Yadav)
Date: Fri, 17 Feb 2012 21:26:00 +0530
Subject: [PATCH 3/3] ARM: dma-mapping: fix array out of bound access
Message-ID: <1329494160-26942-1-git-send-email-ajeet.yadav.77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In __dma_alloc_remap(*,size,*,*)/ __dma_free_remap(*,size) functions
if virtual address is in the last consistent mapping region
i.e idx == ((CONSISTENT_END - base) >> PMD_SHIFT) - 1
and off == PTRS_PER_PTE.
then we have array out of bound access condition.

On entry to while loop we ensure that off is always < PTRS_PER_PTE
via
u32 off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);

therefore we can safely move that condition to begining of while
loop, to ensure that we access consistent_pte[] only if
while condition is true.

Signed-off-by: Naveen Yadav <yad.naveen@gmail.com>
Signed-off-by: Ajeet Yadav <ajeet.yadav.77@gmail.com>
---
 arch/arm/mm/dma-mapping.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 932d288..0e1a2a2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -251,16 +251,16 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 		c->vm_pages = page;
 
 		do {
+			if (off >= PTRS_PER_PTE) {
+				off = 0;
+				pte = consistent_pte[++idx];
+			}
 			BUG_ON(!pte_none(*pte));
 
 			set_pte_ext(pte, mk_pte(page, prot), 0);
 			page++;
 			pte++;
 			off++;
-			if (off >= PTRS_PER_PTE) {
-				off = 0;
-				pte = consistent_pte[++idx];
-			}
 		} while (size -= PAGE_SIZE);
 
 		dsb();
@@ -275,6 +275,7 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 	struct arm_vmregion *c;
 	unsigned long addr;
 	pte_t *ptep;
+	pte_t pte;
 	int idx;
 	u32 off;
 
@@ -298,16 +299,14 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 	ptep = consistent_pte[idx] + off;
 	addr = c->vm_start;
 	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-
-		ptep++;
-		addr += PAGE_SIZE;
-		off++;
 		if (off >= PTRS_PER_PTE) {
 			off = 0;
 			ptep = consistent_pte[++idx];
 		}
-
+		pte = ptep_get_and_clear(&init_mm, addr, ptep);
+		ptep++;
+		addr += PAGE_SIZE;
+		off++;
 		if (pte_none(pte) || !pte_present(pte))
 			printk(KERN_CRIT "%s: bad page in kernel page table\n",
 			       __func__);
-- 
1.7.8.4
