From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Apr 2013 17:17:04 +0100
Subject: [PATCH v3 02/32] arm64: KVM: define HYP and Stage-2 translation page
 flags
In-Reply-To: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365437854-30214-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HYP and S2 page flags, for both normal and device memory.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 13 +++++++++++++
 arch/arm64/include/asm/pgtable.h       | 12 ++++++++++++
 2 files changed, 25 insertions(+)

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
index e333a24..7c84ab4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -76,6 +76,12 @@ extern pgprot_t pgprot_default;
 #define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY)
 #define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY)
 
+#define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
+#define PAGE_HYP_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_HYP)
+
+#define PAGE_S2			_MOD_PROT(pgprot_default, PTE_USER | PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_USER | PTE_S2_RDWR)
+
 #define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE)
 #define __PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
 #define __PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
@@ -197,6 +203,12 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
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
-- 
1.8.1.4
