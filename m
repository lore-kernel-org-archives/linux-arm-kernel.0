From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Feb 2016 13:35:16 +0000
Subject: [PATCH] arm64: mm: keep gcc and sparse happy when !CONFIG_DEBUG_RODATA
Message-ID: <1455197716-28665-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

init/main.c defines an empty static inline mark_rodata_ro #ifndef
CONFIG_DEBUG_RODATA, which clashes with the unconditional definition
in the arm64 backend, which has an IS_ENABLED check in the code.

Whilst this doesn't cause any problems in practice (the static inline
version is used in preference and the out-of-line version has no
prototype), GCC moans with:

  warning: no previous prototype for ?mark_rodata_ro? [-Wmissing-prototypes]

and sparse with:

  warning: symbol 'mark_rodata_ro' was not declared. Should it be static? [sparse]

so keep them happy by replacing the IS_ENABLED check with an #ifdef
around the function instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c3e5df62671e..4a330018ce8f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -372,19 +372,6 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			     late_pgtable_alloc);
 }
 
-static void create_mapping_late(phys_addr_t phys, unsigned long virt,
-				  phys_addr_t size, pgprot_t prot)
-{
-	if (virt < VMALLOC_START) {
-		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
-			&phys, virt);
-		return;
-	}
-
-	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
-			     late_pgtable_alloc);
-}
-
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
 {
 
@@ -438,15 +425,27 @@ static void __init map_mem(pgd_t *pgd)
 	}
 }
 
-void mark_rodata_ro(void)
+#ifdef CONFIG_DEBUG_RODATA
+static void create_mapping_late(phys_addr_t phys, unsigned long virt,
+				  phys_addr_t size, pgprot_t prot)
 {
-	if (!IS_ENABLED(CONFIG_DEBUG_RODATA))
+	if (virt < VMALLOC_START) {
+		pr_warn("BUG: not creating mapping for %pa@0x%016lx - outside kernel range\n",
+			&phys, virt);
 		return;
+	}
 
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
+			     late_pgtable_alloc);
+}
+
+void mark_rodata_ro(void)
+{
 	create_mapping_late(__pa(_stext), (unsigned long)_stext,
 				(unsigned long)_etext - (unsigned long)_stext,
 				PAGE_KERNEL_ROX);
 }
+#endif
 
 void fixup_init(void)
 {
-- 
2.1.4
