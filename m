From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 May 2010 14:21:47 +0100
Subject: [PATCH 3/7] ARM: Avoid the CONSISTENT_DMA_SIZE warning on noMMU builds
In-Reply-To: <20100520131833.7521.66668.stgit@e102109-lin.cambridge.arm.com>
References: <20100520131833.7521.66668.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100520132147.7521.71018.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro is not defined when !CONFIG_MMU.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 13fa536..c4de90f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -25,6 +25,7 @@
 #include <asm/sizes.h>
 
 /* Sanity check size */
+#ifdef CONFIG_MMU
 #if (CONSISTENT_DMA_SIZE % SZ_2M)
 #error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
 #endif
@@ -32,6 +33,7 @@
 #define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
 #define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
 #define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
+#endif
 
 static u64 get_coherent_dma_mask(struct device *dev)
 {
