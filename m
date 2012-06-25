From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jun 2012 12:51:54 +0300
Subject: [PATCHv9 3/8] I2C: OMAP: use devm_* functions
In-Reply-To: <1340273329-8319-4-git-send-email-shubhrajyoti@ti.com>
References: <1340273329-8319-1-git-send-email-shubhrajyoti@ti.com>
 <1340273329-8319-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120625095152.GE6468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 03:38:44PM +0530, Shubhrajyoti D wrote:
> The various devm_* functions allocate memory that is released when a driver
> detaches. This patch uses devm_kzalloc, devm_request_and_ioremap for data
> that is allocated in the probe function of a platform device and is only
> freed in the remove function.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

this looks a lot like:
http://marc.info/?l=linux-omap&m=133969143407572&w=2

I wonder why wasn't that one used instead ?

> ---
>  drivers/i2c/busses/i2c-omap.c |   33 +++++++++------------------------
>  1 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d704f64..328a022 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -943,7 +943,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev;
>  	struct i2c_adapter	*adap;
> -	struct resource		*mem, *irq, *ioarea;
> +	struct resource		*mem, *irq;
>  	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
>  	struct device_node	*node = pdev->dev.of_node;
>  	const struct of_device_id *match;
> @@ -962,17 +962,16 @@ omap_i2c_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	ioarea = request_mem_region(mem->start, resource_size(mem),
> -			pdev->name);
> -	if (!ioarea) {
> -		dev_err(&pdev->dev, "I2C region already claimed\n");
> -		return -EBUSY;
> +	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
> +	if (!dev) {
> +		dev_err(&pdev->dev, "Menory allocation failed\n");
> +		return -ENOMEM;
>  	}
>  
> -	dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
> -	if (!dev) {
> -		r = -ENOMEM;
> -		goto err_release_region;
> +	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "I2C region already claimed\n");
> +		return -ENOMEM;
>  	}
>  
>  	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
> @@ -996,11 +995,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	dev->dev = &pdev->dev;
>  	dev->irq = irq->start;
> -	dev->base = ioremap(mem->start, resource_size(mem));
> -	if (!dev->base) {
> -		r = -ENOMEM;
> -		goto err_free_mem;
> -	}
>  
>  	platform_set_drvdata(pdev, dev);
>  
> @@ -1095,13 +1089,9 @@ err_free_irq:
>  err_unuse_clocks:
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(dev->dev);
> -	iounmap(dev->base);
>  	pm_runtime_disable(&pdev->dev);
>  err_free_mem:
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(dev);
> -err_release_region:
> -	release_mem_region(mem->start, resource_size(mem));
>  
>  	return r;
>  }
> @@ -1109,7 +1099,6 @@ err_release_region:
>  static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
> -	struct resource		*mem;
>  	int ret;
>  
>  	platform_set_drvdata(pdev, NULL);
> @@ -1123,10 +1112,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -	iounmap(dev->base);
> -	kfree(dev);
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(mem->start, resource_size(mem));
>  	return 0;
>  }
>  
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/0ff5c800/attachment.sig>
