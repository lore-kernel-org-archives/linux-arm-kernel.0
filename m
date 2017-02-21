From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Feb 2017 14:16:38 +0100
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions without
 struct page
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
Message-ID: <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DMA regions, for example those created by dma_declare_coherent_memory,
might not be possible to be represented by struct page pointers. Getting
scatterlist for the buffer allocated from such region is not possible.
This patch adds a simple check in arm_dma_get_sgtable() function if the
exported struct page pointer is valid.

Fixes: dc2832e1e7db3 ("ARM: dma-mapping: add support for dma_get_sgtable()")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index fc4a4eaa9934..4b2cf82fbca6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -942,6 +942,10 @@ int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
 	int ret;
 
+	/* Check if DMA handle has been properly translated to page. */
+	if (pfn_to_dma(dev, page_to_pfn(page)) != handle)
+		return -ENXIO;
+
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	if (unlikely(ret))
 		return ret;
-- 
1.9.1
