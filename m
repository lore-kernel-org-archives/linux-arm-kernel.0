From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 02:04:42 +0200
Subject: [PATCH 00/30] ARM: exynos multiplatform support
Message-ID: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I have updated my series for multiplatform support of the ARM exynos
platform, based on what is currently queued up in arm-soc.

It would be really nice to still get this merged for 3.10. A lot of
the patches are really trivial, but there are some complex ones
as well.

To all subsystem maintainers: feel free to directly apply the patches
for your subsystem, there should be no dependencies between any of them,
aside from the last patch requiring all of the earlier ones to be applied
first. Getting an Ack is also fine so we can put the patches into arm-soc.

	Arnd

Arnd Bergmann (30):
  ARM: exynos: introduce EXYNOS_ATAGS symbol
  ARM: exynos: prepare for sparse IRQ
  ARM: exynos: move debug-macro.S to include/debug/
  ARM: samsung: move mfc device definition to s5p-dev-mfc.c
  tty: serial/samsung: prepare for common clock API
  tty: serial/samsung: make register definitions global
  tty: serial/samsung: fix modular build
  i2c: s3c2410: make header file local
  mmc: sdhci-s3c: remove platform dependencies
  usb: exynos: do not include plat/usb-phy.h
  [media] exynos: remove unnecessary header inclusions
  video/exynos: remove unnecessary header inclusions
  video/s3c: move platform_data out of arch/arm
  thermal/exynos: remove unnecessary header inclusions
  mtd: onenand/samsung: make regs-onenand.h file local
  rtc: s3c: make header file local
  pwm: samsung: repair the worst MMIO abuses
  ASoC: samsung: move plat/ headers to local directory
  ASoC: samsung: use irq resource for idma
  ASoC: samsung: convert to dmaengine API
  ASoC: samsung/i2s: fix module_device_table
  ASoC: samsung/idma: export idma_reg_addr_init
  clk: exynos: prepare for multiplatform
  clocksource: exynos_mct: remove platform header dependency
  irqchip: exynos: pass max combiner number to combiner_init
  irqchip: exynos: allocate combiner_data dynamically
  irqchip: exynos: localize irq lookup for ATAGS
  irqchip: exynos: pass irq_base from platform
  spi: s3c64xx: move to generic dmaengine API
  ARM: exynos: enable multiplatform support

 arch/arm/Kconfig                                   |  10 +-
 arch/arm/Kconfig.debug                             |   8 +
 arch/arm/configs/exynos4_defconfig                 |   2 +-
 .../mach/debug-macro.S => include/debug/exynos.S}  |  12 +-
 .../plat/debug-macro.S => include/debug/samsung.S} |   2 +-
 arch/arm/mach-exynos/Kconfig                       |  40 ++-
 arch/arm/mach-exynos/Makefile                      |   5 +-
 arch/arm/mach-exynos/common.c                      |  26 +-
 arch/arm/mach-exynos/common.h                      |   7 +-
 arch/arm/mach-exynos/dev-uart.c                    |   1 +
 arch/arm/mach-exynos/include/mach/irqs.h           |   5 +-
 arch/arm/mach-exynos/mach-armlex4210.c             |   2 +
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   3 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   2 +
 arch/arm/mach-exynos/mach-nuri.c                   |   2 +
 arch/arm/mach-exynos/mach-origen.c                 |   2 +
 arch/arm/mach-exynos/mach-smdk4x12.c               |   2 +
 arch/arm/mach-exynos/mach-smdkv310.c               |   3 +
 arch/arm/mach-exynos/setup-sdhci-gpio.c            |   2 +-
 arch/arm/mach-exynos/setup-usb-phy.c               |   8 +-
 arch/arm/mach-s3c24xx/clock-s3c2440.c              |   5 +
 arch/arm/mach-s3c24xx/common.c                     |   5 +
 arch/arm/mach-s3c24xx/dma-s3c2410.c                |   2 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c                |   2 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c                |   2 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c                |   2 -
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S   |   2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   1 -
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |   2 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |   4 +-
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |   2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |   2 +-
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c           |   1 -
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |   2 +-
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c           |   1 -
 arch/arm/mach-s5pv210/setup-usb-phy.c              |   4 +-
 arch/arm/plat-samsung/Kconfig                      |   7 +-
 arch/arm/plat-samsung/Makefile                     |   8 +-
 arch/arm/plat-samsung/devs.c                       |  62 ++---
 arch/arm/plat-samsung/include/plat/fb.h            |  50 +---
 arch/arm/plat-samsung/include/plat/pm.h            |   5 +
 arch/arm/plat-samsung/include/plat/regs-serial.h   | 282 +--------------------
 arch/arm/plat-samsung/include/plat/sdhci.h         |  56 +---
 arch/arm/plat-samsung/include/plat/usb-phy.h       |   5 +-
 arch/arm/plat-samsung/irq-vic-timer.c              |   1 +
 arch/arm/plat-samsung/pm.c                         |   1 +
 arch/arm/plat-samsung/s5p-dev-mfc.c                |  42 ++-
 arch/arm/plat-samsung/s5p-irq.c                    |   1 +
 drivers/clk/samsung/clk-exynos4.c                  |  93 +++----
 drivers/clk/samsung/clk-exynos5250.c               |   1 -
 drivers/clk/samsung/clk-exynos5440.c               |   1 -
 drivers/clk/samsung/clk.h                          |   2 -
 drivers/clocksource/exynos_mct.c                   |  21 +-
 drivers/gpio/Makefile                              |   2 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   3 +-
 .../regs-iic.h => drivers/i2c/busses/i2c-s3c2410.h |   0
 drivers/irqchip/exynos-combiner.c                  | 116 +++++----
 drivers/media/platform/exynos-gsc/gsc-regs.c       |   1 -
 drivers/media/platform/s5p-tv/sii9234_drv.c        |   3 -
 drivers/mmc/host/Kconfig                           |   2 +-
 .../mmc/host/sdhci-s3c-regs.h                      |   0
 drivers/mmc/host/sdhci-s3c.c                       |   5 +-
 drivers/mtd/onenand/samsung.c                      |   4 +-
 .../mtd/onenand/samsung.h                          |   2 -
 drivers/pwm/pwm-samsung.c                          |  60 +++--
 drivers/rtc/rtc-s3c.c                              |   3 +-
 .../plat/regs-rtc.h => drivers/rtc/rtc-s3c.h       |   3 +-
 drivers/spi/spi-s3c64xx.c                          | 185 ++++++++++----
 drivers/thermal/exynos_thermal.c                   |   2 -
 drivers/tty/serial/samsung.c                       |  17 +-
 drivers/tty/serial/samsung.h                       |   4 +-
 drivers/usb/host/ehci-s5p.c                        |   1 -
 drivers/usb/host/ohci-exynos.c                     |   1 -
 drivers/video/exynos/exynos_mipi_dsi.c             |   2 -
 drivers/video/exynos/exynos_mipi_dsi_common.c      |   2 -
 drivers/video/exynos/exynos_mipi_dsi_lowlevel.c    |   2 -
 drivers/video/s3c-fb.c                             |   3 +-
 include/linux/platform_data/mmc-sdhci-s3c.h        |  56 ++++
 include/linux/platform_data/spi-s3c64xx.h          |   3 +
 include/linux/platform_data/video_s3c.h            |  54 ++++
 include/linux/serial_s3c.h                         | 260 +++++++++++++++++++
 sound/soc/samsung/ac97.c                           |   2 +-
 sound/soc/samsung/dma.c                            | 219 ++++++++++++++++
 sound/soc/samsung/dma.h                            |  15 +-
 sound/soc/samsung/h1940_uda1380.c                  |   2 +-
 sound/soc/samsung/i2s.c                            |   4 +-
 sound/soc/samsung/idma.c                           |  11 +-
 sound/soc/samsung/neo1973_wm8753.c                 |   2 +-
 sound/soc/samsung/pcm.c                            |   1 -
 .../include/plat => sound/soc/samsung}/regs-ac97.h |   0
 .../include/plat => sound/soc/samsung}/regs-iis.h  |   0
 sound/soc/samsung/rx1950_uda1380.c                 |   2 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   2 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |   2 +-
 sound/soc/samsung/spdif.c                          |   1 -
 95 files changed, 1146 insertions(+), 734 deletions(-)
 rename arch/arm/{mach-exynos/include/mach/debug-macro.S => include/debug/exynos.S} (84%)
 rename arch/arm/{plat-samsung/include/plat/debug-macro.S => include/debug/samsung.S} (98%)
 rename arch/arm/plat-samsung/include/plat/regs-iic.h => drivers/i2c/busses/i2c-s3c2410.h (100%)
 rename arch/arm/plat-samsung/include/plat/regs-sdhci.h => drivers/mmc/host/sdhci-s3c-regs.h (100%)
 rename arch/arm/plat-samsung/include/plat/regs-onenand.h => drivers/mtd/onenand/samsung.h (98%)
 rename arch/arm/plat-samsung/include/plat/regs-rtc.h => drivers/rtc/rtc-s3c.h (97%)
 create mode 100644 include/linux/platform_data/mmc-sdhci-s3c.h
 create mode 100644 include/linux/platform_data/video_s3c.h
 create mode 100644 include/linux/serial_s3c.h
 rename {arch/arm/plat-samsung/include/plat => sound/soc/samsung}/regs-ac97.h (100%)
 rename {arch/arm/plat-samsung/include/plat => sound/soc/samsung}/regs-iis.h (100%)

