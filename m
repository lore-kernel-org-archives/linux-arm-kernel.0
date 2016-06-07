From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jun 2016 10:43:08 +0200
Subject: [PATCH] arm64: Implement arch_setup_pdev_archdata hook
In-Reply-To: <b4645ade4a4d4150e76594f5bf04a3ad5e7d5221.1465287808.git.baolin.wang@linaro.org>
References: <b4645ade4a4d4150e76594f5bf04a3ad5e7d5221.1465287808.git.baolin.wang@linaro.org>
Message-ID: <3369300.0KEI34cGsj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 7, 2016 4:29:21 PM CEST Baolin Wang wrote:
> Now on ARM64 platform, it will set 'dummy_dma_ops' for device dma_ops if
> it did not call 'arch_setup_dma_ops' at device creation time by issuing
> platform_device_alloc() function, that will cause failure when setting
> the dma mask for device.
> 
> Hence We need to hook the archdata to setup proper dma_ops for these devices.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  arch/arm64/mm/dma-mapping.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index c566ec8..04e057b 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -26,6 +26,7 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/vmalloc.h>
>  #include <linux/swiotlb.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -961,3 +962,23 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	dev->archdata.dma_coherent = coherent;
>  	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
>  }
> +
> +void arch_setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (!pdev->dev.archdata.dma_ops)
> +		pdev->dev.archdata.dma_ops = &swiotlb_dma_ops;

You need to check the DT here to see if these are the right ops,
or if you have to go through an IOMMU. Also, you have to set up the
other fields that are controlled by arch_setup_dma_ops: whether
it's coherent and what the offset is.

> +	/*
> +	 * Set default coherent_dma_mask to 32 bit. Drivers are expected to
> +	 * setup the correct supported mask.
> +	 */
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +	/*
> +	 * Set it to coherent_dma_mask by default if the architecture
> +	 * code has not set it.
> +	 */
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +}

We still have an open bug about the dma_set_mask() function on ARM64:
we have to check the dma-ranges property to ensure that no device can
set a mask wider than what its parent bus can support.

What is your plan for this in case of these devices?

	Arnd
