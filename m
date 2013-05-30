From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 May 2013 18:14:30 -0700
Subject: [PATCH v3] ARM: KVM: mm: Get rid of L_PTE_USER ref from PAGE_S2_DEVICE
Message-ID: <1369876470-49540-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THe L_PTE_USER actually has nothing to do with stage 2 mappings and the
L_PTE_S2_RDWR value sets the readable bit, which was what L_PTE_USER
was used for before proper handling of stage 2 memory defines.

Changelog:
 [v3]: Drop call to kvm_set_s2pte_writable in mmu.c
 [v2]: Change default mappings to be r/w instead of r/o, as per Marc
       Zyngier's suggestion.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/pgtable.h |    2 +-
 arch/arm/kvm/mmu.c             |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9bcd262..8afc60c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -97,7 +97,7 @@ extern pgprot_t		pgprot_s2_device;
 #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
 #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
 #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
-#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_USER | L_PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDWR)
 
 #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN | L_PTE_NONE)
 #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 2f12e40..d80264c 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -485,7 +485,6 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
 		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
-		kvm_set_s2pte_writable(&pte);
 
 		ret = mmu_topup_memory_cache(&cache, 2, 2);
 		if (ret)
-- 
1.7.9.5
