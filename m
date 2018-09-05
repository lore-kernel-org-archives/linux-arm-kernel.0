From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  5 Sep 2018 17:38:57 +0100
Subject: [PATCH] arm64: fix erroneous warnings in page freeing functions
Message-ID: <20180905163857.7933-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In pmd_free_pte_page() and pud_free_pmd_page() we try to warn if they
hit a present non-table entry. In both cases we'll warn for non-present
entries, as the VM_WARN_ON() only checks the entry is not a table entry.

This has been observed to result in warnings when booting a v4.19-rc2
kernel under qemu.

Fix this by bailing out earlier for non-present entries.

Fixes: ec28bb9c9b0826d7 ("arm64: Implement page table free interfaces")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..8080c9f489c3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -985,8 +985,9 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 
 	pmd = READ_ONCE(*pmdp);
 
-	/* No-op for empty entry and WARN_ON for valid entry */
-	if (!pmd_present(pmd) || !pmd_table(pmd)) {
+	if (!pmd_present(pmd))
+		return 1;
+	if (!pmd_table(pmd)) {
 		VM_WARN_ON(!pmd_table(pmd));
 		return 1;
 	}
@@ -1007,8 +1008,9 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 
 	pud = READ_ONCE(*pudp);
 
-	/* No-op for empty entry and WARN_ON for valid entry */
-	if (!pud_present(pud) || !pud_table(pud)) {
+	if (!pud_present(pud))
+		return 1;
+	if (!pud_table(pud)) {
 		VM_WARN_ON(!pud_table(pud));
 		return 1;
 	}
-- 
2.11.0
