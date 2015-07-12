From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:38 -0500
Subject: [PATCH v2 00/13] Kill off set_irq_flags
Message-ID: <1436711211-18223-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series converts all users of ARM specific set_irq_flags to use
common genirq functions. set_irq_flags is just a wrapper around
irq_modify_status, so this simply removes the wrapper to directly call
irq_modify_status (or other helpers) and the translation from ARM
specific flags to genirq flags. The final irq flag states are unchanged.
In many cases where irqdomains are used, the set_irq_flags calls were
redundant, so I've removed them.

The last version has been run thru kernelci.org testing (thanks Kevin H!).
I plan to send this series through arm-soc. I still need acks from the To
list here.

This series is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git irqflags

v2 changes:
- Rebase to 4.2-rc1 and add acks
- Add xgene PCI conversion (added in 4.2)
- Fix build on clps711x

Rob


Rob Herring (13):
  ARM: kill off set_irq_flags usage
  clk: kill off set_irq_flags usage
  dma: kill off set_irq_flags usage
  gpio: kill off set_irq_flags usage
  gpu/drm: kill off set_irq_flags usage
  irqchip: kill off set_irq_flags usage
  memory: kill off set_irq_flags usage
  mfd: kill off set_irq_flags usage
  PCI: kill off set_irq_flags usage
  pinctrl: kill off set_irq_flags usage
  sh: kill off set_irq_flags usage
  ARM: remove ununsed set_irq_flags
  arm64: remove ununsed set_irq_flags

 arch/arm/common/it8152.c                      |  2 +-
 arch/arm/common/locomo.c                      |  2 +-
 arch/arm/common/sa1111.c                      |  4 ++--
 arch/arm/include/asm/hw_irq.h                 |  6 ------
 arch/arm/kernel/irq.c                         | 20 --------------------
 arch/arm/mach-davinci/cp_intc.c               |  2 +-
 arch/arm/mach-dove/irq.c                      |  2 +-
 arch/arm/mach-ebsa110/core.c                  |  2 +-
 arch/arm/mach-footbridge/common.c             |  2 +-
 arch/arm/mach-footbridge/isa-irq.c            |  8 ++++----
 arch/arm/mach-gemini/gpio.c                   |  2 +-
 arch/arm/mach-gemini/irq.c                    |  2 +-
 arch/arm/mach-imx/3ds_debugboard.c            |  2 +-
 arch/arm/mach-imx/mach-mx31ads.c              |  2 +-
 arch/arm/mach-iop13xx/irq.c                   |  2 +-
 arch/arm/mach-iop32x/irq.c                    |  2 +-
 arch/arm/mach-iop33x/irq.c                    |  2 +-
 arch/arm/mach-ixp4xx/common.c                 |  2 +-
 arch/arm/mach-ks8695/irq.c                    |  2 +-
 arch/arm/mach-lpc32xx/irq.c                   |  2 +-
 arch/arm/mach-netx/generic.c                  |  2 +-
 arch/arm/mach-omap1/fpga.c                    |  2 +-
 arch/arm/mach-omap1/irq.c                     |  2 +-
 arch/arm/mach-pxa/balloon3.c                  |  2 +-
 arch/arm/mach-pxa/irq.c                       |  1 -
 arch/arm/mach-pxa/lpd270.c                    |  2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c          |  2 +-
 arch/arm/mach-pxa/pxa3xx.c                    |  2 +-
 arch/arm/mach-pxa/viper.c                     |  2 +-
 arch/arm/mach-pxa/zeus.c                      |  2 +-
 arch/arm/mach-rpc/ecard.c                     |  2 +-
 arch/arm/mach-rpc/irq.c                       | 16 ++++++++--------
 arch/arm/mach-s3c24xx/bast-irq.c              |  2 +-
 arch/arm/mach-s3c64xx/common.c                |  2 +-
 arch/arm/mach-sa1100/neponset.c               |  4 ++--
 arch/arm/mach-w90x900/irq.c                   |  2 +-
 arch/arm64/include/asm/hardirq.h              |  5 -----
 drivers/clk/at91/pmc.c                        |  1 -
 drivers/dma/ipu/ipu_irq.c                     |  8 ++------
 drivers/gpio/gpio-adp5588.c                   | 10 +---------
 drivers/gpio/gpio-bcm-kona.c                  | 15 ---------------
 drivers/gpio/gpio-davinci.c                   |  1 -
 drivers/gpio/gpio-em.c                        |  1 -
 drivers/gpio/gpio-ep93xx.c                    |  2 +-
 drivers/gpio/gpio-grgpio.c                    |  8 --------
 drivers/gpio/gpio-mcp23s08.c                  |  4 ----
 drivers/gpio/gpio-msm-v2.c                    |  1 -
 drivers/gpio/gpio-pxa.c                       |  8 ++++----
 drivers/gpio/gpio-sa1100.c                    |  2 +-
 drivers/gpio/gpio-sta2x11.c                   |  2 +-
 drivers/gpio/gpio-tegra.c                     |  1 -
 drivers/gpio/gpio-timberdale.c                |  4 +---
 drivers/gpio/gpiolib.c                        |  8 +-------
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c       |  1 -
 drivers/gpu/ipu-v3/ipu-common.c               |  3 +--
 drivers/irqchip/exynos-combiner.c             |  2 +-
 drivers/irqchip/irq-armada-370-xp.c           |  3 +--
 drivers/irqchip/irq-bcm2835.c                 |  2 +-
 drivers/irqchip/irq-clps711x.c                |  6 +++---
 drivers/irqchip/irq-gic-v3.c                  |  5 ++---
 drivers/irqchip/irq-gic.c                     |  4 ++--
 drivers/irqchip/irq-hip04.c                   |  4 ++--
 drivers/irqchip/irq-keystone.c                |  2 +-
 drivers/irqchip/irq-mmp.c                     |  3 ---
 drivers/irqchip/irq-mxs.c                     |  1 -
 drivers/irqchip/irq-renesas-intc-irqpin.c     |  1 -
 drivers/irqchip/irq-renesas-irqc.c            |  1 -
 drivers/irqchip/irq-s3c24xx.c                 | 14 ++------------
 drivers/irqchip/irq-sa11x0.c                  |  1 -
 drivers/irqchip/irq-sun4i.c                   |  2 +-
 drivers/irqchip/irq-versatile-fpga.c          |  2 +-
 drivers/irqchip/irq-vic.c                     |  2 +-
 drivers/irqchip/irq-vt8500.c                  |  1 -
 drivers/irqchip/spear-shirq.c                 |  1 -
 drivers/memory/omap-gpmc.c                    |  5 ++---
 drivers/mfd/88pm860x-core.c                   |  4 ----
 drivers/mfd/ab8500-core.c                     |  4 ----
 drivers/mfd/arizona-irq.c                     |  7 -------
 drivers/mfd/asic3.c                           |  4 ++--
 drivers/mfd/db8500-prcmu.c                    |  1 -
 drivers/mfd/ezx-pcap.c                        |  6 +-----
 drivers/mfd/htc-egpio.c                       |  4 ++--
 drivers/mfd/htc-i2cpld.c                      |  6 +-----
 drivers/mfd/lp8788-irq.c                      |  5 -----
 drivers/mfd/max8925-core.c                    |  5 +----
 drivers/mfd/max8997-irq.c                     |  5 +----
 drivers/mfd/max8998-irq.c                     |  5 +----
 drivers/mfd/mt6397-core.c                     |  4 ----
 drivers/mfd/pm8921-core.c                     |  5 +----
 drivers/mfd/rc5t583-irq.c                     |  4 +---
 drivers/mfd/stmpe.c                           |  7 -------
 drivers/mfd/t7l66xb.c                         |  6 ------
 drivers/mfd/tc3589x.c                         |  7 -------
 drivers/mfd/tc6393xb.c                        |  4 ++--
 drivers/mfd/tps6586x.c                        |  7 -------
 drivers/mfd/tps65912-irq.c                    |  8 +-------
 drivers/mfd/twl4030-irq.c                     | 11 +----------
 drivers/mfd/twl6030-irq.c                     | 13 -------------
 drivers/mfd/ucb1x00-core.c                    |  2 +-
 drivers/mfd/wm831x-irq.c                      |  7 -------
 drivers/mfd/wm8350-irq.c                      |  8 +-------
 drivers/mfd/wm8994-irq.c                      |  7 -------
 drivers/pci/host/pci-dra7xx.c                 |  1 -
 drivers/pci/host/pci-keystone-dw.c            |  2 --
 drivers/pci/host/pci-tegra.c                  |  1 -
 drivers/pci/host/pci-xgene-msi.c              |  1 -
 drivers/pci/host/pcie-designware.c            |  1 -
 drivers/pci/host/pcie-rcar.c                  |  1 -
 drivers/pci/host/pcie-xilinx.c                |  2 --
 drivers/pinctrl/bcm/pinctrl-bcm2835.c         |  1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  2 --
 drivers/pinctrl/pinctrl-single.c              |  5 -----
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  1 -
 drivers/pinctrl/samsung/pinctrl-exynos5440.c  |  1 -
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |  2 --
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |  2 --
 drivers/sh/intc/internals.h                   | 10 +---------
 117 files changed, 96 insertions(+), 357 deletions(-)

--
2.1.0
