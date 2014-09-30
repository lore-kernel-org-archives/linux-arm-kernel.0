From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 30 Sep 2014 06:46:18 -0700
Subject: [3/6] stmp3xxx_rtc_wdt: Add suspend/resume PM support
In-Reply-To: <1411419350-1297-3-git-send-email-j.uzycki@elproma.com.pl>
References: <1411419350-1297-3-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <20140930134618.GA1591@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 10:55:47PM +0200, Janusz U?ycki wrote:
> There is no conflict with rtc/rtc-stmp3xxx.c parent
> because modified registers in PM functions of stmp3xxx_rtc_wdt
> are different.
> 
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> index b4d6b34..77936b6 100644
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> @@ -95,9 +95,33 @@ static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
> +{
> +	struct watchdog_device *wdd = &stmp3xxx_wdd;
> +
> +	if (watchdog_active(wdd))
> +		return wdt_stop(wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdd = &stmp3xxx_wdd;
> +
> +	if (watchdog_active(wdd))
> +		return wdt_start(wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
> +			 stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
> +
>  static struct platform_driver stmp3xxx_wdt_driver = {
>  	.driver = {
>  		.name = "stmp3xxx_rtc_wdt",
> +		.pm = &stmp3xxx_wdt_pm_ops,
>  	},
>  	.probe = stmp3xxx_wdt_probe,
>  	.remove = stmp3xxx_wdt_remove,
