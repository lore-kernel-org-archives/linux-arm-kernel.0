From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 9 Mar 2016 13:17:50 +0100
Subject: [PATCH 0/4] Add AXP209 GPIO driver
In-Reply-To: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <56E0146E.6050102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-03-16 11:50, Maxime Ripard wrote:
> Hi,
>
> The axp209 PMIC used in combination to some Allwinner SoCs has a bunch
> of GPIOs accessible. Some boards use these to control their backlight
> or a few LEDs.

Thanks for working on this, but IMHO this cannot go upstream like this,
the gpio pins on the axp pmics need a pinctrl driver, not a gpio
driver. I.E. on the axp209 gpio0 and gpio1 can also be used to output
an additional low-noise ldo (so as a regulator), or as an adc input.

I've been working on gsl1680 touchscreen support lately and on at least
a few a23 tablets, the low-noise ldo is used as AVCC for the touchscreen
controller. Now these use an axp223 pmic, but nothing is stopping
someone from doing something similar with an axp209 and I think it
would be best to support this from day one, rather then hope we can
retro-fit this later without breaking dts.

> There's supposed to be 4 of them, but the fourth one has a different
> configuration register scheme, and I couldn't find any board that was
> using this GPIO. It will be probably be supported eventually, but
> until then, we support only the first 3 GPIOs.

He he, this matches what I've done in u-boot, the 4th gpio indeed
is somewhat funky (and the docs are not quite clear on how it works
exactly IIRC), leaving it out for now indeed seems for the best.

Regards,

Hans
