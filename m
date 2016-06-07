From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Jun 2016 10:15:55 +0100
Subject: [PATCH] arm64: Implement arch_setup_pdev_archdata hook
In-Reply-To: <b4645ade4a4d4150e76594f5bf04a3ad5e7d5221.1465287808.git.baolin.wang@linaro.org>
References: <b4645ade4a4d4150e76594f5bf04a3ad5e7d5221.1465287808.git.baolin.wang@linaro.org>
Message-ID: <575690CB.5080501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 09:29, Baolin Wang wrote:
> Now on ARM64 platform, it will set 'dummy_dma_ops' for device dma_ops if
> it did not call 'arch_setup_dma_ops' at device creation time by issuing
> platform_device_alloc() function, that will cause failure when setting
> the dma mask for device.

Yes, that's rather the whole point. DMA-capable devices are real 
hardware, therefore don't spring out of thin air without being described 
in DT or ACPI.

Please elaborate on the situation that you're attempting to address here 
(please don't let it be the ongoing Designware USB catastrophe ;))

Robin.

> Hence We need to hook the archdata to setup proper dma_ops for these devices.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   arch/arm64/mm/dma-mapping.c |   21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index c566ec8..04e057b 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -26,6 +26,7 @@
>   #include <linux/dma-contiguous.h>
>   #include <linux/vmalloc.h>
>   #include <linux/swiotlb.h>
> +#include <linux/platform_device.h>
>
>   #include <asm/cacheflush.h>
>
> @@ -961,3 +962,23 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   	dev->archdata.dma_coherent = coherent;
>   	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
>   }
> +
> +void arch_setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (!pdev->dev.archdata.dma_ops)
> +		pdev->dev.archdata.dma_ops = &swiotlb_dma_ops;
> +
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
>
