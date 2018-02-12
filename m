From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 12 Feb 2018 09:59:00 +0100
Subject: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180211200847.25000-1-marcus.folkesson@gmail.com>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
Message-ID: <c925c4cb-1367-d57e-49eb-f88a6d2a1e70@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2018 at 21:08, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
  Nicolas

> ---
> 
> Notes:
>     v3:
>     	- Use wdd->timeout instead of wdt_timeout when print out
>     	  timout in probe function.
> 
>  drivers/watchdog/sama5d4_wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 0ae947c3d7bc..255169916dbb 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -33,7 +33,7 @@ struct sama5d4_wdt {
>  	unsigned long		last_ping;
>  };
>  
> -static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> +static int wdt_timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  module_param(wdt_timeout, int, 0);
> @@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	wdd = &wdt->wdd;
> -	wdd->timeout = wdt_timeout;
> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
>  	wdd->info = &sama5d4_wdt_info;
>  	wdd->ops = &sama5d4_wdt_ops;
>  	wdd->min_timeout = MIN_WDT_TIMEOUT;
> @@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wdt);
>  
>  	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
> -		 wdt_timeout, nowayout);
> +		 wdd->timeout, nowayout);
>  
>  	return 0;
>  }
> 


-- 
Nicolas Ferre
