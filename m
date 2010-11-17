From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Nov 2010 17:29:15 +0000
Subject: [PATCH 3/5] ARM: pgtable: introduce pteval_t to represent a pte value
In-Reply-To: <20101117172717.GF5308@n2100.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
Message-ID: <E1PIlop-0007qc-1e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes everywhere dealing with pte values use the same type.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/page.h    |    6 ++++--
 arch/arm/include/asm/pgtable.h |   39 ++++++++++++++++++++-------------------
 arch/arm/mm/fault-armv.c       |    2 +-
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index a485ac3..f51a695 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -151,13 +151,15 @@ extern void __cpu_copy_user_highpage(struct page *to, struct page *from,
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 extern void copy_page(void *to, const void *from);
 
+typedef unsigned long pteval_t;
+
 #undef STRICT_MM_TYPECHECKS
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
  * These are used to make use of C type-checking..
  */
-typedef struct { unsigned long pte; } pte_t;
+typedef struct { pteval_t pte; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd[2]; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
@@ -175,7 +177,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /*
  * .. while these make it easier on the compiler
  */
-typedef unsigned long pte_t;
+typedef pteval_t pte_t;
 typedef unsigned long pmd_t;
 typedef unsigned long pgd_t[2];
 typedef unsigned long pgprot_t;
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f54d2fe..59e0ea2 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -10,6 +10,7 @@
 #ifndef _ASMARM_PGTABLE_H
 #define _ASMARM_PGTABLE_H
 
+#include <linux/const.h>
 #include <asm-generic/4level-fixup.h>
 #include <asm/proc-fns.h>
 
@@ -165,30 +166,30 @@ extern void __pgd_error(const char *file, int line, pgd_t);
  * The PTE table pointer refers to the hardware entries; the "Linux"
  * entries are stored 1024 bytes below.
  */
-#define L_PTE_PRESENT		(1 << 0)
-#define L_PTE_YOUNG		(1 << 1)
-#define L_PTE_FILE		(1 << 2)	/* only when !PRESENT */
-#define L_PTE_DIRTY		(1 << 6)
-#define L_PTE_WRITE		(1 << 7)
-#define L_PTE_USER		(1 << 8)
-#define L_PTE_EXEC		(1 << 9)
-#define L_PTE_SHARED		(1 << 10)	/* shared(v6), coherent(xsc3) */
+#define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
+#define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
+#define L_PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !PRESENT */
+#define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
+#define L_PTE_WRITE		(_AT(pteval_t, 1) << 7)
+#define L_PTE_USER		(_AT(pteval_t, 1) << 8)
+#define L_PTE_EXEC		(_AT(pteval_t, 1) << 9)
+#define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
 
 /*
  * These are the memory types, defined to be compatible with
  * pre-ARMv6 CPUs cacheable and bufferable bits:   XXCB
  */
-#define L_PTE_MT_UNCACHED	(0x00 << 2)	/* 0000 */
-#define L_PTE_MT_BUFFERABLE	(0x01 << 2)	/* 0001 */
-#define L_PTE_MT_WRITETHROUGH	(0x02 << 2)	/* 0010 */
-#define L_PTE_MT_WRITEBACK	(0x03 << 2)	/* 0011 */
-#define L_PTE_MT_MINICACHE	(0x06 << 2)	/* 0110 (sa1100, xscale) */
-#define L_PTE_MT_WRITEALLOC	(0x07 << 2)	/* 0111 */
-#define L_PTE_MT_DEV_SHARED	(0x04 << 2)	/* 0100 */
-#define L_PTE_MT_DEV_NONSHARED	(0x0c << 2)	/* 1100 */
-#define L_PTE_MT_DEV_WC		(0x09 << 2)	/* 1001 */
-#define L_PTE_MT_DEV_CACHED	(0x0b << 2)	/* 1011 */
-#define L_PTE_MT_MASK		(0x0f << 2)
+#define L_PTE_MT_UNCACHED	(_AT(pteval_t, 0x00) << 2)	/* 0000 */
+#define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
+#define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
+#define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
+#define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
+#define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
+#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
+#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
+#define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
+#define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 83e59f8..01210db 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -26,7 +26,7 @@
 
 #include "mm.h"
 
-static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
+static pteval_t shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
 #if __LINUX_ARM_ARCH__ < 6
 /*
-- 
1.6.2.5
