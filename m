From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 17:40:13 +0000
Subject: [PATCH v3 04/20] ARM: LPAE: use u32 instead of unsigned long for
	32-bit ptes
In-Reply-To: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1289842829-3027-5-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

When using 2-level paging, pte_t and pmd_t are typedefs for
unsigned long but phys_addr_t is a typedef for u32.

This patch uses u32 for the page table entry types when
phys_addr_t is not 64-bit, allowing the same conversion
specifier to be used for physical addresses and page table
entries regardless of LPAE.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/page-nommu.h           |    8 ++++----
 arch/arm/include/asm/pgtable-2level-types.h |   18 +++++++++---------
 arch/arm/mm/fault-armv.c                    |    2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
index d1b162a..a20641a 100644
--- a/arch/arm/include/asm/page-nommu.h
+++ b/arch/arm/include/asm/page-nommu.h
@@ -29,10 +29,10 @@
 /*
  * These are used to make use of C type-checking..
  */
-typedef unsigned long pte_t;
-typedef unsigned long pmd_t;
-typedef unsigned long pgd_t[2];
-typedef unsigned long pgprot_t;
+typedef u32 pte_t;
+typedef u32 pmd_t;
+typedef u32 pgd_t[2];
+typedef u32 pgprot_t;
 
 #define pte_val(x)      (x)
 #define pmd_val(x)      (x)
diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
index 30f6741..adc4928 100644
--- a/arch/arm/include/asm/pgtable-2level-types.h
+++ b/arch/arm/include/asm/pgtable-2level-types.h
@@ -21,16 +21,16 @@
 
 #undef STRICT_MM_TYPECHECKS
 
-typedef unsigned long pteval_t;
+typedef u32 pteval_t;
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
  * These are used to make use of C type-checking..
  */
-typedef struct { unsigned long pte; } pte_t;
-typedef struct { unsigned long pmd; } pmd_t;
-typedef struct { unsigned long pgd[2]; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct { u32 pte; } pte_t;
+typedef struct { u32 pmd; } pmd_t;
+typedef struct { u32 pgd[2]; } pgd_t;
+typedef struct { u32 pgprot; } pgprot_t;
 
 #define pte_val(x)      ((x).pte)
 #define pmd_val(x)      ((x).pmd)
@@ -45,10 +45,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /*
  * .. while these make it easier on the compiler
  */
-typedef unsigned long pte_t;
-typedef unsigned long pmd_t;
-typedef unsigned long pgd_t[2];
-typedef unsigned long pgprot_t;
+typedef u32 pte_t;
+typedef u32 pmd_t;
+typedef u32 pgd_t[2];
+typedef u32 pgprot_t;
 
 #define pte_val(x)      (x)
 #define pmd_val(x)      (x)
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
