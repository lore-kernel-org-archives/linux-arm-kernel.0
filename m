From: yang.shi@linaro.org (Yang Shi)
Date: Fri, 29 Apr 2016 14:07:54 -0700
Subject: [PATCH] arm64: always use STRICT_MM_TYPECHECKS
Message-ID: <1461964074-12544-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by the counterpart of powerpc [1], which shows there is no negative
effect on code generation from enabling STRICT_MM_TYPECHECKS with a modern
compiler.

And, Arnd's comment [2] about that patch says STRICT_MM_TYPECHECKS could
be default as long as the architecture can pass structures in registers as
function arguments. ARM64 can do it as long as the size of structure <= 16
bytes. All the page table value types are u64 on ARM64.

The below disassembly demonstrates it, entry is pte_t type:

            entry = arch_make_huge_pte(entry, vma, page, writable);
   0xffff00000826fc38 <+80>:    and     x0, x0, #0xfffffffffffffffd
   0xffff00000826fc3c <+84>:    mov     w3, w21
   0xffff00000826fc40 <+88>:    mov     x2, x20
   0xffff00000826fc44 <+92>:    mov     x1, x19
   0xffff00000826fc48 <+96>:    orr     x0, x0, #0x400
   0xffff00000826fc4c <+100>:   bl      0xffff00000809bcc0 <arch_make_huge_pte>

[1] http://www.spinics.net/lists/linux-mm/msg105951.html
[2] http://www.spinics.net/lists/linux-mm/msg105969.html

Signed-off-by: Yang Shi <yang.shi@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable-types.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
index 2b1bd7e..69b2fd4 100644
--- a/arch/arm64/include/asm/pgtable-types.h
+++ b/arch/arm64/include/asm/pgtable-types.h
@@ -27,10 +27,6 @@ typedef u64 pmdval_t;
 typedef u64 pudval_t;
 typedef u64 pgdval_t;
 
-#undef STRICT_MM_TYPECHECKS
-
-#ifdef STRICT_MM_TYPECHECKS
-
 /*
  * These are used to make use of C type-checking..
  */
@@ -58,34 +54,6 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-#else	/* !STRICT_MM_TYPECHECKS */
-
-typedef pteval_t pte_t;
-#define pte_val(x)	(x)
-#define __pte(x)	(x)
-
-#if CONFIG_PGTABLE_LEVELS > 2
-typedef pmdval_t pmd_t;
-#define pmd_val(x)	(x)
-#define __pmd(x)	(x)
-#endif
-
-#if CONFIG_PGTABLE_LEVELS > 3
-typedef pudval_t pud_t;
-#define pud_val(x)	(x)
-#define __pud(x)	(x)
-#endif
-
-typedef pgdval_t pgd_t;
-#define pgd_val(x)	(x)
-#define __pgd(x)	(x)
-
-typedef pteval_t pgprot_t;
-#define pgprot_val(x)	(x)
-#define __pgprot(x)	(x)
-
-#endif /* STRICT_MM_TYPECHECKS */
-
 #if CONFIG_PGTABLE_LEVELS == 2
 #include <asm-generic/pgtable-nopmd.h>
 #elif CONFIG_PGTABLE_LEVELS == 3
-- 
2.0.2
