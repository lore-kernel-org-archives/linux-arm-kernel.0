From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Dec 2016 20:07:06 +0100
Subject: arm64: mm: bug around swiotlb_dma_ops
In-Reply-To: <8862fe21-0a82-a09a-c1cb-aa79d46179ec@cogentembedded.com>
References: <8862fe21-0a82-a09a-c1cb-aa79d46179ec@cogentembedded.com>
Message-ID: <2687486.uRNLKRAd5t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 15, 2016 7:20:11 PM CET Nikita Yushchenko wrote:
> Hi.
> 
> Per Documentation/DMA-API-HOWTO.txt, driver of device capable of 64-bit
> DMA addressing, should call dma_set_mask_and_coherent(dev,
> DMA_BIT_MASK(64)) and if that succeeds, assume that 64-bit DMA
> addressing is available.
> 
> This behaves incorrectly on arm64 system (Renesas r8a7795-h3ulcb) here.
> 
> - Device (NVME SSD) has it's dev->archdata.dma_ops set to swiotlb_dma_ops.
> 
> - swiotlb_dma_ops.dma_supported is set to swiotlb_dma_supported():
> 
> int swiotlb_dma_supported(struct device *hwdev, u64 mask)
> {
>         return phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
> }
> 
> this definitely returns true for mask=DMA_BIT_MASK(64) since that is
> maximum possible 64-bit value.
> 
> - Thus device dma_mask is unconditionally updated, and
> dma_set_mask_and_coherent() succeeds.
> 
> - Later, __swiotlb_map_page() / __swiotlb_map_sg_attr() will consult
> this updated mask, and return high addresses as valid DMA addresses.
> 
> 
> Thus recommended dma_set_mask_and_coherent() call, instead of checking
> if platform supports 64-bit DMA addressing, unconditionally enables
> 64-bit DMA addressing. In case of device actually can't do DMA to 64-bit
> addresses (e.g. because of limitations in PCIe controller), this breaks
> things. This is exactly what happens here.
> 
> 
> Not sure what is proper fix for this though.

I had prototyped something for this a long time ago. It's probably
wrong or incomplete, but maybe it helps you get closer to a solution.

	Arnd

commit 76c3f31874b0791b4be72cdd64791a64495c3a4a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Nov 17 14:06:55 2015 +0100

    [EXPERIMENTAL] ARM64: check implement dma_set_mask
    
    Needs work for coherent mask
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 243ef256b8c9..a57e7bb10e71 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 	void *iommu;			/* private IOMMU data */
 #endif
 	bool dma_coherent;
+	u64 parent_dma_mask;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 290a84f3351f..aa65875c611b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -352,6 +352,31 @@ static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return 1;
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
+	if (mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
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
@@ -367,6 +392,7 @@ static struct dma_map_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = __swiotlb_sync_sg_for_device,
 	.dma_supported = __swiotlb_dma_supported,
 	.mapping_error = swiotlb_dma_mapping_error,
+	.set_dma_mask = __swiotlb_set_dma_mask,
 };
 
 static int __init atomic_pool_init(void)
@@ -957,6 +983,18 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!dev->archdata.dma_ops)
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
