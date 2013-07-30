From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Jul 2013 11:14:37 +0800
Subject: [RFC 1/8] gpio: mxc: Use devm_ functions
In-Reply-To: <1374938808-27316-2-git-send-email-mpa@pengutronix.de>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130730031436.GE19715@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 05:26:41PM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/gpio/gpio-mxc.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 7176743..cee040f 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -405,33 +405,31 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>  
>  	mxc_gpio_get_hw(pdev);
>  
> -	port = kzalloc(sizeof(struct mxc_gpio_port), GFP_KERNEL);
> +	port = devm_kzalloc(&pdev->dev, sizeof(struct mxc_gpio_port),
> +			GFP_KERNEL);
>  	if (!port)
>  		return -ENOMEM;
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!iores) {
> -		err = -ENODEV;
> -		goto out_kfree;
> +		return -ENODEV;
>  	}
>  
> -	if (!request_mem_region(iores->start, resource_size(iores),
> -				pdev->name)) {
> -		err = -EBUSY;
> -		goto out_kfree;
> +	if (!devm_request_mem_region(&pdev->dev, iores->start,
> +				resource_size(iores), pdev->name)) {
> +		return -EBUSY;
>  	}
>  
> -	port->base = ioremap(iores->start, resource_size(iores));
> +	port->base = devm_ioremap(&pdev->dev, iores->start,
> +			resource_size(iores));

It can be even cleaner by using devm_ioremap_resource().

>  	if (!port->base) {
> -		err = -ENOMEM;
> -		goto out_release_mem;
> +		return -ENOMEM;
>  	}

We should probably drop the braces then.

Shawn

>  
>  	port->irq_high = platform_get_irq(pdev, 1);
>  	port->irq = platform_get_irq(pdev, 0);
>  	if (port->irq < 0) {
> -		err = -EINVAL;
> -		goto out_iounmap;
> +		return -EINVAL;
>  	}
>  
>  	/* disable the interrupt and clear the status */
> @@ -462,7 +460,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>  			 port->base + GPIO_DR, NULL,
>  			 port->base + GPIO_GDIR, NULL, 0);
>  	if (err)
> -		goto out_iounmap;
> +		return err;
>  
>  	port->bgc.gc.to_irq = mxc_gpio_to_irq;
>  	port->bgc.gc.base = (pdev->id < 0) ? of_alias_get_id(np, "gpio") * 32 :
> @@ -498,12 +496,6 @@ out_gpiochip_remove:
>  	WARN_ON(gpiochip_remove(&port->bgc.gc) < 0);
>  out_bgpio_remove:
>  	bgpio_remove(&port->bgc);
> -out_iounmap:
> -	iounmap(port->base);
> -out_release_mem:
> -	release_mem_region(iores->start, resource_size(iores));
> -out_kfree:
> -	kfree(port);
>  	dev_info(&pdev->dev, "%s failed with errno %d\n", __func__, err);
>  	return err;
>  }
> -- 
> 1.8.3.2
> 
