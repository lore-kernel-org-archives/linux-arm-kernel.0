From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  2 Mar 2015 13:35:53 +0100
Subject: [PATCH 00/10] ARM: s3c64xx multiplatform, help needed
Message-ID: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I've had these patches in a private git tree for a while, and have
finally gotten around to clean them up some more for submission.
Hopefully we can get all of it merged into 4.1.

I've done this to the best of my knowledge, but some parts are
a bit tricky, so I expect that there are bugs. The trickiest
part is the touchscreen driver. I've sent it out for review
last year already, but I have not found anybody who could test
it, and it's basically a blind rewrite of an existing driver,
so it's unlikely that I got it all right.

The other parts may actually work, but it is possible that
I made a mistake with the ASoC driver, the sparseirq support
or something else.

Does anyone still have access to the hardware? I'm particularly
interested in seeing this patch set get tested on smartq
and on smdk6410, which have the majority of the hardware.

Arnd Bergmann (10):
  Input: s3c2410_ts: fix S3C_ADC dependency
  ASoC: samsung/smartq: use dynamic registration
  gpio: samsung: move gpio-samsung driver back to platform code
  ARM: s3c64xx: prepare initcalls for multiplatform
  ARM: s3c64xx: enable sparse IRQ support
  iio: exynos-adc: add experimental touchscreen support
  ARM: s3c64xx: use new adc/touchscreen driver
  ARM: s3c64xx: use common debug-ll implementation
  ARM: s3c64xx: multiplatform support
  ARM: s3c64xx: allow building without board support

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |   3 +
 arch/arm/Kconfig                                   |  26 ---
 arch/arm/Kconfig.debug                             |  19 +-
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/configs/s3c6400_defconfig                 |   2 +
 arch/arm/mach-s3c64xx/Kconfig                      |  31 ++-
 arch/arm/mach-s3c64xx/Makefile                     |  23 ++-
 arch/arm/mach-s3c64xx/common.c                     |   5 +-
 arch/arm/mach-s3c64xx/cpuidle.c                    |   5 +-
 arch/arm/mach-s3c64xx/dev-uart.c                   |   1 +
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |  38 ----
 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h  |   3 +
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |  20 +-
 arch/arm/mach-s3c64xx/include/mach/pm-core.h       |   1 +
 arch/arm/mach-s3c64xx/irq-pm.c                     |   2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |   3 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |   6 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   2 +
 arch/arm/mach-s3c64xx/mach-hmt.c                   |   2 +
 arch/arm/mach-s3c64xx/mach-mini6410.c              |   5 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |   2 +
 arch/arm/mach-s3c64xx/mach-real6410.c              |   6 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |  16 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |   2 +
 arch/arm/mach-s3c64xx/mach-smartq7.c               |   2 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |   3 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   6 +-
 arch/arm/mach-s3c64xx/pl080.c                      |   4 +
 arch/arm/mach-s3c64xx/pm.c                         |   4 +
 arch/arm/mach-s3c64xx/s3c6400.c                    |   2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |   2 +-
 arch/arm/plat-samsung/Kconfig                      |   5 +-
 arch/arm/plat-samsung/Makefile                     |   5 +-
 arch/arm/plat-samsung/devs.c                       |  22 +-
 .../gpio => arch/arm/plat-samsung}/gpio-samsung.c  |  12 +-
 arch/arm/plat-samsung/init.c                       |   5 +
 arch/arm/plat-samsung/pm.c                         |   4 -
 drivers/gpio/Kconfig                               |   7 -
 drivers/gpio/Makefile                              |   1 -
 drivers/iio/adc/exynos_adc.c                       | 222 ++++++++++++++++++++-
 drivers/input/touchscreen/Kconfig                  |   2 +-
 include/linux/platform_data/touchscreen-s3c2410.h  |   1 +
 sound/soc/samsung/smartq_wm8987.c                  |  77 +++----
 43 files changed, 408 insertions(+), 204 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/debug-macro.S
 rename {drivers/gpio => arch/arm/plat-samsung}/gpio-samsung.c (99%)

-- 
2.1.0.rc2
