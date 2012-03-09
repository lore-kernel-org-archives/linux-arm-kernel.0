From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Mar 2012 15:53:32 +0100
Subject: [PATCH] ARM: dma-mapping: fix calculation of iova bitmap size
In-Reply-To: <011701ccfc83$78030180$68090480$%szyprowski@samsung.com>
References: <011701ccfc83$78030180$68090480$%szyprowski@samsung.com>
Message-ID: <1331304812-10386-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix calculation of iova address space for IOMMU-aware dma mapping.

Reported-by: Krishna Reddy <vdumpa@nvidia.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ea5a0ad..f0f600a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1601,11 +1601,14 @@ struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 			 int order)
 {
-	unsigned int count = (size >> PAGE_SHIFT) - order;
+	unsigned int count = size >> (PAGE_SHIFT + order);
 	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
 	int err = -ENOMEM;
 
+	if (!count)
+		return ERR_PTR(-EINVAL);
+
 	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
 	if (!mapping)
 		goto err;
-- 
1.7.1.569.g6f426
