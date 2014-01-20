From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 20 Jan 2014 14:40:08 +0530
Subject: [PATCH V3 REPOST] dma: tegra: register as an OF DMA controller
In-Reply-To: <1386699949-13595-1-git-send-email-swarren@wwwdotorg.org>
References: <1386699949-13595-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140120091008.GQ26823@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 11:25:49AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Call of_dma_controller_register() so that DMA clients can look up the
> Tegra DMA controller using standard APIs. This requires the of_xlate()
> function to save off the DMA slave ID, and for tegra_dma_slave_config()
> not to over-write this information; once DMA client drivers are converted
> to dma_request_slave_channel() and DT-based lookups, they won't set this
> field of struct dma_slave_config anymore.
> 
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: dmaengine at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

Sorry for delay in doing this

--
~Vinod
> ---
> (just reposting this in order to get an ack from one of the dmaengine
> maintainers)
> 
> v3:
> * Rework of_xlate() to use new dma_get_any_slave_channel().
> v2:
> * Use of_dma_slave_xlate() rather than of_dma_simple_xlate(), as
>   suggested by Arnd Bergmann.
> 
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/dma/tegra20-apb-dma.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index afa5844c9346..d11bb3620f27 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1,7 +1,7 @@
>  /*
>   * DMA driver for Nvidia's Tegra20 APB DMA controller.
>   *
> - * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -29,6 +29,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_dma.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -199,6 +200,7 @@ struct tegra_dma_channel {
>  	void			*callback_param;
>  
>  	/* Channel-slave specific configuration */
> +	unsigned int slave_id;
>  	struct dma_slave_config dma_sconfig;
>  	struct tegra_dma_channel_regs	channel_reg;
>  };
> @@ -340,6 +342,8 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
>  	}
>  
>  	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
> +	if (!tdc->slave_id)
> +		tdc->slave_id = sconfig->slave_id;
>  	tdc->config_init = true;
>  	return 0;
>  }
> @@ -942,7 +946,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>  	ahb_seq |= TEGRA_APBDMA_AHBSEQ_BUS_WIDTH_32;
>  
>  	csr |= TEGRA_APBDMA_CSR_ONCE | TEGRA_APBDMA_CSR_FLOW;
> -	csr |= tdc->dma_sconfig.slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
> +	csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
>  	if (flags & DMA_PREP_INTERRUPT)
>  		csr |= TEGRA_APBDMA_CSR_IE_EOC;
>  
> @@ -1086,7 +1090,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
>  	csr |= TEGRA_APBDMA_CSR_FLOW;
>  	if (flags & DMA_PREP_INTERRUPT)
>  		csr |= TEGRA_APBDMA_CSR_IE_EOC;
> -	csr |= tdc->dma_sconfig.slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
> +	csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
>  
>  	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
>  
> @@ -1206,6 +1210,25 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>  		kfree(sg_req);
>  	}
>  	clk_disable_unprepare(tdma->dma_clk);
> +
> +	tdc->slave_id = 0;
> +}
> +
> +static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
> +					   struct of_dma *ofdma)
> +{
> +	struct tegra_dma *tdma = ofdma->of_dma_data;
> +	struct dma_chan *chan;
> +	struct tegra_dma_channel *tdc;
> +
> +	chan = dma_get_any_slave_channel(&tdma->dma_dev);
> +	if (!chan)
> +		return NULL;
> +
> +	tdc = to_tegra_dma_chan(chan);
> +	tdc->slave_id = dma_spec->args[0];
> +
> +	return chan;
>  }
>  
>  /* Tegra20 specific DMA controller information */
> @@ -1383,10 +1406,20 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 tegra_dma_of_xlate, tdma);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Tegra20 APB DMA OF registration failed %d\n", ret);
> +		goto err_unregister_dma_dev;
> +	}
> +
>  	dev_info(&pdev->dev, "Tegra20 APB DMA driver register %d channels\n",
>  			cdata->nr_channels);
>  	return 0;
>  
> +err_unregister_dma_dev:
> +	dma_async_device_unregister(&tdma->dma_dev);
>  err_irq:
>  	while (--i >= 0) {
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
> -- 
> 1.8.1.5
> 

-- 
