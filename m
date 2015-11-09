From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  9 Nov 2015 09:55:45 +0100
Subject: [PATCH 1/2] arm64: fix STRICT_MM_TYPECHECKS issue in PTE_CONT
 manipulation
In-Reply-To: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1447059346-12050-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new page table code that manipulates the PTE_CONT flags does so
in a way that is inconsistent with STRICT_MM_TYPECHECKS. Fix it by
using the correct combination of __pgprot() and pgprot_val().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4cf54411b392..46a2b8805c97 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -149,7 +149,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		if (((addr | next | phys) & ~CONT_MASK) == 0) {
 			/* a block of CONT_PTES  */
 			__populate_init_pte(pte, addr, next, phys,
-					    prot | __pgprot(PTE_CONT));
+					__pgprot(pgprot_val(prot) | PTE_CONT));
 		} else {
 			/*
 			 * If the range being split is already inside of a
-- 
1.9.1
