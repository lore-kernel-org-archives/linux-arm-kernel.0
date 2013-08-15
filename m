From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 15 Aug 2013 12:10:45 +0100
Subject: [PATCH v4 01/10] swiotlb: replace dma_length with sg_dma_len() macro
In-Reply-To: <alpine.DEB.2.02.1308151200580.4470@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308151200580.4470@kaball.uk.xensource.com>
Message-ID: <1376565054-24153-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: EUNBONG SONG <eunb.song@samsung.com>

This patch replace dma_length in "lib/swiotlb.c" to sg_dma_len() macro,
because the build error can occur if CONFIG_NEED_SG_DMA_LENGTH is not
set, and CONFIG_SWIOTLB is set.

Singed-off-by: EunBong Song <eunb.song@samsung.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 lib/swiotlb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index d23762e..4e8686c 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -870,13 +870,13 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 				swiotlb_full(hwdev, sg->length, dir, 0);
 				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
 						       attrs);
-				sgl[0].dma_length = 0;
+				sg_dma_len(sgl) = 0;
 				return 0;
 			}
 			sg->dma_address = phys_to_dma(hwdev, map);
 		} else
 			sg->dma_address = dev_addr;
-		sg->dma_length = sg->length;
+		sg_dma_len(sg) = sg->length;
 	}
 	return nelems;
 }
@@ -904,7 +904,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		unmap_single(hwdev, sg->dma_address, sg->dma_length, dir);
+		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir);
 
 }
 EXPORT_SYMBOL(swiotlb_unmap_sg_attrs);
@@ -934,7 +934,7 @@ swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
 
 	for_each_sg(sgl, sg, nelems, i)
 		swiotlb_sync_single(hwdev, sg->dma_address,
-				    sg->dma_length, dir, target);
+				    sg_dma_len(sg), dir, target);
 }
 
 void
-- 
1.7.2.5
