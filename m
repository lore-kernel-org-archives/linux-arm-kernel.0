From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Jul 2014 18:12:35 +0100
Subject: [PATCH 12/11] arm64: Remove asm/pgtable-*level-types.h files
In-Reply-To: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1405703555-9314-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros and typedefs in these files are already duplicated, so just
use a single pgtable-types.h file with the corresponding #ifdefs.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Some more clean-up similar to the removal of pgtable-*level-hwdef.h

 arch/arm64/include/asm/page.h                      |  8 +--
 arch/arm64/include/asm/pgtable-2level-types.h      | 62 -------------------
 arch/arm64/include/asm/pgtable-3level-types.h      | 68 --------------------
 .../{pgtable-4level-types.h => pgtable-types.h}    | 72 ++++++++++++++--------
 4 files changed, 49 insertions(+), 161 deletions(-)
 delete mode 100644 arch/arm64/include/asm/pgtable-2level-types.h
 delete mode 100644 arch/arm64/include/asm/pgtable-3level-types.h
 rename arch/arm64/include/asm/{pgtable-4level-types.h => pgtable-types.h} (73%)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index a998ff478777..2502754d1921 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -47,13 +47,7 @@
 
 #ifndef __ASSEMBLY__
 
-#if CONFIG_ARM64_PGTABLE_LEVELS == 2
-#include <asm/pgtable-2level-types.h>
-#elif CONFIG_ARM64_PGTABLE_LEVELS == 3
-#include <asm/pgtable-3level-types.h>
-#else
-#include <asm/pgtable-4level-types.h>
-#endif
+#include <asm/pgtable-types.h>
 
 extern void __cpu_clear_user_page(void *p, unsigned long user);
 extern void __cpu_copy_user_page(void *to, const void *from,
diff --git a/arch/arm64/include/asm/pgtable-2level-types.h b/arch/arm64/include/asm/pgtable-2level-types.h
deleted file mode 100644
index 5f101e63dfc1..000000000000
--- a/arch/arm64/include/asm/pgtable-2level-types.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_PGTABLE_2LEVEL_TYPES_H
-#define __ASM_PGTABLE_2LEVEL_TYPES_H
-
-#include <asm/types.h>
-
-typedef u64 pteval_t;
-typedef u64 pgdval_t;
-typedef pgdval_t pmdval_t;
-
-#undef STRICT_MM_TYPECHECKS
-
-#ifdef STRICT_MM_TYPECHECKS
-
-/*
- * These are used to make use of C type-checking..
- */
-typedef struct { pteval_t pte; } pte_t;
-typedef struct { pgdval_t pgd; } pgd_t;
-typedef struct { pteval_t pgprot; } pgprot_t;
-
-#define pte_val(x)      ((x).pte)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)   ((x).pgprot)
-
-#define __pte(x)        ((pte_t) { (x) } )
-#define __pgd(x)	((pgd_t) { (x) } )
-#define __pgprot(x)     ((pgprot_t) { (x) } )
-
-#else	/* !STRICT_MM_TYPECHECKS */
-
-typedef pteval_t pte_t;
-typedef pgdval_t pgd_t;
-typedef pteval_t pgprot_t;
-
-#define pte_val(x)	(x)
-#define pgd_val(x)	(x)
-#define pgprot_val(x)	(x)
-
-#define __pte(x)	(x)
-#define __pgd(x)	(x)
-#define __pgprot(x)	(x)
-
-#endif	/* STRICT_MM_TYPECHECKS */
-
-#include <asm-generic/pgtable-nopmd.h>
-
-#endif	/* __ASM_PGTABLE_2LEVEL_TYPES_H */
diff --git a/arch/arm64/include/asm/pgtable-3level-types.h b/arch/arm64/include/asm/pgtable-3level-types.h
deleted file mode 100644
index 4e94424938a4..000000000000
--- a/arch/arm64/include/asm/pgtable-3level-types.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_PGTABLE_3LEVEL_TYPES_H
-#define __ASM_PGTABLE_3LEVEL_TYPES_H
-
-#include <asm/types.h>
-
-typedef u64 pteval_t;
-typedef u64 pmdval_t;
-typedef u64 pgdval_t;
-
-#undef STRICT_MM_TYPECHECKS
-
-#ifdef STRICT_MM_TYPECHECKS
-
-/*
- * These are used to make use of C type-checking..
- */
-typedef struct { pteval_t pte; } pte_t;
-typedef struct { pmdval_t pmd; } pmd_t;
-typedef struct { pgdval_t pgd; } pgd_t;
-typedef struct { pteval_t pgprot; } pgprot_t;
-
-#define pte_val(x)      ((x).pte)
-#define pmd_val(x)      ((x).pmd)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)   ((x).pgprot)
-
-#define __pte(x)        ((pte_t) { (x) } )
-#define __pmd(x)        ((pmd_t) { (x) } )
-#define __pgd(x)	((pgd_t) { (x) } )
-#define __pgprot(x)     ((pgprot_t) { (x) } )
-
-#else	/* !STRICT_MM_TYPECHECKS */
-
-typedef pteval_t pte_t;
-typedef pmdval_t pmd_t;
-typedef pgdval_t pgd_t;
-typedef pteval_t pgprot_t;
-
-#define pte_val(x)	(x)
-#define pmd_val(x)	(x)
-#define pgd_val(x)	(x)
-#define pgprot_val(x)	(x)
-
-#define __pte(x)	(x)
-#define __pmd(x)	(x)
-#define __pgd(x)	(x)
-#define __pgprot(x)	(x)
-
-#endif	/* STRICT_MM_TYPECHECKS */
-
-#include <asm-generic/pgtable-nopud.h>
-
-#endif	/* __ASM_PGTABLE_3LEVEL_TYPES_H */
diff --git a/arch/arm64/include/asm/pgtable-4level-types.h b/arch/arm64/include/asm/pgtable-types.h
similarity index 73%
rename from arch/arm64/include/asm/pgtable-4level-types.h
rename to arch/arm64/include/asm/pgtable-types.h
index 7ad8dd257ea1..ca9df80af896 100644
--- a/arch/arm64/include/asm/pgtable-4level-types.h
+++ b/arch/arm64/include/asm/pgtable-types.h
@@ -1,5 +1,10 @@
 /*
- * This program is free software; you can redistribute it and/or modify
+ * Page table types definitions.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
@@ -11,8 +16,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_PGTABLE_4LEVEL_TYPES_H
-#define __ASM_PGTABLE_4LEVEL_TYPES_H
+
+#ifndef __ASM_PGTABLE_TYPES_H
+#define __ASM_PGTABLE_TYPES_H
 
 #include <asm/types.h>
 
@@ -29,43 +35,61 @@ typedef u64 pgdval_t;
  * These are used to make use of C type-checking..
  */
 typedef struct { pteval_t pte; } pte_t;
-typedef struct { pmdval_t pmd; } pmd_t;
-typedef struct { pudval_t pud; } pud_t;
-typedef struct { pgdval_t pgd; } pgd_t;
-typedef struct { pteval_t pgprot; } pgprot_t;
-
 #define pte_val(x)	((x).pte)
-#define pmd_val(x)	((x).pmd)
-#define pud_val(x)	((x).pud)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
-
 #define __pte(x)	((pte_t) { (x) } )
+
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
+typedef struct { pmdval_t pmd; } pmd_t;
+#define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
+#endif
+
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
+typedef struct { pudval_t pud; } pud_t;
+#define pud_val(x)	((x).pud)
 #define __pud(x)	((pud_t) { (x) } )
+#endif
+
+typedef struct { pgdval_t pgd; } pgd_t;
+#define pgd_val(x)	((x).pgd)
 #define __pgd(x)	((pgd_t) { (x) } )
+
+typedef struct { pteval_t pgprot; } pgprot_t;
+#define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
 #else	/* !STRICT_MM_TYPECHECKS */
 
 typedef pteval_t pte_t;
-typedef pmdval_t pmd_t;
-typedef pudval_t pud_t;
-typedef pgdval_t pgd_t;
-typedef pteval_t pgprot_t;
-
 #define pte_val(x)	(x)
-#define pmd_val(x)	(x)
-#define pud_val(x)	(x)
-#define pgd_val(x)	(x)
-#define pgprot_val(x)	(x)
-
 #define __pte(x)	(x)
+
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
+typedef pmdval_t pmd_t;
+#define pmd_val(x)	(x)
 #define __pmd(x)	(x)
+#endif
+
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
+typedef pudval_t pud_t;
+#define pud_val(x)	(x)
 #define __pud(x)	(x)
+#endif
+
+typedef pgdval_t pgd_t;
+#define pgd_val(x)	(x)
 #define __pgd(x)	(x)
+
+typedef pteval_t pgprot_t;
+#define pgprot_val(x)	(x)
 #define __pgprot(x)	(x)
 
 #endif /* STRICT_MM_TYPECHECKS */
 
-#endif /* __ASM_PGTABLE_4LEVEL_TYPES_H */
+#if CONFIG_ARM64_PGTABLE_LEVELS == 2
+#include <asm-generic/pgtable-nopmd.h>
+#elif CONFIG_ARM64_PGTABLE_LEVELS == 3
+#include <asm-generic/pgtable-nopud.h>
+#endif
+
+#endif	/* __ASM_PGTABLE_TYPES_H */
