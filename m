From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Aug 2017 14:35:01 +0530
Subject: [PATCH v2 2/3] i2c: davinci: Add PM Runtime Support
In-Reply-To: <20170816221715.15027-3-fcooper@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-3-fcooper@ti.com>
Message-ID: <8207a684-f010-ca82-baae-db06665f098e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 August 2017 03:47 AM, Franklin S Cooper Jr wrote:

> @@ -802,7 +821,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
> -	clk_prepare_enable(dev->clk);
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dev->base = devm_ioremap_resource(&pdev->dev, mem);
> @@ -811,6 +829,18 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;

This goto is wrong now. There is no need to unwind the pm_runtime setup
on a devm_ioremap_resource() failure. You can just return error here.

>  	}
>  
> +	pm_runtime_set_autosuspend_delay(dev->dev,
> +					 DAVINCI_I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev->dev);
> +
> +	pm_runtime_enable(dev->dev);
> +
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0) {
> +		dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
> +		goto err_unuse_clocks;
> +	}
> +
>  	i2c_davinci_init(dev);
>  
>  	r = devm_request_irq(&pdev->dev, dev->irq, i2c_davinci_isr, 0,
> @@ -849,10 +879,16 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	if (r)
>  		goto err_unuse_clocks;
>  
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
>  	return 0;
>  
>  err_unuse_clocks:
> -	clk_disable_unprepare(dev->clk);
> +	pm_runtime_dont_use_autosuspend(dev->dev);
> +	pm_runtime_put_sync(dev->dev);
> +	pm_runtime_disable(dev->dev);
> +
>  	dev->clk = NULL;

This null setting of clk seems quite bogus and can be cleaned-up.

>  	return r;
>  }

Thanks,
Sekhar
