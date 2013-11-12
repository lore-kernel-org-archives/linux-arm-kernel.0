From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Nov 2013 14:11:59 +0000
Subject: [PATCH 1/2] swiotlb-xen: add missing xen_dma_map_page call
In-Reply-To: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
Message-ID: <1384265520-6833-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

swiotlb-xen is missing a xen_dma_map_page call in
xen_swiotlb_map_sg_attrs, in the slow path.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/swiotlb-xen.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a224bc7..1eac073 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -555,6 +555,11 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 				sg_dma_len(sgl) = 0;
 				return 0;
 			}
+			xen_dma_map_page(hwdev, pfn_to_page(map >> PAGE_SHIFT),
+						map & ~PAGE_MASK,
+						sg->length,
+						dir,
+						attrs);
 			sg->dma_address = xen_phys_to_bus(map);
 		} else {
 			/* we are not interested in the dma_addr returned by
-- 
1.7.2.5
