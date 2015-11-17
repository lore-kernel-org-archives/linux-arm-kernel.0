From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 13:50:24 +0100
Subject: [RFC] ARM64: simplify dma_get_ops
In-Reply-To: <20151117122250.GH6556@e104818-lin.cambridge.arm.com>
References: <4270550.cGd11OgA5n@wuerfel> <5118146.8KqrJiJrDe@wuerfel>
 <20151117122250.GH6556@e104818-lin.cambridge.arm.com>
Message-ID: <7483659.O8uXXLFCFD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 12:22:51 Catalin Marinas wrote:
> 
> > On a related note, we should also urgently fix the
> > arch_setup_dma_ops() function to no longer ignore the base and size
> > arguments. For dma_base, we can simply WARN_ON(dma_base != 0), so we
> > can implement support for that whenever we need it,
> 
> I think we should, at least until we implement support for
> dev->dma_pfn_offset. I'm not sure about iommu though, maybe there are
> working configurations with dma_base != 0.

I think we can assume for now that all IOMMUs are similar to the
ARM SMMU and don't need this.

> > but for the size we need to prevent drivers from calling
> > dma_set_mask() with an argument larger than the size we pass in here,
> > unless the size is also larger than max_pfn.
> 
> We have a default mask set up in of_dma_configure() based on size and
> dma_base. Can we check the new mask against the default one?

The size variable here is the mask that of_dma_configure() computes,
though it is not a "default": it is whatever the parent bus can support,
independent of additional restrictions that may be present in the
device and that are set by the driver.

Checking against that is what I meant above, see below for a prototype
that I have not even compile-tested and that might be missing some corner
cases.

We actually have the option of swapping out the dev->dma_ops in set_mask
so we don't have to go through the swiotlb code for devices that don't
need it.

	Arnd

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 243ef256b8c9..2af91a5bec4e 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 	void *iommu;			/* private IOMMU data */
 #endif
 	bool dma_coherent;
+	parent_dma_mask;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 9e351c1f89e2..0433b911b1bd 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -341,6 +341,31 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
+static int __swiotlb_set_dma_mask(struct device *dev, u64 mask)
+{
+	/* device is not DMA capable */
+	if (!dev->dma_mask)
+		return -EIO;
+
+	/* mask is below swiotlb bounce buffer, so fail */
+	if (!swiotlb_dma_supported(dev, mask))
+		return -EIO;
+
+	/*
+	 * because of the swiotlb, we can return success for
+	 * larger masks, but need to ensure that bounce buffers
+	 * are used above parent_dma_mask, so set that as
+	 * the effective mask.
+	 */
+	if (mask > dev->dev_archdata.parent_dma_mask)
+		mask = dev->dev_archdata.parent_dma_mask;
+
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
 static struct dma_map_ops swiotlb_dma_ops = {
 	.alloc = __dma_alloc,
 	.free = __dma_free,
@@ -356,6 +381,7 @@ static struct dma_map_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = __swiotlb_sync_sg_for_device,
 	.dma_supported = swiotlb_dma_supported,
 	.mapping_error = swiotlb_dma_mapping_error,
+	.set_dma_mask = __swiotlb_set_dma_mask,
 };
 
 static int __init atomic_pool_init(void)
@@ -979,6 +1005,18 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!acpi_disabled && !dev->archdata.dma_ops)
 		dev->archdata.dma_ops = &swiotlb_dma_ops;
 
+	/*
+	 * we don't yet support buses that have a non-zero mapping.
+	 *  Let's hope we won't need it
+	 */
+	WARN_ON(dma_base != 0);
+
+	/*
+	 * Whatever the parent bus can set. A device must not set
+	 * a DMA mask larger than this.
+	 */
+	dev->archdata.parent_dma_mask = size;
+
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 }
