From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 08 Feb 2013 11:47:40 +0100
Subject: [PATCH] ARM: DMA-mapping: fix memory leak in IOMMU dma-mapping
 implementation
Message-ID: <1360320460-17246-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes page_address() usage in IOMMU-aware dma-mapping
implementation and replaced it with direct use of the cpu virtual address
provided by the caller. page_address() returned incorrect address for
pages remapped in atomic pool, what caused memory leak.

Reported-by: Hiroshi Doyu <hdoyu@nvidia.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b2fb87..8c38378 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1255,11 +1255,11 @@ err_mapping:
 	return NULL;
 }
 
-static void __iommu_free_atomic(struct device *dev, struct page **pages,
+static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 				dma_addr_t handle, size_t size)
 {
 	__iommu_remove_mapping(dev, handle, size);
-	__free_from_pool(page_address(pages[0]), size);
+	__free_from_pool(cpu_addr, size);
 }
 
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
@@ -1342,7 +1342,7 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	}
 
 	if (__in_atomic_pool(cpu_addr, size)) {
-		__iommu_free_atomic(dev, pages, handle, size);
+		__iommu_free_atomic(dev, cpu_addr, handle, size);
 		return;
 	}
 
-- 
1.7.9.5
