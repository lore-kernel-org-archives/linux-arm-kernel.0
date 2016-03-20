From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 22:04:36 +0100
Subject: [GIT PULL 8/8] ARM: SoC driver updates for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <3250290.M7sm1Q7PB0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 33b96d2c9579213cf3f36d7b29841b1e464750c4:

  bus: imx-weim: Take the 'status' property value into account (2016-03-12 17:07:39 -0800)

----------------------------------------------------------------
ARM: SoC driver updates for v4.6

Driver updates for ARM SoCs, these contain various things that touch
the drivers/ directory but got merged through arm-soc for practical
reasons:

- Rockchip rk3368 gains power domain support
- Small updates for the ARM spmi driver
- The Atmel PMC driver saw a larger rework, touching both
  arch/arm/mach-at91 and drivers/clk/at91
- All reset controller driver changes alway get merged through
  arm-soc, though this time the largest change is the addition
  of a MIPS pistachio reset driver
- One bugfix for the NXP (formerly Freescale) i.MX weim bus driver

----------------------------------------------------------------
Alexandre Belloni (11):
      clk: at91: remove IRQ handling and use polling
      clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe
      clk: at91: pmc: move pmc structures to C file
      ARM: at91: pm: simply call at91_pm_init
      ARM: at91: pm: find and remap the pmc
      ARM: at91: pm: move idle functions to pm.c
      ARM: at91: remove useless includes and function prototypes
      usb: gadget: atmel: access the PMC using regmap
      clk: at91: pmc: drop at91_pmc_base
      clk: at91: pmc: remove useless capacities handling
      clk: at91: remove useless includes

Andre Przywara (1):
      drivers: sunxi-rsb: fix error output type

Arnd Bergmann (2):
      Merge tag 'sunxi-drivers-for-4.6' of https://git.kernel.org/.../mripard/linux into next/drivers
      Merge tag 'gpmc-omap-for-v4.6' of https://github.com/rogerq/linux into next/drivers

Bartlomiej Zolnierkiewicz (1):
      cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs

Boris Brezillon (2):
      clk: at91: make use of syscon to share PMC registers in several drivers
      clk: at91: make use of syscon/regmap internally

Damien Horsley (2):
      reset: img: Add pistachio reset controller binding document
      reset: img: Add Pistachio reset controller driver

Fabio Estevam (1):
      bus: imx-weim: Take the 'status' property value into account

Heiko Stuebner (1):
      Merge branch 'v4.6-shared/pdids' into v4.6-armsoc/drivers

Jens Kuske (1):
      drivers: soc: sunxi: Fix mask generation for SRAM mapping

Masahiro Yamada (1):
      reset: hisilicon: check return value of reset_controller_register()

Maxime Ripard (2):
      reset: Make reset_control_ops const
      reset: Move DT cell size check to the core

Neil Armstrong (2):
      memory: omap-gpmc: Add support for AAD timings
      dt-bindings: bus: ti-gpmc: Add AAD timings properties

Olof Johansson (5):
      Merge tag 'v4.6-rockchip-drivers1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'samsung-drivers-4.6' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'scpi-for-v4.6/updates' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'at91-ab-4.6-drivers' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'reset-for-4.6' of git://git.pengutronix.de/git/pza/linux into next/drivers

Philipp Zabel (11):
      reset: remove unnecessary local variable initialization from of_reset_control_get_by_index
      reset: berlin: drop DT cell size check
      reset: berlin: Make reset_control_ops const
      reset: img: Make reset_control_ops const
      reset: sunxi: Make reset_control_ops const
      reset: lpc18xx: Make reset_control_ops const
      reset: ath79: Make reset_control_ops const
      reset: hi6220: Make reset_control_ops const
      reset: socfpga: Make reset_control_ops const
      reset: zynq: Make reset_control_ops const
      reset: sti: Make reset_control_ops const

Shawn Lin (1):
      soc: rockchip: power-domain: fix err handle while probing

