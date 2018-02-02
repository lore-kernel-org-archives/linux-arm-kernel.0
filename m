From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 2 Feb 2018 09:47:23 -0800
Subject: [PATCH 22/34] dma-mapping: add an arch_dma_supported hook
In-Reply-To: <20180112084232.2857-23-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
 <20180112084232.2857-23-hch@lst.de>
Message-ID: <5d7dfb29-eeef-2280-13c9-5260e9104f67@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2018 12:42 AM, Christoph Hellwig wrote:
> To implement the x86 forbid_dac and iommu_sac_force we want an arch hook
> so that it can apply the global options across all dma_map_ops
> implementations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/dma-mapping.h |  3 +++
>  arch/x86/kernel/pci-dma.c          | 19 ++++++++++++-------
>  include/linux/dma-mapping.h        | 11 +++++++++++
>  3 files changed, 26 insertions(+), 7 deletions(-)

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 88bcb1a8211d..d67742dad904 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -576,6 +576,14 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  	return 0;
>  }
>  
> +/*
> + * This is a hack for the legacy x86 forbid_dac and iommu_sac_force. Please
> + * don't use this is new code.

                     in new code.

> + */
> +#ifndef arch_dma_supported
> +#define arch_dma_supported(dev, mask)	(1)
> +#endif


-- 
~Randy
