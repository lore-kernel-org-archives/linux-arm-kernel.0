From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 Jun 2015 18:04:50 +0200
Subject: [PATCH 2/2] arm/arm64: KVM: fix two build failured under
 STRICT_MM_TYPECHECKS
In-Reply-To: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1435680290-13945-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes two instances where a pgprot_t is used as the operand
of a bitwise & operation. In order to comply with STRICT_MM_TYPECHECKS,
bitwise arithmetic on a pgprot_t should go via the pgprot_val()
accessor.

Cc: kvmarm at lists.cs.columbia.edu
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kvm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1d5accbd3dcf..a255c7dd534b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -213,7 +213,8 @@ static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
 			kvm_tlb_flush_vmid_ipa(kvm, addr);
 
 			/* No need to invalidate the cache for device mappings */
-			if ((pte_val(old_pte) & PAGE_S2_DEVICE) != PAGE_S2_DEVICE)
+			if ((pte_val(old_pte) & pgprot_val(PAGE_S2_DEVICE)) !=
+			    pgprot_val(PAGE_S2_DEVICE))
 				kvm_flush_dcache_pte(old_pte);
 
 			put_page(virt_to_page(pte));
@@ -306,7 +307,8 @@ static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
 	pte = pte_offset_kernel(pmd, addr);
 	do {
 		if (!pte_none(*pte) &&
-		    (pte_val(*pte) & PAGE_S2_DEVICE) != PAGE_S2_DEVICE)
+		    (pte_val(*pte) & pgprot_val(PAGE_S2_DEVICE)) !=
+		    pgprot_val(PAGE_S2_DEVICE))
 			kvm_flush_dcache_pte(*pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
-- 
1.9.1
