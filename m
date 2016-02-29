From: brian.starkey@arm.com (Brian Starkey)
Date: Mon, 29 Feb 2016 16:09:23 +0000
Subject: [PATCH v2 3/4] drivers: dma-coherent: use MEMREMAP_WC for
 DMA_MEMORY_MAP
In-Reply-To: <cover.1456225103.git.brian.starkey@arm.com>
References: <cover.1456225103.git.brian.starkey@arm.com>
Message-ID: <4c424a3e08434387dcfbb273aa1ff061363af635.1456225103.git.brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the DMA_MEMORY_MAP flag is used, memory which can be accessed
directly should be returned, so use memremap(..., MEMREMAP_WC) to
provide a writecombine mapping.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 drivers/base/dma-coherent.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 87b8083..25bb398 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -2,6 +2,7 @@
  * Coherent per-device memory handling.
  * Borrowed from i386
  */
+#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -31,7 +32,10 @@ static bool dma_init_coherent_memory(
 	if (!size)
 		goto out;
 
-	mem_base = ioremap(phys_addr, size);
+	if (flags & DMA_MEMORY_MAP)
+		mem_base = memremap(phys_addr, size, MEMREMAP_WC);
+	else
+		mem_base = ioremap(phys_addr, size);
 	if (!mem_base)
 		goto out;
 
@@ -54,8 +58,12 @@ static bool dma_init_coherent_memory(
 
 out:
 	kfree(dma_mem);
-	if (mem_base)
-		iounmap(mem_base);
+	if (mem_base) {
+		if (flags & DMA_MEMORY_MAP)
+			memunmap(mem_base);
+		else
+			iounmap(mem_base);
+	}
 	return false;
 }
 
@@ -63,7 +71,11 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 {
 	if (!mem)
 		return;
-	iounmap(mem->virt_base);
+
+	if (mem->flags & DMA_MEMORY_MAP)
+		memunmap(mem->virt_base);
+	else
+		iounmap(mem->virt_base);
 	kfree(mem->bitmap);
 	kfree(mem);
 }
-- 
1.7.9.5
