From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 10:05:25 +0800
Subject: [RFC 1/3] SPI: imx: Convert to devm_* API
In-Reply-To: <1369847430-10799-1-git-send-email-shc_work@mail.ru>
References: <20130529144909.GT3660@sirena.org.uk>
 <1369847430-10799-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130530020524.GB1875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 09:10:28PM +0400, Alexander Shiyan wrote:
> Use devm_* functions for the driver.
> This ensures more consistent error values and simplifies error paths.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/spi/spi-imx.c | 79 ++++++++++++++-------------------------------------
>  1 file changed, 21 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 0befeeb..1cd4473 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -85,7 +85,6 @@ struct spi_imx_data {
>  
>  	struct completion xfer_done;
>  	void __iomem *base;
> -	int irq;
>  	struct clk *clk_per;
>  	struct clk *clk_ipg;
>  	unsigned long spi_clk;
> @@ -761,7 +760,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	struct spi_imx_data *spi_imx;
>  	struct resource *res;
>  	struct pinctrl *pinctrl;
> -	int i, ret, num_cs;
> +	int i, irq, ret, num_cs;
>  
>  	if (!np && !mxc_platform_info) {
>  		dev_err(&pdev->dev, "can't get the platform data\n");
> @@ -798,7 +797,8 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		if (!gpio_is_valid(cs_gpio))
>  			continue;
>  
> -		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
> +		ret = devm_gpio_request(&pdev->dev, spi_imx->chipselect[i],
> +					DRIVER_NAME);
>  		if (ret) {
>  			dev_err(&pdev->dev, "can't get cs gpios\n");
>  			goto out_gpio_free;
> @@ -818,52 +818,41 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "can't get platform resource\n");
> -		ret = -ENOMEM;
> +	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spi_imx->base)) {
> +		ret = PTR_ERR(spi_imx->base);
>  		goto out_gpio_free;
>  	}
>  
> -	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> -		dev_err(&pdev->dev, "request_mem_region failed\n");
> -		ret = -EBUSY;
> -		goto out_gpio_free;
> -	}
> -
> -	spi_imx->base = ioremap(res->start, resource_size(res));
> -	if (!spi_imx->base) {
> -		ret = -EINVAL;
> -		goto out_release_mem;
> -	}
> -
> -	spi_imx->irq = platform_get_irq(pdev, 0);
> -	if (spi_imx->irq < 0) {
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
>  		ret = -EINVAL;
> -		goto out_iounmap;
> +		goto out_gpio_free;
>  	}
>  
> -	ret = request_irq(spi_imx->irq, spi_imx_isr, 0, DRIVER_NAME, spi_imx);
> +	ret = devm_request_irq(&pdev->dev, irq, spi_imx_isr, 0, DRIVER_NAME,
> +			       spi_imx);
>  	if (ret) {
> -		dev_err(&pdev->dev, "can't get irq%d: %d\n", spi_imx->irq, ret);
> -		goto out_iounmap;
> +		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
> +		goto out_gpio_free;
>  	}
>  
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>  	if (IS_ERR(pinctrl)) {
>  		ret = PTR_ERR(pinctrl);
> -		goto out_free_irq;
> +		goto out_gpio_free;
>  	}
>  
>  	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(spi_imx->clk_ipg)) {
>  		ret = PTR_ERR(spi_imx->clk_ipg);
> -		goto out_free_irq;
> +		goto out_gpio_free;
>  	}
>  
>  	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
>  	if (IS_ERR(spi_imx->clk_per)) {
>  		ret = PTR_ERR(spi_imx->clk_per);
> -		goto out_free_irq;
> +		goto out_gpio_free;
>  	}
>  
>  	clk_prepare_enable(spi_imx->clk_per);
> @@ -877,60 +866,34 @@ static int spi_imx_probe(struct platform_device *pdev)
>  
>  	master->dev.of_node = pdev->dev.of_node;
>  	ret = spi_bitbang_start(&spi_imx->bitbang);

---8<-----
> -	if (ret) {
> -		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
> -		goto out_clk_put;
> -	}
> -
> -	dev_info(&pdev->dev, "probed\n");
> +	if (!ret)
> +		return 0;
>  
> -	return ret;
> +	dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
>  
> -out_clk_put:
--->8------

I do not understand why above changes are necessary.

>  	clk_disable_unprepare(spi_imx->clk_per);
>  	clk_disable_unprepare(spi_imx->clk_ipg);
> -out_free_irq:
> -	free_irq(spi_imx->irq, spi_imx);
> -out_iounmap:
> -	iounmap(spi_imx->base);
> -out_release_mem:
> -	release_mem_region(res->start, resource_size(res));
> +
>  out_gpio_free:
> -	while (--i >= 0) {
> -		if (gpio_is_valid(spi_imx->chipselect[i]))
> -			gpio_free(spi_imx->chipselect[i]);
> -	}

With the change, label out_gpio_free becomes improper, and we should
probably rename it.

Shawn

>  	spi_master_put(master);
>  	kfree(master);
> -	platform_set_drvdata(pdev, NULL);
> +
>  	return ret;
>  }
>  
>  static int spi_imx_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master = platform_get_drvdata(pdev);
> -	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
> -	int i;
>  
>  	spi_bitbang_stop(&spi_imx->bitbang);
>  
>  	writel(0, spi_imx->base + MXC_CSPICTRL);
>  	clk_disable_unprepare(spi_imx->clk_per);
>  	clk_disable_unprepare(spi_imx->clk_ipg);
> -	free_irq(spi_imx->irq, spi_imx);
> -	iounmap(spi_imx->base);
> -
> -	for (i = 0; i < master->num_chipselect; i++)
> -		if (gpio_is_valid(spi_imx->chipselect[i]))
> -			gpio_free(spi_imx->chipselect[i]);
>  
>  	spi_master_put(master);
>  
> -	release_mem_region(res->start, resource_size(res));
> -
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
>  
> -- 
> 1.8.1.5
> 
