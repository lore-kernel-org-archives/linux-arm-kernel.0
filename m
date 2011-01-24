From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Jan 2011 17:55:44 +0000
Subject: [PATCH v4 02/19] ARM: LPAE: Fix early_pte_alloc() assumption about
	the Linux PTE
In-Reply-To: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1295891761-18366-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With LPAE we no longer have software bits in a separate Linux PTE and
the early_pte_alloc() function should pass PTE_HWTABLE_OFF +
PTE_HWTABLE_SIZE to early_alloc() to avoid allocating extra memory.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/mmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 3c67e92..dcafa5c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -533,7 +533,7 @@ static void __init *early_alloc(unsigned long sz)
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr, unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = early_alloc(2 * PTRS_PER_PTE * sizeof(pte_t));
+		pte_t *pte = early_alloc(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE);
 		__pmd_populate(pmd, __pa(pte), prot);
 	}
 	BUG_ON(pmd_bad(*pmd));
