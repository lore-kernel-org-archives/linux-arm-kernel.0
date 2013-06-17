From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 14:25:50 +0200
Subject: [GIT PULL] U300 multiplatform for v3.11
Message-ID: <CACRpkdY1EUbFK6Mk3nogjGGeSkmio2v6ZNFe1wh7sFcE3d51fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

this is my big pull request for the U300 device tree and multiplatform work
queued for v3.11. It represents my best effort to do this as well as possible
to this point.

After this the mach-u300 likely looks much more appetizing than before and
none of the changes are such that they cannot be undone if need be.
The only outstanding issue was that of the specific board node used
to hog board power, a patch to do that from the regulator driver was
rejected by the regulator maintainer asking that it be done from the
reset subsystem (power) instead, and that can certainly be done as
a refactoring for the next cycle, just as the movement to the regulator
driver was sent as a refactoring patch.

All patches outside arch/arm/* have been ACKed by repective subsystem
maintainer except for the RTC COH 901331 driver where I have had no
response from the RTC maintainer for two months, and the patch is small
and fairly standard so now I suggest we merge that anyway.

One could argue that some patches could have been delivered on
separate branches, for example the two fixes from Ulf Hansson and
Peter Huewe, but since the DT and multiplat conversion touches
absolutely everything, I am saving you some hours of conflict
resolution between these things by delivering it all on one branch.
Trying to deliver device tree and multiplatform on two branches
would have caused eternal headaches for sure.

insertions - deletetion - devicetree - bindings doc gives a net deletion
of 1000+ lines in arch/arm.

So: please pull this into the ARM SoC tree.

Yours,
Linus Walleij


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/u300-multiplatform

for you to fetch changes up to 7fca1f20c0f3e9d7a3b23ee1fc9e832f520f3f1a:

  ARM: u300: switch to using syscon regmap for board (2013-06-17 13:54:39 +0200)

----------------------------------------------------------------
Device Tree and Multiplatform support for U300:
- Add devicetree support to timer, pinctrl (probe), I2C block,
  watchdog, DMA controller and clocks.
- Piecewise add a device tree containing all peripherals.
- Delete the ATAG boot path.
- Delete redundant platform data and board files.
- Convert to multiplatform.

----------------------------------------------------------------
Linus Walleij (38):
      ARM: u300: enable delaytimer on the U300
      ARM: u300: device tree support for the timer
      pinctrl: u300 device tree support
      pinctrl: coh901: add device tree support
      ARM: u300: basic device tree support
      i2c: stu300: device tree support
      ARM: u300: register I2C bus drivers from device tree
      watchdog: coh901327: devicetree support
      ARM: u300: add the COH 901 327 watchdog to device tree
      rtc: coh901331: add devicetree support
      ARM: u300: add RTC to device tree
      ARM: u300: set up board power from device tree
      ARM: u300: support regulators in the device tree
      ARM: u300: enable MMC/SD card from device tree
      dma: coh901318: add devicetree support
      ARM: u300: augment device tree with DMA channels
      ARM: u300: add the COH 901 318 DMAC to device tree
      ARM: u300: add SPI PL022 to the device tree
      ARM: u300: probe the U300 dummy-spichip from device tree
      ARM: u300: add FSMC flash into the device tree
      ARM: u300: delete all static board data
      ARM: u300: move debugmacro to debug includes
      ARM: u300: remove deps from debug macro
      ARM: u300: push down syscon registers
      ARM: u300: delete <mach/hardware.h>
      ARM: u300: delete <mach/irqs.h>
      ARM: u300: localize <mach/u300-regs.h>
      ARM: u300: convert to multiplatform
      ARM: u300: delete remnant machine headers
      ARM: u300: add syscon node
      ARM: u300: remove register definition file
      clk: move the U300 fixed and fixed-factor to DT
      i2c: stu300: do not request a specific clock name
      ARM: u300: move the gated system controller clocks to DT
      ARM: u300: convert MMC/SD clock to device tree
      pinctrl: get rid of all platform data for coh901
      spi: pl022: use DMA by default when probing from DT
      ARM: u300: switch to using syscon regmap for board

Peter Huewe (1):
      ARM: u300 use module_spi_driver to register driver

Ulf Hansson (1):
      ARM: u300: Update MMC configs for u300 defconfig

 Documentation/devicetree/bindings/arm/ste-u300.txt |  46 ++
 .../bindings/clock/ste-u300-syscon-clock.txt       |  80 +++
 .../devicetree/bindings/dma/ste-coh901318.txt      |  32 +
 .../bindings/gpio/gpio-stericsson-coh901.txt       |   7 +
 .../devicetree/bindings/i2c/i2c-st-ddci2c.txt      |  15 +
 .../bindings/timer/stericsson-u300-apptimer.txt    |  18 +
 .../bindings/watchdog/stericsson-coh901327.txt     |  19 +
 arch/arm/Kconfig                                   |  19 +-
 arch/arm/Kconfig.debug                             |   8 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/ste-u300.dts                     | 473 +++++++++++++
 arch/arm/configs/u300_defconfig                    |  14 +-
 .../mach/debug-macro.S => include/debug/u300.S}    |   9 +-
 arch/arm/mach-u300/Kconfig                         |  32 +-
 arch/arm/mach-u300/Makefile                        |   2 -
 arch/arm/mach-u300/core.c                          | 759 +++++++--------------
 arch/arm/mach-u300/dummyspichip.c                  |  20 +-
 arch/arm/mach-u300/i2c.c                           | 285 --------
 arch/arm/mach-u300/i2c.h                           |  23 -
 arch/arm/mach-u300/include/mach/hardware.h         |   5 -
 arch/arm/mach-u300/include/mach/irqs.h             |  80 ---
 arch/arm/mach-u300/include/mach/syscon.h           | 592 ----------------
 arch/arm/mach-u300/include/mach/timex.h            |  17 -
 arch/arm/mach-u300/include/mach/u300-regs.h        | 165 -----
 arch/arm/mach-u300/include/mach/uncompress.h       |  45 --
 arch/arm/mach-u300/regulator.c                     |  67 +-
 arch/arm/mach-u300/spi.c                           | 102 ---
 arch/arm/mach-u300/spi.h                           |  26 -
 arch/arm/mach-u300/timer.c                         | 113 +--
 arch/arm/mach-u300/timer.h                         |   1 -
 arch/arm/mach-u300/u300-gpio.h                     |  70 --
 drivers/clk/clk-u300.c                             | 718 +++++++++++++++----
 drivers/dma/coh901318.c                            |  43 ++
 drivers/i2c/busses/i2c-stu300.c                    |  16 +-
 drivers/pinctrl/pinctrl-coh901.c                   |  35 +-
 drivers/pinctrl/pinctrl-u300.c                     |   7 +
 drivers/rtc/rtc-coh901331.c                        |   6 +
 drivers/spi/spi-pl022.c                            |   1 +
 drivers/watchdog/coh901327_wdt.c                   |  12 +-
 include/linux/platform_data/pinctrl-coh901.h       |  22 -
 40 files changed, 1786 insertions(+), 2219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ste-u300.txt
 create mode 100644
Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
 create mode 100644 Documentation/devicetree/bindings/dma/ste-coh901318.txt
 create mode 100644
Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st-ddci2c.txt
 create mode 100644
Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
 create mode 100644
Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
 create mode 100644 arch/arm/boot/dts/ste-u300.dts
 rename arch/arm/{mach-u300/include/mach/debug-macro.S =>
include/debug/u300.S} (78%)
 delete mode 100644 arch/arm/mach-u300/i2c.c
 delete mode 100644 arch/arm/mach-u300/i2c.h
 delete mode 100644 arch/arm/mach-u300/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-u300/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-u300/include/mach/syscon.h
 delete mode 100644 arch/arm/mach-u300/include/mach/timex.h
 delete mode 100644 arch/arm/mach-u300/include/mach/u300-regs.h
 delete mode 100644 arch/arm/mach-u300/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-u300/spi.c
 delete mode 100644 arch/arm/mach-u300/spi.h
 delete mode 100644 arch/arm/mach-u300/timer.h
 delete mode 100644 arch/arm/mach-u300/u300-gpio.h
 delete mode 100644 include/linux/platform_data/pinctrl-coh901.h
