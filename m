From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 14:55:55 +0000
Subject: [PATCH v2] mfd: ab8500-gpadc: Complain if we fail to enable
 vtvout LDO
In-Reply-To: <1362822405.8907.1.camel@phoenix>
References: <1362822405.8907.1.camel@phoenix>
Message-ID: <20130321145555.GE26314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 Mar 2013, Axel Lin wrote:

> Since commit c8801a8e
> "regulator: core: Mark all get and enable calls as __must_check",
> we must check return value of regulator_enable() to silence below build warning.
> 
>   CC      drivers/mfd/ab8500-gpadc.o
> drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_runtime_resume':
> drivers/mfd/ab8500-gpadc.c:598:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
> drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_probe':
> drivers/mfd/ab8500-gpadc.c:655:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
> 
> Also convert to devm_regulator_get(), this fixes a missing regulator_put() call
> in ab8500_gpadc_remove().
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> v2:
> In the case of goto fail_enable, we should call regulator_put instead of
> regulator_disable. However, the regulator_put call is also missed in
> ab8500_gpadc_remove(). Thus a simpler fix is to convert regulator_get to
> devm_regulator_get.
> 
>  drivers/mfd/ab8500-gpadc.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
> index b1f3561..5f341a5 100644
> --- a/drivers/mfd/ab8500-gpadc.c
> +++ b/drivers/mfd/ab8500-gpadc.c
> @@ -594,9 +594,12 @@ static int ab8500_gpadc_runtime_suspend(struct device *dev)
>  static int ab8500_gpadc_runtime_resume(struct device *dev)
>  {
>  	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> +	int ret;
>  
> -	regulator_enable(gpadc->regu);
> -	return 0;
> +	ret = regulator_enable(gpadc->regu);
> +	if (ret)
> +		dev_err(dev, "Failed to enable vtvout LDO: %d\n", ret);
> +	return ret;
>  }
>  
>  static int ab8500_gpadc_runtime_idle(struct device *dev)
> @@ -643,7 +646,7 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* VTVout LDO used to power up ab8500-GPADC */
> -	gpadc->regu = regulator_get(&pdev->dev, "vddadc");
> +	gpadc->regu = devm_regulator_get(&pdev->dev, "vddadc");
>  	if (IS_ERR(gpadc->regu)) {
>  		ret = PTR_ERR(gpadc->regu);
>  		dev_err(gpadc->dev, "failed to get vtvout LDO\n");
> @@ -652,7 +655,11 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, gpadc);
>  
> -	regulator_enable(gpadc->regu);
> +	ret = regulator_enable(gpadc->regu);
> +	if (ret) {
> +		dev_err(gpadc->dev, "Failed to enable vtvout LDO: %d\n", ret);
> +		goto fail_enable;
> +	}
>  
>  	pm_runtime_set_autosuspend_delay(gpadc->dev, GPADC_AUDOSUSPEND_DELAY);
>  	pm_runtime_use_autosuspend(gpadc->dev);
> @@ -663,6 +670,8 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  	list_add_tail(&gpadc->node, &ab8500_gpadc_list);
>  	dev_dbg(gpadc->dev, "probe success\n");
>  	return 0;
> +
> +fail_enable:
>  fail_irq:
>  	free_irq(gpadc->irq, gpadc);
>  fail:

Actually I think this is the opposite of what we want.

Please see: https://patchwork.kernel.org/patch/2147571/

I can't get hold of Jonas to ask him yet, as he is on parental leave.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
