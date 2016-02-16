From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 16 Feb 2016 19:05:59 +0000
Subject: [PATCH] ARM64: dma-mapping: fix handling of devices registered
 before arch_initcall
In-Reply-To: <1455632084-14666-1-git-send-email-m.szyprowski@samsung.com>
References: <1455632084-14666-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <56C37317.9020104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 14:14, Marek Szyprowski wrote:
> This patch ensures that devices, which got registered before arch_initcall
> will be handled correctly by IOMMU-based DMA-mapping code.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm64/mm/dma-mapping.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 573b1e6..ce6019f 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -928,6 +928,10 @@ static int __init __iommu_dma_init(void)
>   		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
>   	if (!ret)
>   		ret = register_iommu_dma_ops_notifier(&amba_bustype);
> +
> +	/* handle devices queued before this arch_initcall */
> +	if (!ret)
> +		__iommu_attach_notifier(NULL, BUS_NOTIFY_ADD_DEVICE, NULL);

Hmm, surely unless *all* the devices on the relevant buses are created 
before arch_initcall level, then the next one is going to kick off the 
notifier to walk the whole list anyway. Have you seen this being a 
problem in practice?

Robin.

>   	return ret;
>   }
>   arch_initcall(__iommu_dma_init);
>
