From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Mar 2018 19:19:57 +0800
Subject: [RFC PATCH 5/6] arm64/mm: factor out clear_page() for unmapped memory
In-Reply-To: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
Message-ID: <20180319111958.4171-6-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the code that clears newly memblock_alloc()'ed pages so
we can reuse it to clear the pgdir allocation later.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index af6fe001df0c..55c84d63244d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -79,19 +79,14 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(void)
+static void __init clear_page_phys(phys_addr_t phys)
 {
-	phys_addr_t phys;
-	void *ptr;
-
-	phys = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-
 	/*
 	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
 	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
 	 * any level of table.
 	 */
-	ptr = pte_set_fixmap(phys);
+	void *ptr = pte_set_fixmap(phys);
 
 	memset(ptr, 0, PAGE_SIZE);
 
@@ -100,7 +95,13 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	 * table walker
 	 */
 	pte_clear_fixmap();
+}
+
+static phys_addr_t __init early_pgtable_alloc(void)
+{
+	phys_addr_t phys = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
+	clear_page_phys(phys);
 	return phys;
 }
 
-- 
2.11.0
