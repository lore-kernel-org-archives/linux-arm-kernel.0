From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 16 Oct 2013 13:19:13 +0300
Subject: [PATCH 1/1] ARM: dma-mapping: Drop GFP_COMP for DMA memory allocations
Message-ID: <1381918756-10389-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_iommu_alloc_attrs wants to split pages after allocation in order
to reduce the memory footprint. This does not work well with GFP_COMP
pages, so drop this flag before allocation.

ref: ea2e7057c0234cfb8b09467d8f137760d371fc72:

    ARM: 7172/1: dma: Drop GFP_COMP for DMA memory allocations

    dma_alloc_coherent wants to split pages after allocation in order to
    reduce the memory footprint. This does not work well with GFP_COMP
    pages, so drop this flag before allocation.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f5e1a84..955dd3e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1321,6 +1321,13 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	struct page **pages;
 	void *addr = NULL;
 
+	/* Following is a work-around (a.k.a. hack) to prevent pages
+	 * with __GFP_COMP being passed to split_page() which cannot
+	 * handle them.  The real problem is that this flag probably
+	 * should be 0 on ARM as it is not supported on this
+	 * platform--see CONFIG_HUGETLB_PAGE. */
+	gfp &= ~(__GFP_COMP);
+
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
-- 
1.8.1.5
