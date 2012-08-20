From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Aug 2012 12:47:26 +0200
Subject: [PATCH 1/3] ARM: DMA-Mapping: add function for setting coherent pool
 size from platform code
In-Reply-To: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1345459648-24263-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms might require to increase atomic coherent pool to make
sure that their device will be able to allocate all their buffers from
atomic context. This function can be also used to decrease atomic
coherent pool size if coherent allocations are not used for the given
sub-platform.

Suggested-by: Josh Coombs <josh.coombs@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-mapping.h |    7 +++++++
 arch/arm/mm/dma-mapping.c          |   19 ++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 2ae842d..a53940d 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -203,6 +203,13 @@ static inline void dma_free_writecombine(struct device *dev, size_t size,
 }
 
 /*
+ * This can be called during early boot to increase the size of the atomic
+ * coherent DMA pool above the default value of 256KiB. It must be called 
+ * before postcore_initcall.
+ */
+extern void __init init_dma_coherent_pool_size(unsigned long size);
+
+/*
  * This can be called during boot to increase the size of the consistent
  * DMA region above it's default value of 2MB. It must be called before the
  * memory allocator is initialised, i.e. before any core_initcall.
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4e7d118..d1cc9c1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -267,6 +267,8 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 	vunmap(cpu_addr);
 }
 
+#define DEFAULT_DMA_COHERENT_POOL_SIZE	SZ_256K
+
 struct dma_pool {
 	size_t size;
 	spinlock_t lock;
@@ -277,7 +279,7 @@ struct dma_pool {
 };
 
 static struct dma_pool atomic_pool = {
-	.size = SZ_256K,
+	.size = DEFAULT_DMA_COHERENT_POOL_SIZE,
 };
 
 static int __init early_coherent_pool(char *p)
@@ -287,6 +289,21 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
+void __init init_dma_coherent_pool_size(unsigned long size)
+{
+	/*
+	 * Catch any attempt to set the pool size too late.
+	 */
+	BUG_ON(atomic_pool.vaddr);
+
+	/*
+	 * Set architecture specific coherent pool size only if
+	 * it has not been changed by kernel command line parameter.
+	 */
+	if (atomic_pool.size == DEFAULT_DMA_COHERENT_POOL_SIZE)
+		atomic_pool.size = size;
+}
+
 /*
  * Initialise the coherent pool for atomic allocations.
  */
-- 
1.7.1.569.g6f426
