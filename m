From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 1 Feb 2018 18:58:20 -0800
Subject: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <7d53a583-f8fa-b479-cc8a-408febdddc0e@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2018 10:24 AM, Fabrizio Castro wrote:
> On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> by means of the watchdog.
> This patch adds a restart handler to rwdt_ops, and also makes sure we
> keep its priority to a medium level, in order to not override other more
> effective handlers.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v3->v4:
> * New patch spawn out from patch 12/16. The restart handler on Gen3 is
>    controversial, hopefully this patch will help finalizing the discussion.
> 
>   drivers/watchdog/renesas_wdt.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 0a1a402..6d1c4b9 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -107,6 +107,24 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
>   	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
>   }
>   
> +static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
> +			void *data)
> +{
> +	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	pm_runtime_get_sync(wdev->parent);
> +
> +	rwdt_write(priv, 0x00, RWTCSRB);
> +	rwdt_write(priv, 0x00, RWTCSRA);
> +	rwdt_write(priv, 0xffff, RWTCNT);
> +
> +	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +		cpu_relax();
> +
> +	rwdt_write(priv, 0x80, RWTCSRA);
> +	return 0;
> +}
> +
>   static const struct watchdog_info rwdt_ident = {
>   	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
>   	.identity = "Renesas WDT Watchdog",
> @@ -118,6 +136,7 @@ static const struct watchdog_ops rwdt_ops = {
>   	.stop = rwdt_stop,
>   	.ping = rwdt_init_timeout,
>   	.get_timeleft = rwdt_get_timeleft,
> +	.restart = rwdt_restart,
>   };
>   
>   static int rwdt_probe(struct platform_device *pdev)
> @@ -176,6 +195,7 @@ static int rwdt_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, priv);
>   	watchdog_set_drvdata(&priv->wdev, priv);
>   	watchdog_set_nowayout(&priv->wdev, nowayout);
> +	watchdog_set_restart_priority(&priv->wdev, 128);
>   
>   	/* This overrides the default timeout only if DT configuration was found */
>   	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
> 
