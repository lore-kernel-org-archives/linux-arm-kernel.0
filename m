From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:44 +0100
Subject: [PATCH 40/67] iommu/intel-iommu: use dma_direct_* helpers for the
 direct mapping case
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-41-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the code a bit, and prepares for future cleanups.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 17 ++++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc7c1914645d..df171cb85822 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -143,6 +143,7 @@ config DMAR_TABLE
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
+	select DMA_DIRECT_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
 	select DMAR_TABLE
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 921caf4f0c3e..0de8bfe89061 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/mempool.h>
 #include <linux/memory.h>
 #include <linux/cpu.h>
@@ -3712,17 +3713,12 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
+	if (iommu_no_mapping(dev))
+		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
-
-	if (!iommu_no_mapping(dev))
-		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
-			flags |= GFP_DMA;
-		else
-			flags |= GFP_DMA32;
-	}
+	flags &= ~(GFP_DMA | GFP_DMA32);
 
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
@@ -3758,6 +3754,9 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
+	if (iommu_no_mapping(dev))
+		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-- 
2.14.2
