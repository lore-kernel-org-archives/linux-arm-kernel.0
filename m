From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Jun 2015 09:09:30 +0200 (CEST)
Subject: [PATCH] ARM: pxa: ssp: remove unnessary free for devm_xxx
In-Reply-To: <1433744346-14095-1-git-send-email-firogm@gmail.com>
References: <1433744346-14095-1-git-send-email-firogm@gmail.com>
Message-ID: <alpine.DEB.2.10.1506080908460.2660@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 8 Jun 2015, Firo Yang wrote:

> A Coccinelle warning.
> It's not necessary to free memory allocated with devm_xxx
> and using these free functions maybe lead to a double free that
> will corrupt the resource subsys. So, I just remove them.

This code could also be using devm_ioremap_resource rather than
devm_request_mem_region and devm_ioremap.

julia


>
> Signed-off-by: Firo Yang <firogm@gmail.com>
> ---
>  arch/arm/plat-pxa/ssp.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index ad9529c..f3f1431 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -239,18 +239,10 @@ static int pxa_ssp_remove(struct platform_device *pdev)
>  	if (ssp == NULL)
>  		return -ENODEV;
>
> -	iounmap(ssp->mmio_base);
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -
> -	clk_put(ssp->clk);
> -
>  	mutex_lock(&ssp_lock);
>  	list_del(&ssp->node);
>  	mutex_unlock(&ssp_lock);
>
> -	kfree(ssp);
>  	return 0;
>  }
>
> --
> 2.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
