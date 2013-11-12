From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 10:37:04 -0500
Subject: Fwd: [PATCH 2/8] watchdog: davinci: use davinci_wdt_device
 structure to hold device data
In-Reply-To: <527A2888.5030604@ti.com>
References: <1383680783-12114-3-git-send-email-ivan.khoronzhuk@ti.com>
 <527A2888.5030604@ti.com>
Message-ID: <52824B20.9080002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 November 2013 06:31 AM, ivan.khoronzhuk wrote:
> Some SoCs, like Keystone 2, can support more than one WDT and each
> watchdog device has to use it's own base address, clock source,
> wdd device, so add new davinci_wdt_device structure to hold device
In commit avoid struct names ;)
s/wdd/watchdog device
> data.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  drivers/watchdog/davinci_wdt.c |   74 ++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index a6eef71..1fc2093 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c

[...]

> @@ -123,14 +135,21 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct resource  *wdt_mem;
>  	struct watchdog_device *wdd;
> +	struct davinci_wdt_device *davinci_wdt;
> +
> +	davinci_wdt = devm_kzalloc(dev, sizeof(*davinci_wdt), GFP_KERNEL);
> +	if (!davinci_wdt)
> +		return -ENOMEM;
>  
> -	wdt_clk = devm_clk_get(dev, NULL);
> -	if (WARN_ON(IS_ERR(wdt_clk)))
> -		return PTR_ERR(wdt_clk);
> +	davinci_wdt->clk = devm_clk_get(dev, NULL);
> +	if (WARN_ON(IS_ERR(davinci_wdt->clk)))
> +		return PTR_ERR(davinci_wdt->clk);
>  
> -	clk_prepare_enable(wdt_clk);
> +	clk_prepare_enable(davinci_wdt->clk);
>  
> -	wdd			= &wdt_wdd;
> +	platform_set_drvdata(pdev, davinci_wdt);
> +
> +	wdd			= &davinci_wdt->wdd;
>  	wdd->info		= &davinci_wdt_info;
>  	wdd->ops		= &davinci_wdt_ops;
>  	wdd->min_timeout 	= 1;
> @@ -142,12 +161,13 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>  
>  	dev_info(dev, "heartbeat %d sec\n", wdd->timeout);
>  
> +	watchdog_set_drvdata(wdd, davinci_wdt);
>  	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
>  
>  	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	wdt_base = devm_ioremap_resource(dev, wdt_mem);
> -	if (IS_ERR(wdt_base))
> -		return PTR_ERR(wdt_base);
> +	davinci_wdt->base = devm_ioremap_resource(dev, wdt_mem);
> +	if (IS_ERR(davinci_wdt->base))
> +		return PTR_ERR(davinci_wdt->base);
You should free up davinci_wdt memory before returning, right ?

Other than that patch looks fine to me. With above fixed,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
