From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Apr 2017 18:28:11 -0700
Subject: [PATCH] watchdog: bcm281xx: Fix use of uninitialized spinlock.
In-Reply-To: <20170428010232.19905-1-eric@anholt.net>
References: <20170428010232.19905-1-eric@anholt.net>
Message-ID: <8592b4ab-3277-d8ef-a227-91ad30f05328@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/27/2017 06:02 PM, Eric Anholt wrote:
> The bcm_kona_wdt_set_resolution_reg() call takes the spinlock, so
> initialize it earlier.  Fixes a warning at boot with lock debugging
> enabled.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Fixes: 6adb730dc208 ("watchdog: bcm281xx: Watchdog Driver")
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/watchdog/bcm_kona_wdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index 6fce17d5b9f1..a5775dfd8d5f 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -304,6 +304,8 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  	if (!wdt)
>  		return -ENOMEM;
>  
> +	spin_lock_init(&wdt->lock);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	wdt->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(wdt->base))
> @@ -316,7 +318,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	spin_lock_init(&wdt->lock);
>  	platform_set_drvdata(pdev, wdt);
>  	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
>  	bcm_kona_wdt_wdd.parent = &pdev->dev;
> 

-- 
Florian
