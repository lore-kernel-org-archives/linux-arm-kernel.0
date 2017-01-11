From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 11 Jan 2017 21:31:52 +0300
Subject: [PATCH 2/2] arm64: avoid increasing DMA masks above what hardware
 supports
In-Reply-To: <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <1484159512-28515-3-git-send-email-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases when device supports wide DMA addresses wider than
device's connection supports.

In this case driver sets DMA mask based on knowledge of device
capabilities. That must succeed to allow drivers to initialize.

However, swiotlb or iommu still need knowledge about actual device
capabilities. To avoid breakage, actual mask must not be set wider than
device connection allows.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Robin Murphy <robin.murphy@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                   |  3 +++
 arch/arm64/include/asm/device.h      |  1 +
 arch/arm64/include/asm/dma-mapping.h |  3 +++
 arch/arm64/mm/dma-mapping.c          | 40 ++++++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..afb2c08 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -216,6 +216,9 @@ config NEED_DMA_MAP_STATE
 config NEED_SG_DMA_LENGTH
 	def_bool y
 
+config ARCH_HAS_DMA_SET_COHERENT_MASK
+	def_bool y
+
 config SMP
 	def_bool y
 
diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 243ef25..a57e7bb 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 	void *iommu;			/* private IOMMU data */
 #endif
 	bool dma_coherent;
+	u64 parent_dma_mask;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index ae1c23f..46b53e6 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -52,6 +52,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
+#define HAVE_ARCH_DMA_SET_MASK 1
+extern int dma_set_mask(struct device *dev, u64 dma_mask);
+
 #ifdef CONFIG_IOMMU_DMA
 void arch_teardown_dma_ops(struct device *dev);
 #define arch_teardown_dma_ops	arch_teardown_dma_ops
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index ea295f1..31b96fd 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -203,6 +203,37 @@ static void __dma_free(struct device *dev, size_t size,
 	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
 }
 
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+	if (ops->set_dma_mask)
+		return ops->set_dma_mask(dev, mask);
+
+	if (!dev->dma_mask || !dma_supported(dev, mask))
+		return -EIO;
+
+	*dev->dma_mask = mask;
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_mask);
+
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+	if (!dma_supported(dev, mask))
+		return -EIO;
+
+	dev->coherent_dma_mask = mask;
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_coherent_mask);
+
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
@@ -959,6 +990,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!dev->archdata.dma_ops)
 		dev->archdata.dma_ops = &swiotlb_dma_ops;
 
+	/*
+	 * Whatever the parent bus can set. A device must not set
+	 * a DMA mask larger than this.
+	 */
+	if (enforce_range)
+		dev->archdata.parent_dma_mask = size - 1;
+	else
+		dev->archdata.parent_dma_mask = DMA_BIT_MASK(64);
+
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 }
-- 
2.1.4
