From: daniel@zonque.org (Daniel Mack)
Date: Mon, 08 Jun 2015 11:23:53 +0200
Subject: [PATCH v2] ARM: pxa: ssp: Use devm_ioremap_resource instead of
 devm_ioremap
In-Reply-To: <1433755017-30159-1-git-send-email-firogm@gmail.com>
References: <1433755017-30159-1-git-send-email-firogm@gmail.com>
Message-ID: <55755F29.4000103@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 11:16 AM, Firo Yang wrote:
> Using devm_ioremap_resource() API to simplify the code.
> 
> Signed-off-by: Firo Yang <firogm@gmail.com>

This one looks good to me now, thanks!

Reviewed-by: Daniel Mack <daniel@zonque.org>



> ---
> According to Julia's advices:
> 
> The patch "[PATCH v2] ARM: pxa: ssp: remove unnessary free for devm_xxx"
> submited by Firo Yang should be discard. It was obsoleted by
> "[PATCH] ARM: pxa: ssp: remove unnessary free for devm_xxx"
> and
> "[PATCH v2] ARM: pxa: ssp: Use devm_ioremap_resource instead of devm_ioremap"
> 
> I am not sure whether it was clear. If there is any doubt, please
>  email me.
>  arch/arm/plat-pxa/ssp.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index ad9529c..d8f331c 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -177,26 +177,12 @@ static int pxa_ssp_probe(struct platform_device *pdev)
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res == NULL) {
> -		dev_err(dev, "no memory resource defined\n");
> -		return -ENODEV;
> -	}
> -
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
> 
