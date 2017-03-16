From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 16 Mar 2017 17:00:17 +0000
Subject: [PATCH v2 2/4] iommu/dma: Don't reserve PCI I/O windows
In-Reply-To: <cover.1489683129.git.robin.murphy@arm.com>
References: <cover.1489683129.git.robin.murphy@arm.com>
Message-ID: <093edba64fd941c59929e09118561f669b761aac.1489683129.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if a host controller's CPU-side MMIO windows into PCI I/O space do
happen to leak into PCI memory space such that it might treat them as
peer addresses, trying to reserve the corresponding I/O space addresses
doesn't do anything to help solve that problem. Stop doing a silly thing.

Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Notes:
    v2:
    - No change

 drivers/iommu/dma-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48d36ce59efb..1e0983488a8d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -175,8 +175,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 	unsigned long lo, hi;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
-		if (resource_type(window->res) != IORESOURCE_MEM &&
-		    resource_type(window->res) != IORESOURCE_IO)
+		if (resource_type(window->res) != IORESOURCE_MEM)
 			continue;
 
 		lo = iova_pfn(iovad, window->res->start - window->offset);
-- 
2.11.0.dirty
