From: shijie8@gmail.com (Huang Shijie)
Date: Tue,  6 Mar 2012 00:07:16 -0500
Subject: [PATCH] ARM: move mem_type's real definition to asm/mach/map.h
Message-ID: <1331010436-31576-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we use the mem_type in the driver. We will meet the compiler error:
"error: dereferencing pointer to incomplete type"

Move mem_type's real definition to asm/mach/map.h to fix it.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 arch/arm/include/asm/mach/map.h |    8 +++++++-
 arch/arm/mm/mm.h                |    7 +------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index b36f365..a5ee07d 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -34,7 +34,13 @@ struct map_desc {
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
 
-struct mem_type;
+struct mem_type {
+	pteval_t prot_pte;
+	pmdval_t prot_l1;
+	pmdval_t prot_sect;
+	unsigned int domain;
+};
+
 extern const struct mem_type *get_mem_type(unsigned int type);
 /*
  * external interface to remap single page with appropriate type
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 70f6d3ea..1930bc9 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -10,12 +10,7 @@ static inline pmd_t *pmd_off_k(unsigned long virt)
 	return pmd_offset(pud_offset(pgd_offset_k(virt), virt), virt);
 }
 
-struct mem_type {
-	pteval_t prot_pte;
-	pmdval_t prot_l1;
-	pmdval_t prot_sect;
-	unsigned int domain;
-};
+struct mem_type;
 
 const struct mem_type *get_mem_type(unsigned int type);
 
-- 
1.7.4.4
