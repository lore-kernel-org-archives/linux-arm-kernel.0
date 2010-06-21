From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 11:29:35 +0100
Subject: [PATCH v4 1/8] ARM: Avoid the CONSISTENT_DMA_SIZE warning on noMMU
	builds
In-Reply-To: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
References: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621102935.9353.82172.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro is not defined when !CONFIG_MMU so this patch moves the
CONSISTENT_* definitions to the CONFIG_MMU section.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/dma-mapping.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 13fa536..9e7742f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -24,15 +24,6 @@
 #include <asm/tlbflush.h>
 #include <asm/sizes.h>
 
-/* Sanity check size */
-#if (CONSISTENT_DMA_SIZE % SZ_2M)
-#error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
-#endif
-
-#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
-#define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
-
 static u64 get_coherent_dma_mask(struct device *dev)
 {
 	u64 mask = ISA_DMA_THRESHOLD;
@@ -123,6 +114,15 @@ static void __dma_free_buffer(struct page *page, size_t size)
 }
 
 #ifdef CONFIG_MMU
+/* Sanity check size */
+#if (CONSISTENT_DMA_SIZE % SZ_2M)
+#error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
+#endif
+
+#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
+#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
+#define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
+
 /*
  * These are the page tables (2MB each) covering uncached, DMA consistent allocations
  */
