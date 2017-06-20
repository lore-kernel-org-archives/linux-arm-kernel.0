From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Jun 2017 06:42:19 -0700
Subject: [PATCH v5 3/7] drivers: dma-coherent: Account dma_pfn_offset
 when used with device tree
In-Reply-To: <1495621472-9323-4-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170620134219.GA31496@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wouldn't the smal patch below solve the same issue in a simple way?

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 640a7e63c453..e8f8447d705b 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -290,9 +290,11 @@ EXPORT_SYMBOL(dma_mmap_from_coherent);
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
 	struct dma_coherent_mem *mem = rmem->priv;
+	dma_addr_t dev_addr = ((rmem->base >> PAGE_SHIFT) -
+				dev->dma_pfn_offset) << PAGE_SHIFT;
 
 	if (!mem &&
-	    !dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+	    !dma_init_coherent_memory(rmem->base, dev_addr, rmem->size,
 				      DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
 				      &mem)) {
 		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
