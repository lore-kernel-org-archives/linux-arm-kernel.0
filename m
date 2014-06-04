From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 4 Jun 2014 10:51:45 -0700
Subject: [PATCH 1/1] device.h: arm,dma-iommu: Move out dma_iommu_mapping
 struct
In-Reply-To: <1401869506-48129-2-git-send-email-ritesh.harjani@gmail.com>
References: <1401869506-48129-1-git-send-email-ritesh.harjani@gmail.com>
 <1401869506-48129-2-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <20140604175145.GD20812@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 01:41:46PM +0530, ritesh.harjani at gmail.com wrote:
> From: Ritesh Harjani <ritesh.harjani@gmail.com>
> 
> This patch moves out *mapping pointer of dma_iommu_mapping
> from arch/arm/include/asm/device.h to include/liunux/device.h

Why?  Who else can use this becides arm devices?

> 
> Also, it moves out complete structre definition of dma_iommu_mapping
> to include/linux/iommu-helper.h
> 
> This is done since arm iommu's dma-mapping arch independent code,
> needs to be moved out to lib/iommu-helper.c, this means
> dma_iommu_mapping will be arch independent and later other archs
> can make use of it.

Will that really happen?  Do you have patches that do that?  I'd prefer
to not do stuff like this until you have a patch series that needs it,
otherwise this is just unneeded churn.

> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -705,6 +705,10 @@ struct device {
>  	/* arch specific additions */
>  	struct dev_archdata	archdata;
>  
> +#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
> +	struct dma_iommu_mapping	*mapping;
> +#endif
> +
>  	struct device_node	*of_node; /* associated device tree node */
>  	struct acpi_dev_node	acpi_node; /* associated ACPI device node */
>  

Are you sure this will not break the build on systems that enable that
option, yet do not include iommu-helper.h?

thanks,

greg k-h
