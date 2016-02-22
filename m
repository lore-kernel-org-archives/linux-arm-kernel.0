From: rabin.vincent@axis.com (Rabin Vincent)
Date: Mon, 22 Feb 2016 15:41:29 +0100
Subject: [PATCHv2 1/2] ARM: dma-mapping: store buffer information
Message-ID: <1456152090-18630-1-git-send-email-rabin.vincent@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep a list of allocated DMA buffers so that we can store metadata in
alloc() which we later need in free().

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 arch/arm/mm/dma-mapping.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0eca381..d8c6efc 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -42,6 +42,31 @@
 #include "dma.h"
 #include "mm.h"
 
+struct arm_dma_buffer {
+	struct list_head list;
+	void *virt;
+};
+
+static LIST_HEAD(arm_dma_bufs);
+static DEFINE_SPINLOCK(arm_dma_bufs_lock);
+
+static struct arm_dma_buffer *arm_dma_buffer_find(void *virt)
+{
+	struct arm_dma_buffer *buf, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&arm_dma_bufs_lock, flags);
+	list_for_each_entry(buf, &arm_dma_bufs, list) {
+		if (buf->virt == virt) {
+			list_del(&buf->list);
+			found = buf;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&arm_dma_bufs_lock, flags);
+	return found;
+}
+
 /*
  * The DMA API is built upon the notion of "buffer ownership".  A buffer
  * is either exclusively owned by the CPU (and therefore may be accessed
@@ -620,6 +645,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	struct page *page = NULL;
 	void *addr;
 	bool want_vaddr;
+	struct arm_dma_buffer *buf;
 
 #ifdef CONFIG_DMA_API_DEBUG
 	u64 limit = (mask + 1) & ~mask;
@@ -633,6 +659,10 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (!mask)
 		return NULL;
 
+	buf = kzalloc(sizeof(*buf), gfp);
+	if (!buf)
+		return NULL;
+
 	if (mask < 0xffffffffULL)
 		gfp |= GFP_DMA;
 
@@ -662,8 +692,18 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page,
 					    caller, want_vaddr);
 
-	if (page)
+	if (page) {
+		unsigned long flags;
+
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
+		buf->virt = want_vaddr ? addr : page;
+
+		spin_lock_irqsave(&arm_dma_bufs_lock, flags);
+		list_add(&buf->list, &arm_dma_bufs);
+		spin_unlock_irqrestore(&arm_dma_bufs_lock, flags);
+	} else {
+		kfree(buf);
+	}
 
 	return want_vaddr ? addr : page;
 }
@@ -742,6 +782,11 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
 	bool want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
+	struct arm_dma_buffer *buf;
+
+	buf = arm_dma_buffer_find(cpu_addr);
+	if (WARN(!buf, "Freeing invalid buffer %p\n", cpu_addr))
+		return;
 
 	size = PAGE_ALIGN(size);
 
@@ -760,6 +805,8 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		WARN_ON(irqs_disabled());
 		__free_from_contiguous(dev, page, cpu_addr, size, want_vaddr);
 	}
+
+	kfree(buf);
 }
 
 void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-- 
2.7.0
