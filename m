From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 12:15:05 +0100
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201401071215.06064.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 December 2013, Linus Walleij wrote:
> This isolates the custom S3C24xx GPIO definition table to
> <linux/platform_data/gpio-samsung-s3x24xx.h> as this is
> used in a few different places in the kernel, removing the
> need to depend on the implicit inclusion of <mach/gpio.h>
> from <linux/gpio.h> and thus getting rid of a few nasty
> cross-dependencies.
> 
> We also delete the nifty CONFIG_S3C24XX_GPIO_EXTRA stuff.
> The biggest this can ever be for the S3C24XX is
> CONFIG_S3C24XX_GPIO_EXTRA = 128, and then for CPU_S3C2443 or
> CPU_S3C2416 32*12 GPIOs are added, so 32*12+128 = 512
> is the absolute roof value on this platform. So we set
> the size of ARCH_NR_GPIO to this and the GPIOs array will
> fit any S3C24XX platform, as per pattern from other archs.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: linux-samsung-soc at vger.kernel.org
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm getting build errors in linux-next for s3c2410_defconfig now
because of this patch :(

Two problems:

* Some files that use functions or macros defined in this file
  fail to include it. I see drivers/leds/leds-s3c24xx.c and
  mach-osiris-dvs.c, but there might be more that don't get built
  by default.

* The file includes <plat/gpio-cfg.h>, which is not a bug yet, but
  will be once we move s3c24xx to multiplatform, which would make
  it impossible to include this file from outside of arch/arm.

Note that on Exynos, the solution for the gpio driver dependencies
was to scrap the driver and use pinctrl-exynos instead.

	Arnd
