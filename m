From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Feb 2016 09:51:45 +0100
Subject: arm64 defconfig currently broken in -next
Message-ID: <CAKv+Gu933t2DjBoHEfe=ZNcbrJMHHvT_F3Pug261w0WYTduVTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 defconfig is currently broken in -next, due to the way
early_memremap_ro() is compiled conditionally, based on a condition
that incorrectly resolves to false due to the inclusion order of
various header files

This fixes it for me

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 16438dd..c6ede6d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -49,16 +49,6 @@

 #define FIRST_USER_ADDRESS     0UL

-#ifndef __ASSEMBLY__
-
-#include <asm/fixmap.h>
-#include <linux/mmdebug.h>
-
-extern void __pte_error(const char *file, int line, unsigned long val);
-extern void __pmd_error(const char *file, int line, unsigned long val);
-extern void __pud_error(const char *file, int line, unsigned long val);
-extern void __pgd_error(const char *file, int line, unsigned long val);
-
 #define PROT_DEFAULT           (PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define PROT_SECT_DEFAULT      (PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)

@@ -112,6 +102,16 @@
 #define __S110  PAGE_SHARED_EXEC
 #define __S111  PAGE_SHARED_EXEC

+#ifndef __ASSEMBLY__
+
+#include <asm/fixmap.h>
+#include <linux/mmdebug.h>
+
+extern void __pte_error(const char *file, int line, unsigned long val);
+extern void __pmd_error(const char *file, int line, unsigned long val);
+extern void __pud_error(const char *file, int line, unsigned long val);
+extern void __pgd_error(const char *file, int line, unsigned long val);
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
