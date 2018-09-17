From: minchan@kernel.org (Minchan Kim)
Date: Mon, 17 Sep 2018 09:44:50 +0900
Subject: [PATCH v1 2/3] arm: mm: introduce L_PTE_SPECIAL
In-Reply-To: <20180917004451.174527-1-minchan@kernel.org>
References: <20180917004451.174527-1-minchan@kernel.org>
Message-ID: <20180917004451.174527-3-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces L_PTE_SPECIAL and pte functions for supporting
get_user_pages_fast.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/include/asm/pgtable-2level.h |  3 +--
 arch/arm/include/asm/pgtable-3level.h |  6 ------
 arch/arm/include/asm/pgtable.h        | 13 +++++++++++++
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..278cf22b5aa1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,7 +10,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
-	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
+	select ARCH_HAS_PTE_SPECIAL if (ARM_LPAE || CPU_V7 || CPU_V6 || CPUV6K)
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 514b13c27b43..378668420642 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -120,6 +120,7 @@
 #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
 #define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
+#define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 5)
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
 #define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
@@ -224,8 +225,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
-#define pte_special(pte)	(0)
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 /*
  * We don't have huge page support for short descriptors, for the moment
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 6d50a11d7793..b6f52e16b478 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -213,12 +213,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_present(pmd)	(pmd_isset((pmd), L_PMD_SECT_VALID))
 #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
-#define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	pte_val(pte) |= L_PTE_SPECIAL;
-	return pte;
-}
 
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a757401129f9..6cc7ce0e423e 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -228,6 +228,11 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
 #define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
 #define pte_exec(pte)		(pte_isclear((pte), L_PTE_XN))
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
+#define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
+#else
+#define pte_special(pte)	(0)
+#endif
 
 #define pte_valid_user(pte)	\
 	(pte_valid(pte) && pte_isset((pte), L_PTE_USER) && pte_young(pte))
@@ -318,6 +323,14 @@ static inline pte_t pte_mknexec(pte_t pte)
 	return set_pte_bit(pte, __pgprot(L_PTE_XN));
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_SPECIAL));
+}
+#else
+static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
+#endif
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
-- 
2.19.0.397.gdd90340f6a-goog
