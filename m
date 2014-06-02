From: chanho.min@lge.com (Chanho Min)
Date: Mon,  2 Jun 2014 10:45:28 +0900
Subject: [PATCH] arm: dma-mapping: fix potential build error under !CMA
Message-ID: <1401673528-19077-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes build error under !CONFIG_CMA. dev_get_cma_area can be used
when CMA is disabled when the bellow patch is appied.

"arm: dma-mapping: add checking cma area initialized"
https://lkml.org/lkml/2014/5/22/35

arch/arm/mm/dma-mapping.c: In function 'atomic_pool_init':
arch/arm/mm/dma-mapping.c:361:2: error: implicit declaration of function
 'dev_get_cma_area' [-Werror=implicit-function-declaration]

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/include/asm/dma-contiguous.h |    2 +-
 include/asm-generic/dma-contiguous.h  |   13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/dma-contiguous.h b/arch/arm/include/asm/dma-contiguous.h
index 3ed37b4..56c17bc 100644
--- a/arch/arm/include/asm/dma-contiguous.h
+++ b/arch/arm/include/asm/dma-contiguous.h
@@ -2,11 +2,11 @@
 #define ASMARM_DMA_CONTIGUOUS_H
 
 #ifdef __KERNEL__
-#ifdef CONFIG_CMA
 
 #include <linux/types.h>
 #include <asm-generic/dma-contiguous.h>
 
+#ifdef CONFIG_CMA
 void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
 
 #endif
diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
index 294b1e7..3d48460 100644
--- a/include/asm-generic/dma-contiguous.h
+++ b/include/asm-generic/dma-contiguous.h
@@ -2,11 +2,11 @@
 #define ASM_DMA_CONTIGUOUS_H
 
 #ifdef __KERNEL__
-#ifdef CONFIG_CMA
 
 #include <linux/device.h>
 #include <linux/dma-contiguous.h>
 
+#ifdef CONFIG_CMA
 static inline struct cma *dev_get_cma_area(struct device *dev)
 {
 	if (dev && dev->cma_area)
@@ -22,7 +22,16 @@ static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
 		dma_contiguous_default_area = cma;
 }
 
-#endif
+#else
+static inline struct cma *dev_get_cma_area(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
+{
+}
 #endif
 
 #endif
+#endif
-- 
1.7.9.5
