From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Jun 2015 11:01:35 +0200 (CEST)
Subject: [PATCH] ARM: pxa: ssp: Use devm_ioremap_resource instead of
 devm_ioremap
In-Reply-To: <1433753632-28534-1-git-send-email-firogm@gmail.com>
References: <1433753632-28534-1-git-send-email-firogm@gmail.com>
Message-ID: <alpine.DEB.2.10.1506081100150.2660@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -182,21 +182,12 @@ static int pxa_ssp_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}

Actually, the code up here is a check that res is not null.  You can drop
that as well.  devm_ioremap_resource checks the same thing.

julia

>
> -	res = devm_request_mem_region(dev, res->start, resource_size(res),
> -				      pdev->name);
> -	if (res == NULL) {
> -		dev_err(dev, "failed to request memory resource\n");
> -		return -EBUSY;
> -	}
> +	ssp->mmio_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ssp->mmio_base))
> +		return PTR_ERR(ssp->mmio_base);
>
>  	ssp->phys_base = res->start;
>
> -	ssp->mmio_base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (ssp->mmio_base == NULL) {
> -		dev_err(dev, "failed to ioremap() registers\n");
> -		return -ENODEV;
> -	}
> -
>  	ssp->irq = platform_get_irq(pdev, 0);
>  	if (ssp->irq < 0) {
>  		dev_err(dev, "no IRQ resource defined\n");
> --
> 2.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
