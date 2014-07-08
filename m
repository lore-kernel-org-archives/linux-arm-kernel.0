From: minchan@kernel.org (Minchan Kim)
Date: Tue,  8 Jul 2014 15:03:43 +0900
Subject: [PATCH v11 6/7] ARM: add pmd_[dirty|mkclean] for THP
In-Reply-To: <1404799424-1120-1-git-send-email-minchan@kernel.org>
References: <1404799424-1120-1-git-send-email-minchan@kernel.org>
Message-ID: <1404799424-1120-7-git-send-email-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
overwrite of the contents since MADV_FREE syscall is called for
THP page.

This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/include/asm/pgtable-3level.h | 3 +++
 arch/arm64/include/asm/pgtable.h      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 85c60adc8b60..3a7bb8dc7d05 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -220,6 +220,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
 #endif
 
+#define pmd_dirty	(pmd_val(pmd) & PMD_SECT_DIRTY)
+
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
 
@@ -228,6 +230,7 @@ PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
 PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
 PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
+PMD_BIT_FUNC(mkclean,   &= ~PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 579702086488..f3ec01cef04f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -240,10 +240,12 @@ static inline pmd_t pte_pmd(pte_t pte)
 #endif
 
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
+#define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mksplitting(pmd)	pte_pmd(pte_mkspecial(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_TYPE_MASK))
-- 
2.0.0
