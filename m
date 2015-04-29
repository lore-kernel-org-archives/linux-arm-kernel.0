From: dnelson@redhat.com (Dean Nelson)
Date: Wed, 29 Apr 2015 11:09:18 -0400
Subject: [PATCH] arm64: add missing PAGE_ALIGN() to __dma_free()
Message-ID: <20150429150917.14395.31269.email-sent-by-dnelson@teal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__dma_alloc() does a PAGE_ALIGN() on the passed in size argument before
doing anything else. __dma_free() does not. And because it doesn't, it is
possible to leak memory should size not be an integer multiple of PAGE_SIZE.

The solution is to add a PAGE_ALIGN() to __dma_free() like is done in
__dma_alloc().

Additionally, this patch removes a redundant PAGE_ALIGN() from
__dma_alloc_coherent(), since __dma_alloc_coherent() can only be called
from __dma_alloc(), which already does a PAGE_ALIGN() before the call.

Signed-off-by: Dean Nelson <dnelson@redhat.com>
Cc: stable at vger.kernel.org
---
 arch/arm64/mm/dma-mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index ef7d112..6e5e687 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -105,7 +105,6 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 		struct page *page;
 		void *addr;
 
-		size = PAGE_ALIGN(size);
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
 							get_order(size));
 		if (!page)
@@ -195,6 +194,8 @@ static void __dma_free(struct device *dev, size_t size,
 {
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
+	size = PAGE_ALIGN(size);
+
 	if (!is_device_dma_coherent(dev)) {
 		if (__free_from_pool(vaddr, size))
 			return;
