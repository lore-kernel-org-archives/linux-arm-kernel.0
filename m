From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 11 Jan 2017 21:31:51 +0300
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range passed to
 arch_setup_dma_ops()
In-Reply-To: <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <1484159512-28515-2-git-send-email-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases when device is capable of wide DMA mask (and driver
issues corresponding dma_set_mask() call), but bus device sits on can't
support wide address. Example: NVMe device behind PCIe controller
sitting on 32-bit SoC bus.

To support such case, architecture needs information about such
limitations. Such information can originate from dma-ranges property
in device tree, and is passed to architecture via arch_setup_dma_ops()
call.

Problem is that in wide majority of cases, no dma range is defined.
E.g. ACPI has no means to define it. Thus default range (usually
full 32-bit range, i.e. 4G starting at zero address) is passed instead.

If architecture enforce this range, all setups currently using
wide DMA addresses without explicitly defining support for that via
device tree will break. This is bad, especially for ACPI based
platforms.

To avoid that, this patch adds additional boolean argument to
arch_setup_dma_ops() to show if range originates from authorative source
and thus should be enforced, or is just a guess and should be handled as
such.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/include/asm/dma-mapping.h             | 1 +
 arch/arm/mm/dma-mapping.c                      | 3 ++-
 arch/arm64/include/asm/dma-mapping.h           | 3 ++-
 arch/arm64/mm/dma-mapping.c                    | 3 ++-
 arch/mips/include/asm/dma-mapping.h            | 3 ++-
 drivers/acpi/scan.c                            | 2 +-
 drivers/iommu/rockchip-iommu.c                 | 2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 drivers/of/device.c                            | 5 ++++-
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c        | 2 +-
 10 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bf02dbd..2a3863e 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -117,6 +117,7 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 
 #define arch_setup_dma_ops arch_setup_dma_ops
 extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			       bool enforce_range,
 			       const struct iommu_ops *iommu, bool coherent);
 
 #define arch_teardown_dma_ops arch_teardown_dma_ops
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ab77100..b8b11f8 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2380,7 +2380,8 @@ static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+			bool enforce_range, const struct iommu_ops *iommu,
+			bool coherent)
 {
 	struct dma_map_ops *dma_ops;
 
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index ccea82c..ae1c23f 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -48,7 +48,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent);
+			bool enforce_range, const struct iommu_ops *iommu,
+			bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
 #ifdef CONFIG_IOMMU_DMA
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index e040827..ea295f1 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -953,7 +953,8 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 #endif  /* CONFIG_IOMMU_DMA */
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+			bool enforce_range, const struct iommu_ops *iommu,
+			bool coherent)
 {
 	if (!dev->archdata.dma_ops)
 		dev->archdata.dma_ops = &swiotlb_dma_ops;
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 7aa71b9..6af4d87 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -34,7 +34,8 @@ extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 
 #define arch_setup_dma_ops arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, const struct iommu_ops *iommu,
+				      u64 size, bool enforce_range,
+				      const struct iommu_ops *iommu,
 				      bool coherent)
 {
 #ifdef CONFIG_DMA_PERDEV_COHERENT
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..dea17a5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1385,7 +1385,7 @@ void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	 * Assume dma valid range starts at 0 and covers the whole
 	 * coherent_dma_mask.
 	 */
-	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, false, iommu,
 			   attr == DEV_DMA_COHERENT);
 }
 EXPORT_SYMBOL_GPL(acpi_dma_configure);
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9afcbf7..0995ab3 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1096,7 +1096,7 @@ static int rk_iommu_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Set dma_ops for dev, otherwise it would be dummy_dma_ops */
-	arch_setup_dma_ops(dev, 0, DMA_BIT_MASK(32), NULL, false);
+	arch_setup_dma_ops(dev, 0, DMA_BIT_MASK(32), false, NULL, false);
 
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index c9b7ad6..19f70d8 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2533,7 +2533,7 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	priv->buf_layout[TX].priv_data_size = DPAA_TX_PRIV_DATA_SIZE; /* Tx */
 
 	/* device used for DMA mapping */
-	arch_setup_dma_ops(dev, 0, 0, NULL, false);
+	arch_setup_dma_ops(dev, 0, 0, false, NULL, false);
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
 	if (err) {
 		dev_err(dev, "dma_coerce_mask_and_coherent() failed\n");
diff --git a/drivers/of/device.c b/drivers/of/device.c
index fd5cfad..1cc2115 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -89,6 +89,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	bool coherent;
 	unsigned long offset;
 	const struct iommu_ops *iommu;
+	bool enforce_range = false;
 
 	/*
 	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
@@ -126,6 +127,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 			return;
 		}
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
+
+		enforce_range = true;
 	}
 
 	dev->dma_pfn_offset = offset;
@@ -147,7 +150,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+	arch_setup_dma_ops(dev, dma_addr, size, enforce_range, iommu, coherent);
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 5ac373c..480b644 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -540,7 +540,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 
 	/* Objects are coherent, unless 'no shareability' flag set. */
 	if (!(obj_desc->flags & DPRC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
+		arch_setup_dma_ops(&mc_dev->dev, 0, 0, false, NULL, true);
 
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
-- 
2.1.4
