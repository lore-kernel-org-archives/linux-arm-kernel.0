From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:02:04 +0200
Subject: [PATCH] ARM: thp: fix unterminated ifdef in header file
Message-ID: <5446974.UXhT00HeJk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change accidentally removed one line more than it should
have, causing the build to fail with ARM LPAE:

In file included from /git/arm-soc/arch/arm/include/asm/pgtable.h:31:0,
                 from /git/arm-soc/include/linux/mm.h:55,
                 from /git/arm-soc/arch/arm/kernel/asm-offsets.c:15:
/git/arm-soc/arch/arm/include/asm/pgtable-3level.h:20:0: error: unterminated #ifndef
 #ifndef _ASM_PGTABLE_3LEVEL_H

This puts the line back where it was.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f054144a1b23 ("arm, thp: remove infrastructure for handling splitting PMDs")
---
I noticed this on today's linux-next. It's likely that someone else did too
and already submitted a patch, so mine can be ignored. Otherwise please fold
into the original patch.

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index d42f81f13618..dc46398bc3a5 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -231,6 +231,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
+#endif
 
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
