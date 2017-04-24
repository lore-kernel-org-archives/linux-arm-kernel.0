From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 24 Apr 2017 11:16:51 +0100
Subject: [PATCH v4 1/7] dma: Take into account dma_pfn_offset
In-Reply-To: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
References: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1493029017-31382-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though dma-noop-ops assumes 1:1 memory mapping DMA memory range
can be different to RAM. For example, ARM STM32F4 MCU offers the
possibility to remap SDRAM from 0xc000_0000 to 0x0 to get CPU
performance boost, but DMA continue to see SDRAM at 0xc000_0000. This
difference in mapping is handled via device-tree "dma-range" property
which leads to dev->dma_pfn_offset is set nonzero. To handle such
cases take dma_pfn_offset into account.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Reported-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 lib/dma-noop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index de26c8b..ff4ef5e 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
+#include <linux/pfn.h>
 
 static void *dma_noop_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t gfp,
@@ -16,7 +17,8 @@ static void *dma_noop_alloc(struct device *dev, size_t size,
 
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 	if (ret)
-		*dma_handle = virt_to_phys(ret);
+		*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
+
 	return ret;
 }
 
@@ -32,7 +34,7 @@ static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
 				      enum dma_data_direction dir,
 				      unsigned long attrs)
 {
-	return page_to_phys(page) + offset;
+	return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
 }
 
 static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
@@ -47,7 +49,7 @@ static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nent
 
 		BUG_ON(!sg_page(sg));
 		va = sg_virt(sg);
-		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va);
+		sg_dma_address(sg) = (dma_addr_t)(virt_to_phys(va) - PFN_PHYS(dev->dma_pfn_offset));
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.0.0
