From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:00:57 +0000
Subject: [PATCH v2 02/30] arm64: KVM: define HYP and Stage-2 translation page
 flags
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364317285-20937-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HYP and S2 page flags, for both normal and device memory.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 13 +++++++++++++
 arch/arm64/include/asm/pgtable.h       | 13 +++++++++++++
 arch/arm64/mm/mmu.c                    |  6 +++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 75fd13d..acb4ee5 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -35,6 +35,7 @@
 /*
  * Section
  */
+#define PMD_SECT_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
 #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
 #define PMD_SECT_AF		(_AT(pmdval_t, 1) << 10)
 #define PMD_SECT_NG		(_AT(pmdval_t, 1) << 11)
@@ -68,6 +69,18 @@
 #define PTE_ATTRINDX_MASK	(_AT(pteval_t, 7) << 2)
 
 /*
+ * 2nd stage PTE definitions
+ */
+#define PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
+#define PTE_S2_RDWR		 (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */
+
+/*
+ * EL2/HYP PTE/PMD definitions
+ */
+#define PMD_HYP			PMD_SECT_USER
+#define PTE_HYP			PTE_USER
+
+/*
  * 40-bit physical address supported.
  */
 #define PHYS_MASK_SHIFT		(40)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e333a24..11c608a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -60,6 +60,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define _PAGE_DEFAULT		PTE_TYPE_PAGE | PTE_AF
 
 extern pgprot_t pgprot_default;
+extern pgprot_t	pgprot_device;
 
 #define __pgprot_modify(prot,mask,bits) \
 	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
@@ -76,6 +77,12 @@ extern pgprot_t pgprot_default;
 #define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY)
 #define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY)
 
+#define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
+#define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_device, PTE_HYP)
+
+#define PAGE_S2			_MOD_PROT(pgprot_default, PTE_USER | PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_device, PTE_USER | PTE_S2_RDWR)
+
 #define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE)
 #define __PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
 #define __PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
@@ -197,6 +204,12 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 #define pmd_bad(pmd)		(!(pmd_val(pmd) & 2))
 
+#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
+				 PMD_TYPE_TABLE)
+#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
+				 PMD_TYPE_SECT)
+
+
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	*pmdp = pmd;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 224b44a..df03aea 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -44,6 +44,7 @@ struct page *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
 pgprot_t pgprot_default;
+pgprot_t pgprot_device;
 EXPORT_SYMBOL(pgprot_default);
 
 static pmdval_t prot_sect_kernel;
@@ -127,10 +128,11 @@ early_param("cachepolicy", early_cachepolicy);
  */
 static void __init init_mem_pgprot(void)
 {
-	pteval_t default_pgprot;
+	pteval_t default_pgprot, device_pgprot;
 	int i;
 
 	default_pgprot = PTE_ATTRINDX(MT_NORMAL);
+	device_pgprot = PTE_ATTRINDX(MT_DEVICE_nGnRE) | PTE_PXN | PTE_UXN;
 	prot_sect_kernel = PMD_TYPE_SECT | PMD_SECT_AF | PMD_ATTRINDX(MT_NORMAL);
 
 #ifdef CONFIG_SMP
@@ -138,6 +140,7 @@ static void __init init_mem_pgprot(void)
 	 * Mark memory with the "shared" attribute for SMP systems
 	 */
 	default_pgprot |= PTE_SHARED;
+	device_pgprot |= PTE_SHARED;
 	prot_sect_kernel |= PMD_SECT_S;
 #endif
 
@@ -147,6 +150,7 @@ static void __init init_mem_pgprot(void)
 	}
 
 	pgprot_default = __pgprot(PTE_TYPE_PAGE | PTE_AF | default_pgprot);
+	pgprot_device = __pgprot(PTE_TYPE_PAGE | PTE_AF | device_pgprot);
 }
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
1.8.1.4
