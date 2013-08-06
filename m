From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Aug 2013 13:05:48 +0100
Subject: [PATCH] arm64: KVM: fix 2-level page tables unmapping
Message-ID: <1375790748-10296-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using 64kB pages, we only have two levels of page tables,
meaning that PGD, PUD and PMD are fused. In this case, trying
to refcount PUDs and PMDs independantly is a a complete disaster,
as they are the same.

We manage to get it right for the allocation (stage2_set_pte uses
{pmd,pud}_none), but the unmapping path clears both pud and pmd
refcounts, which fails spectacularly with 2-level page tables.

The fix is to avoid calling clear_pud_entry when both the pmd and
pud pages are empty. For this, and instead of introducing another
pud_empty function, consolidate both pte_empty and pmd_empty into
page_empty (the code is actually identical) and use that to also
test the validity of the pud.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index ca6bea4..7e1d899 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -85,6 +85,12 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 	return p;
 }
 
+static bool page_empty(void *ptr)
+{
+	struct page *ptr_page = virt_to_page(ptr);
+	return page_count(ptr_page) == 1;
+}
+
 static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
 {
 	pmd_t *pmd_table = pmd_offset(pud, 0);
@@ -103,12 +109,6 @@ static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
 	put_page(virt_to_page(pmd));
 }
 
-static bool pmd_empty(pmd_t *pmd)
-{
-	struct page *pmd_page = virt_to_page(pmd);
-	return page_count(pmd_page) == 1;
-}
-
 static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
 {
 	if (pte_present(*pte)) {
@@ -118,12 +118,6 @@ static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
 	}
 }
 
-static bool pte_empty(pte_t *pte)
-{
-	struct page *pte_page = virt_to_page(pte);
-	return page_count(pte_page) == 1;
-}
-
 static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 			unsigned long long start, u64 size)
 {
@@ -153,10 +147,10 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 		range = PAGE_SIZE;
 
 		/* If we emptied the pte, walk back up the ladder */
-		if (pte_empty(pte)) {
+		if (page_empty(pte)) {
 			clear_pmd_entry(kvm, pmd, addr);
 			range = PMD_SIZE;
-			if (pmd_empty(pmd)) {
+			if (page_empty(pmd) && !page_empty(pud)) {
 				clear_pud_entry(kvm, pud, addr);
 				range = PUD_SIZE;
 			}
-- 
1.8.2.3
