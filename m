From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 16:59:02 +0100
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <201401081243.04326.arnd@arndb.de>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbdDHyg4uz0tAMccB8yGxsoF4JaHocAxbV_bTJ832kbQw@mail.gmail.com>
 <201401081243.04326.arnd@arndb.de>
Message-ID: <201401081659.03357.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014, Arnd Bergmann wrote:
> On Wednesday 08 January 2014, Linus Walleij wrote:
> > On Tue, Jan 7, 2014 at 8:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
b> > 
> > I was wrong about this, too much in my head. As Tomasz says,
> > pinctrl-samsung can be used, but mandates that everything is
> > moved over to device tree.
> > 
> > Probably the best thing now that I have one problem less is to
> > leave it to the S3C maintainers to complete their DT migration?
> 
> Let me have another look first, maybe I can find an intermediate
> step that helps you on your conquest to kill mach/gpio.h.

I've asked the mighty grep and it said that these are the files
using the contents you moved around:

drivers/gpio/gpio-samsung.c
drivers/leds/leds-s3c24xx.c
drivers/mmc/host/s3cmci.c
sound/soc/samsung/h1940_uda1380.c
sound/soc/samsung/neo1973_wm8753.c
sound/soc/samsung/rx1950_uda1380.c
sound/soc/samsung/s3c2412-i2s.c
sound/soc/samsung/s3c24xx-i2s.c
sound/soc/samsung/smartq_wm8987.c

The symbols used in these drivers are:

S3C....GP.()
S3C_GPIO_END
S3C_GPIO_PULL_.*
S3C_GPIO_SFN()
s3c_gpio_cfgall_range()
s3c_gpio_setpull()

which is basically all of the mach/gpio.h file, plus a few small parts of
the plat/gpio-cfg.h file. The rest of plat/gpio-cfg.h however is used in
board files to call into the gpio-samsung.c driver, so we still need 
the header file for those, until the board files get replaced with DT
descriptions using the pinctrl interface.

I think it would be worthwhile to go ahead and make all inclusions of
the plat/gpio-cfg.h file explicit, and remove it from mach/gpio.h, that
part should be simple enough and helpful at the same time. Besides the
leds-s3c24xx.c and gpio-samsung.c files we already talked about, I think
it's only s3cmci.c, s3c2412-i2s.c and s3c24xx-i2s.c that still need this
outside of mach-s3c*.

The correct way to get rid of S3C...._GP. and S3C_GPIO_END would be to
pass the GPIO numbers from platform code in platform_data pointers.
It's not hard to do, but tedious to get right for the seven drivers
that need them.

	Arnd
