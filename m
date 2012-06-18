From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 11:19:15 +0200
Subject: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER
 if GPIO not yet available
In-Reply-To: <4FDE8D27.6030508@wwwdotorg.org>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
 <4FDE8D27.6030508@wwwdotorg.org>
Message-ID: <4FDEF293.9080305@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 04:06 AM, Stephen Warren wrote:
> On 06/17/2012 04:11 AM, Roland Stigge wrote:
>> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
>> respective GPIO is not (yet) available. This is useful if driver's probe()
>> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
>> can be probed again later on.
>>
>> The function still returns -EINVAL on other errors (parse error or node doesn't
>> exist). This way, the case of an optional/intentionally missing GPIO is handled
>> appropriately.
> 
> While I agree this is a correct change, it is going to break some
> existing code - at least sound/soc/tegra/tegra_{wm8903.c,alc5632.c}.

Can you please tell in which way the patch breaks those drivers?
However, I can see that those drivers solved the same problem in a
different way (deferring of_get_named_gpio(), via the sound init()). So
they could be adjusted to take advantage of new -EPROBE_DEFER.

> I'm
> happy to send patches for those files though (is this going into 3.5 or
> 3.6?).

For 3.6 would be best, IMO.

> However, have you audited all existing callers (including
> indirect, e.g. through plain of_get_named_gpio()) for issues this will
> cause?

Thanks for the hint, I searched the code and found

drivers/spi/spi-pl022.c

to be using -ENODEV as indication to return -EPROBE_DEFER from probe().
Will send a patch that adjusts to our of_get_named_gpio_flags() patch
and if it's good, we should join the two.

Some drivers possibly suffer from the same issue that the patch adresses:

drivers/mfd/twl6040-core.c
drivers/staging/nvec/nvec.c
drivers/usb/host/ohci-at91.c
drivers/usb/host/ehci-tegra.c
drivers/usb/gadget/at91_udc.c
drivers/spi/spi-imx.c
drivers/spi/spi-sirf.c
drivers/mmc/host/sdhci-tegra.c
drivers/mmc/host/omap_hsmmc.c
drivers/mmc/host/mxs-mmc.c
drivers/mmc/host/sdhci-esdhc-imx.c
drivers/regulator/tps62360-regulator.c
drivers/regulator/fixed.c

But the breakage therefore exists even before the patch.

Other drivers don't handle the result of of_get_named_gpio*() correctly
at all:

drivers/power/sbs-battery.c

I can help the respective maintainers to work out this issue when we
have the EPROBE_DEFER ready in gpiolib-of.c.

Thanks,

Roland
