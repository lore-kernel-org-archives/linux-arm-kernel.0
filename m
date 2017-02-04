From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 4 Feb 2017 15:57:17 -0800
Subject: [PATCH 2/2] watchdog: sama5d4: Implement resume hook
In-Reply-To: <20170130171848.31598-2-alexandre.belloni@free-electrons.com>
References: <20170130171848.31598-1-alexandre.belloni@free-electrons.com>
 <20170130171848.31598-2-alexandre.belloni@free-electrons.com>
Message-ID: <179ad9de-b2de-947f-e990-92de1a2ce374@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2017 09:18 AM, Alexandre Belloni wrote:
> When resuming for the deepest state on sama5d2, it is necessary to restore
> MR as the registers are lost.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/watchdog/sama5d4_wdt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 6dd07bef515a..de8ff10a032e 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -258,11 +258,28 @@ static const struct of_device_id sama5d4_wdt_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sama5d4_wdt_of_match);
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sama5d4_wdt_resume(struct device *dev)
> +{
> +	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
> +
> +	wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
> +	if (wdt->mr & AT91_WDT_WDDIS)
> +		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> +
> +	return 0;
> +}
> +#endif
> +

First time I ever see a system which doesn't need a matching suspend function.
I assume that isn't needed. With that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> +static SIMPLE_DEV_PM_OPS(sama5d4_wdt_pm_ops, NULL,
> +			 sama5d4_wdt_resume);
> +
>  static struct platform_driver sama5d4_wdt_driver = {
>  	.probe		= sama5d4_wdt_probe,
>  	.remove		= sama5d4_wdt_remove,
>  	.driver		= {
>  		.name	= "sama5d4_wdt",
> +		.pm	= &sama5d4_wdt_pm_ops,
>  		.of_match_table = sama5d4_wdt_of_match,
>  	}
>  };
>
