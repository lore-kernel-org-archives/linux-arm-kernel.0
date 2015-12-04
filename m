From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri,  4 Dec 2015 21:14:18 +0100
Subject: [PATCH] drivers: dma-coherent: simplify dma_init_coherent_memory
 return value
Message-ID: <1449260058-3572-1-git-send-email-mina86@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since only dma_declare_coherent_memory cares about
dma_init_coherent_memory returning part of flags as it return value,
move the condition to the former and simplify the latter.  This in
turn makes rmem_dma_device_init less confusing.

Reported-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 drivers/base/dma-coherent.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 55b8398..87b8083 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -17,9 +17,9 @@ struct dma_coherent_mem {
 	spinlock_t	spinlock;
 };
 
-static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_addr,
-			     size_t size, int flags,
-			     struct dma_coherent_mem **mem)
+static bool dma_init_coherent_memory(
+	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
+	struct dma_coherent_mem **mem)
 {
 	struct dma_coherent_mem *dma_mem = NULL;
 	void __iomem *mem_base = NULL;
@@ -50,17 +50,13 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
 	spin_lock_init(&dma_mem->spinlock);
 
 	*mem = dma_mem;
-
-	if (flags & DMA_MEMORY_MAP)
-		return DMA_MEMORY_MAP;
-
-	return DMA_MEMORY_IO;
+	return true;
 
 out:
 	kfree(dma_mem);
 	if (mem_base)
 		iounmap(mem_base);
-	return 0;
+	return false;
 }
 
 static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
@@ -88,15 +84,13 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size, int flags)
 {
 	struct dma_coherent_mem *mem;
-	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, flags,
-				       &mem);
-	if (ret == 0)
+	if (!dma_init_coherent_memory(phys_addr, device_addr, size, flags,
+				      &mem))
 		return 0;
 
 	if (dma_assign_coherent_memory(dev, mem) == 0)
-		return ret;
+		return flags & DMA_MEMORY_MAP ? DMA_MEMORY_MAP : DMA_MEMORY_IO;
 
 	dma_release_coherent_memory(mem);
 	return 0;
@@ -281,9 +275,9 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	struct dma_coherent_mem *mem = rmem->priv;
 
 	if (!mem &&
-	    dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
-				     DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
-				     &mem) != DMA_MEMORY_MAP) {
+	    !dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+				      DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
+				      &mem)) {
 		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
 			&rmem->base, (unsigned long)rmem->size / SZ_1M);
 		return -ENODEV;
-- 
2.6.0.rc2.230.g3dd15c0
