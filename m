From: robherring2@gmail.com (Rob Herring)
Date: Wed,  5 Feb 2014 08:50:29 -0600
Subject: [PATCH] arm64: fix early_io_map for 64K pages
Message-ID: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

earlyprintk is broken with 64KB pages. The problem is pgprot_default
is not yet initialized when early_io_map is called, so the pte does not
get marked as valid. Set the necessary page and access permission bits.

Cc: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---

I'm not sure this is really the best fix. Perhaps pgprot_default can be
statically initialized to something useful instead? 

Rob

 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f557ebb..c41daa6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -284,7 +284,7 @@ void __iomem * __init early_io_map(phys_addr_t phys, unsigned long virt)
 		if (pmd_none(*pmd))
 			return NULL;
 		pte = pte_offset_kernel(pmd, virt);
-		set_pte(pte, __pte((phys & mask) | PROT_DEVICE_nGnRE));
+		set_pte(pte, __pte((phys & mask) | PTE_TYPE_PAGE | PTE_AF | PROT_DEVICE_nGnRE));
 	} else {
 		set_pmd(pmd, __pmd((phys & mask) | PROT_SECT_DEVICE_nGnRE));
 	}
-- 
1.8.3.2
