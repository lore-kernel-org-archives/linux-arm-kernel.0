From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 16:28:57 +0100
Subject: [PATCH 13/31] dma: tegra: register as an OF DMA controller
In-Reply-To: <1384548866-13141-14-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-14-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201311201628.57951.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Stephen Warren wrote:
> +bool tegra_dma_filter_fn(struct dma_chan *dc, void *param)
> +{
> +       u32 slave_id = *(u32 *)param;
> +       struct tegra_dma_channel *tdc;
> +
> +       if (dc->device->dev->driver != &tegra_dmac_driver.driver)
> +               return false;
> +
> +       tdc = to_tegra_dma_chan(dc);
> +       tdc->slave_id = slave_id;
> +
> +       return true;
> +}
> +
> +static struct of_dma_filter_info tegra_dma_info = {
> +       .filter_fn = tegra_dma_filter_fn,
> +};
> +
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
> @@ -1383,6 +1409,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>                 goto err_irq;
>         }
>  
> +       tegra_dma_info.dma_cap = tdma->dma_dev.cap_mask;
> +       ret = of_dma_controller_register(pdev->dev.of_node,
> +                                        of_dma_simple_xlate, &tegra_dma_info);
> +

I would suggest to use a custom xlate() function based on
dma_get_slave_channel() that was added recently: Iterating through all
channels is not necessary any more.

	Arnd
