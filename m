From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Sep 2014 18:56:25 +0100
Subject: [RFC PATCH v2 5/7] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409680587-29818-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends of_dma_configure so that it sets up the IOMMU for a
device, as well as the coherent/non-coherent DMA mapping ops.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/dma-mapping.h |  5 ++++-
 drivers/of/platform.c              | 36 ++++++++++++++++++++++--------------
 include/linux/dma-mapping.h        |  5 ++++-
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index dad006dabbe6..788b8eef40e8 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -122,7 +122,10 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
 static inline void arch_setup_dma_ops(struct device *dev, u64 mask,
-				      unsigned long offset, bool coherent)
+				      u64 dma_base, u64 size,
+				      unsigned long offset,
+				      struct iommu_dma_mapping *iommu,
+				      bool coherent)
 {
 	dev->coherent_dma_mask	= mask;
 	dev->dma_mask		= &dev->coherent_dma_mask;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 484c558c63a6..6067f6423674 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -162,25 +163,37 @@ EXPORT_SYMBOL(of_device_alloc);
  */
 static void of_dma_configure(struct platform_device *pdev)
 {
-	u64 dma_addr, paddr, size;
+	u64 dma_addr, paddr, size, mask;
 	int ret;
 	bool coherent;
 	unsigned long offset;
+	struct iommu_dma_mapping *iommu;
 	struct device *dev = &pdev->dev;
 
+	/*
+	 * Set default dma-mask to 32 bit. Drivers are expected to setup
+	 * the correct supported dma_mask.
+	 */
+	mask = DMA_BIT_MASK(32);
+
 	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
-	offset = ret < 0 ? 0 : PFN_DOWN(paddr - dma_addr);
-	dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
+	if (ret < 0) {
+		dma_addr = offset = 0;
+		size = mask;
+	} else {
+		offset = PFN_DOWN(paddr - dma_addr);
+		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
+	}
 
 	coherent = of_dma_is_coherent(dev->of_node);
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	/*
-	 * Set default dma-mask to 32 bit. Drivers are expected to setup
-	 * the correct supported dma_mask.
-	 */
-	arch_setup_dma_ops(dev, DMA_BIT_MASK(32), offset, coherent);
+	iommu = of_iommu_configure(dev);
+	dev_dbg(dev, "device is%sbehind an iommu\n",
+		iommu ? " " : " not ");
+
+	arch_setup_dma_ops(dev, mask, dma_addr, size, offset, iommu, coherent);
 }
 
 /**
@@ -209,14 +222,9 @@ static struct platform_device *of_platform_device_create_pdata(
 	if (!dev)
 		goto err_clear_flag;
 
-	of_dma_configure(dev);
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-
-	/* We do not fill the DMA ops for platform devices by default.
-	 * This is currently the responsibility of the platform code
-	 * to do such, possibly using a device notifier
-	 */
+	of_dma_configure(dev);
 
 	if (of_device_add(dev) != 0) {
 		platform_device_put(dev);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 16bf92f71c3e..19a31f55a5d0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,7 +138,10 @@ extern u64 dma_get_required_mask(struct device *dev);
 
 #ifndef arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 mask,
-				      unsigned long offset, bool coherent) { }
+				      u64 dma_base, u64 size,
+				      unsigned long offset,
+				      struct iommu_dma_mapping *iommu,
+				      bool coherent) { }
 #endif
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
2.1.0
