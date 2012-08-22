From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 Aug 2012 10:20:57 -0000
Subject: [RFC 3/4] ARM: dma-mapping: Return cpu addr when dma_alloc(GFP_ATOMIC)
In-Reply-To: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345630830-9586-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make dma_alloc{_attrs}() returns cpu address when
DMA_ATTR_NO_KERNEL_MAPPING && GFP_ATOMIC.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9260107..a0cd476 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1198,8 +1198,11 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (*handle == DMA_ERROR_CODE)
 		goto err_buffer;
 
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+		if (gfp & GFP_ATOMIC)
+			return page_address(pages[0]);
 		return pages;
+	}
 
 	addr = __iommu_alloc_remap(pages, size, gfp, prot,
 				   __builtin_return_address(0));
-- 
1.7.5.4
