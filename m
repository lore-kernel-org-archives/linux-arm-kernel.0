From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 14 Sep 2015 17:13:18 +0100
Subject: [PATCH] arm: dma-mapping: fix build warning with new DMA_ERROR_CODE
 definition
Message-ID: <1442247198-12435-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 96231b2686b5: ("ARM: 8419/1: dma-mapping: harmonize definition
of DMA_ERROR_CODE") changed the definition of DMA_ERROR_CODE to use
dma_addr_t, which makes the compiler barf on assigning this to an
"int" variable on ARM with LPAE enabled:
-------------------
In file included from /src/linux/include/linux/dma-mapping.h:86:0,
                 from /src/linux/arch/arm/mm/dma-mapping.c:21:
/src/linux/arch/arm/mm/dma-mapping.c: In function '__iommu_create_mapping':
/src/linux/arch/arm/include/asm/dma-mapping.h:16:24: warning:
overflow in implicit constant conversion [-Woverflow]
 #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
                        ^
/src/linux/arch/arm/mm/dma-mapping.c:1252:15: note: in expansion of
macro DMA_ERROR_CODE'
  int i, ret = DMA_ERROR_CODE;
               ^
-------------------

Remove the actually unneeded initialization of "ret" in
__iommu_create_mapping() and move the variable declaration inside the
for-loop to make the scope of this variable more clear.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mm/dma-mapping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Hi Russell,

I hope that hasn't turned up before, but this triggers with my config.
Please apply for 4.3.

Cheers,
Andre.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e626043..1a7815e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1249,7 +1249,7 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	dma_addr_t dma_addr, iova;
-	int i, ret = DMA_ERROR_CODE;
+	int i;
 
 	dma_addr = __alloc_iova(mapping, size);
 	if (dma_addr == DMA_ERROR_CODE)
@@ -1257,6 +1257,8 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 
 	iova = dma_addr;
 	for (i = 0; i < count; ) {
+		int ret;
+
 		unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
 		phys_addr_t phys = page_to_phys(pages[i]);
 		unsigned int len, j;
-- 
2.5.1
