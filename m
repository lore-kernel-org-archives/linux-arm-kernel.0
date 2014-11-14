From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Nov 2014 11:59:53 +0000
Subject: [PATCH v9 05/13] arm: introduce is_device_dma_coherent
In-Reply-To: <1415792454-23161-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1411121130020.26318@kaball.uk.xensource.com>
 <1415792454-23161-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.DEB.2.02.1411141158560.26318@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
this patch needs your feedback.

- Stefano

On Wed, 12 Nov 2014, Stefano Stabellini wrote:
> Introduce a boolean flag and an accessor function to check whether a
> device is dma_coherent. Set the flag from set_arch_dma_coherent_ops.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> CC: linux at arm.linux.org.uk
> ---
>  arch/arm/include/asm/device.h      |    1 +
>  arch/arm/include/asm/dma-mapping.h |    6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index dc662fc..4111592 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -17,6 +17,7 @@ struct dev_archdata {
>  #ifdef CONFIG_ARM_DMA_USE_IOMMU
>  	struct dma_iommu_mapping	*mapping;
>  #endif
> +	bool dma_coherent;
>  };
>  
>  struct omap_device;
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 85738b2..8c3b616 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -123,11 +123,17 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  
>  static inline int set_arch_dma_coherent_ops(struct device *dev)
>  {
> +	dev->archdata.dma_coherent = true;
>  	set_dma_ops(dev, &arm_coherent_dma_ops);
>  	return 0;
>  }
>  #define set_arch_dma_coherent_ops(dev)	set_arch_dma_coherent_ops(dev)
>  
> +static inline bool is_device_dma_coherent(struct device *dev)
> +{
> +	return dev->archdata.dma_coherent;
> +}
> +
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	unsigned int offset = paddr & ~PAGE_MASK;
> -- 
> 1.7.10.4
> 
