From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 17:57:56 +0200
Subject: [PATCH 1/5] wdt: sunxi: Move restart code to the watchdog driver
In-Reply-To: <1398265476-29373-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <11279831.fXrrNoqKX2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 17:04:32 Maxime Ripard wrote:
> Most of the watchdog code is duplicated between the machine restart code and
> the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> remove it from the machine code eventually.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>


> @@ -181,6 +209,9 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
>  	if (unlikely(err))
>  		return err;
>  
> +	sunxi_restart_ctx = sunxi_wdt;
> +	arm_pm_restart = sun4i_wdt_restart;
> +
>  	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
>  			sunxi_wdt->wdt_dev.timeout, nowayout);
>  
> @@ -191,6 +222,8 @@ static int sunxi_wdt_remove(struct platform_device *pdev)
>  {
>  	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
>  
> +	arm_pm_restart = NULL;
> +
>  	watchdog_unregister_device(&sunxi_wdt->wdt_dev);
>  	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, NULL);

I think we will eventually want a more sophisticated method of registering
and unregistering reset handlers in order to deal with multiple ways of
triggering reset. For now, your approach seems sufficient.

	Arnd
