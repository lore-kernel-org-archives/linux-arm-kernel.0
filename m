From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:31:35 +0100
Subject: [PATCH 5/9] ARM: domains: keep vectors in separate domain
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmPv-0002zB-Uf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep the machine vectors in its own domain to avoid software based
user access control from making the vector code inaccessible, and
thereby deadlocking the machine.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h               |  4 +++-
 arch/arm/include/asm/pgtable-2level-hwdef.h |  1 +
 arch/arm/mm/mmu.c                           |  4 ++--
 arch/arm/mm/pgd.c                           | 10 ++++++++++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 08b601e69ddc..396a12e486fe 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -43,6 +43,7 @@
 #define DOMAIN_USER	1
 #define DOMAIN_IO	0
 #endif
+#define DOMAIN_VECTORS	3
 
 /*
  * Domain types
@@ -62,7 +63,8 @@
 	(domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 	 domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
-	 domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+	 domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
+	 domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index 5e68278e953e..d0131ee6f6af 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -23,6 +23,7 @@
 #define PMD_PXNTABLE		(_AT(pmdval_t, 1) << 2)     /* v7 */
 #define PMD_BIT4		(_AT(pmdval_t, 1) << 4)
 #define PMD_DOMAIN(x)		(_AT(pmdval_t, (x)) << 5)
+#define PMD_DOMAIN_MASK		PMD_DOMAIN(0x0f)
 #define PMD_PROTECTION		(_AT(pmdval_t, 1) << 9)		/* v5 */
 /*
  *   - section
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6ca7d9aa896f..a016de248034 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -291,13 +291,13 @@ static struct mem_type mem_types[] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
 				L_PTE_RDONLY,
 		.prot_l1   = PMD_TYPE_TABLE,
-		.domain    = DOMAIN_USER,
+		.domain    = DOMAIN_VECTORS,
 	},
 	[MT_HIGH_VECTORS] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
 				L_PTE_USER | L_PTE_RDONLY,
 		.prot_l1   = PMD_TYPE_TABLE,
-		.domain    = DOMAIN_USER,
+		.domain    = DOMAIN_VECTORS,
 	},
 	[MT_MEMORY_RWX] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index a3681f11dd9f..e683db1b90a3 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -84,6 +84,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		if (!new_pte)
 			goto no_pte;
 
+#ifndef CONFIG_ARM_LPAE
+		/*
+		 * Modify the PTE pointer to have the correct domain.  This
+		 * needs to be the vectors domain to avoid the low vectors
+		 * being unmapped.
+		 */
+		pmd_val(*new_pmd) &= ~PMD_DOMAIN_MASK;
+		pmd_val(*new_pmd) |= PMD_DOMAIN(DOMAIN_VECTORS);
+#endif
+
 		init_pud = pud_offset(init_pgd, 0);
 		init_pmd = pmd_offset(init_pud, 0);
 		init_pte = pte_offset_map(init_pmd, 0);
-- 
2.1.0
