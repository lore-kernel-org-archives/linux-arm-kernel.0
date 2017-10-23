From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 23 Oct 2017 11:45:09 +0530
Subject: [PATCH v5 07/11] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <2200ff4f-67f6-45c7-a2c8-99d066af3391@rwthex-w2-a.rwth-ad.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
 <2200ff4f-67f6-45c7-a2c8-99d066af3391@rwthex-w2-a.rwth-ad.de>
Message-ID: <20171023061508.GD936@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 01:06:34AM +0200, Stefan Br?ns wrote:
> To avoid introduction of a new compatible for each small SoC/DMA controller
> variation, move the definition of the channel count to the devicetree.
> 
> The number of vchans is no longer explicit, but limited by the highest
> port/DMA request number. The result is a slight overallocation for SoCs
> with a sparse port mapping.

Applied, thanks. But ...


>  static int sun6i_dma_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct sun6i_dma_dev *sdc;
>  	struct resource *res;
>  	int ret, i;
> @@ -1228,6 +1233,26 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  	sdc->num_vchans = sdc->cfg->nr_max_vchans;
>  	sdc->max_request = sdc->cfg->nr_max_requests;
>  
> +	ret = of_property_read_u32(np, "dma-channels", &sdc->num_pchans);
> +	if (ret && !sdc->num_pchans) {
> +		dev_err(&pdev->dev, "Can't get dma-channels.\n");
> +		return ret;
> +	}

 ... we should probably use device_read_xxx calls instead of of_xxx

-- 
~Vinod
