From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue, 10 Nov 2015 18:03:20 -0800
Subject: [PATCH 1/2] arm64: Fix STRICT_MM_TYPECHECKS errors from pgprot
Message-ID: <1447207401-12023-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Several accesses of pgprot values are incorrect when compiled with
STRICT_MM_TYPECHECKS. Use the appropriate pgprot_val/__pgprot wrappers
to access the structures appropriately.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
Found while working on the set_memory_* work
---
 arch/arm64/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c2fa6b5..83a1162 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -146,7 +146,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		if (((addr | next | phys) & ~CONT_MASK) == 0) {
 			/* a block of CONT_PTES  */
 			__populate_init_pte(pte, addr, next, phys,
-					    prot | __pgprot(PTE_CONT));
+					 __pgprot(pgprot_val(prot) | PTE_CONT));
 		} else {
 			/*
 			 * If the range being split is already inside of a
@@ -475,7 +475,7 @@ void mark_rodata_ro(void)
 {
 	create_mapping_late(__pa(_stext), (unsigned long)_stext,
 				(unsigned long)_etext - (unsigned long)_stext,
-				PAGE_KERNEL_EXEC | PTE_RDONLY);
+				__pgprot(pgprot_val(PAGE_KERNEL_EXEC) | PTE_RDONLY));
 
 }
 #endif
@@ -691,7 +691,7 @@ void __set_fixmap(enum fixed_addresses idx,
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
-	pgprot_t prot = PAGE_KERNEL | PTE_RDONLY;
+	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | PTE_RDONLY);
 	int size, offset;
 	void *dt_virt;
 
-- 
2.5.0
