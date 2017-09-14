From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 14 Sep 2017 12:17:39 +0200
Subject: [PATCH v1 1/2] watchdog: dw_wdt: add stop watchdog operation
In-Reply-To: <20170914081402.7893-1-o.rempel@pengutronix.de>
References: <20170914081402.7893-1-o.rempel@pengutronix.de>
Message-ID: <1505384259.10100.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

On Thu, 2017-09-14 at 10:14 +0200, Oleksij Rempel wrote:
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
> ?drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
> ?1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 36be987ff9ef..50d8a6a5b5ac 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device
> *wdd)
> ?	return 0;
> ?}
> ?
> +static int dw_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> +
> +	if (IS_ERR(dw_wdt->rst)) {

	if (!dw_wdt->rst) {

Since commit 65a3b6935d92 ("watchdog: dw_wdt: get reset lines from dt"),
the reset control is requested as optional, meaning dw_wdt->rst == NULL
if the reset line is not present. If an error is value is stored into
dw_wdt->rst, the probe function does not succeed.

> +		dev_warn(wdd->parent, "No reset line. Will not
> stop.\n");
> +		return PTR_ERR(dw_wdt->rst);
> +	}

regards
Philipp
