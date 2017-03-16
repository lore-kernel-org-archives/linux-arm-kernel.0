From: tixy@linaro.org (Jon Medhurst)
Date: Thu, 16 Mar 2017 13:29:58 +0000
Subject: [PATCH 2/2] arm: Make fixmap memory type defines work with
 STRICT_MM_TYPECHECKS
In-Reply-To: <20170316132958.22227-1-tixy@linaro.org>
References: <20170316132958.22227-1-tixy@linaro.org>
Message-ID: <20170316132958.22227-2-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change fixmap's defines for memory types to make use of the same
constructs as in pgtable.h. This results in the code compiling when
STRICT_MM_TYPECHECKS is defined and enables us to directly use the
PAGE_KERNEL define rather than open coding a separate equivalent.

Whilst changing these defines, also rename FIXMAP_PAGE_COMMON to
have a double underscore prefix as this is an internal implementation
factor and not a memory type definition to be used with fixmap the APIs.

Reviewed-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/include/asm/fixmap.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 4e6784dc5668..c376dd9ac1ae 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -39,14 +39,15 @@ static const enum fixed_addresses __end_of_fixed_addresses =
 	__end_of_fixmap_region > __end_of_early_ioremap_region ?
 	__end_of_fixmap_region : __end_of_early_ioremap_region;
 
-#define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
+#define __FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
 
-#define FIXMAP_PAGE_NORMAL	(pgprot_kernel ? pgprot_kernel | L_PTE_XN : \
-					FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
-#define FIXMAP_PAGE_RO		(FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
+#define FIXMAP_PAGE_NORMAL	(pgprot_val(pgprot_kernel) ? PAGE_KERNEL : \
+				 __pgprot(__FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK))
+#define FIXMAP_PAGE_RO		_MOD_PROT(FIXMAP_PAGE_NORMAL, L_PTE_RDONLY)
 
 /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
-#define FIXMAP_PAGE_IO		(FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
+#define FIXMAP_PAGE_IO		__pgprot(__FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | \
+					 L_PTE_SHARED)
 #define FIXMAP_PAGE_NOCACHE	FIXMAP_PAGE_IO
 
 #define __early_set_fixmap	__set_fixmap
-- 
2.11.0
