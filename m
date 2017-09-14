From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Sep 2017 07:43:45 -0700
Subject: [PATCH v1 1/2] watchdog: dw_wdt: add stop watchdog operation
In-Reply-To: <20170914081402.7893-1-o.rempel@pengutronix.de>
References: <20170914081402.7893-1-o.rempel@pengutronix.de>
Message-ID: <20170914144345.GA7337@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 10:14:01AM +0200, Oleksij Rempel wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> The only way of stopping the watchdog is by resetting it.
> Add the watchdog op for stopping the device and reset if
> a reset line is provided.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog at vger.kernel.org
> ---
>  drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 36be987ff9ef..50d8a6a5b5ac 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
>  	return 0;
>  }
>  
> +static int dw_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> +
> +	if (IS_ERR(dw_wdt->rst)) {
> +		dev_warn(wdd->parent, "No reset line. Will not stop.\n");
> +		return PTR_ERR(dw_wdt->rst);
> +	}

This is a change in behavior. Previously, with no stop function,
the watchdog core would keep pinging the watchdog in this situation.
Now it would end up spitting a warning and resetting the system.

> +
> +	reset_control_assert(dw_wdt->rst);
> +	reset_control_deassert(dw_wdt->rst);
> +
> +	return 0;
> +}
> +
>  static int dw_wdt_restart(struct watchdog_device *wdd,
>  			  unsigned long action, void *data)
>  {
> @@ -173,6 +188,7 @@ static const struct watchdog_info dw_wdt_ident = {
>  static const struct watchdog_ops dw_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= dw_wdt_start,
> +	.stop		= dw_wdt_stop,
>  	.ping		= dw_wdt_ping,
>  	.set_timeout	= dw_wdt_set_timeout,
>  	.get_timeleft	= dw_wdt_get_timeleft,
> -- 
> 2.11.0
> 
