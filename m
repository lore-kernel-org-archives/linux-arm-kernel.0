From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 24 Aug 2014 17:00:07 +0200
Subject: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B39421@SW-EX-MBX02.diasemi.com>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B39421@SW-EX-MBX02.diasemi.com>
Message-ID: <20140824150007.GD23823@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Fri, Aug 22, 2014 at 03:47:48PM +0000, Opensource [Steve Twiss] wrote:
> On 16 August 2014 13:36, Markus Pargmann [mailto:mpa at pengutronix.de] wrote:
> 
> > Subject: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.
> 
> Hi Markus,
> 
> > 
> > From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> > 
> > This driver supports the watchdog device inside the DA906x PMIC.
> > 
> 
> There is only DA9063 , in this case there is no "x". Thanks.

Thanks, fixed in the commit message.

> 
> [...]
> 
> > +
> > +/*
> > + * Watchdog selector to timeout in seconds.
> > + *   0: WDT disabled;
> > + *   others: timeout = 2048 ms * 2^(TWDSCALE-1).
> > + */
> > +static const int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
> 
> This table is just an approximation of the real times provided by the PMIC. 
> 
> The first three bits in the CONTROL_D register at 0x11 define a scaling value
> for the nominal maximum time TWDMAX. The 7 values specifying the timeout
> of the watchdog are:
> 
> 001 = 1 = 1x = 2048ms 
> 010 = 2 = 2x = 4096ms
> 011 = 3 = 4x = 8192ms
> 100 = 4 = 8x = 16384ms
> 101 = 5 = 16x = 32768ms
> 110 = 6 = 32x = 65536ms
> 111 = 7 = 64x = 131072ms

Thanks. So the 7 values are good approximations for the real values
right?

> 
>  [...]
> 
> > +
> > +static int da9063_wdt_disable(struct da9063 *da9063)
> > +{
> > +	return regmap_update_bits(da9063->regmap,
> > DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK,
> > +			DA9063_TWDSCALE_DISABLE);
> > +}
> > +
> > +static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int
> > regval)
> > +{
> > +	return regmap_update_bits(da9063->regmap,
> > DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK, regval);
> > +}
> > +
> > +static int _da9063_wdt_kick(struct da9063 *da9063)
> > +{
> > +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> > +			DA9063_WATCHDOG);
> > +}
> > +
> 
> The _da9063_wdt_kick() and da9063_wdt_disable() functions are only used once
> throughout the code -- in the watchdog_ops functions da9063_wdt_ping() and
> da9063_wdt_stop() respectively. 
> Since these are just simple regmap calls, could they be added at those places
> directly and therefore remove the function calls?

Thanks, I removed those functions and included the regmap function calls
directly as they are already well described by the functions from which
they are called.

> 
> [...]
> 
> > +static int da9063_wdt_start(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
> > +	unsigned int selector;
> > +	int ret;
> > +
> > +	selector = da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> > +	if (selector < 0) {
> 
> Unsigned if < 0

That was already fixed for the next version.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140824/947ef81b/attachment.sig>
