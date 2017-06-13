From: briannorris@chromium.org (Brian Norris)
Date: Tue, 13 Jun 2017 10:29:32 -0700
Subject: [PATCH v2 1/4] spi: rockchip: fix error handling when probe
In-Reply-To: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170613172931.GA9026@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 01:25:40PM +0800, Jeffy Chen wrote:
> After failed to request dma tx chain, we need to disable pm_runtime.
> Also cleanup error labels for better readability.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2: None

Looks good to me. I guess the original code was sort of trying to do a
different style of error handling, where you name the labels after the
point where the failure comes from (i.e., if ioremap fails, you 'goto
ioremap_fail' or something like that). But since we have enough devm_*
usage here that doesn't need unwound explicitly, and we didn't add
extra labels for all them, then that "style" doesn't really make much
sense.

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  drivers/spi/spi-rockchip.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index acf31f3..bab9b13 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -684,33 +684,33 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>  	rs->regs = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(rs->regs)) {
>  		ret =  PTR_ERR(rs->regs);
> -		goto err_ioremap_resource;
> +		goto err_put_master;
>  	}
>  
>  	rs->apb_pclk = devm_clk_get(&pdev->dev, "apb_pclk");
>  	if (IS_ERR(rs->apb_pclk)) {
>  		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
>  		ret = PTR_ERR(rs->apb_pclk);
> -		goto err_ioremap_resource;
> +		goto err_put_master;
>  	}
>  
>  	rs->spiclk = devm_clk_get(&pdev->dev, "spiclk");
>  	if (IS_ERR(rs->spiclk)) {
>  		dev_err(&pdev->dev, "Failed to get spi_pclk\n");
>  		ret = PTR_ERR(rs->spiclk);
> -		goto err_ioremap_resource;
> +		goto err_put_master;
>  	}
>  
>  	ret = clk_prepare_enable(rs->apb_pclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to enable apb_pclk\n");
> -		goto err_ioremap_resource;
> +		goto err_put_master;
>  	}
>  
>  	ret = clk_prepare_enable(rs->spiclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to enable spi_clk\n");
> -		goto err_spiclk_enable;
> +		goto err_disable_apbclk;
>  	}
>  
>  	spi_enable_chip(rs, 0);
> @@ -728,7 +728,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>  	if (!rs->fifo_len) {
>  		dev_err(&pdev->dev, "Failed to get fifo length\n");
>  		ret = -EINVAL;
> -		goto err_get_fifo_len;
> +		goto err_disable_spiclk;
>  	}
>  
>  	spin_lock_init(&rs->lock);
> @@ -755,7 +755,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>  		/* Check tx to see if we need defer probing driver */
>  		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
>  			ret = -EPROBE_DEFER;
> -			goto err_get_fifo_len;
> +			goto err_disable_pm_runtime;
>  		}
>  		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
>  		rs->dma_tx.ch = NULL;
> @@ -786,23 +786,24 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register master\n");
> -		goto err_register_master;
> +		goto err_free_dma_rx;
>  	}
>  
>  	return 0;
>  
> -err_register_master:
> -	pm_runtime_disable(&pdev->dev);
> +err_free_dma_rx:
>  	if (rs->dma_rx.ch)
>  		dma_release_channel(rs->dma_rx.ch);
>  err_free_dma_tx:
>  	if (rs->dma_tx.ch)
>  		dma_release_channel(rs->dma_tx.ch);
> -err_get_fifo_len:
> +err_disable_pm_runtime:
> +	pm_runtime_disable(&pdev->dev);
> +err_disable_spiclk:
>  	clk_disable_unprepare(rs->spiclk);
> -err_spiclk_enable:
> +err_disable_apbclk:
>  	clk_disable_unprepare(rs->apb_pclk);
> -err_ioremap_resource:
> +err_put_master:
>  	spi_master_put(master);
>  
>  	return ret;
> -- 
> 2.1.4
> 
> 
