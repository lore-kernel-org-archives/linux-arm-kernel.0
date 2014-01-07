From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 19:27:49 +0100
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <201401071215.06064.arnd@arndb.de>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
 <201401071215.06064.arnd@arndb.de>
Message-ID: <CACRpkdacaskiv2R5YTB_9jFaOueXGEFxYQUEo4eq7aHkDLhjfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 7, 2014 at 12:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 13 December 2013, Linus Walleij wrote:
>> This isolates the custom S3C24xx GPIO definition table to
>> <linux/platform_data/gpio-samsung-s3x24xx.h> as this is
>> used in a few different places in the kernel, removing the
>> need to depend on the implicit inclusion of <mach/gpio.h>
>> from <linux/gpio.h> and thus getting rid of a few nasty
>> cross-dependencies.
>>
>> We also delete the nifty CONFIG_S3C24XX_GPIO_EXTRA stuff.
>> The biggest this can ever be for the S3C24XX is
>> CONFIG_S3C24XX_GPIO_EXTRA = 128, and then for CPU_S3C2443 or
>> CPU_S3C2416 32*12 GPIOs are added, so 32*12+128 = 512
>> is the absolute roof value on this platform. So we set
>> the size of ARCH_NR_GPIO to this and the GPIOs array will
>> fit any S3C24XX platform, as per pattern from other archs.
>>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: linux-samsung-soc at vger.kernel.org
>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'm getting build errors in linux-next for s3c2410_defconfig now
> because of this patch :(

Hm. I just compiled this defconfig on linux-next:

  AS      arch/arm/boot/compressed/lib1funcs.o
  AS      arch/arm/boot/compressed/ashldi3.o
  AS      arch/arm/boot/compressed/bswapsdi2.o
  CC      arch/arm/boot/compressed/decompress.o
  CC      arch/arm/boot/compressed/misc.o
  GZIP    arch/arm/boot/compressed/piggy.gzip
  AS      arch/arm/boot/compressed/piggy.gzip.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready

It appears that these problems appear if you explicitly
enable the DT board support, can't we just put that into
the defconfig then, so we don't miss such things?

> Two problems:
>
> * Some files that use functions or macros defined in this file
>   fail to include it. I see drivers/leds/leds-s3c24xx.c

I merged a patch fixing this by having that file explicitly include
<plat/gpip-cfg.h> (it was already including it implicitly).

> and
>   mach-osiris-dvs.c,

It needs this:
#include <linux/platform_data/gpio-samsung-s3c24xx.h>

(I have sent a patch.)

> but there might be more that don't get built
>   by default.

Yeah implicit includes are a nightmare for refactoring...
I'm trying to grep around for some symbols to see if I
can find some lost cases.

> * The file includes <plat/gpio-cfg.h>, which is not a bug yet, but
>   will be once we move s3c24xx to multiplatform, which would make
>   it impossible to include this file from outside of arch/arm.

Yes that needs to be a step for multiplatform enablement.
My series only tries to make the problem smaller and remove
the dependence on <mach/gpio.h>. All the <mach/*> and
<plat/*> stuff needs to go away eventually ...

> Note that on Exynos, the solution for the gpio driver dependencies
> was to scrap the driver and use pinctrl-exynos instead.

I think the S3C driver is a different piece of hardware unfortunately.

Yours,
Linus Walleij
