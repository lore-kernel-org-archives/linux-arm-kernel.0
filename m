From: steve.capper@linaro.org (Steve Capper)
Date: Thu,  6 Feb 2014 14:16:09 +0000
Subject: [PATCH 1/3] arm64: mm: Remove PMD_BIT_FUNC macro
In-Reply-To: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1391696171-8922-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expand out the pmd thp manipulation functions. This makes our life
easier when using things like tags and cscope.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 51 ++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b524dcd..a3fb1e4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -247,16 +247,47 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
 #endif
 
-#define PMD_BIT_FUNC(fn,op) \
-static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
-
-PMD_BIT_FUNC(wrprotect,	|= PMD_SECT_RDONLY);
-PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
-PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
-PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
-PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
-PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
-PMD_BIT_FUNC(mknotpresent, &= ~PMD_TYPE_MASK);
+static inline pmd_t pmd_wrprotect(pmd_t pmd)
+{
+	pmd_val(pmd) |= PMD_SECT_RDONLY;
+	return pmd;
+}
+
+static inline pmd_t pmd_mkold(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~PMD_SECT_AF;
+	return pmd;
+}
+
+static inline pmd_t pmd_mksplitting(pmd_t pmd)
+{
+	pmd_val(pmd) |= PMD_SECT_SPLITTING;
+	return pmd;
+}
+
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~PMD_SECT_RDONLY;
+	return pmd;
+}
+
+static inline pmd_t pmd_mkdirty(pmd_t pmd)
+{
+	pmd_val(pmd) |= PMD_SECT_DIRTY;
+	return pmd;
+}
+
+static inline pmd_t pmd_mkyoung(pmd_t pmd)
+{
+	pmd_val(pmd) |= PMD_SECT_AF;
+	return pmd;
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~PMD_TYPE_MASK;
+	return pmd;
+}
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
-- 
1.8.1.4
