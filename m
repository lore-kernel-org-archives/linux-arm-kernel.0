From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 Jun 2015 18:04:49 +0200
Subject: [PATCH 1/2] arm64: fix incorrect use of pgprot_t variable
Message-ID: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a build failure under STRICT_MM_TYPECHECKS, by adding
a missing pgprot_val() around a pgport_t reference.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5b8b664422d3..79f29bab7259 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -116,7 +116,7 @@ void split_pud(pud_t *old_pud, pmd_t *pmd)
 	int i = 0;
 
 	do {
-		set_pmd(pmd, __pmd(addr | prot));
+		set_pmd(pmd, __pmd(addr | pgprot_val(prot)));
 		addr += PMD_SIZE;
 	} while (pmd++, i++, i < PTRS_PER_PMD);
 }
-- 
1.9.1
