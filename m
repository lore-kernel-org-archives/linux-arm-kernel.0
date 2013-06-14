From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:36 +0200
Subject: [PATCH 00/28] Twenty eight patches big Exynos cleanup
Message-ID: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

As I promised, I am doing some spring (or rather summer) cleaning
of Exynos- and Samsung- related code.

This first part consists mostly of removing dead code remaining after
removal of ATAGS support for Exynos, but several patches cleans up
other things found by the way.

See particular patches for more detailed description.

On Exynos4210-based Trats board:
Tested-by: Tomasz Figa <t.figa@samsung.com>

Build tested every patch with s3c6400_defconfig, s5pv210_defconfig
and exynos_defconfig.

Tomasz Figa (28):
  ARM: EXYNOS: Remove unused board files
  ARM: EXYNOS: Make ARCH_EXYNOS select USE_OF
  ARM: SAMSUNG: Introduce SAMSUNG_ATAGS Kconfig entry
  ARM: EXYNOS: common: Remove legacy PMU initialization code
  ARM: EXYNOS: common: Remove legacy EINT initialization code
  ARM: EXYNOS: common: Remove legacy UART initialization code
  ARM: EXYNOS: Remove legacy dev- and setup- files
  ARM: EXYNOS: common: Remove legacy interrupt initialization code
  ARM: EXYNOS: common: Remove legacy timer initialization code
  ARM: EXYNOS: common: Remove platform device initialization
  ARM: EXYNOS: common: Remove legacy mapping of chip ID block
  ARM: EXYNOS: firmware: Remove check for device tree presence
  ARM: EXYNOS: pm_domains: Remove legacy power domain registration code
  ARM: SAMSUNG: Introduce GPIO_SAMSUNG Kconfig entry
  ARM: EXYNOS: Provide compatibility stubs for PM code in pm-core.h
    header
  ARM: SAMSUNG: Compile s5p-irq-pm only with ATAGS support
  ARM: EXYNOS: Decouple ARCH_EXYNOS from PLAT_S5P
  ARM: SAMSUNG: pm: Include most of mach/ headers conditionally
  ARM: EXYNOS: Do not select legacy Kconfig symbols any more
  ARM: EXYNOS: Remove setup-i2c0.c
  ARM: EXYNOS: Remove mach/gpio.h
  ARM: EXYNOS: Remove mach/regs-gpio.h header
  ARM: SAMSUNG: Make legacy MFC support code depend on SAMSUNG_ATAGS
  ARM: EXYNOS: Select SPARSE_IRQ for Exynos
  ARM: EXYNOS: Remove mach/irqs.h header
  ARM: EXYNOS: Remove unused base addresses from mach/map.h header
  ARM: EXYNOS: Remove CONFIG_SOC_EXYNOS4412
  ARM: EXYNOS: Remove mach/regs-usb-phy.h header

 arch/arm/Kconfig                                 |   15 +-
 arch/arm/Makefile                                |    1 +
 arch/arm/mach-exynos/Kconfig                     |   14 +-
 arch/arm/mach-exynos/Makefile                    |    6 -
 arch/arm/mach-exynos/common.c                    |  472 +-------
 arch/arm/mach-exynos/dev-audio.c                 |  254 ----
 arch/arm/mach-exynos/dev-uart.c                  |   55 -
 arch/arm/mach-exynos/firmware.c                  |   22 +-
 arch/arm/mach-exynos/include/mach/gpio.h         |  289 -----
 arch/arm/mach-exynos/include/mach/irqs.h         |  476 --------
 arch/arm/mach-exynos/include/mach/map.h          |  214 ----
 arch/arm/mach-exynos/include/mach/pm-core.h      |    5 +
 arch/arm/mach-exynos/include/mach/regs-gpio.h    |   40 -
 arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   74 --
 arch/arm/mach-exynos/mach-armlex4210.c           |  207 ----
 arch/arm/mach-exynos/mach-nuri.c                 | 1388 ----------------------
 arch/arm/mach-exynos/mach-origen.c               |  823 -------------
 arch/arm/mach-exynos/mach-smdk4x12.c             |  396 ------
 arch/arm/mach-exynos/mach-smdkv310.c             |  444 -------
 arch/arm/mach-exynos/mach-universal_c210.c       | 1159 ------------------
 arch/arm/mach-exynos/pm.c                        |    1 -
 arch/arm/mach-exynos/pm_domains.c                |   94 +-
 arch/arm/mach-exynos/setup-fimc.c                |   44 -
 arch/arm/mach-exynos/setup-fimd0.c               |   43 -
 arch/arm/mach-exynos/setup-i2c0.c                |   29 -
 arch/arm/mach-exynos/setup-i2c1.c                |   23 -
 arch/arm/mach-exynos/setup-i2c2.c                |   23 -
 arch/arm/mach-exynos/setup-i2c3.c                |   23 -
 arch/arm/mach-exynos/setup-i2c4.c                |   23 -
 arch/arm/mach-exynos/setup-i2c5.c                |   23 -
 arch/arm/mach-exynos/setup-i2c6.c                |   23 -
 arch/arm/mach-exynos/setup-i2c7.c                |   23 -
 arch/arm/mach-exynos/setup-keypad.c              |   36 -
 arch/arm/mach-exynos/setup-sdhci-gpio.c          |  152 ---
 arch/arm/mach-exynos/setup-spi.c                 |   45 -
 arch/arm/mach-exynos/setup-usb-phy.c             |  223 ----
 arch/arm/plat-samsung/Kconfig                    |   40 +-
 arch/arm/plat-samsung/Makefile                   |   11 +-
 arch/arm/plat-samsung/include/plat/cpu.h         |    6 +-
 arch/arm/plat-samsung/include/plat/pm.h          |    5 +
 arch/arm/plat-samsung/init.c                     |    8 +-
 arch/arm/plat-samsung/pm-gpio.c                  |    5 +-
 arch/arm/plat-samsung/pm.c                       |    8 +-
 arch/arm/plat-samsung/s5p-dev-mfc.c              |   11 +-
 drivers/cpufreq/Kconfig.arm                      |    2 +-
 drivers/gpio/Kconfig                             |    7 +
 drivers/gpio/Makefile                            |    2 +-
 drivers/media/platform/exynos4-is/Kconfig        |    2 +-
 drivers/thermal/exynos_thermal.c                 |    2 +-
 drivers/tty/serial/samsung.c                     |    3 +-
 50 files changed, 115 insertions(+), 7179 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/dev-audio.c
 delete mode 100644 arch/arm/mach-exynos/dev-uart.c
 delete mode 100644 arch/arm/mach-exynos/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-gpio.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-phy.h
 delete mode 100644 arch/arm/mach-exynos/mach-armlex4210.c
 delete mode 100644 arch/arm/mach-exynos/mach-nuri.c
 delete mode 100644 arch/arm/mach-exynos/mach-origen.c
 delete mode 100644 arch/arm/mach-exynos/mach-smdk4x12.c
 delete mode 100644 arch/arm/mach-exynos/mach-smdkv310.c
 delete mode 100644 arch/arm/mach-exynos/mach-universal_c210.c
 delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
 delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c0.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
 delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
 delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
 delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/mach-exynos/setup-spi.c
 delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c

-- 
1.8.2.1
