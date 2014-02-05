From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Feb 2014 19:58:25 +0000
Subject: [PATCH] ARM: KVM: fix warning in mmu.c
Message-ID: <1391630305-8056-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling with THP enabled leads to the following warning:

arch/arm/kvm/mmu.c: In function ?unmap_range?:
arch/arm/kvm/mmu.c:177:39: warning: ?pte? may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
                                        ^
Code inspection reveals that these two cases are mutually exclusive,
so GCC is a bit overzealous here. But silence it anyway by setting
pte to NULL if kvm_pmd_huge(*pmd) is true.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index ea21b6a..3020221 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -169,12 +169,14 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 			pte = pte_offset_kernel(pmd, addr);
 			clear_pte_entry(kvm, pte, addr);
 			next = addr + PAGE_SIZE;
+		} else {
+			pte = NULL;
 		}
 
 		/*
 		 * If the pmd entry is to be cleared, walk back up the ladder
 		 */
-		if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
+		if (kvm_pmd_huge(*pmd) || (pte && page_empty(pte))) {
 			clear_pmd_entry(kvm, pmd, addr);
 			next = pmd_addr_end(addr, end);
 			if (page_empty(pmd) && !page_empty(pud)) {
-- 
1.8.3.4
