From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  1 Oct 2015 19:04:21 +0200
Subject: [PATCH 7/9] ARM: implement create_mapping_late() for EFI use
In-Reply-To: <1443719063-6832-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1443719063-6832-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1443719063-6832-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements create_mapping_late(), which we will use to populate
the UEFI Runtime Services page tables.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/mach/map.h |  1 +
 arch/arm/mm/mmu.c               | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index f98c7f32c9c8..14fe67bd0272 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -42,6 +42,7 @@ enum {
 extern void iotable_init(struct map_desc *, int);
 extern void vm_reserve_area_early(unsigned long addr, unsigned long size,
 				  void *caller);
+extern void create_mapping_late(struct mm_struct *mm, struct map_desc *md);
 
 #ifdef CONFIG_DEBUG_LL
 extern void debug_ll_addr(unsigned long *paddr, unsigned long *vaddr);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index dd0967ee23b7..c5f0c0ade981 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -723,6 +723,14 @@ static void __init *early_alloc(unsigned long sz)
 	return early_alloc_aligned(sz, sz);
 }
 
+static void *__init late_alloc(unsigned long sz)
+{
+	void *ptr = (void *)__get_free_pages(PGALLOC_GFP, get_order(sz));
+
+	BUG_ON(!ptr);
+	return ptr;
+}
+
 static pte_t * __init pte_alloc(pmd_t *pmd, unsigned long addr,
 				unsigned long prot,
 				void *(*alloc)(unsigned long sz))
@@ -954,6 +962,17 @@ static void __init create_mapping(struct map_desc *md)
 	__create_mapping(&init_mm, md, early_alloc);
 }
 
+void __init create_mapping_late(struct mm_struct *mm, struct map_desc *md)
+{
+#ifdef CONFIG_ARM_LPAE
+	pud_t *pud = pud_alloc(mm, pgd_offset(mm, md->virtual), md->virtual);
+	if (WARN_ON(!pud))
+		return;
+	pmd_alloc(mm, pud, 0);
+#endif
+	__create_mapping(mm, md, late_alloc);
+}
+
 /*
  * Create the architecture specific mappings
  */
-- 
1.9.1
