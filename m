From: stwiss.opensource@diasemi.com (Opensource [Steve Twiss])
Date: Fri, 22 Aug 2014 15:47:48 +0000
Subject: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B39421@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 August 2014 13:36, Markus Pargmann [mailto:mpa at pengutronix.de] wrote:

> Subject: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.

Hi Markus,

> 
> From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> 
> This driver supports the watchdog device inside the DA906x PMIC.
> 

There is only DA9063 , in this case there is no "x". Thanks.

[...]

> +
> +/*
> + * Watchdog selector to timeout in seconds.
> + *   0: WDT disabled;
> + *   others: timeout = 2048 ms * 2^(TWDSCALE-1).
> + */
> +static const int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };

This table is just an approximation of the real times provided by the PMIC. 

The first three bits in the CONTROL_D register at 0x11 define a scaling value
for the nominal maximum time TWDMAX. The 7 values specifying the timeout
of the watchdog are:

001 = 1 = 1x = 2048ms 
010 = 2 = 2x = 4096ms
011 = 3 = 4x = 8192ms
100 = 4 = 8x = 16384ms
101 = 5 = 16x = 32768ms
110 = 6 = 32x = 65536ms
111 = 7 = 64x = 131072ms

 [...]

> +
> +static int da9063_wdt_disable(struct da9063 *da9063)
> +{
> +	return regmap_update_bits(da9063->regmap,
> DA9063_REG_CONTROL_D,
> +			DA9063_TWDSCALE_MASK,
> +			DA9063_TWDSCALE_DISABLE);
> +}
> +
> +static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int
> regval)
> +{
> +	return regmap_update_bits(da9063->regmap,
> DA9063_REG_CONTROL_D,
> +			DA9063_TWDSCALE_MASK, regval);
> +}
> +
> +static int _da9063_wdt_kick(struct da9063 *da9063)
> +{
> +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> +			DA9063_WATCHDOG);
> +}
> +

The _da9063_wdt_kick() and da9063_wdt_disable() functions are only used once
throughout the code -- in the watchdog_ops functions da9063_wdt_ping() and
da9063_wdt_stop() respectively. 
Since these are just simple regmap calls, could they be added at those places
directly and therefore remove the function calls?

[...]

> +static int da9063_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector = da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> +	if (selector < 0) {

Unsigned if < 0

 [...]

> +static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
> +		unsigned int timeout)
> +{
> +	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector = da9063_wdt_timeout_to_sel(timeout);
> +	if (selector < 0) {

And again

Regards,
Steve
