From: b38611@freescale.com (Fugang Duan)
Date: Thu, 3 Dec 2015 18:36:02 +0800
Subject: [PATCH] drivers: dma-coherent: free memory when failed to init DMA
 memory pool
Message-ID: <1449138962-8264-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free dma coherent memory when it failed to init DMA memory pool after
calling .dma_init_coherent_memory(), otherwise it causes memmory leak.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/base/dma-coherent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 55b8398..beb6bbe 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -286,6 +286,7 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 				     &mem) != DMA_MEMORY_MAP) {
 		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
 			&rmem->base, (unsigned long)rmem->size / SZ_1M);
+		kfree(mem);
 		return -ENODEV;
 	}
 	rmem->priv = mem;
-- 
1.9.1
