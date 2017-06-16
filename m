From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:37 +0200
Subject: [PATCH 22/44] x86/pci-nommu: implement ->mapping_error
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-23-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA_ERROR_CODE is going to go away, so don't rely on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-nommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index a88952ef371c..085fe6ce4049 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -11,6 +11,8 @@
 #include <asm/iommu.h>
 #include <asm/dma.h>
 
+#define NOMMU_MAPPING_ERROR		0
+
 static int
 check_addr(char *name, struct device *hwdev, dma_addr_t bus, size_t size)
 {
@@ -33,7 +35,7 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	dma_addr_t bus = page_to_phys(page) + offset;
 	WARN_ON(size == 0);
 	if (!check_addr("map_single", dev, bus, size))
-		return DMA_ERROR_CODE;
+		return NOMMU_MAPPING_ERROR;
 	flush_write_buffers();
 	return bus;
 }
@@ -88,6 +90,11 @@ static void nommu_sync_sg_for_device(struct device *dev,
 	flush_write_buffers();
 }
 
+static int nommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == NOMMU_MAPPING_ERROR;
+}
+
 const struct dma_map_ops nommu_dma_ops = {
 	.alloc			= dma_generic_alloc_coherent,
 	.free			= dma_generic_free_coherent,
@@ -96,4 +103,5 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
+	.mapping_error		= nommu_mapping_error,
 };
-- 
2.11.0
