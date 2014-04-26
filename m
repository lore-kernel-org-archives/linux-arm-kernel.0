From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 26 Apr 2014 08:31:07 -0700
Subject: [PATCH 1/5] wdt: sunxi: Move restart code to the watchdog driver
In-Reply-To: <1398265476-29373-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <535BD13B.103@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 08:04 AM, Maxime Ripard wrote:
> Most of the watchdog code is duplicated between the machine restart code and
> the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> remove it from the machine code eventually.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   drivers/watchdog/sunxi_wdt.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index cd00a7836cdc..0644c45d2b60 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -14,6 +14,7 @@
>    */
>
>   #include <linux/clk.h>
> +#include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
> @@ -22,9 +23,12 @@
>   #include <linux/moduleparam.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/reboot.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
>
> +#include <asm/system_misc.h>
> +
>   #define WDT_MAX_TIMEOUT         16
>   #define WDT_MIN_TIMEOUT         1
>   #define WDT_MODE_TIMEOUT(n)     ((n) << 3)
> @@ -70,6 +74,30 @@ static const int wdt_timeout_map[] = {
>   	[16] = 0b1011, /* 16s */
>   };
>
> +static struct sunxi_wdt_dev *sunxi_restart_ctx;
> +
> +static void sun4i_wdt_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	if (!sunxi_restart_ctx)
> +		return;
> +
The only condition where this can happen if is there is a race between the calling
code and the remove function below. If that race really exists, it could as well
happen after this check, so the check does not really provide any value and can
be removed.

Note that I find the variable name a bit misleading. It isn't a context,
it is the poitner to sunxi_wdt_dev. What is really needed is wdt_base,
not this pointer. Would it make more sense to provide that pointer
directly instead, like you did in the code for the A31 ?

Guenter

> +	/* Enable timer and set reset bit in the watchdog */
> +	writel(WDT_MODE_EN | WDT_MODE_RST_EN,
> +	       sunxi_restart_ctx->wdt_base + WDT_MODE);
> +
> +	/*
> +	 * Restart the watchdog. The default (and lowest) interval
> +	 * value for the watchdog is 0.5s.
> +	 */
> +	writel(WDT_CTRL_RELOAD, sunxi_restart_ctx->wdt_base + WDT_CTRL);
> +
> +	while (1) {
> +		mdelay(5);
> +		writel(WDT_MODE_EN | WDT_MODE_RST_EN,
> +		       sunxi_restart_ctx->wdt_base + WDT_MODE);
> +	}
> +}
> +
>   static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
>   {
>   	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
> @@ -181,6 +209,9 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
>   	if (unlikely(err))
>   		return err;
>
> +	sunxi_restart_ctx = sunxi_wdt;
> +	arm_pm_restart = sun4i_wdt_restart;
> +
>   	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
>   			sunxi_wdt->wdt_dev.timeout, nowayout);
>
> @@ -191,6 +222,8 @@ static int sunxi_wdt_remove(struct platform_device *pdev)
>   {
>   	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
>
> +	arm_pm_restart = NULL;
> +
>   	watchdog_unregister_device(&sunxi_wdt->wdt_dev);
>   	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, NULL);
>
>
