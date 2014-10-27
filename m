From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 27 Oct 2014 15:09:22 +0000
Subject: [PATCH v7 2/8] xen/arm: remove outer_*_range call
In-Reply-To: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
Message-ID: <1414422568-19103-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dom0 is not actually capable of issuing outer_inv_range or
outer_clean_range calls.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
---
 arch/arm/xen/mm32.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index a5a93fc..6153d61 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -61,9 +61,6 @@ static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
 	/* Cannot use __dma_page_dev_to_cpu because we don't have a
 	 * struct page for handle */
 
-	if (dir != DMA_TO_DEVICE)
-		outer_inv_range(handle, handle + size);
-
 	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_unmap_area);
 }
 
@@ -72,12 +69,6 @@ static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
 {
 
 	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_map_area);
-
-	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(handle, handle + size);
-	} else {
-		outer_clean_range(handle, handle + size);
-	}
 }
 
 void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-- 
1.7.10.4
