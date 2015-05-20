From: vadim.lomovtsev@auriga.com (Lomovtsev, Vadim)
Date: Wed, 20 May 2015 17:55:57 +0000
Subject: [PATCH v3 1/4] of: iommu: add ptr to OF node arg to
 of_iommu_configure()
References: <999c3dfe5d864d9da4990093e28fe0a3@nn-ms.office.auriga.msk>
Message-ID: <d6fd8bf744c24fa9b8c8c728cd2e4524@nn-ms.office.auriga.msk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Murali,

Are there any plans to implement IOMMU support for PCI devices ?
Even if I have "iommus", "iommu-cells" at my DT I won't get IOMMU
support because of this patch, correct?
Otherwise, I still have an ability to use dma-range so does it make a
sense to turn this message into dbg() print instead of dev_err()?

thanks,
Vadim

> Function of_iommu_configure() is called from of_dma_configure() to
> setup iommu ops using DT property. This API is currently used for
> platform devices for which DMA configuration (including iommu ops)
> may come from device's parent. To extend this functionality for PCI
> devices, this API need to take a parent node ptr as an argument
> instead of assuming device's parent. This is needed since for PCI, the
> dma configuration may be defined in the DT node of the root bus bridge's
> parent device. Currently only dma-range is used for PCI and iommu is not
> supported. So return error if the device is PCI.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>
> ---
>  drivers/iommu/of_iommu.c |   10 ++++++++--
>  drivers/of/platform.c    |    2 +-
>  include/linux/of_iommu.h |    6 ++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index af1dc6a..396bc77 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -133,19 +133,25 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>  	return ops;
>  }
>  
> -struct iommu_ops *of_iommu_configure(struct device *dev)
> +struct iommu_ops *of_iommu_configure(struct device *dev,
> +				     struct device_node *node)
>  {
>  	struct of_phandle_args iommu_spec;
>  	struct device_node *np;
>  	struct iommu_ops *ops = NULL;
>  	int idx = 0;
>  
> +	if (dev_is_pci(dev)) {
> +		dev_err(dev, "iommu is currently not supported for PCI\n");
> +		return NULL;
> +	}
> +
>  	/*
>  	 * We don't currently walk up the tree looking for a parent IOMMU.
>  	 * See the `Notes:' section of
>  	 * Documentation/devicetree/bindings/iommu/iommu.txt
>  	 */
> -	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +	while (!of_parse_phandle_with_args(node, "iommus",
>  					   "#iommu-cells", idx,
>  					   &iommu_spec)) {
>  		np = iommu_spec.np;
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index a54ec10..7675b79 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -196,7 +196,7 @@ static void of_dma_configure(struct device *dev)
>  	dev_dbg(dev, "device is%sdma coherent\n",
>  		coherent ? " " : " not ");
>  
> -	iommu = of_iommu_configure(dev);
> +	iommu = of_iommu_configure(dev, dev->of_node);
>  	dev_dbg(dev, "device is%sbehind an iommu\n",
>  		iommu ? " " : " not ");
>  
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 16c7554..3258cbb 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -12,7 +12,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>  			     size_t *size);
>  
>  extern void of_iommu_init(void);
> -extern struct iommu_ops *of_iommu_configure(struct device *dev);
> +extern struct iommu_ops *of_iommu_configure(struct device *dev,
> +					struct device_node *np);
>  
>  #else
>  
> @@ -24,7 +25,8 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
>  }
>  
>  static inline void of_iommu_init(void) { }
> -static inline struct iommu_ops *of_iommu_configure(struct device *dev)
> +static inline struct iommu_ops *of_iommu_configure(struct device *dev,
> +					 struct device_node *np)
>  {
>  	return NULL;
>  }
> -- 
> 1.7.9.5
