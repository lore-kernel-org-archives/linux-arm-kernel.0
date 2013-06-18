From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Jun 2013 19:23:29 +0900
Subject: [PATCH v2 00/38] Thirty eight patches big Exynos cleanup
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1c0b01ce6c0d$e0475930$a0d60b90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi All,
> 
> As I promised, I am doing some spring (or rather summer) cleaning
> of Exynos- and Samsung- related code.
> 
> This first part consists mostly of removing dead code remaining after
> removal of ATAGS support for Exynos, but several patches cleans up
> other things found by the way.
> 
> See particular patches for more detailed description.
> 
> On Exynos4210-based Trats board:
> Tested-by: Tomasz Figa <t.figa@samsung.com>
> 
> Build tested every patch with s3c6400_defconfig, s5pv210_defconfig
> and exynos_defconfig.
> 
> Changes since v1:
>  - Split patches removing SOC_EXYNOS4412
>  - Adjusted drivers to check for ARCH_EXYNOS in addition to PLAT_S5P
>  - Fixed compilation issue on s5pc100
>  - Removed empty line from mach-exynos/Makefile
>  - Removed SAMSUNG_GPIOLIB_4BIT selection from ARCH_EXYNOS
>  - Sorted Kconfig and Makefile entries
>  - Added additional cleanup from Arnd (split and slightly modified)
> 
Tomasz, good job.

After looking at, almost same with your previous version but modifying 16,
19, 21, 25(just Cc) and adding some patches 17, 18, 29 and 35 to 38. Would
be helpful to  me if you could note about that in this series ;-)

Anyway, looks good I will apply this series except removing
CONFIG_SOC_EXYNOS4412 patches.

Thanks,
- Kukjin

