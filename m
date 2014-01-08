From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 08 Jan 2014 01:52:50 +0100
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <201401072052.30599.arnd@arndb.de>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdacaskiv2R5YTB_9jFaOueXGEFxYQUEo4eq7aHkDLhjfw@mail.gmail.com>
 <201401072052.30599.arnd@arndb.de>
Message-ID: <6590746.Z4WIdgduRV@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 of January 2014 20:52:30 Arnd Bergmann wrote:
> On Tuesday 07 January 2014, Linus Walleij wrote:
> > On Tue, Jan 7, 2014 at 12:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Friday 13 December 2013, Linus Walleij wrote:
> > 
> > Hm. I just compiled this defconfig on linux-next:
> > 
> >   AS      arch/arm/boot/compressed/lib1funcs.o
> >   AS      arch/arm/boot/compressed/ashldi3.o
> >   AS      arch/arm/boot/compressed/bswapsdi2.o
> >   CC      arch/arm/boot/compressed/decompress.o
> >   CC      arch/arm/boot/compressed/misc.o
> >   GZIP    arch/arm/boot/compressed/piggy.gzip
> >   AS      arch/arm/boot/compressed/piggy.gzip.o
> >   LD      arch/arm/boot/compressed/vmlinux
> >   OBJCOPY arch/arm/boot/zImage
> >   Kernel: arch/arm/boot/zImage is ready
> > 
> > It appears that these problems appear if you explicitly
> > enable the DT board support, can't we just put that into
> > the defconfig then, so we don't miss such things?
> 
> I don't understand. I didn't enable it manually and
> I still get it on linux-next-20130107. Maybe you were
> still on the older linux-next that had not been updated
> for some time?
> 
> > > Two problems:
> > >
> > > * Some files that use functions or macros defined in this file
> > >   fail to include it. I see drivers/leds/leds-s3c24xx.c
> > 
> > I merged a patch fixing this by having that file explicitly include
> > <plat/gpip-cfg.h> (it was already including it implicitly).
> > 
> > > and
> > >   mach-osiris-dvs.c,
> > 
> > It needs this:
> > #include <linux/platform_data/gpio-samsung-s3c24xx.h>
> > 
> > (I have sent a patch.)
> 
> Ok, thanks!
> 
> > > but there might be more that don't get built
> > >   by default.
> > 
> > Yeah implicit includes are a nightmare for refactoring...
> > I'm trying to grep around for some symbols to see if I
> > can find some lost cases.
> 
> I just tried building with "make allmodconfig KCONFIG_ALLCONFIG=allconfig",
> with the allconfig file containing a CONFIG_MACH_S3C2410=y statement.
> This caught a number of additionl problems, some related and some not.
> 
> > > * The file includes <plat/gpio-cfg.h>, which is not a bug yet, but
> > >   will be once we move s3c24xx to multiplatform, which would make
> > >   it impossible to include this file from outside of arch/arm.
> > 
> > Yes that needs to be a step for multiplatform enablement.
> > My series only tries to make the problem smaller and remove
> > the dependence on <mach/gpio.h>. All the <mach/*> and
> > <plat/*> stuff needs to go away eventually ...
> 
> True. What is actually the bigger worry here is that the contents
> of the new file, while correctly moved out of mach/gpio.h also
> don't belong into include/linux/platform_data, because they don't
> define a pdata structure but rather the contents that are supposed
> to be passed from the platform code. I would much prefer if you could
> move the file back into mach-s3c24xx/ under a new name and keep it out of
> platform_data. I suspect that the only thing actually needed by the
> gpio driver is the number of GPIO lines per platform, and we can
> find another way to communicate that. Most of the contents should
> be private to the mach-s3c code and not be visible to either the
> gpio driver or any drivers using the plat/gpio-cfg.h interface.
> 
> > > Note that on Exynos, the solution for the gpio driver dependencies
> > > was to scrap the driver and use pinctrl-exynos instead.
> > 
> > I think the S3C driver is a different piece of hardware unfortunately.
> 
> But exynos was using this driver before it moved to the new pinctrl
> driver.

Note that, however, pinctrl-samsung is a DT-only driver, so for non-DT
platforms the old gpio-samsung needs to be used. There are no DT platforms
using the old driver, though, all do use the new one.

Best regards,
Tomasz
