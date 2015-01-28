From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 28 Jan 2015 10:22:55 +0800
Subject: [RFC PATCH 4/5] arm64: add IOMMU dma_ops
In-Reply-To: <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
Message-ID: <54C847FF.8060805@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin

Sorry for separate the comments into many replies.

On 01/13/2015 04:48 AM, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/include/asm/device.h      |   3 +
>   arch/arm64/include/asm/dma-mapping.h |  12 ++
>   arch/arm64/mm/dma-mapping.c          | 297 +++++++++++++++++++++++++++++++++++
>   3 files changed, 312 insertions(+)
>
[snip]
> +static void __iommu_sync_sg_for_cpu(struct device *dev,
> +				    struct scatterlist *sgl, int nelems,
> +				    enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	if (is_device_dma_coherent(dev))
> +		return;
> +
> +	for_each_sg(sgl, sg, nelems, i) {
> +		unsigned int len = sg_dma_len(sg);
> +		void *virt = iova_to_virt(dev, sg_dma_address(sg));
> +
> +		if (virt && len)
> +			__dma_unmap_area(virt, len, dir);
> +	}
> +}
> +
> +static void __iommu_sync_sg_for_device(struct device *dev,
> +				       struct scatterlist *sgl, int nelems,
> +				       enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	if (is_device_dma_coherent(dev))
> +		return;
> +
> +	for_each_sg(sgl, sg, nelems, i) {
> +		unsigned int len = sg_dma_len(sg);
> +		void *virt = iova_to_virt(dev, sg_dma_address(sg));

I think we don't need to manually table walk of the IOMMU page table to 
get the PA of the iova and translate it back to CPU VA here. The page in 
the SG list already has the info we want. And same as above function. It 
just the same as the change below.

@@ -635,7 +635,7 @@ static void __iommu_sync_sg_for_cpu(struct device *dev,

         for_each_sg(sgl, sg, nelems, i) {
                 unsigned int len = sg_dma_len(sg);
-               void *virt = iova_to_virt(dev, sg_dma_address(sg));
+               void *virt = page_address(sg_page(sg));

                 if (virt && len)
                         __dma_unmap_area(virt, len, dir);
@@ -654,7 +654,7 @@ static void __iommu_sync_sg_for_device(struct device 
*dev,

         for_each_sg(sgl, sg, nelems, i) {
                 unsigned int len = sg_dma_len(sg);
-               void *virt = iova_to_virt(dev, sg_dma_address(sg));
+               void *virt = page_address(sg_page(sg));

                 if (virt && len)
                         __dma_map_area(virt, len, dir);
-Joseph

> +
> +		if (virt && len)
> +			__dma_map_area(virt, len, dir);
> +	}
> +}
> +
[snip]
