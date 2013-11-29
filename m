From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 15:17:26 +0100
Subject: [PATCH V2] dma: tegra: register as an OF DMA controller
In-Reply-To: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
References: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129141725.GA22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 02:53:36PM -0700, Stephen Warren wrote:
[...]
>  	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
> +	if (!tdc->slave_id)
> +		tdc->slave_id = sconfig->slave_id;
>  	tdc->config_init = true;

This could use some blank lines to unclutter it a bit.

>  	return 0;
>  }
> @@ -942,7 +947,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>  	ahb_seq |= TEGRA_APBDMA_AHBSEQ_BUS_WIDTH_32;
>  
>  	csr |= TEGRA_APBDMA_CSR_ONCE | TEGRA_APBDMA_CSR_FLOW;
> -	csr |= tdc->dma_sconfig.slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
> +	csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;

Perhaps I'm missing something, but couldn't we reuse the .slave_id field
of struct dma_slave_config? It seems like it might be overwritten by the
DMA engine core or users when they call dmaengine_slave_config().

But wouldn't it be better to have the core take care of all the slave ID
management, so we don't have to jump through hoops? Or perhaps the
concept isn't general enough to map well to other drivers.

>  /* Tegra20 specific DMA controller information */
> @@ -1245,6 +1262,8 @@ static const struct of_device_id tegra_dma_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
>  
> +static struct platform_driver tegra_dmac_driver;
> +

This doesn't seem to be used anymore.

>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>  	struct resource	*res;
> @@ -1383,10 +1402,22 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> +	tdma->xlate_info.device = &tdma->dma_dev;
> +	tdma->xlate_info.post_alloc = tegra_dma_of_xlate_post_alloc;
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 of_dma_slave_xlate, &tdma->xlate_info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Tegra20 APB DMA OF registration failed %d\n", ret);
> +		goto err_unregister_dma_dev;
> +	}

Would it be useful to move this into the core and have it register the
OF parts transparently to the driver? That's of course nothing that
should be done in this patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/c1550f62/attachment.sig>
