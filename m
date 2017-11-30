From: bin.lu@arm.com (Bin Lu)
Date: Thu, 30 Nov 2017 00:14:09 -0800
Subject: [PATCH] arm64: dirty memory check, enable soft dirty for arm64
Message-ID: <1512029649-61312-1-git-send-email-bin.lu@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    arch/arm64/Kconfig: enable CONFIG_HAVE_ARCH_SOFT_DIRTY
    arch/arm64/include/asm/pgtable.h: enable functions for soft dirty

    Checkpoint/Restore In Userspace(CRIU) needs the page's change
    to be soft tracked. This allows to do a pre checkpoint and then dump
    only touched pages.

    This is done by using a PTE bit (PTE_DIRTY) when
    the page is backed in memory, and a new _PAGE_SWP_SOFT_DIRTY bit when
    the page is swapped out.

    The bit of PTE_DIRTY is already defined in pgtable-prot.h.

    The _PAGE_SWP_SOFT_DIRTY bit is set as 59 in the swap pte.

    pmd_dirty and pmd_mkclean for THP page MADV_FREE also were
    supported in this patch.

    This patch has been tested with ZDTM test suite in CRIU.
    Such as: ./zdtm.py run -t zdtm/static/env00 --pre 10
Signed-off-by: Bin Lu <bin.lu@arm.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfd9086..933f5be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARM_SMCCC
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6eae342..8ab251e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -306,6 +306,28 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
 	return __pgprot(pgprot_val(prot) & ~PTE_TABLE_BIT);
 }
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline bool pte_soft_dirty(pte_t pte)
+{
+        return pte_sw_dirty(pte);
+}
+
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+        return pte_mkdirty(pte);
+}
+
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+        return pte_mkclean(pte);
+}
+
+#define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
+#define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_clear_soft_dirty(pmd) pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
+
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/asm-generic/pgtable.h
@@ -695,10 +717,12 @@ extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
  *	bits 2-7:	swap type
  *	bits 8-57:	swap offset
  *	bit  58:	PTE_PROT_NONE (must be zero)
+ *	bit  59:	swap software dirty tracking
  */
 #define __SWP_TYPE_SHIFT	2
 #define __SWP_TYPE_BITS		6
 #define __SWP_OFFSET_BITS	50
+#define __SWP_PROT_NONE_BITS	1
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
 #define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
 #define __SWP_OFFSET_MASK	((1UL << __SWP_OFFSET_BITS) - 1)
@@ -710,6 +734,28 @@ extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
 
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define _PAGE_SWP_SOFT_DIRTY   (1UL << (__SWP_OFFSET_SHIFT + __SWP_OFFSET_BITS + __SWP_PROT_NONE_BITS))
+#else
+#define _PAGE_SWP_SOFT_DIRTY    0UL
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+        return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+        return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+        return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 /*
  * Ensure that there are not more swap files than can be encoded in the kernel
  * PTEs.
-- 
2.7.4