-- 
1.8.1.2

Cc: stern at rowland.harvard.edu
Cc: a.zummo at towertech.it
Cc: ben-linux at fluff.org
Cc: cjb at laptop.org
Cc: dwmw2 at infradead.org
Cc: grant.likely at secretlab.ca
Cc: gregkh at linuxfoundation.org
Cc: jg1.han at samsung.com
Cc: john.stultz at linaro.org
Cc: broonie at opensource.wolfsonmicro.com
Cc: mchehab at redhat.com
Cc: mturquette at linaro.org
Cc: padma.kvr at gmail.com
Cc: thierry.reding at avionic-design.de
Cc: tglx at linutronix.de
Cc: t.figa at samsung.com
Cc: wsa at the-dreams.de
Cc: rui.zhang at intel.com
Cc: alsa-devel at alsa-project.org
Cc: linux-fbdev at vger.kernel.org
Cc: linux-i2c at vger.kernel.org
Cc: linux-media at vger.kernel.org
Cc: linux-mmc at vger.kernel.org
Cc: linux-mtd at lists.infradead.org
Cc: linux-pm at vger.kernel.org
Cc: linux-serial at vger.kernel.org
Cc: linux-usb at vger.kernel.org
Cc: rtc-linux at googlegroups.com
Cc: spi-devel-general at lists.sourceforge.net
.
