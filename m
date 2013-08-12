From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Aug 2013 21:13:00 -0700
Subject: [PATCH 3/4] arm64: KVM: fix 2-level page tables unmapping
In-Reply-To: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
References: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1376280781-6539-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When using 64kB pages, we only have two levels of page tables,
meaning that PGD, PUD and PMD are fused. In this case, trying
to refcount PUDs and PMDs independently is a a complete disaster,
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
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 80a83ec..0988d9e 100644
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
 		next = addr + PAGE_SIZE;
 
 		/* If we emptied the pte, walk back up the ladder */
-		if (pte_empty(pte)) {
+		if (page_empty(pte)) {
 			clear_pmd_entry(kvm, pmd, addr);
 			next = pmd_addr_end(addr, end);
-			if (pmd_empty(pmd)) {
+			if (page_empty(pmd) && !page_empty(pud)) {
 				clear_pud_entry(kvm, pud, addr);
 				next = pud_addr_end(addr, end);
 			}
-- 
1.7.10.4
