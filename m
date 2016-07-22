From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Jul 2016 19:32:24 +0200
Subject: [PATCH 1/2] arm64: mm: make create_mapping_late() non-allocating
In-Reply-To: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1469208745-6693-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only purpose served by create_mapping_late() is to remap the already
mapped .text and .rodata kernel segments with read-only permissions. Since
we no longer allow block mappings to be split or merged,
create_mapping_late() should not pass an allocation function pointer into
__create_pgd_mapping(). So pass NULL instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a96a2413fa18..33f36cede02d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -312,7 +312,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 	}
 
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
-			     late_pgtable_alloc, !debug_pagealloc_enabled());
+			     NULL, !debug_pagealloc_enabled());
 }
 
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
-- 
2.7.4
