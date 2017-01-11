From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 22:08:56 +0100
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range passed
 to arch_setup_dma_ops()
In-Reply-To: <1484159512-28515-2-git-send-email-nikita.yoush@cogentembedded.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
 <1484159512-28515-2-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <30025121.yS4lyZEDrk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 11, 2017 9:31:51 PM CET Nikita Yushchenko wrote:

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9afcbf7..0995ab3 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1096,7 +1096,7 @@ static int rk_iommu_domain_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* Set dma_ops for dev, otherwise it would be dummy_dma_ops */
> -	arch_setup_dma_ops(dev, 0, DMA_BIT_MASK(32), NULL, false);
> +	arch_setup_dma_ops(dev, 0, DMA_BIT_MASK(32), false, NULL, false);
>  
>  	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
>  	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index c9b7ad6..19f70d8 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2533,7 +2533,7 @@ static int dpaa_eth_probe(struct platform_device *pdev)
>  	priv->buf_layout[TX].priv_data_size = DPAA_TX_PRIV_DATA_SIZE; /* Tx */
>  
>  	/* device used for DMA mapping */
> -	arch_setup_dma_ops(dev, 0, 0, NULL, false);
> +	arch_setup_dma_ops(dev, 0, 0, false, NULL, false);
>  	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
>  	if (err) {
>  		dev_err(dev, "dma_coerce_mask_and_coherent() failed\n");
> diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
> index 5ac373c..480b644 100644
> --- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
> +++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
> @@ -540,7 +540,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
>  
>  	/* Objects are coherent, unless 'no shareability' flag set. */
>  	if (!(obj_desc->flags & DPRC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> +		arch_setup_dma_ops(&mc_dev->dev, 0, 0, false, NULL, true);
>  
>  	/*
>  	 * The device-specific probe callback will get invoked by device_add()

Why are these actually calling arch_setup_dma_ops() here in the first
place? Are these all devices that are DMA masters without an OF node?

> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index fd5cfad..1cc2115 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -89,6 +89,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	bool coherent;
>  	unsigned long offset;
>  	const struct iommu_ops *iommu;
> +	bool enforce_range = false;
>  
>  	/*
>  	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> @@ -126,6 +127,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  			return;
>  		}
>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
> +
> +		enforce_range = true;
>  	}
>  
>  	dev->dma_pfn_offset = offset;

Hmm, I think when the dma-ranges are missing, we should either enforce
a 32-bit mask, or disallow DMA completely. It's probably too late for
the latter, I wish we had done this earlier in order to force everyone
on ARM64 to have a valid dma-ranges property for any DMA master.

	Arnd