Sudeep Holla (4):
      firmware: arm_scpi: fix send_message and sensor_get_value for big-endian
      firmware: arm_scpi: decrease Tx timeout to 20ms
      firmware: arm_scpi: add support for 64-bit sensor values
      hwmon: (scpi) add energy meter support

zhangqing (3):
      dt-bindings: add power-domain header for RK3368 SoCs
      dt-bindings: modify document of Rockchip power domains
      soc: rockchip: power-domain: Modify power domain driver for rk3368

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |   5 +
 .../bindings/reset/img,pistachio-reset.txt         |  55 +++
 .../bindings/soc/rockchip/power_domain.txt         |  21 +
 arch/arm/mach-at91/Kconfig                         |   1 +
 arch/arm/mach-at91/at91rm9200.c                    |   2 -
 arch/arm/mach-at91/at91sam9.c                      |   2 -
 arch/arm/mach-at91/generic.h                       |  13 +-
 arch/arm/mach-at91/pm.c                            |  70 +++-
 arch/arm/mach-at91/sama5.c                         |   2 +-
 drivers/bus/imx-weim.c                             |   2 +-
 drivers/bus/sunxi-rsb.c                            |   4 +-
 drivers/clk/at91/clk-generated.c                   |  95 +++--
 drivers/clk/at91/clk-h32mx.c                       |  40 +-
 drivers/clk/at91/clk-main.c                        | 324 +++++++---------
 drivers/clk/at91/clk-master.c                      |  94 ++---
 drivers/clk/at91/clk-peripheral.c                  | 137 ++++---
 drivers/clk/at91/clk-pll.c                         | 150 ++++----
 drivers/clk/at91/clk-plldiv.c                      |  44 +--
 drivers/clk/at91/clk-programmable.c                |  96 ++---
 drivers/clk/at91/clk-slow.c                        |  35 +-
 drivers/clk/at91/clk-smd.c                         |  56 +--
 drivers/clk/at91/clk-system.c                      |  96 ++---
 drivers/clk/at91/clk-usb.c                         | 123 +++---
 drivers/clk/at91/clk-utmi.c                        |  80 ++--
 drivers/clk/at91/pmc.c                             | 426 +--------------------
 drivers/clk/at91/pmc.h                             |  98 +----
 drivers/cpufreq/s5pv210-cpufreq.c                  |   2 -
 drivers/firmware/arm_scpi.c                        |  17 +-
 drivers/hwmon/scpi-hwmon.c                         |  14 +-
 drivers/memory/omap-gpmc.c                         |  30 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  10 +-
 drivers/reset/hisilicon/hi6220_reset.c             |   6 +-
 drivers/reset/reset-ath79.c                        |   2 +-
 drivers/reset/reset-berlin.c                       |   5 +-
 drivers/reset/reset-lpc18xx.c                      |   2 +-
 drivers/reset/reset-pistachio.c                    | 154 ++++++++
 drivers/reset/reset-socfpga.c                      |   2 +-
 drivers/reset/reset-sunxi.c                        |   2 +-
 drivers/reset/reset-zynq.c                         |   2 +-
 drivers/reset/sti/reset-syscfg.c                   |   2 +-
 drivers/soc/rockchip/pm_domains.c                  |  34 ++
 drivers/soc/sunxi/sunxi_sram.c                     |   5 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |  20 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h            |   2 +
 include/dt-bindings/power/rk3368-power.h           |  28 ++
 include/dt-bindings/reset/pistachio-resets.h       |  36 ++
 include/linux/clk/at91_pmc.h                       |  12 -
 include/linux/omap-gpmc.h                          |   5 +
 include/linux/reset-controller.h                   |   2 +-
 include/linux/scpi_protocol.h                      |   3 +-
 51 files changed, 1138 insertions(+), 1331 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/img,pistachio-reset.txt
 create mode 100644 drivers/reset/reset-pistachio.c
 create mode 100644 include/dt-bindings/power/rk3368-power.h
 create mode 100644 include/dt-bindings/reset/pistachio-resets.h
