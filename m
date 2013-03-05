From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 05 Mar 2013 19:28:01 +0100
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1579361.FL4RHMlS27@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

First of all, thanks for your great effort on making Exynos multiplatform-
friendly.

I have added my two cents inline.

On Tuesday 05 of March 2013 18:42:10 Arnd Bergmann wrote:
> Hi everyone,
> 
> Although I'm not present at the Linaro Connect hacking
> sessions, I am participating remotely and have tried
> hacking on multiplatform support for Exynos. This patch
> set is far from complete, but I think the patches
> can be useful anyway.
> 
> The series gets increasingly fishy towards the end,
> and we should probably not apply any of the last nine
> patches as-is, nor do I expect everything to work, since
> I have not tested them at all.
> 
> With this patch set, we can build mach-exynos as part
> of a multiplatform kernel, with the following caveats:
> 
> * Only DT based boards are supported

As far as I'm aware, there are plans to drop non-DT Exynos support. Kgene 
should know more on this.

> * Moving to common-clk breaks things including cpufreq
>   and others. Thomas is working on a patch for this

We have several patches internally for fixing things up to run correclty with 
common-clk. I'll see if we can post some patches.

> * We disable the gpio implementation, which also breaks
>   stuff, but Thomas has a patch already

The legacy GPIO code is needed only for non-DT case. DT-case uses the new 
pinctrl-samsung driver, which is (AFAIK) multiplatform-aware.

> * Using the generic DMA engine API in SPI and ASoC
>   means they no longer work on S3C
> * I did not like the solution for the UART driver, but
>   could also not think of a better one.
> * The FB_S3C, S3C2410_WATCHDOG and S3C_ADC drivers
>   are left as an exercise to the reader, they are
>   currently disabled with multiplatform
> * sparsemem support is not available on multiplatform

There was some discussion some time ago whether we really need sparsemem on 
Exynos. If I remember correctly, it turned out that we don't. So this is not 
really an issue.

> The patches are based on v3.9-rc1 and I have pushed
> the git branch to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> testing/exynos-multiplatform
> 
> I have not yet added subsystem maintainers to Cc on the
> patches, I'd like to coordinate with the other people
> involved first, so see if they already have patches
> for the same drivers.
> 
> 	Arnd
> 
> Arnd Bergmann (23):
>   ARM: exynos: introduce EXYNOS_ATAGS symbol
>   irqchip: exynos: remove dependency on mach/irqs.h
>   tty: serial/samsung: prepare for common clock API
>   tty: serial/samsung: make register definitions global
>   tty: serial/samsung: fix modular build
>   ARM: exynos: move debug-macro.S to include/debug/
>   i2c: s3c2410: make header file local
>   mmc: sdhci-s3c: remove platform dependencies
>   usb: exynos: do not include plat/usb-phy.h
>   [media] exynos: remove unnecessary header inclusions
>   video/exynos: remove unnecessary header inclusions
>   thermal/exynos: remove unnecessary header inclusions
>   mtd: onenand/samsung: make regs-onenand.h file local
>   rtc: s3c: make header file local
>   spi: s3c64xx: move to generic dmaengine API
>   pwm: samsung: repair the worst MMIO abuses

I'm currently working (in my free time) on a series of cleanup patches 
sanitizing Samsung PWM code for S3C64xx and S5PV210 DT (and multiplatform) 
support.

On those platforms it is a bit more complex case as there are two blocks of 
code that access the same hardware - samsung-time (using two PWM channels for 
clocksource and clock events) and pwm-samsung.

Hopefully, I will have some patches ready soon.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework

