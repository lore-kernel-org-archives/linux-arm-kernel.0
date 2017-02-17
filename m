From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 17 Feb 2017 06:47:03 -0800
Subject: [PATCH v2 3/3] watchdog: sama5d4: Implement resume hook
In-Reply-To: <20170216193053.5546-3-alexandre.belloni@free-electrons.com>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-3-alexandre.belloni@free-electrons.com>
Message-ID: <0fe51486-2de0-eda6-2310-823fc4fd7c82@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2017 11:30 AM, Alexandre Belloni wrote:
> When resuming for the deepest state on sama5d2, it is necessary to restore
> MR as the registers are lost.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Changes in v2:
>  - cache mr beofre suspending
>
>  drivers/watchdog/sama5d4_wdt.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 2a60251806d2..5ddeb4803dc3 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -28,6 +28,7 @@
>  struct sama5d4_wdt {
>  	struct watchdog_device	wdd;
>  	void __iomem		*reg_base;
> +	u32			mr;

Makes me wonder if we shouldn't just retain the original 'config'
(and maybe rename it to 'mr). After all, it _is_ used now.

>  };
>
>  static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> @@ -248,11 +249,42 @@ static const struct of_device_id sama5d4_wdt_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sama5d4_wdt_of_match);
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sama5d4_wdt_suspend(struct device *dev)
> +{
> +	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
> +
> +	wdt->mr = wdt_read(wdt, AT91_WDT_MR);
> +

Wouldn't you want to stop the watchdog here if it is running,
ie set AT91_WDT_WDDIS ?

> +	return 0;
> +}
> +
> +static int sama5d4_wdt_resume(struct device *dev)
> +{
> +	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	reg = wdt_read(wdt, AT91_WDT_MR);
> +	if (reg & AT91_WDT_WDDIS)
> +		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
> +
> +	wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);

Is that necessary ? Why not just write wdt->mr unconditionally ?

> +	if (wdt->mr & AT91_WDT_WDDIS)
> +		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sama5d4_wdt_pm_ops, sama5d4_wdt_suspend,
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
