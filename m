From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  7 Aug 2017 11:29:49 +0100
Subject: [UPDATE PATCH v3 4/5] ACPI: Make acpi_dma_configure() DMA regions
 aware
In-Reply-To: <20170807102949.29701-1-lorenzo.pieralisi@arm.com>
References: <20170807102949.29701-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170807102949.29701-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current ACPI DMA configuration set-up device DMA capabilities through
kernel defaults that do not take into account platform specific DMA
configurations reported by firmware.

By leveraging the ACPI acpi_dev_get_dma_resources() API, add code
in acpi_dma_configure() to retrieve the DMA regions to correctly
set-up PCI devices DMA parameters.

Rework the ACPI IORT kernel API to make sure they can accommodate
the DMA set-up required by firmware. By making PCI devices DMA set-up
ACPI IORT specific, the kernel is shielded from unwanted regressions
that could be triggered by parsing DMA resources on arches that were
previously ignoring them (ie x86/ia64), leaving kernel behaviour
unchanged on those arches.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 37 +++++++++++++++++++++++++++++++++++--
 drivers/acpi/scan.c       | 12 ++++--------
 include/linux/acpi_iort.h |  5 +++--
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a3215ee..606af87 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -681,12 +681,17 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 }
 
 /**
- * iort_set_dma_mask - Set-up dma mask for a device.
+ * iort_dma_setup() - Set-up device DMA parameters.
  *
  * @dev: device to configure
+ * @dma_addr: device DMA address result pointer
+ * @size: DMA range size result pointer
  */
-void iort_set_dma_mask(struct device *dev)
+void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 {
+	u64 mask, dmaaddr = 0, size = 0, offset = 0;
+	int ret, msb;
+
 	/*
 	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
 	 * setup the correct supported mask.
@@ -700,6 +705,34 @@ void iort_set_dma_mask(struct device *dev)
 	 */
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;
+
+	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+
+	if (dev_is_pci(dev)) {
+		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
+		if (!ret) {
+			msb = fls64(dmaaddr + size - 1);
+			/*
+			 * Round-up to the power-of-two mask or set
+			 * the mask to the whole 64-bit address space
+			 * in case the DMA region covers the full
+			 * memory window.
+			 */
+			mask = msb == 64 ? U64_MAX : (1ULL << msb) - 1;
+			/*
+			 * Limit coherent and dma mask based on size
+			 * retrieved from firmware.
+			 */
+			dev->coherent_dma_mask = mask;
+			*dev->dma_mask = mask;
+		}
+	}
+
+	*dma_addr = dmaaddr;
+	*dma_size = size;
+
+	dev->dma_pfn_offset = PFN_DOWN(offset);
+	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
 }
 
 /**
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 842658c..f024996 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1446,20 +1446,16 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
 	const struct iommu_ops *iommu;
-	u64 size;
+	u64 dma_addr = 0, size = 0;
 
-	iort_set_dma_mask(dev);
+	iort_dma_setup(dev, &dma_addr, &size);
 
 	iommu = iort_iommu_configure(dev);
 	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
-	/*
-	 * Assume dma valid range starts at 0 and covers the whole
-	 * coherent_dma_mask.
-	 */
-	arch_setup_dma_ops(dev, 0, size, iommu, attr == DEV_DMA_COHERENT);
+	arch_setup_dma_ops(dev, dma_addr, size,
+				iommu, attr == DEV_DMA_COHERENT);
 
 	return 0;
 }
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8379d40..8d3f0bf 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -36,7 +36,7 @@
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
-void iort_set_dma_mask(struct device *dev);
+void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
@@ -47,7 +47,8 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
-static inline void iort_set_dma_mask(struct device *dev) { }
+static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
+				  u64 *size) { }
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
-- 
1.9.1
