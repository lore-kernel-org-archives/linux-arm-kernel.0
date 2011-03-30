From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 30 Mar 2011 12:06:05 +0530
Subject: [PATCH 2/5] OMAP3: l3: fix omap3_l3_probe error path
In-Reply-To: <1301419219-30547-3-git-send-email-omar.ramirez@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
	<1301419219-30547-3-git-send-email-omar.ramirez@ti.com>
Message-ID: <4D92CF55.2070506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/2011 10:50 PM, Omar Ramirez Luna wrote:
> Add missing free_irq and remove an empty goto label.
>
> Safe to assume that if we reached the end point of execution
> without errors, then return value is 0, so replacing instead
> another goto.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---

The free_irq() change looks good. Other changes are not
necessary though because its is personnel choice to
return from one place or from every error path.

In both forms ...
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


>   arch/arm/mach-omap2/omap_l3_smx.c |   23 ++++++++++-------------
>   1 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
> index 4321e79..32961b1 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -228,10 +228,8 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>   	int                     ret;
>
>   	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
> -	if (!l3) {
> -		ret = -ENOMEM;
> -		goto err0;
> -	}
> +	if (!l3)
> +		return -ENOMEM;
>
>   	platform_set_drvdata(pdev, l3);
>
> @@ -239,13 +237,13 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>   	if (!res) {
>   		dev_err(&pdev->dev, "couldn't find resource\n");
>   		ret = -ENODEV;
> -		goto err1;
> +		goto err0;
>   	}
>   	l3->rt = ioremap(res->start, resource_size(res));
>   	if (!(l3->rt)) {
>   		dev_err(&pdev->dev, "ioremap failed\n");
>   		ret = -ENOMEM;
> -		goto err2;
> +		goto err0;
>   	}
>
>   	l3->debug_irq = platform_get_irq(pdev, 0);
> @@ -254,7 +252,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>   		"l3-debug-irq", l3);
>   	if (ret) {
>   		dev_err(&pdev->dev, "couldn't request debug irq\n");
> -		goto err3;
> +		goto err1;
>   	}
>
>   	l3->app_irq = platform_get_irq(pdev, 1);
> @@ -264,18 +262,17 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
>
>   	if (ret) {
>   		dev_err(&pdev->dev, "couldn't request app irq\n");
> -		goto err4;
> +		goto err2;
>   	}
>
> -	goto err0;
> +	return 0;
>
> -err4:
> -err3:
> -	iounmap(l3->rt);
>   err2:
> +	free_irq(l3->debug_irq, l3);
>   err1:
> -	kfree(l3);
> +	iounmap(l3->rt);
>   err0:
> +	kfree(l3);
>   	return ret;
>   }
>
