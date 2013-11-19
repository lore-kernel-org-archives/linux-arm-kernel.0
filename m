From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 18 Nov 2013 21:14:35 -0800
Subject: [PATCH 3/6] watchdog: davinci: add GET_TIMELEFT option support
In-Reply-To: <1384795139-19466-4-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384795139-19466-4-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <528AF3BB.5020305@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 09:18 AM, Ivan Khoronzhuk wrote:
> Currently, the davinci watchdog can be read while counting,
> so we can add ability to report the remaining time before
> the system will reboot.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/davinci_wdt.c |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index b353df5..55deaf8 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -116,6 +116,31 @@ static int davinci_wdt_ping(struct watchdog_device *wdd)
>   	return 0;
>   }
>
> +static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	u64 timer_counter;
> +	unsigned long freq;
> +	u32 val;
> +	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
> +
> +	/* if timeout has occured then return 0 */
> +	val = ioread32(davinci_wdt->base + WDTCR);
> +	if (val & WDFLAG)
> +		return 0;
> +
> +	freq = clk_get_rate(davinci_wdt->clk);
> +
> +	if (!freq)
> +		return 0;
> +
> +	timer_counter = ioread32(davinci_wdt->base + TIM12);
> +	timer_counter |= ((u64)ioread32(davinci_wdt->base + TIM34) << 32);
> +
> +	do_div(timer_counter, freq);
> +
> +	return wdd->timeout - timer_counter;
> +}
> +
>   static const struct watchdog_info davinci_wdt_info = {
>   	.options = WDIOF_KEEPALIVEPING,
>   	.identity = "DaVinci Watchdog",
> @@ -126,6 +151,7 @@ static const struct watchdog_ops davinci_wdt_ops = {
>   	.start		= davinci_wdt_start,
>   	.stop		= davinci_wdt_ping,
>   	.ping		= davinci_wdt_ping,
> +	.get_timeleft	= davinci_wdt_get_timeleft,
>   };
>
>   static int davinci_wdt_probe(struct platform_device *pdev)
>
