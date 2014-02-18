From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Feb 2014 15:27:33 +0000
Subject: [PATCH v4 12/12] ARM: KVM: fix warning in mmu.c
In-Reply-To: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
References: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1392737253-10480-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling with THP enabled leads to the following warning:

arch/arm/kvm/mmu.c: In function ?unmap_range?:
arch/arm/kvm/mmu.c:177:39: warning: ?pte? may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
                                        ^
Code inspection reveals that these two cases are mutually exclusive,
so GCC is a bit overzealous here. Silence it anyway by initializing
pte to NULL and testing it later on.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 209f20f..5e56cbc 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -144,6 +144,7 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 	while (addr < end) {
 		pgd = pgdp + pgd_index(addr);
 		pud = pud_offset(pgd, addr);
+		pte = NULL;
 		if (pud_none(*pud)) {
 			addr = kvm_pud_addr_end(addr, end);
 			continue;
@@ -174,7 +175,7 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 		/*
 		 * If the pmd entry is to be cleared, walk back up the ladder
 		 */
-		if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
+		if (kvm_pmd_huge(*pmd) || (pte && page_empty(pte))) {
 			clear_pmd_entry(kvm, pmd, addr);
 			next = kvm_pmd_addr_end(addr, end);
 			if (page_empty(pmd) && !page_empty(pud)) {
-- 
1.8.3.4
