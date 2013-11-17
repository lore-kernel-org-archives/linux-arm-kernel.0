From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 16 Nov 2013 18:24:39 -0800
Subject: Fwd: [PATCH 4/8] watchdog: davinci: add GET_STATUS option support
In-Reply-To: <527A28CE.2070802@ti.com>
References: <1383680783-12114-5-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28CE.2070802@ti.com>
Message-ID: <528828E7.6060404@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 03:32 AM, ivan.khoronzhuk wrote:
> When watchdog timer is expired we can know about it thought

thought -> through or with

> GET_STATUS ioctl option.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>   drivers/watchdog/davinci_wdt.c |   13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 6cbf2e1..a371b2d 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -144,6 +144,18 @@ static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
>   	return wdd->timeout - timer_counter;
>   }
>
> +static unsigned int davinci_wdt_status(struct watchdog_device *wdd)
> +{
> +	u32 val;
> +	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
> +
> +	val = ioread32(davinci_wdt->base + WDTCR);
> +	if (val & WDFLAG)
> +		return WDIOF_CARDRESET;
> +
	"Card previously reset the CPU"

Is this really accurate / correct ?

My understanding is that the status is supposed to return the reason for a previous reset/reboot,
not the curent condition.

> +	return 0;
> +}
> +
>   static const struct watchdog_info davinci_wdt_info = {
>   	.options = WDIOF_KEEPALIVEPING,
>   	.identity = "DaVinci Watchdog",
> @@ -155,6 +167,7 @@ static const struct watchdog_ops davinci_wdt_ops = {
>   	.stop		= davinci_wdt_ping,
>   	.ping		= davinci_wdt_ping,
>   	.get_timeleft	= davinci_wdt_get_timeleft,
> +	.status		= davinci_wdt_status,
>   };
>
>   static int davinci_wdt_probe(struct platform_device *pdev)
>
