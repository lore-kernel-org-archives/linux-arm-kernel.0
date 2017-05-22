From: oza.oza@broadcom.com (Oza Pawandeep)
Date: Mon, 22 May 2017 22:09:42 +0530
Subject: [PATCH v7 3/3] IOMMU/PCI: Reserve IOVA for inbound memory for PCI
 masters
In-Reply-To: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
Message-ID: <1495471182-12490-4-git-send-email-oza.oza@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reserves the inbound memory holes for PCI masters.
ARM64 based SOCs may have scattered memory banks.
For e.g as iproc based SOC has

<0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
<0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
<0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
<0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */

But incoming PCI transaction addressing capability is limited
by host bridge, for example if max incoming window capability
is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.

To address this problem, iommu has to avoid allocating IOVA which
are reserved. 

Which in turn does not allocate IOVA if it falls into hole.
and the holes should be reserved before any of the IOVA allocations
can happen.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8348f366..efe3d07 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -171,16 +171,15 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
+	struct iommu_resv_region *region;
+	phys_addr_t start, end;
+	size_t length;
 
 	if (!dev_is_pci(dev))
 		return;
 
 	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
 	resource_list_for_each_entry(window, &bridge->windows) {
-		struct iommu_resv_region *region;
-		phys_addr_t start;
-		size_t length;
-
 		if (resource_type(window->res) != IORESOURCE_MEM)
 			continue;
 
@@ -193,6 +192,43 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 
 		list_add_tail(&region->list, list);
 	}
+
+	/* PCI inbound memory reservation. */
+	start = length = 0;
+	resource_list_for_each_entry(window, &bridge->inbound_windows) {
+		end = window->res->start - window->offset;
+
+		if (start > end) {
+			/* multiple ranges assumed sorted. */
+			pr_warn("PCI: failed to reserve iovas\n");
+			return;
+		}
+
+		if (start != end) {
+			length = end - start - 1;
+			region = iommu_alloc_resv_region(start, length, 0,
+				IOMMU_RESV_RESERVED);
+			if (!region)
+				return;
+
+			list_add_tail(&region->list, list);
+		}
+
+		start += end + length + 1;
+	}
+	/*
+	 * the last dma-range should honour based on the
+	 * 32/64-bit dma addresses.
+	 */
+	if ((start) && (start < DMA_BIT_MASK(sizeof(dma_addr_t) * 8))) {
+		length = DMA_BIT_MASK((sizeof(dma_addr_t) * 8)) - 1;
+		region = iommu_alloc_resv_region(start, length, 0,
+			IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, list);
+	}
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
1.9.1
