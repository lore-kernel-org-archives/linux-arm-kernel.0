From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 28 Jan 2014 13:24:24 -0800
Subject: [PATCH v2] ARM: mm: Fix stage-2 device memory attributes
Message-ID: <1390944264-3435-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stage-2 memory attributes are distinct from the Hyp memory
attributes and the Stage-1 memory attributes.  We were using the stage-1
memory attributes for stage-2 mappings causing device mappings to be
mapped as normal memory.  Add the S2 equivalent defines for memory
attributes and fix the comments explaining the defines while at it.

Add a prot_pte_s2 field to the mem_type struct and fill out the field
for device mappings accordingly.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changes [v1 -> v2]:
 - Only define stage 2 protection flag for MT_DEVICE memory type.

 arch/arm/include/asm/pgtable-3level.h | 15 +++++++++------
 arch/arm/mm/mm.h                      |  1 +
 arch/arm/mm/mmu.c                     |  7 ++++++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 4f95039..1d15673 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -120,13 +120,16 @@
 /*
  * 2nd stage PTE definitions for LPAE.
  */
-#define L_PTE_S2_MT_UNCACHED	 (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
-#define L_PTE_S2_MT_WRITETHROUGH (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
-#define L_PTE_S2_MT_WRITEBACK	 (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
-#define L_PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
-#define L_PTE_S2_RDWR		 (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
+#define L_PTE_S2_MT_UNCACHED		(_AT(pteval_t, 0x0) << 2) /* strongly ordered */
+#define L_PTE_S2_MT_WRITETHROUGH	(_AT(pteval_t, 0xa) << 2) /* normal inner write-through */
+#define L_PTE_S2_MT_WRITEBACK		(_AT(pteval_t, 0xf) << 2) /* normal inner write-back */
+#define L_PTE_S2_MT_DEV_SHARED		(_AT(pteval_t, 0x1) << 2) /* device */
+#define L_PTE_S2_MT_MASK		(_AT(pteval_t, 0xf) << 2)
 
-#define L_PMD_S2_RDWR		 (_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
+#define L_PTE_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
+#define L_PTE_S2_RDWR			(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
+
+#define L_PMD_S2_RDWR			(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 
 /*
  * Hyp-mode PL2 PTE definitions for LPAE.
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index d5a982d..7ea641b 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -38,6 +38,7 @@ static inline pmd_t *pmd_off_k(unsigned long virt)
 
 struct mem_type {
 	pteval_t prot_pte;
+	pteval_t prot_pte_s2;
 	pmdval_t prot_l1;
 	pmdval_t prot_sect;
 	unsigned int domain;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 580ef2d..911d433 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -231,12 +231,16 @@ __setup("noalign", noalign_setup);
 #endif /* ifdef CONFIG_CPU_CP15 / else */
 
 #define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
+#define PROT_PTE_S2_DEVICE	PROT_PTE_DEVICE
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
 static struct mem_type mem_types[] = {
 	[MT_DEVICE] = {		  /* Strongly ordered / ARMv6 shared device */
 		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
 				  L_PTE_SHARED,
+		.prot_pte_s2	= s2_policy(PROT_PTE_S2_DEVICE) |
+				  s2_policy(L_PTE_S2_MT_DEV_SHARED) |
+				  L_PTE_SHARED,
 		.prot_l1	= PMD_TYPE_TABLE,
 		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_S,
 		.domain		= DOMAIN_IO,
@@ -458,7 +462,8 @@ static void __init build_mem_type_table(void)
 	cp = &cache_policies[cachepolicy];
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
 	s2_pgprot = cp->pte_s2;
-	hyp_device_pgprot = s2_device_pgprot = mem_types[MT_DEVICE].prot_pte;
+	hyp_device_pgprot = mem_types[MT_DEVICE].prot_pte;
+	s2_device_pgprot = mem_types[MT_DEVICE].prot_pte_s2;
 
 	/*
 	 * ARMv6 and above have extended page tables.
-- 
1.8.5.2
