From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Mar 2016 14:40:48 +0530
Subject: [PATCH v2 2/5] mmc: davinci: fix unwinding in probe
In-Reply-To: <1457996081-21975-3-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-3-git-send-email-david@lechnology.com>
Message-ID: <56E7D198.4050900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 March 2016 04:24 AM, David Lechner wrote:
> Unwiding from an error in davinci_mmcsd_probe was a mess. Some errors were
> not handled and not all paths unwound correctly. Also using devm_ where
> possible to simplify things.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes: use devm_ where possible
> 
>  drivers/mmc/host/davinci_mmc.c | 93 ++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index a294d261..6dd9562 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1223,7 +1223,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>  	struct mmc_davinci_host *host = NULL;
>  	struct mmc_host *mmc = NULL;
>  	struct resource *r, *mem = NULL;
> -	int ret = 0, irq = 0;
> +	int ret, irq;
>  	size_t mem_size;
>  	const struct platform_device_id *id_entry;
>  
> @@ -1233,22 +1233,20 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	ret = -ENODEV;
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (!r || irq == NO_IRQ)
> -		goto out;
> +		return -ENODEV;
>  
> -	ret = -EBUSY;
>  	mem_size = resource_size(r);
> -	mem = request_mem_region(r->start, mem_size, pdev->name);
> +	mem = devm_request_mem_region(&pdev->dev, r->start, mem_size,
> +				      pdev->name);
>  	if (!mem)
> -		goto out;
> +		return -EBUSY;
>  
> -	ret = -ENOMEM;
>  	mmc = mmc_alloc_host(sizeof(struct mmc_davinci_host), &pdev->dev);
>  	if (!mmc)
> -		goto out;
> +		ret = -ENOMEM;

This should be 'return -ENOMEM' you dont want to proceed further if this
fails.

Other than that, looks fine to me.

Regards,
Sekhar
