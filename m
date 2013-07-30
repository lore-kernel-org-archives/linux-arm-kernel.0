From: horms@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 11:06:46 +0900
Subject: [PATCH] clocksource: em_sti: Convert to devm_* managed helpers
In-Reply-To: <1374848897-18545-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374848897-18545-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20130730020640.GA27724@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ CC John Stultz, Thomas Gleixner ]

On Fri, Jul 26, 2013 at 04:28:17PM +0200, Laurent Pinchart wrote:
> Replace kzalloc, clk_get, ioremap and request_irq by their managed
> counterparts to simplify error paths.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Laurent,

I was recently asked for shmobile clocksource patches to be reviewed
by the clocksource maintainers. I believe that means John Stultz
and Thomas Gleixner who I have CCed on this email accordingly.

I have also CCed linux-arm-kernel at lists.infradead.org as many moons ago
I was asked for all patches that will go through my tree and on to arm-soc
to be sent there.

> ---
>  drivers/clocksource/em_sti.c | 49 +++++++++++++-------------------------------
>  1 file changed, 14 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
> index 4329a29..b9c81b7 100644
> --- a/drivers/clocksource/em_sti.c
> +++ b/drivers/clocksource/em_sti.c
> @@ -315,68 +315,47 @@ static int em_sti_probe(struct platform_device *pdev)
>  {
>  	struct em_sti_priv *p;
>  	struct resource *res;
> -	int irq, ret;
> +	int irq;
>  
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
>  	if (p == NULL) {
>  		dev_err(&pdev->dev, "failed to allocate driver data\n");
> -		ret = -ENOMEM;
> -		goto err0;
> +		return -ENOMEM;
>  	}
>  
>  	p->pdev = pdev;
>  	platform_set_drvdata(pdev, p);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to get I/O memory\n");
> -		ret = -EINVAL;
> -		goto err0;
> -	}
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "failed to get irq\n");
> -		ret = -EINVAL;
> -		goto err0;
> +		return -EINVAL;
>  	}
>  
>  	/* map memory, let base point to the STI instance */
> -	p->base = ioremap_nocache(res->start, resource_size(res));
> -	if (p->base == NULL) {
> -		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> -		ret = -ENXIO;
> -		goto err0;
> -	}
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	p->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(p->base))
> +		return PTR_ERR(p->base);
>  
>  	/* get hold of clock */
> -	p->clk = clk_get(&pdev->dev, "sclk");
> +	p->clk = devm_clk_get(&pdev->dev, "sclk");
>  	if (IS_ERR(p->clk)) {
>  		dev_err(&pdev->dev, "cannot get clock\n");
> -		ret = PTR_ERR(p->clk);
> -		goto err1;
> +		return PTR_ERR(p->clk);
>  	}
>  
> -	if (request_irq(irq, em_sti_interrupt,
> -			IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
> -			dev_name(&pdev->dev), p)) {
> +	if (devm_request_irq(&pdev->dev, irq, em_sti_interrupt,
> +			     IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
> +			     dev_name(&pdev->dev), p)) {
>  		dev_err(&pdev->dev, "failed to request low IRQ\n");
> -		ret = -ENOENT;
> -		goto err2;
> +		return -ENOENT;
>  	}
>  
>  	raw_spin_lock_init(&p->lock);
>  	em_sti_register_clockevent(p);
>  	em_sti_register_clocksource(p);
>  	return 0;
> -
> -err2:
> -	clk_put(p->clk);
> -err1:
> -	iounmap(p->base);
> -err0:
> -	kfree(p);
> -	return ret;
>  }
>  
>  static int em_sti_remove(struct platform_device *pdev)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
