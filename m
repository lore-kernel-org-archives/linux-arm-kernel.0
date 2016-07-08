From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jul 2016 15:11:19 +0200
Subject: [PATCH 1/4] spi: s3c64xx: rename goto labels to meaningful names
In-Reply-To: <1467980304-14093-2-git-send-email-andi.shyti@samsung.com>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
 <1467980304-14093-2-git-send-email-andi.shyti@samsung.com>
Message-ID: <577FA677.7090708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 02:18 PM, Andi Shyti wrote:
> In goto labels of the style of

s/In/The/

> 
>   err4:
>   err3:
>   err2:
>   err1:
> 
> is complex to insert in between new errors without renaming all

s/is/are/ (or just rewrite it... "The style of such goto labels... is")

> the goto statments. Replace the errX naming style to meaningful

s/statments/satements/

> names in order to make it easier to insert new goto exit ponts.

s/ponts/points/


> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6f2e91a..2ab42b2 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1071,7 +1071,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
>  				ret);
> -			goto err0;
> +			goto err_deref_master;
>  		}
>  		sdd->port_id = ret;
>  	} else {
> @@ -1109,13 +1109,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
>  	if (IS_ERR(sdd->regs)) {
>  		ret = PTR_ERR(sdd->regs);
> -		goto err0;
> +		goto err_deref_master;
>  	}
>  
>  	if (sci->cfg_gpio && sci->cfg_gpio()) {
>  		dev_err(&pdev->dev, "Unable to config gpio\n");
>  		ret = -EBUSY;
> -		goto err0;
> +		goto err_deref_master;
>  	}
>  
>  	/* Setup clocks */
> @@ -1123,13 +1123,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	if (IS_ERR(sdd->clk)) {
>  		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
>  		ret = PTR_ERR(sdd->clk);
> -		goto err0;
> +		goto err_deref_master;
>  	}
>  
>  	if (clk_prepare_enable(sdd->clk)) {
>  		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
>  		ret = -EBUSY;
> -		goto err0;
> +		goto err_deref_master;
>  	}
>  
>  	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
> @@ -1138,13 +1138,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Unable to acquire clock '%s'\n", clk_name);
>  		ret = PTR_ERR(sdd->src_clk);
> -		goto err2;
> +		goto err_disable_clk;
>  	}
>  
>  	if (clk_prepare_enable(sdd->src_clk)) {
>  		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
>  		ret = -EBUSY;
> -		goto err2;
> +		goto err_disable_clk;
>  	}
>  
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
> @@ -1164,7 +1164,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n",
>  			irq, ret);
> -		goto err3;
> +		goto err_power_off;
>  	}
>  
>  	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
> @@ -1174,7 +1174,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
> -		goto err3;
> +		goto err_power_off;
>  	}
>  
>  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
> @@ -1188,15 +1188,15 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err3:
> +err_power_off:

err_pm_put? There is no real power off here (noidle).

It's a nit so anyway:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  
>  	clk_disable_unprepare(sdd->src_clk);
> -err2:
> +err_disable_clk:
>  	clk_disable_unprepare(sdd->clk);
> -err0:
> +err_deref_master:
>  	spi_master_put(master);
>  
>  	return ret;
> 
