From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 26 Jun 2017 10:18:57 +0100
Subject: [PATCH v6 3/7] drivers: dma-coherent: Account dma_pfn_offset when
 used with device tree
In-Reply-To: <1498468741-12020-1-git-send-email-vladimir.murzin@arm.com>
References: <1498468741-12020-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1498468741-12020-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_declare_coherent_memory() and friends are designed to account
difference in CPU and device addresses. However, when it is used with
reserved memory regions there is assumption that CPU and device have
the same view on address space. This assumption gets invalid when
reserved memory for coherent DMA allocations is referenced by device
with non-empty "dma-range" property.

Simply feeding device address as rmem->base + dev->dma_pfn_offset
would not work due to reserved memory region can be shared, so this
patch turns device address to be expressed with help of CPU address
and device's dma_pfn_offset in case memory reservation has been done
via device tree; non device tree users continue to use the old scheme.


Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/base/dma-coherent.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 640a7e6..99c9695 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -16,8 +16,18 @@ struct dma_coherent_mem {
 	int		flags;
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
+	bool		use_dev_dma_pfn_offset;
 };
 
+static inline dma_addr_t dma_get_device_base(struct device *dev,
+					     struct dma_coherent_mem * mem)
+{
+	if (mem->use_dev_dma_pfn_offset)
+		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
+	else
+		return mem->device_base;
+}
+
 static bool dma_init_coherent_memory(
 	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
 	struct dma_coherent_mem **mem)
@@ -133,7 +143,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 		return ERR_PTR(-EINVAL);
 
 	spin_lock_irqsave(&mem->spinlock, flags);
-	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
+	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
 	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 
@@ -186,7 +196,7 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 	/*
 	 * Memory was found in the per-device area.
 	 */
-	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
+	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
 	*ret = mem->virt_base + (pageno << PAGE_SHIFT);
 	dma_memory_map = (mem->flags & DMA_MEMORY_MAP);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
@@ -299,6 +309,7 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 			&rmem->base, (unsigned long)rmem->size / SZ_1M);
 		return -ENODEV;
 	}
+	mem->use_dev_dma_pfn_offset = true;
 	rmem->priv = mem;
 	dma_assign_coherent_memory(dev, mem);
 	return 0;
-- 
2.0.0
