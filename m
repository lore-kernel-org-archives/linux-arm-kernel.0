From: anup.patel@linaro.org (Anup Patel)
Date: Thu,  9 May 2013 11:23:33 +0530
Subject: [PATCH] arm64: KVM: Add bits for specifying memory type in stage2 PTE
Message-ID: <1368078813-16904-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot use existing stage1 PTE_ATTRINDX() macro for specifying
stage2 memory type because stage1 ATTRINDX = PTE[4:2] and stage2
MEMATTR = PTE[5:2].

This patch adds bit definetions for specifying device, noncacheable,
writethrough, and writeback memory types in stage2 PTE and also uses
it in PAGE_S2 and PAGE_S2_DEVICE.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h |    4 ++++
 arch/arm64/include/asm/pgtable.h       |    6 ++++--
 arch/arm64/mm/mmu.c                    |    9 +++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c49cd61..555babb 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -73,6 +73,10 @@
  */
 #define PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
 #define PTE_S2_RDWR		 (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
+#define PTE_S2_MT_DEVICE	 (_AT(pteval_t, 0x0) << 2) /* MemAttr[3:0] */
+#define PTE_S2_MT_UNCACHED	 (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
+#define PTE_S2_MT_WRITETHROUGH	 (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
+#define PTE_S2_MT_WRITEBACK	 (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
 
 /*
  * EL2/HYP PTE/PMD definitions
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 43ce724..3003fd0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -60,6 +60,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define _PAGE_DEFAULT		PTE_TYPE_PAGE | PTE_AF
 
 extern pgprot_t pgprot_default;
+extern pgprot_t pgprot_s2;
+extern pgprot_t pgprot_s2_device;
 
 #define __pgprot_modify(prot,mask,bits) \
 	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
@@ -79,8 +81,8 @@ extern pgprot_t pgprot_default;
 #define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
 #define PAGE_HYP_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_HYP)
 
-#define PAGE_S2			_MOD_PROT(pgprot_default, PTE_S2_RDONLY)
-#define PAGE_S2_DEVICE		__pgprot_modify(__pgprot(PROT_DEVICE_nGnRE), PTE_PXN, PTE_S2_RDWR)
+#define PAGE_S2			_MOD_PROT(pgprot_s2, PTE_USER | PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, PTE_USER | PTE_S2_RDWR)
 
 #define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE)
 #define __PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 70b8cd4..ef26978 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -46,6 +46,12 @@ EXPORT_SYMBOL(empty_zero_page);
 pgprot_t pgprot_default;
 EXPORT_SYMBOL(pgprot_default);
 
+pgprot_t pgprot_s2;
+EXPORT_SYMBOL(pgprot_s2);
+
+pgprot_t pgprot_s2_device;
+EXPORT_SYMBOL(pgprot_s2_device);
+
 static pmdval_t prot_sect_kernel;
 
 struct cachepolicy {
@@ -147,6 +153,9 @@ static void __init init_mem_pgprot(void)
 	}
 
 	pgprot_default = __pgprot(PTE_TYPE_PAGE | PTE_AF | default_pgprot);
+
+	pgprot_s2 = __pgprot(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED | PTE_S2_MT_WRITEBACK);
+	pgprot_s2_device = __pgprot(PTE_TYPE_PAGE | PTE_AF | PTE_S2_MT_DEVICE);
 }
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
1.7.9.5
