From: yao.yuan@freescale.com (Yuan Yao)
Date: Mon, 19 Oct 2015 15:56:48 +0800
Subject: [PATCH] arm: fix a compile error for pgtable-3level.h
Message-ID: <1445241408-11897-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the compile error:
In file included from ./arch/arm/include/asm/pgtable.h:31:0,
                 from include/linux/mm.h:55,
                 from arch/arm/kernel/asm-offsets.c:15:
./arch/arm/include/asm/pgtable-3level.h:20:0: error: unterminated #ifndef
 #ifndef _ASM_PGTABLE_3LEVEL_H
 ^
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

The
 #endif
for
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
is missing.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/include/asm/pgtable-3level.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index d42f81f..dc46398 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -231,6 +231,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
+#endif
 
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
-- 
2.1.0.27.g96db324
