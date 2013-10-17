From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 17 Oct 2013 18:43:22 +0100
Subject: [PATCH v8 07/19] swiotlb-xen: introduce xen_swiotlb_set_dma_mask
In-Reply-To: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
Message-ID: <1382031814-8782-7-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement xen_swiotlb_set_dma_mask, use it for set_dma_mask on arm.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/mm.c         |    1 +
 drivers/xen/swiotlb-xen.c |   12 ++++++++++++
 include/xen/swiotlb-xen.h |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index d56b8c6..0d69b87 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -51,6 +51,7 @@ static struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
+	.set_dma_mask = xen_swiotlb_set_dma_mask,
 };
 
 int __init xen_mm_init(void)
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index f0fc1a4..d8ef0bf 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -608,3 +608,15 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(xen_io_tlb_end - 1) <= mask;
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_dma_supported);
+
+int
+xen_swiotlb_set_dma_mask(struct device *dev, u64 dma_mask)
+{
+	if (!dev->dma_mask || !xen_swiotlb_dma_supported(dev, dma_mask))
+		return -EIO;
+
+	*dev->dma_mask = dma_mask;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xen_swiotlb_set_dma_mask);
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index de8bcc6..7b64465 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -55,4 +55,6 @@ xen_swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr);
 extern int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask);
 
+extern int
+xen_swiotlb_set_dma_mask(struct device *dev, u64 dma_mask);
 #endif /* __LINUX_SWIOTLB_XEN_H */
-- 
1.7.2.5
