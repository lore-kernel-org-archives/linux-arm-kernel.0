From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 5 Aug 2013 17:30:48 +0100
Subject: [PATCH v3 02/10] swiotlb-xen: replace dma_length with sg_dma_len()
 macro
In-Reply-To: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
Message-ID: <1375720256-8014-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

swiotlb-xen has an implicit dependency on CONFIG_NEED_SG_DMA_LENGTH.
Remove it by replacing dma_length with sg_dma_len.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/swiotlb-xen.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index aadffcf..1b2277c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -506,13 +506,13 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 				   to do proper error handling. */
 				xen_swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
 							   attrs);
-				sgl[0].dma_length = 0;
+				sg_dma_len(sgl) = 0;
 				return DMA_ERROR_CODE;
 			}
 			sg->dma_address = xen_phys_to_bus(map);
 		} else
 			sg->dma_address = dev_addr;
-		sg->dma_length = sg->length;
+		sg_dma_len(sg) = sg->length;
 	}
 	return nelems;
 }
@@ -533,7 +533,7 @@ xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		xen_unmap_single(hwdev, sg->dma_address, sg->dma_length, dir);
+		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir);
 
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_sg_attrs);
@@ -555,7 +555,7 @@ xen_swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
 
 	for_each_sg(sgl, sg, nelems, i)
 		xen_swiotlb_sync_single(hwdev, sg->dma_address,
-					sg->dma_length, dir, target);
+					sg_dma_len(sg), dir, target);
 }
 
 void
-- 
1.7.2.5
