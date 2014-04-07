From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 7 Apr 2014 09:48:11 -0700
Subject: [PATCH] watchdog: imx2_wdt:  convert to watchdog core api
In-Reply-To: <1396722580-7058-1-git-send-email-agust@denx.de>
References: <1396722580-7058-1-git-send-email-agust@denx.de>
Message-ID: <20140407164811.GA28025@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 08:29:40PM +0200, Anatolij Gustschin wrote:
> Convert the imx2_wdt driver to the new watchdog core api.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Looks pretty good, just a couple of nitpicks.

> ---
> NOTE: This patch applies on top of the imx2_wdt regmap-mmio support
> patch series http://comments.gmane.org/gmane.linux.kernel/1677735
> 
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/imx2_wdt.c |  292 ++++++++++++++++++-------------------------
>  2 files changed, 124 insertions(+), 169 deletions(-)
>  
[ ... ]

> -static void imx2_wdt_timer_ping(unsigned long arg)
> -{
> -	/* ping it every imx2_wdt.timeout / 2 seconds to prevent reboot */
> -	imx2_wdt_ping();
> -	mod_timer(&imx2_wdt.timer, jiffies + imx2_wdt.timeout * HZ / 2);
> +	regmap_read(wdev->regmap, IMX2_WDT_WCR, &val);
> +
> +	if (val & IMX2_WDT_WCR_WDE)
> +		return true;
> +	return false;
>  }

You can simplyfy this to

	return val & IMX2_WDT_WCR_WDE;

since C auto-converts from int to bool. If you feel fancy and don't
trust the C compiler, another option would be

	return !!(val & IMX2_WDT_WCR_WDE);

which would at least drop the if statement.

[ ... ]

> +
> +	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
> +	if (wdog->timeout != timeout)
>  		dev_warn(&pdev->dev, "Initial timeout out of range! "
> -			"Clamped from %u to %u\n", timeout, imx2_wdt.timeout);
> +			"Clamped from %u to %u\n", timeout, wdog->timeout);

Somewhat unrelated, but this results in a checkpatch warning.
I would suggest to put the string in a single line.

		dev_warn(&pdev->dev,
			 "Initial timeout out of range! Clamped from %u to %u\n",
			 timeout, wdog->timeout);

Guenter
