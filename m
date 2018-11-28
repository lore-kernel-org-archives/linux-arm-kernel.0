From: nathanj439@gmail.com (Nathan Jones)
Date: Wed, 28 Nov 2018 12:39:29 -0500
Subject: [PATCH] ARM: dma-mapping: fix potential uninitialized return
Message-ID: <20181128173929.3050-1-nathanj439@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If neither of the if() statements fire then the return value is
uninitialized. In the worst case it returns 0 which means the caller
will think the function succeeded.

Signed-off-by: Nathan Jones <nathanj439@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48ab78d..78de138aa66d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	int ret;
+	int ret = -ENXIO;
 	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
-- 
2.19.1