>   ASoC: samsung: move plat/ headers to local directory
>   ASoC: samsung: convert to dmaengine API
>   ASoC: samsung: use irq resource for idma
>   ARM: exynos: prepare for sparse IRQ
>   ARM: exynos: hack to disable private clock code
>   ARM: exynos: work around missing gpio code on multiplatform
>   ARM: exynos: experimental multiplatform support
> 
>  arch/arm/Kconfig                                  |  11 +-
>  arch/arm/Kconfig.debug                            |   8 +
>  arch/arm/include/debug/exynos.S                   |  39 +++
>  arch/arm/include/debug/samsung.S                  |  87 +++++++
>  arch/arm/mach-exynos/Kconfig                      |  36 ++-
>  arch/arm/mach-exynos/Makefile                     |   5 +
>  arch/arm/mach-exynos/common.c                     |  14 +-
>  arch/arm/mach-exynos/common.h                     |   2 +-
>  arch/arm/mach-exynos/dev-audio.c                  |   1 +
>  arch/arm/mach-exynos/dev-uart.c                   |   1 +
>  arch/arm/mach-exynos/include/mach/debug-macro.S   |  39 ---
>  arch/arm/mach-exynos/include/mach/gpio.h          |   2 +
>  arch/arm/mach-exynos/include/mach/irqs.h          |   5 +-
>  arch/arm/mach-exynos/mach-armlex4210.c            |   3 +
>  arch/arm/mach-exynos/mach-exynos4-dt.c            |   2 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c            |   2 +
>  arch/arm/mach-exynos/mach-nuri.c                  |   2 +
>  arch/arm/mach-exynos/mach-origen.c                |   3 +
>  arch/arm/mach-exynos/mach-smdk4x12.c              |   2 +
>  arch/arm/mach-exynos/mach-smdkv310.c              |   3 +
>  arch/arm/mach-exynos/setup-i2c0.c                 |   3 +-
>  arch/arm/mach-exynos/setup-sdhci-gpio.c           |   2 +-
>  arch/arm/mach-exynos/setup-usb-phy.c              |   8 +-
>  arch/arm/mach-s3c24xx/clock-s3c2440.c             |   5 +
>  arch/arm/mach-s3c24xx/common.c                    |   5 +
>  arch/arm/mach-s3c24xx/dma-s3c2410.c               |   2 -
>  arch/arm/mach-s3c24xx/dma-s3c2412.c               |   2 -
>  arch/arm/mach-s3c24xx/dma-s3c2440.c               |   2 -
>  arch/arm/mach-s3c24xx/dma-s3c2443.c               |   2 -
>  arch/arm/mach-s3c24xx/include/mach/debug-macro.S  |   2 +-
>  arch/arm/mach-s3c24xx/mach-rx1950.c               |   1 -
>  arch/arm/mach-s3c64xx/include/mach/debug-macro.S  |   2 +-
>  arch/arm/mach-s3c64xx/include/mach/gpio.h         |   4 +
>  arch/arm/mach-s3c64xx/setup-usb-phy.c             |   4 +-
>  arch/arm/mach-s5p64x0/include/mach/debug-macro.S  |   2 +-
>  arch/arm/mach-s5pc100/include/mach/debug-macro.S  |   2 +-
>  arch/arm/mach-s5pc100/setup-sdhci-gpio.c          |   1 -
>  arch/arm/mach-s5pv210/include/mach/debug-macro.S  |   2 +-
>  arch/arm/mach-s5pv210/setup-sdhci-gpio.c          |   1 -
>  arch/arm/mach-s5pv210/setup-usb-phy.c             |   4 +-
>  arch/arm/plat-samsung/Kconfig                     |   5 +
>  arch/arm/plat-samsung/Makefile                    |   3 +
>  arch/arm/plat-samsung/clock-clksrc.c              |   3 +
>  arch/arm/plat-samsung/devs.c                      |  17 +-
>  arch/arm/plat-samsung/include/plat/debug-macro.S  |  87 -------
>  arch/arm/plat-samsung/include/plat/gpio-core.h    |   3 +
>  arch/arm/plat-samsung/include/plat/regs-ac97.h    |  67 -----
>  arch/arm/plat-samsung/include/plat/regs-iic.h     |  56 -----
>  arch/arm/plat-samsung/include/plat/regs-iis.h     |  70 ------
>  arch/arm/plat-samsung/include/plat/regs-onenand.h |  63 -----
>  arch/arm/plat-samsung/include/plat/regs-rtc.h     |  71 ------
>  arch/arm/plat-samsung/include/plat/regs-sdhci.h   |  87 -------
>  arch/arm/plat-samsung/include/plat/regs-serial.h  | 282
> +--------------------- arch/arm/plat-samsung/include/plat/sdhci.h        | 
> 56 +----
>  arch/arm/plat-samsung/include/plat/usb-phy.h      |   5 +-
>  arch/arm/plat-samsung/irq-vic-timer.c             |   1 +
>  arch/arm/plat-samsung/pm-gpio.c                   |   1 +
>  arch/arm/plat-samsung/pm.c                        |   1 +
>  arch/arm/plat-samsung/s5p-clock.c                 |   3 +
>  arch/arm/plat-samsung/s5p-irq.c                   |   1 +
>  drivers/cpufreq/Kconfig.arm                       |   4 +-
>  drivers/devfreq/Kconfig                           |   1 +
>  drivers/gpio/Makefile                             |   2 +-
>  drivers/i2c/busses/i2c-s3c2410.c                  |   3 +-
>  drivers/i2c/busses/i2c-s3c2410.h                  |  56 +++++
>  drivers/irqchip/exynos-combiner.c                 | 113 +++++----
>  drivers/media/platform/exynos-gsc/gsc-regs.c      |   1 -
>  drivers/media/platform/s5p-tv/sii9234_drv.c       |   3 -
>  drivers/mmc/host/Kconfig                          |   2 +-
>  drivers/mmc/host/sdhci-s3c-regs.h                 |  87 +++++++
>  drivers/mmc/host/sdhci-s3c.c                      |   5 +-
>  drivers/mtd/onenand/samsung.c                     |   4 +-
>  drivers/mtd/onenand/samsung.h                     |  61 +++++
>  drivers/pwm/pwm-samsung.c                         |  60 +++--
>  drivers/rtc/rtc-s3c.c                             |   3 +-
>  drivers/rtc/rtc-s3c.h                             |  70 ++++++
>  drivers/spi/spi-s3c64xx.c                         | 107 ++++----
>  drivers/thermal/exynos_thermal.c                  |   2 -
>  drivers/tty/serial/samsung.c                      |  17 +-
>  drivers/tty/serial/samsung.h                      |   4 +-
>  drivers/usb/host/ehci-s5p.c                       |   1 -
>  drivers/usb/host/ohci-exynos.c                    |   1 -
>  drivers/video/Kconfig                             |   2 +-
>  drivers/video/exynos/exynos_mipi_dsi.c            |   2 -
>  drivers/video/exynos/exynos_mipi_dsi_common.c     |   2 -
>  drivers/video/exynos/exynos_mipi_dsi_lowlevel.c   |   2 -
>  drivers/watchdog/Kconfig                          |   1 +
>  include/linux/platform_data/mmc-sdhci-s3c.h       |  56 +++++
>  include/linux/platform_data/spi-s3c64xx.h         |   3 +
>  include/linux/serial_s3c.h                        | 260
> ++++++++++++++++++++ sound/soc/samsung/ac97.c                          | 
> 17 +-
>  sound/soc/samsung/dma.c                           | 104 ++++----
>  sound/soc/samsung/dma.h                           |   4 +-
>  sound/soc/samsung/h1940_uda1380.c                 |   2 +-
>  sound/soc/samsung/i2s.c                           |   9 +-
>  sound/soc/samsung/idma.c                          |  10 +-
>  sound/soc/samsung/neo1973_wm8753.c                |   2 +-
>  sound/soc/samsung/pcm.c                           |  13 -
>  sound/soc/samsung/regs-ac97.h                     |  67 +++++
>  sound/soc/samsung/regs-iis.h                      |  70 ++++++
>  sound/soc/samsung/rx1950_uda1380.c                |   2 +-
>  sound/soc/samsung/s3c2412-i2s.c                   |  10 -
>  sound/soc/samsung/s3c24xx-i2s.c                   |  12 +-
>  sound/soc/samsung/s3c24xx_uda134x.c               |   2 +-
>  sound/soc/samsung/spdif.c                         |   6 -
>  105 files changed, 1262 insertions(+), 1208 deletions(-)
>  create mode 100644 arch/arm/include/debug/exynos.S
>  create mode 100644 arch/arm/include/debug/samsung.S
>  delete mode 100644 arch/arm/mach-exynos/include/mach/debug-macro.S
>  delete mode 100644 arch/arm/plat-samsung/include/plat/debug-macro.S
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-ac97.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-iic.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-iis.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-onenand.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-rtc.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-sdhci.h
>  create mode 100644 drivers/i2c/busses/i2c-s3c2410.h
>  create mode 100644 drivers/mmc/host/sdhci-s3c-regs.h
>  create mode 100644 drivers/mtd/onenand/samsung.h
>  create mode 100644 drivers/rtc/rtc-s3c.h
>  create mode 100644 include/linux/platform_data/mmc-sdhci-s3c.h
>  create mode 100644 include/linux/serial_s3c.h
>  create mode 100644 sound/soc/samsung/regs-ac97.h
>  create mode 100644 sound/soc/samsung/regs-iis.h
