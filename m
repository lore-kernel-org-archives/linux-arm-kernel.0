From: steve.capper@linaro.org (Steve Capper)
Date: Thu,  1 Oct 2015 13:06:07 +0100
Subject: [PATCH] arm64: Fix THP protection change logic
Message-ID: <1443701167-10816-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

6910fa1 ("arm64: enable PTE type bit in the mask for pte_modify") fixes
a problem whereby a large block of PROT_NONE mapped memory is
incorrectly mapped as block descriptors when mprotect is called.

Unfortunately, a subtle bug was introduced by this fix to the THP logic.

If one mmaps a large block of memory, then faults it such that it is
collapsed into THPs; resulting calls to mprotect on this area of memory
will lead to incorrect table descriptors being written instead of block
descriptors. This is because pmd_modify calls pte_modify which is now
allowed to modify the type of the page table entry.

This patch reverts commit 6910fa16dbe142f6a0fd0fd7c249f9883ff7fc8a, and
fixes the problem it was trying to address by adjusting PAGE_NONE to
represent a table entry. Thus no change in pte type is required when
moving from PROT_NONE to a different protection.

Fixes: 6910fa16dbe1 ("arm64: enable PTE type bit in the mask for pte_modify")
Cc: Feng Kan <fkan@apm.com>
Reported-by: Ganapatrao Kulkarni <Ganapatrao.Kulkarni@caviumnetworks.com>
Signed-off-by: Steve Capper <steve.capper@linaro.org>
---

This patch stops my THP mprotect tests from crashing my machine quite
horrendously.

Ganapatrao, could you please give this a test and let me know if it behaves
with your NUMA stuff?

Feng, does this revised fix work with the Trinity test you mentioned in
6910fa1 ("arm64: enable PTE type bit in the mask for pte_modify")?

Cheers,
-- 
Steve

---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 56283f8..cf73194 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -80,7 +80,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 
-#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
+#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
 #define PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
@@ -460,7 +460,7 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_WRITE | PTE_TYPE_MASK;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
-- 
2.1.0
