From: albert_herranz@yahoo.es (Albert Herranz)
Date: Sun, 28 Feb 2010 15:07:54 +0100
Subject: [RFC PATCH v2 1/9] powerpc: add per-device dma coherent support
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Message-ID: <1267366082-15248-2-git-send-email-albert_herranz@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic per-device dma coherent allocator on powerpc.
This allows a driver to declare coherent memory area from where
a device can allocate coherent memory chunks.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/dma-mapping.h |    1 +
 arch/powerpc/kernel/dma.c              |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 80a973b..18ecec8 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -17,6 +17,7 @@
 #include <linux/dma-debug.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
+#include <asm-generic/dma-coherent.h>
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 6215062..83d5232 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -27,6 +27,9 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 {
 	void *ret;
 #ifdef CONFIG_NOT_COHERENT_CACHE
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
 	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
 	if (ret == NULL)
 		return NULL;
@@ -54,6 +57,8 @@ void dma_direct_free_coherent(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle)
 {
 #ifdef CONFIG_NOT_COHERENT_CACHE
+	if (dma_release_from_coherent(dev, get_order(size), vaddr))
+		return;
 	__dma_free_coherent(size, vaddr);
 #else
 	free_pages((unsigned long)vaddr, get_order(size));
-- 
1.6.3.3
