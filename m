From: vitalya@ti.com (Vitaly Andrianov)
Date: Mon, 14 May 2012 13:56:29 -0400
Subject: [PATCH] ARM: LPAE: fix access flag setup in mem_type_table
Message-ID: <1337018189-27356-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A zero value for prot_sect in the memory types table implies that
section mappings should never be created for the memory type in question.
This is checked for in alloc_init_section().

With LPAE, we set a bit to mask access flag faults for kernel mappings.
This breaks the aforementioned (!prot_sect) check in alloc_init_section().

This patch fixes this bug by first checking for a non-zero
prot_sect before setting the PMD_SECT_AF flag.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/mmu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b9fbec2..1e16b20 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -494,7 +494,8 @@ static void __init build_mem_type_table(void)
 	 */
 	for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 		mem_types[i].prot_pte |= PTE_EXT_AF;
-		mem_types[i].prot_sect |= PMD_SECT_AF;
+		if (mem_types[i].prot_sect)
+			mem_types[i].prot_sect |= PMD_SECT_AF;
 	}
 	kern_pgprot |= PTE_EXT_AF;
 	vecs_pgprot |= PTE_EXT_AF;
-- 
1.7.5.4
