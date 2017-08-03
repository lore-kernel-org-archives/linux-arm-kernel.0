From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  3 Aug 2017 13:32:39 +0100
Subject: [PATCH v3 5/5] ACPI/IORT: Add IORT named component memory address
 limits
In-Reply-To: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
References: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170803123239.11359-6-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IORT named components provide firmware configuration describing
how many address bits a given device is capable of generating
to address memory.

Add code to the kernel to retrieve memory address limits
configuration for IORT named components and configure DMA masks
accordingly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/acpi/arm64/iort.c | 54 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 606af87..5b9e8dc2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -680,6 +680,24 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 	return ret ? NULL : ops;
 }
 
+static int nc_dma_get_range(struct device *dev, u64 *size)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_named_component *ncomp;
+
+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+			      iort_match_node_callback, dev);
+	if (!node)
+		return -ENODEV;
+
+	ncomp = (struct acpi_iort_named_component *)node->node_data;
+
+	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
+			1ULL<<ncomp->memory_address_limit;
+
+	return 0;
+}
+
 /**
  * iort_dma_setup() - Set-up device DMA parameters.
  *
@@ -708,24 +726,26 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 
 	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 
-	if (dev_is_pci(dev)) {
+	if (dev_is_pci(dev))
 		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
-		if (!ret) {
-			msb = fls64(dmaaddr + size - 1);
-			/*
-			 * Round-up to the power-of-two mask or set
-			 * the mask to the whole 64-bit address space
-			 * in case the DMA region covers the full
-			 * memory window.
-			 */
-			mask = msb == 64 ? U64_MAX : (1ULL << msb) - 1;
-			/*
-			 * Limit coherent and dma mask based on size
-			 * retrieved from firmware.
-			 */
-			dev->coherent_dma_mask = mask;
-			*dev->dma_mask = mask;
-		}
+	else
+		ret = nc_dma_get_range(dev, &size);
+
+	if (!ret) {
+		msb = fls64(dmaaddr + size - 1);
+		/*
+		 * Round-up to the power-of-two mask or set
+		 * the mask to the whole 64-bit address space
+		 * in case the DMA region covers the full
+		 * memory window.
+		 */
+		mask = msb == 64 ? U64_MAX : (1ULL << msb) - 1;
+		/*
+		 * Limit coherent and dma mask based on size
+		 * retrieved from firmware.
+		 */
+		dev->coherent_dma_mask = mask;
+		*dev->dma_mask = mask;
 	}
 
 	*dma_addr = dmaaddr;
-- 
2.10.0
