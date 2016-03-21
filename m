From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Mar 2016 18:38:44 +0100
Subject: [PATCH 2/2] arm64: choose memstart_addr based on minimum sparsemem
 section alignment
In-Reply-To: <1458581924-14462-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1458581924-14462-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1458581924-14462-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 36e5cd6b897e, which was needed in v4.5 and before to
ensure the correct alignment of the base of the vmemmap region. However,
since commit a7f8de168ace ("arm64: allow kernel Image to be loaded anywhere
in physical memory"), the alignment of memstart_addr itself can be freely
chosen, which means we can choose it such that additional rounding in the
definition of vmemmap is no longer necessary.

So redefine ARM64_MEMSTART_ALIGN in terms of the minimal alignment required
by sparsemem, and drop the redundant rounding in the definition of vmemmap.

Note that the net result of this change is that we align memstart_addr to
1 GB in all cases, since sparsemem is mandatory on arm64.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 17 +++++++++++++++--
 arch/arm64/include/asm/pgtable.h        |  5 ++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 5c6375d8528b..a144ae2953a2 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -19,6 +19,7 @@
 #ifndef __ASM_KERNEL_PGTABLE_H
 #define __ASM_KERNEL_PGTABLE_H
 
+#include <asm/sparsemem.h>
 
 /*
  * The linear mapping and the start of memory are both 2M aligned (per
@@ -87,9 +88,21 @@
  * in the page tables: 32 * PMD_SIZE (16k granule)
  */
 #ifdef CONFIG_ARM64_64K_PAGES
-#define ARM64_MEMSTART_ALIGN	SZ_512M
+#define ARM64_MEMSTART_BITS	29
 #else
-#define ARM64_MEMSTART_ALIGN	SZ_1G
+#define ARM64_MEMSTART_BITS	30
+#endif
+
+/*
+ * sparsemem imposes an additional requirement on the alignment of
+ * memstart_addr, due to the fact that the base of the vmemmap region
+ * has a direct correspondence, and needs to appear sufficiently aligned
+ * in the virtual address space.
+ */
+#if defined(CONFIG_SPARSEMEM_VMEMMAP) && ARM64_MEMSTART_BITS < SECTION_SIZE_BITS
+#define ARM64_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
+#else
+#define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_BITS)
 #endif
 
 #endif	/* __ASM_KERNEL_PGTABLE_H */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 989fef16d461..aa6106ac050c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -32,14 +32,13 @@
  * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
  *	fixed mappings and modules
  */
-#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
+#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
 
 #define VMALLOC_START		(MODULES_END)
 #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
 
 #define VMEMMAP_START		(VMALLOC_END + SZ_64K)
-#define vmemmap			((struct page *)VMEMMAP_START - \
-				 SECTION_ALIGN_DOWN(memstart_addr >> PAGE_SHIFT))
+#define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
 #define FIRST_USER_ADDRESS	0UL
 
-- 
1.9.1
