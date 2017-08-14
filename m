From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 14 Aug 2017 09:50:19 +0100
Subject: [PATCH] ARM: dma-mapping: Remove init_dma_coherent_pool_size()
In-Reply-To: <1502700619-44809-1-git-send-email-vladimir.murzin@arm.com>
References: <1502700619-44809-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1502700619-44809-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no users of init_dma_coherent_pool_size() left due to
387870f ("mm: dmapool: use provided gfp flags for all
dma_alloc_coherent() calls"), so remove it.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/dma-mapping.h |  7 -------
 arch/arm/mm/dma-mapping.c          | 15 ---------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 4e0285a..462803f 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -190,13 +190,6 @@ extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			unsigned long attrs);
 
 /*
- * This can be called during early boot to increase the size of the atomic
- * coherent DMA pool above the default value of 256KiB. It must be called
- * before postcore_initcall.
- */
-extern void __init init_dma_coherent_pool_size(unsigned long size);
-
-/*
  * For SA-1111, IXP425, and ADI systems  the dma-mapping functions are "magic"
  * and utilize bounce buffers as needed to work around limited DMA windows.
  *
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 785606e..25a8bce 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -393,21 +393,6 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
-void __init init_dma_coherent_pool_size(unsigned long size)
-{
-	/*
-	 * Catch any attempt to set the pool size too late.
-	 */
-	BUG_ON(atomic_pool);
-
-	/*
-	 * Set architecture specific coherent pool size only if
-	 * it has not been changed by kernel command line parameter.
-	 */
-	if (atomic_pool_size == DEFAULT_DMA_COHERENT_POOL_SIZE)
-		atomic_pool_size = size;
-}
-
 /*
  * Initialise the coherent pool for atomic allocations.
  */
-- 
2.0.0
