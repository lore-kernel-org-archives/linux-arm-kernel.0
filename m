From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jan 2014 11:42:08 +0100
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <201401081659.03357.arnd@arndb.de>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbdDHyg4uz0tAMccB8yGxsoF4JaHocAxbV_bTJ832kbQw@mail.gmail.com>
 <201401081243.04326.arnd@arndb.de>
 <201401081659.03357.arnd@arndb.de>
Message-ID: <CACRpkdZfXFja-j9ot_e4eu4yPo_YAk-U7Gr3xXvMQhSEJBvUbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 4:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I've asked the mighty grep and it said that these are the files
> using the contents you moved around:
>
> drivers/gpio/gpio-samsung.c
> drivers/leds/leds-s3c24xx.c
> drivers/mmc/host/s3cmci.c
> sound/soc/samsung/h1940_uda1380.c
> sound/soc/samsung/neo1973_wm8753.c
> sound/soc/samsung/rx1950_uda1380.c
> sound/soc/samsung/s3c2412-i2s.c
> sound/soc/samsung/s3c24xx-i2s.c
> sound/soc/samsung/smartq_wm8987.c
>
> The symbols used in these drivers are:
>
> S3C....GP.()
> S3C_GPIO_END
> S3C_GPIO_PULL_.*
> S3C_GPIO_SFN()
> s3c_gpio_cfgall_range()
> s3c_gpio_setpull()

Hm I will look closer at these. Maybe I can even fix some to just
pass GPIO thru platform data and end-of-story them.
Targeting v3.15.

But I guess you want me to move the
<linux/platform_data/gpio-s3c*> back to <mach/*>
before v3.14 so focusing on that now. (These patches
cannot be just reverted as people have fixed other
Samsung GPIO issues on top of them, so it needs to be done
carefully.)

> I think it would be worthwhile to go ahead and make all inclusions of
> the plat/gpio-cfg.h file explicit, and remove it from mach/gpio.h, that
> part should be simple enough and helpful at the same time.

<plat/gpio-cfg.h> is used by S5P as well, but I guess you've
checked that.

If I take it driver-by-driver it should be possible to get rid of it
or most of it I think, reducing it to the arch/arm/mach-* folder.

Certainly I should be attacking S3C and S5P simultaneously.

Yours,
Linus Walleij
