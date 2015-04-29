From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Apr 2015 10:53:41 +0100
Subject: [PATCH v2] arm: dma-mapping: fix off-by-one check in
 arm_setup_iommu_dma_ops
In-Reply-To: <1430294039-25218-1-git-send-email-m.szyprowski@samsung.com>
References: <1430294039-25218-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150429095341.GI8236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

A couple of really minor comments.

On Wed, Apr 29, 2015 at 08:53:59AM +0100, Marek Szyprowski wrote:
> diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> index 8e3fcb924db6..2ef282f96651 100644
> --- a/arch/arm/include/asm/dma-iommu.h
> +++ b/arch/arm/include/asm/dma-iommu.h
> @@ -25,7 +25,7 @@ struct dma_iommu_mapping {
>  };
>  
>  struct dma_iommu_mapping *
> -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size);
>  
>  void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
>  
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 09c5fe3d30c2..143c0735cb58 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1878,7 +1878,7 @@ struct dma_map_ops iommu_coherent_ops = {
>   * arm_iommu_attach_device function.
>   */
>  struct dma_iommu_mapping *
> -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size)
>  {
>  	unsigned int bits = size >> PAGE_SHIFT;
>  	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
> @@ -1886,6 +1886,10 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
>  	int extensions = 1;
>  	int err = -ENOMEM;
>  
> +	/* currently ony 32-bit DMA address space is supported */

s/ony/only/

> +	if (size > DMA_BIT_MASK(32) + 1)
> +		return ERR_PTR(-EINVAL);

-ERANGE?

With that,

  Acked-by: Will Deacon <will.deacon@arm.com>

Can you stick this in the patch system please?

Will