> Tomasz Figa (38):
>   ARM: EXYNOS: Remove unused board files
>   ARM: EXYNOS: Make ARCH_EXYNOS select USE_OF
>   ARM: SAMSUNG: Introduce SAMSUNG_ATAGS Kconfig entry
>   ARM: EXYNOS: common: Remove legacy PMU initialization code
>   ARM: EXYNOS: common: Remove legacy EINT initialization code
>   ARM: EXYNOS: common: Remove legacy UART initialization code
>   ARM: EXYNOS: Remove legacy dev- and setup- files
>   ARM: EXYNOS: common: Remove legacy interrupt initialization code
>   ARM: EXYNOS: common: Remove legacy timer initialization code
>   ARM: EXYNOS: common: Remove platform device initialization
>   ARM: EXYNOS: common: Remove legacy mapping of chip ID block
>   ARM: EXYNOS: firmware: Remove check for device tree presence
>   ARM: EXYNOS: pm_domains: Remove legacy power domain registration code
>   ARM: SAMSUNG: Introduce GPIO_SAMSUNG Kconfig entry
>   ARM: EXYNOS: Provide compatibility stubs for PM code in pm-core.h
>     header
>   ARM: SAMSUNG: Compile legacy IRQ and GPIO PM code only with ATAGS
>     support
>   [media] platform: Check for ARCH_EXYNOS separately
>   USB: Check for ARCH_EXYNOS separately
>   ARM: EXYNOS: Decouple ARCH_EXYNOS from PLAT_S5P
>   ARM: SAMSUNG: pm: Include most of mach/ headers conditionally
>   ARM: EXYNOS: Do not select legacy Kconfig symbols any more
>   ARM: EXYNOS: Remove setup-i2c0.c
>   ARM: EXYNOS: Remove mach/gpio.h
>   ARM: EXYNOS: Remove mach/regs-gpio.h header
>   ARM: SAMSUNG: Make legacy MFC support code depend on SAMSUNG_ATAGS
>   ARM: EXYNOS: Select SPARSE_IRQ for Exynos
>   ARM: EXYNOS: Remove mach/irqs.h header
>   ARM: EXYNOS: Remove unused base addresses from mach/map.h header
>   thermal: exynos: Support both Exynos4x12 SoCs
>   ARM: EXYNOS: Remove CONFIG_SOC_EXYNOS4412
>   cpufreq: exynos4x12: Remove check for SOC_EXYNOS4412
>   [media] exynos4-is: Remove check for SOC_EXYNOS4412
>   thermal: exynos: Remove check for SOC_EXYNOS4412
>   ARM: EXYNOS: Remove mach/regs-usb-phy.h header
>   ARM: EXYNOS: Remove custom init_irq callbacks
>   ARM: EXYNOS: Use exynos_init_io() as map_io callback
>   ARM: EXYNOS: Remove legacy L2X0 initialization
>   ARM: EXYNOS: Remove remaining dead code after non-DT support removal
> 
>  arch/arm/Kconfig                                 |   15 +-
>  arch/arm/Makefile                                |    1 +
>  arch/arm/mach-exynos/Kconfig                     |   31 +-
>  arch/arm/mach-exynos/Makefile                    |    7 -
>  arch/arm/mach-exynos/common.c                    |  537 +--------
>  arch/arm/mach-exynos/common.h                    |    4 +-
>  arch/arm/mach-exynos/dev-audio.c                 |  254 ----
>  arch/arm/mach-exynos/dev-uart.c                  |   55 -
>  arch/arm/mach-exynos/firmware.c                  |   22 +-
>  arch/arm/mach-exynos/include/mach/gpio.h         |  289 -----
>  arch/arm/mach-exynos/include/mach/irqs.h         |  476 --------
>  arch/arm/mach-exynos/include/mach/map.h          |  218 +---
>  arch/arm/mach-exynos/include/mach/pm-core.h      |   12 +-
>  arch/arm/mach-exynos/include/mach/regs-gpio.h    |   40 -
>  arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   74 --
>  arch/arm/mach-exynos/mach-armlex4210.c           |  207 ----
>  arch/arm/mach-exynos/mach-exynos4-dt.c           |    8 +-
>  arch/arm/mach-exynos/mach-exynos5-dt.c           |    8 +-
>  arch/arm/mach-exynos/mach-nuri.c                 | 1388
---------------------
> -
>  arch/arm/mach-exynos/mach-origen.c               |  823 -------------
>  arch/arm/mach-exynos/mach-smdk4x12.c             |  396 ------
>  arch/arm/mach-exynos/mach-smdkv310.c             |  444 -------
>  arch/arm/mach-exynos/mach-universal_c210.c       | 1159
------------------
>  arch/arm/mach-exynos/pm.c                        |    1 -
>  arch/arm/mach-exynos/pm_domains.c                |   94 +-
>  arch/arm/mach-exynos/setup-fimc.c                |   44 -
>  arch/arm/mach-exynos/setup-fimd0.c               |   43 -
>  arch/arm/mach-exynos/setup-i2c0.c                |   29 -
>  arch/arm/mach-exynos/setup-i2c1.c                |   23 -
>  arch/arm/mach-exynos/setup-i2c2.c                |   23 -
>  arch/arm/mach-exynos/setup-i2c3.c                |   23 -
>  arch/arm/mach-exynos/setup-i2c4.c                |   23 -
>  arch/arm/mach-exynos/setup-i2c5.c                |   23 -
>  arch/arm/mach-exynos/setup-i2c6.c                |   23 -
>  arch/arm/mach-exynos/setup-i2c7.c                |   23 -
>  arch/arm/mach-exynos/setup-keypad.c              |   36 -
>  arch/arm/mach-exynos/setup-sdhci-gpio.c          |  152 ---
>  arch/arm/mach-exynos/setup-spi.c                 |   45 -
>  arch/arm/mach-exynos/setup-usb-phy.c             |  223 ----
>  arch/arm/plat-samsung/Kconfig                    |   47 +-
>  arch/arm/plat-samsung/Makefile                   |   11 +-
>  arch/arm/plat-samsung/include/plat/cpu.h         |    6 +-
>  arch/arm/plat-samsung/include/plat/pm.h          |    5 +
>  arch/arm/plat-samsung/init.c                     |    8 +-
>  arch/arm/plat-samsung/pm-gpio.c                  |    5 +-
>  arch/arm/plat-samsung/pm.c                       |    8 +-
>  arch/arm/plat-samsung/s5p-dev-mfc.c              |   11 +-
>  drivers/cpufreq/Kconfig.arm                      |    2 +-
>  drivers/gpio/Kconfig                             |    7 +
>  drivers/gpio/Makefile                            |    2 +-
>  drivers/media/platform/Kconfig                   |    6 +-
>  drivers/media/platform/exynos4-is/Kconfig        |    5 +-
>  drivers/media/platform/s5p-tv/Kconfig            |    2 +-
>  drivers/thermal/exynos_thermal.c                 |    2 +-
>  drivers/usb/Kconfig                              |    1 +
>  drivers/usb/host/Kconfig                         |    2 +-
>  56 files changed, 142 insertions(+), 7284 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/dev-audio.c
>  delete mode 100644 arch/arm/mach-exynos/dev-uart.c
>  delete mode 100644 arch/arm/mach-exynos/include/mach/gpio.h
>  delete mode 100644 arch/arm/mach-exynos/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-gpio.h
>  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-phy.h
>  delete mode 100644 arch/arm/mach-exynos/mach-armlex4210.c
>  delete mode 100644 arch/arm/mach-exynos/mach-nuri.c
>  delete mode 100644 arch/arm/mach-exynos/mach-origen.c
>  delete mode 100644 arch/arm/mach-exynos/mach-smdk4x12.c
>  delete mode 100644 arch/arm/mach-exynos/mach-smdkv310.c
>  delete mode 100644 arch/arm/mach-exynos/mach-universal_c210.c
>  delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
>  delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c0.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
>  delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
>  delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
>  delete mode 100644 arch/arm/mach-exynos/setup-spi.c
>  delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c
> 
> --
> 1.8.2.1
