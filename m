From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Apr 2013 01:44:04 +0900
Subject: [PATCH v3 00/10] ARM: exynos multiplatform series, part 1
In-Reply-To: <1365716245-99231-1-git-send-email-arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
Message-ID: <517568D4.8020307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/13 06:37, Arnd Bergmann wrote:
> Hi Kukjin,
>
Hi Arnd,

> These are the patches that I would like to apply directly to
> the arm-soc next/multiplatform branch, unless you have any

Yeah, looks good to me.

> objections. This would get all the simple stuff out of the
> way, and I don't think there is a big risk of introducing
> regressions with these.
>
OK, please go ahead and if you want to add my ack:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

> A lot of the other patches have already been merged into
> subsystem trees. After this series in in arm-soc, what is
> left comes down to
>
> * The ASoC conversion to dmaengine won't make it unless someone
>    who knows that code better steps up to do it right away. This
>    means that we won't have audio in a 3.10 multiplatform kernel
>    on Exynos, but it will still work for users that don't enable
>    multiplatform.
>
> * The irqchip (combiner), clk and clksource patches are all based
>    on top   of other changesets we pulled in from your trees, so I
>    would not make them part of the next/multiplatform branch. We can
>    apply them on top of the next/drivers branch once they are
>    tested successfully.
>
> * A trivial patch is needed in the end to actually make
>    CONFIG_ARCH_EXYNOS visible in multiplatform configurations.
>    We will do that as a separate patch once everything else is
>    there.
>
> Please provide an ACK so I can put this into arm-soc, or let
> me know if I screwed up somewhere.
>
> 	Arnd
>
> Arnd Bergmann (10):
>    ARM: exynos: introduce EXYNOS_ATAGS symbol
>    ARM: exynos: prepare for sparse IRQ
>    ARM: exynos: move debug-macro.S to include/debug/
>    ARM: samsung: move mfc device definition to s5p-dev-mfc.c
>    i2c: s3c2410: make header file local
>    mmc: sdhci-s3c: remove platform dependencies
>    thermal/exynos: remove unnecessary header inclusions
>    mtd: onenand/samsung: make regs-onenand.h file local
>    rtc: s3c: make header file local
>    ARM: exynos: enable multiplatform support
>
>   arch/arm/Kconfig                                   |  9 +---
>   arch/arm/Kconfig.debug                             |  8 ++++
>   arch/arm/configs/exynos4_defconfig                 |  2 +-
>   .../mach/debug-macro.S =>  include/debug/exynos.S}  | 12 ++---
>   .../plat/debug-macro.S =>  include/debug/samsung.S} |  2 +-
>   arch/arm/mach-exynos/Kconfig                       | 41 ++++++++++++++--
>   arch/arm/mach-exynos/Makefile                      |  5 +-
>   arch/arm/mach-exynos/common.c                      |  6 +++
>   arch/arm/mach-exynos/dev-uart.c                    |  1 +
>   arch/arm/mach-exynos/include/mach/irqs.h           |  5 +-
>   arch/arm/mach-exynos/mach-armlex4210.c             |  2 +
>   arch/arm/mach-exynos/mach-exynos4-dt.c             |  2 +
>   arch/arm/mach-exynos/mach-exynos5-dt.c             |  2 +
>   arch/arm/mach-exynos/mach-nuri.c                   |  2 +
>   arch/arm/mach-exynos/mach-origen.c                 |  2 +
>   arch/arm/mach-exynos/mach-smdk4x12.c               |  2 +
>   arch/arm/mach-exynos/mach-smdkv310.c               |  3 ++
>   arch/arm/mach-exynos/setup-sdhci-gpio.c            |  2 +-
>   arch/arm/mach-s3c24xx/include/mach/debug-macro.S   |  2 +-
>   arch/arm/mach-s3c24xx/mach-rx1950.c                |  1 -
>   arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |  2 +-
>   arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |  2 +-
>   arch/arm/mach-s5pc100/include/mach/debug-macro.S   |  2 +-
>   arch/arm/mach-s5pc100/setup-sdhci-gpio.c           |  1 -
>   arch/arm/mach-s5pv210/include/mach/debug-macro.S   |  2 +-
>   arch/arm/mach-s5pv210/setup-sdhci-gpio.c           |  1 -
>   arch/arm/plat-samsung/Kconfig                      |  7 ++-
>   arch/arm/plat-samsung/Makefile                     |  8 +++-
>   arch/arm/plat-samsung/devs.c                       | 46 ------------------
>   arch/arm/plat-samsung/include/plat/pm.h            |  5 ++
>   arch/arm/plat-samsung/include/plat/sdhci.h         | 56 +---------------------
>   arch/arm/plat-samsung/irq-vic-timer.c              |  1 +
>   arch/arm/plat-samsung/pm.c                         |  1 +
>   arch/arm/plat-samsung/s5p-dev-mfc.c                | 42 +++++++++++++++-
>   arch/arm/plat-samsung/s5p-irq.c                    |  1 +
>   drivers/gpio/Makefile                              |  2 +-
>   drivers/i2c/busses/i2c-s3c2410.c                   |  3 +-
>   .../regs-iic.h =>  drivers/i2c/busses/i2c-s3c2410.h |  0
>   drivers/mmc/host/Kconfig                           |  2 +-
>   .../mmc/host/sdhci-s3c-regs.h                      |  0
>   drivers/mmc/host/sdhci-s3c.c                       |  5 +-
>   drivers/mtd/onenand/samsung.c                      |  4 +-
>   .../mtd/onenand/samsung.h                          |  2 -
>   drivers/rtc/rtc-s3c.c                              |  3 +-
>   .../plat/regs-rtc.h =>  drivers/rtc/rtc-s3c.h       |  3 +-
>   drivers/thermal/exynos_thermal.c                   |  2 -
>   include/linux/platform_data/mmc-sdhci-s3c.h        | 56 ++++++++++++++++++++++
>   47 files changed, 217 insertions(+), 153 deletions(-)
>   rename arch/arm/{mach-exynos/include/mach/debug-macro.S =>  include/debug/exynos.S} (84%)
>   rename arch/arm/{plat-samsung/include/plat/debug-macro.S =>  include/debug/samsung.S} (98%)
>   rename arch/arm/plat-samsung/include/plat/regs-iic.h =>  drivers/i2c/busses/i2c-s3c2410.h (100%)
>   rename arch/arm/plat-samsung/include/plat/regs-sdhci.h =>  drivers/mmc/host/sdhci-s3c-regs.h (100%)
>   rename arch/arm/plat-samsung/include/plat/regs-onenand.h =>  drivers/mtd/onenand/samsung.h (98%)
>   rename arch/arm/plat-samsung/include/plat/regs-rtc.h =>  drivers/rtc/rtc-s3c.h (97%)
>   create mode 100644 include/linux/platform_data/mmc-sdhci-s3c.h
